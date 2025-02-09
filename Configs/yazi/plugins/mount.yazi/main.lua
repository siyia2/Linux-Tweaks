--- @since 25.2.7

local toggle_ui = ya.sync(function(self)
    if self.children then
        Modal:children_remove(self.children)
        self.children = nil
    else
        self.children = Modal:children_add(self, 10)
    end
    ya.render()
end)

local subscribe = ya.sync(function(self)
    ps.unsub("mount")
    ps.sub("mount", function() ya.manager_emit("plugin", { self._id, "refresh" }) end)
end)

local update_partitions = ya.sync(function(self, partitions)
    self.partitions = partitions
    self.cursor = math.max(0, math.min(self.cursor or 0, #self.partitions - 1))
    ya.render()
end)

local active_partition = ya.sync(function(self) return self.partitions[self.cursor + 1] end)

local update_cursor = ya.sync(function(self, cursor)
    if #self.partitions == 0 then
        self.cursor = 0
    else
        self.cursor = ya.clamp(0, self.cursor + cursor, #self.partitions - 1)
    end
    ya.render()
end)

local M = {
    keys = {
        { on = "q", run = "quit" },

        { on = "k", run = "up" },
        { on = "j", run = "down" },
        { on = "l", run = { "enter", "quit" } },

        { on = "<Up>", run = "up" },
        { on = "<Down>", run = "down" },
        { on = "<Right>", run = { "enter", "quit" } },

        { on = "m", run = "mount" },
        { on = "u", run = "unmount" },
        { on = "e", run = "eject" },
    },
}

function M:new(area)
    self:layout(area)
    return self
end

function M:layout(area)
    local chunks = ui.Layout()
        :constraints({
            ui.Constraint.Percentage(10),
            ui.Constraint.Percentage(80),
            ui.Constraint.Percentage(10),
        })
        :split(area)

    local chunks = ui.Layout()
        :direction(ui.Layout.HORIZONTAL)
        :constraints({
            ui.Constraint.Percentage(10),
            ui.Constraint.Percentage(80),
            ui.Constraint.Percentage(10),
        })
        :split(chunks[2])

    self._area = chunks[2]
end

function M:entry(job)
    if job.args[1] == "refresh" then
        return update_partitions(self.obtain())
    end

    toggle_ui()
    update_partitions(self.obtain())
    subscribe()

    local tx1, rx1 = ya.chan("mpsc")
    local tx2, rx2 = ya.chan("mpsc")
    function producer()
        while true do
            local cand = self.keys[ya.which { cands = self.keys, silent = true }] or { run = {} }
            for _, r in ipairs(type(cand.run) == "table" and cand.run or { cand.run }) do
                tx1:send(r)
                if r == "quit" then
                    toggle_ui()
                    return
                end
            end
        end
    end

    function consumer1()
        repeat
            local run = rx1:recv()
            if run == "quit" then
                tx2:send(run)
                break
            elseif run == "up" then
                update_cursor(-1)
            elseif run == "down" then
                update_cursor(1)
            elseif run == "enter" then
                local active = active_partition()
                if active and active.dist then
                    ya.manager_emit("cd", { active.dist })
                end
            else
                tx2:send(run)
            end
        until not run
    end

    function consumer2()
        repeat
            local run = rx2:recv()
            if run == "quit" then
                break
            elseif run == "mount" then
                self.operate("mount")
            elseif run == "unmount" then
                self.operate("unmount")
            elseif run == "eject" then
                self.operate("eject")
            end
        until not run
    end

    ya.join(producer, consumer1, consumer2)
end

function M:reflow() return { self } end

function M:redraw()
    local rows = {}
    for _, p in ipairs(self.partitions or {}) do
        if p.sub == "" then
            rows[#rows + 1] = ui.Row { p.main }
        else
            rows[#rows + 1] = ui.Row { p.sub, p.label or "", p.dist or "", p.fstype or "" }
        end
    end

    return {
        ui.Clear(self._area),
        ui.Border(ui.Border.ALL)
            :area(self._area)
            :type(ui.Border.ROUNDED)
            :style(ui.Style():fg("blue"))
            :title(ui.Line("Mount"):align(ui.Line.CENTER)),
        ui.Table(rows)
            :area(self._area:pad(ui.Pad(1, 2, 1, 2)))
            :header(ui.Row({ "Src", "Label", "Dist", "FSType" }):style(ui.Style():bold()))
            :row(self.cursor)
            :row_style(ui.Style():fg("blue"):underline())
            :widths {
                ui.Constraint.Length(20),
                ui.Constraint.Length(20),
                ui.Constraint.Percentage(70),
                ui.Constraint.Length(10),
            },
    }
end

function M.obtain()
    local tbl = {}
    local last
    -- Process mounted partitions from fs.partitions()
    for _, p in ipairs(fs.partitions()) do
        local main, sub
        if ya.target_os() == "macos" then
            main, sub = p.src:match("^(/dev/disk%d+)(.+)$")
        elseif p.src:find("/dev/nvme", 1, true) == 1 then -- e.g. /dev/nvme0n1p1
            main, sub = p.src:match("^(/dev/nvme%d+n%d+)(p%d+)$")
        elseif p.src:find("/dev/mmcblk", 1, true) == 1 then -- e.g. /dev/mmcblk0p1
            main, sub = p.src:match("^(/dev/mmcblk%d+)(p%d+)$")
        elseif p.src:find("/dev/sd", 1, true) == 1 then -- e.g. /dev/sda1 (includes many USB drives)
            main, sub = p.src:match("^(/dev/sd[a-z])(%d+)$")
        end
        if sub then
            if last ~= main then
                last = main
                tbl[#tbl + 1] = { src = main, main = main, sub = "" }
            end
            p.main = main
            p.sub = "  " .. sub
            tbl[#tbl + 1] = p
        end
    end

    -- For Linux, add removable USB drives (which may be unmounted)
if ya.target_os() == "linux" then
    local output, err = Command("lsblk"):args({ "-p", "-J", "-o", "NAME,RM,TRAN,FSTYPE" }):output()
    if not output then
        ya.dbg("Failed to fetch lsblk info: " .. err)
    else
        local data = ya.json_decode(output.stdout)
        if data and data.blockdevices then
            for _, dev in ipairs(data.blockdevices) do
                -- Process devices marked as removable via rm or transport type "usb"
                if dev.rm == true or dev.rm == "1" or dev.rm == 1 or (dev.tran and dev.tran:lower() == "usb") then
                    -- Ensure that the device header (whole disk) is in our list
                    local headerFound = false
                    for _, entry in ipairs(tbl) do
                        if entry.src == dev.name and entry.sub == "" then
                            headerFound = true
                            break
                        end
                    end
                    if not headerFound then
                        tbl[#tbl+1] = { src = dev.name, main = dev.name, sub = "", fstype = dev.fstype, removable = true }
                    end
                    -- Add any children (partitions) from the device
                    if dev.children then
                        for _, child in ipairs(dev.children) do
                            local sub = child.name:match("^" .. dev.name:gsub("([%-%.])", "%%%1") .. "(.*)$")
                            if sub then
                                sub = "  " .. sub
                            else
                                sub = "  " .. child.name:gsub(dev.name, "")
                            end
                            -- Check if this partition already exists in the table
                            local found = false
                            for _, entry in ipairs(tbl) do
                                if entry.src == child.name then
                                    found = true
                                    break
                                end
                            end
                            if not found then
                                tbl[#tbl+1] = {
                                    src = child.name,
                                    main = dev.name,
                                    sub = sub,
                                    fstype = child.fstype,
                                    removable = true,
                                    -- Preserve 'dist' if already mounted (from fs.partitions())
                                    dist = child.mountpoint and child.mountpoint or nil
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end

    table.sort(M.fillin(tbl), function(a, b)
        if a.main == b.main then
            return a.sub < b.sub
        else
            return a.main < b.main
        end
    end)
    return tbl
end

function M.fillin(tbl)
    if ya.target_os() ~= "linux" then
        return tbl
    end

    local sources, indices = {}, {}
    for i, p in ipairs(tbl) do
        if p.sub ~= "" and not p.fstype then
            sources[#sources + 1], indices[p.src] = p.src, i
        end
    end
    if #sources == 0 then
        return tbl
    end

    local output, err = Command("lsblk"):args({ "-p", "-o", "name,fstype", "-J" }):args(sources):output()
    if err then
        ya.dbg("Failed to fetch filesystem types for unmounted partitions: " .. err)
        return tbl
    end

    local t = ya.json_decode(output and output.stdout or "")
    for _, p in ipairs(t and t.blockdevices or {}) do
        tbl[indices[p.name]].fstype = p.fstype
    end
    return tbl
end

function M.operate(action)
    local active = active_partition()
    if not active then
        return
    end
    -- Allow mount/unmount actions for removable devices even if the row is a header (sub == "")
    if active.sub == "" and not active.removable then
        return -- TODO: mount/unmount main (non-removable) disks if desired.
    end

    local dev = active.src  -- e.g. "/dev/sda1"
    local output, err

    if ya.target_os() == "macos" then
        output, err = Command("diskutil"):args({ action, dev }):output()

    elseif ya.target_os() == "linux" then
        -- Get the filesystem type for the device
        local fs_out, fs_err = Command("lsblk"):args({ "-n", dev, "-o", "FSTYPE" }):output()
        if not fs_out then
            M.fail("Failed to get filesystem type for `%s`: %s", dev, fs_err)
            return
        end
        local fs_type = fs_out.stdout:match("^(%S+)")
        fs_type = fs_type or ""

        if action == "mount" then
            -- If pmount exists, use it
            local pmount_check = Command("which"):args({ "pmount" }):output()
            if pmount_check and pmount_check.status and pmount_check.status.success then
                output, err = Command("pmount"):args({ dev }):output()
            else
                if fs_type == "crypto_LUKS" then
                    local unlock_out = Command("udisksctl"):args({ "unlock", "-b", dev, "--no-user-interaction" }):output()
                    if not unlock_out then
                        M.fail("Failed to unlock `%s`: %s", dev, err or "unknown error")
                        return
                    end
                    local dev_map = unlock_out.stdout:match("(dm%-%d+)")
                    if dev_map then
                        output, err = Command("udisksctl"):args({ "mount", "-b", "/dev/" .. dev_map, "--no-user-interaction" }):output()
                    else
                        M.fail("Failed to determine device mapping for `%s`", dev)
                        return
                    end
                else
                    output, err = Command("udisksctl"):args({ "mount", "-b", dev, "--no-user-interaction" }):output()
                end
            end

        elseif action == "unmount" then
            -- If pumount exists, use it
            local pumount_check = Command("which"):args({ "pumount" }):output()
            if pumount_check and pumount_check.status and pumount_check.status.success then
                output, err = Command("pumount"):args({ dev }):output()
            else
                if fs_type == "crypto_LUKS" then
                    local info_out = Command("udisksctl"):args({ "info", "-b", dev }):output()
                    if not info_out then
                        M.fail("Failed to get info for `%s`", dev)
                        return
                    end
                    local dev_map = info_out.stdout:match("CleartextDevice%s*:%s*(%S+)")
                    if dev_map then
                        output, err = Command("udisksctl"):args({ "unmount", "-b", dev_map, "--no-user-interaction" }):output()
                        Command("udisksctl"):args({ "lock", "-b", dev, "--no-user-interaction" }):output()
                    else
                        M.fail("Failed to determine cleartext device for `%s`", dev)
                        return
                    end
                else
                    output, err = Command("udisksctl"):args({ "unmount", "-b", dev, "--no-user-interaction" }):output()
                end
            end

        elseif action == "eject" then
            Command("udisksctl"):args({ "unmount", "-b", dev, "--no-user-interaction" }):status()
            output, err = Command("udisksctl"):args({ "power-off", "-b", dev, "--no-user-interaction" }):output()
        end
    end

    if not output then
        M.fail("Failed to %s `%s`: %s", action, dev, err)
    elseif not output.status or not output.status.success then
        M.fail("Failed to %s `%s`: %s", action, dev, output and output.stderr or "unknown error")
    end
end

function M.fail(s, ...)
    ya.notify { title = "Mount", content = string.format(s, ...), timeout = 10, level = "error" }
end

function M:click() end
function M:scroll() end
function M:touch() end

return M
