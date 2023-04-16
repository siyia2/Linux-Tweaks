function fish_greeting                                            
echo 'Package Managers:'(set_color cyan --bold)'"pacman", "yay" (aur)'(set_color normal) 
echo "Functions:"(set_color green --bold)'"-Ss" (search), "-S" (install), "-R" (remove),'(set_color normal) (set_color red --bold)'"-Rdd" (remove w/o dependencies), "-Rns (pacman -Qtdq)" (remove orphans)'(set_color normal)

echo Recursively Chown: (set_color green --bold)'"chown -R USER:GROUP FILE"'(set_color normal) Recursively RW: (set_color green --bold)'"chmod -R 700 FILE"'(set_color normal) Make Executable: (set_color green --bold)'"chmod +x FILE"'(set_color normal)
echo " "
end 
