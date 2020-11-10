/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of dsdt.dat, Tue Nov 10 00:47:50 2020
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000683B (26683)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0xF4
 *     OEM ID           "GBT   "
 *     OEM Table ID     "GBTUACPI"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "MSFT"
 *     Compiler Version 0x03000000 (50331648)
 */
DefinitionBlock ("", "DSDT", 1, "GBT   ", "GBTUACPI", 0x00001000)
{
    External (LNKA, UnknownObj)
    External (LNKB, UnknownObj)
    External (LNKC, UnknownObj)
    External (LNKD, UnknownObj)

    Scope (\_PR)
    {
        Processor (\_PR.C000, 0x00, 0x00004010, 0x06){}
        Processor (\_PR.C001, 0x01, 0x00004010, 0x06){}
        Processor (\_PR.C002, 0x02, 0x00004010, 0x06){}
        Processor (\_PR.C003, 0x03, 0x00004010, 0x06){}
        Processor (\_PR.C004, 0x04, 0x00004010, 0x06){}
        Processor (\_PR.C005, 0x05, 0x00004010, 0x06){}
        Processor (\_PR.C006, 0x06, 0x00004010, 0x06){}
        Processor (\_PR.C007, 0x07, 0x00004010, 0x06){}
    }

    Name (\_S0, Package (0x04)  // _S0_: S0 System State
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S3, Package (0x04)  // _S3_: S3 System State
    {
        0x03, 
        0x01, 
        0x01, 
        0x01
    })
    Name (\_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x04, 
        0x04, 
        0x04, 
        0x04
    })
    Name (\_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x05, 
        0x05, 
        0x05, 
        0x05
    })
    OperationRegion (\DEBG, SystemIO, 0x80, 0x01)
    Field (\DEBG, ByteAcc, NoLock, Preserve)
    {
        DBG1,   8
    }

    Name (OSTY, Ones)
    OperationRegion (ACMS, SystemIO, 0x72, 0x02)
    Field (ACMS, ByteAcc, NoLock, Preserve)
    {
        ICMS,   8, 
        DCMS,   8
    }

    IndexField (ICMS, DCMS, ByteAcc, NoLock, Preserve)
    {
        Offset (0x01), 
        Offset (0x04), 
        Offset (0x08), 
        BS_A,   32
    }

    OperationRegion (CFGS, SystemMemory, BS_A, 0x80)
    Field (CFGS, AnyAcc, NoLock, Preserve)
    {
        Offset (0x04), 
        PCIE,   32, 
        Offset (0x3D), 
        TPMF,   1, 
        STHP,   1, 
        SHPG,   1, 
        OSCF,   1, 
        Offset (0x41), 
        XLM0,   32
    }

    OperationRegion (CMPT, SystemIO, 0x0C50, 0x03)
    Field (CMPT, ByteAcc, NoLock, Preserve)
    {
        CMID,   8, 
            ,   6, 
        GPCT,   2, 
        GP0I,   1, 
        GP1I,   1, 
        GP2I,   1, 
        GP3I,   1, 
        GP4I,   1, 
        GP5I,   1, 
        GP6I,   1, 
        GP7I,   1
    }

    OperationRegion (PCFG, SystemMemory, PCIE, 0x02000000)
    Field (PCFG, AnyAcc, NoLock, Preserve)
    {
        Offset (0xA0004), 
        SMIE,   1, 
        SMME,   1, 
        Offset (0xA0008), 
        RVID,   8, 
        Offset (0xA0014), 
        SMB1,   32, 
        Offset (0xA0050), 
        GO49,   1, 
        GO50,   1, 
        GO51,   1, 
        GO52,   1, 
        Offset (0xA0051), 
        GP49,   1, 
        GP50,   1, 
        GP51,   1, 
        GP52,   1, 
        Offset (0xA0052), 
        GO53,   1, 
        GO54,   1, 
        GO55,   1, 
        GO56,   1, 
        Offset (0xA0053), 
        GP53,   1, 
        GP54,   1, 
        GP55,   1, 
        GP56,   1, 
        Offset (0xA0054), 
        GO57,   1, 
        GO58,   1, 
        GO59,   1, 
        GO60,   1, 
        Offset (0xA0055), 
        GP57,   1, 
        GP58,   1, 
        GP59,   1, 
        GP60,   1, 
        Offset (0xA0056), 
        GO61,   1, 
        GO62,   1, 
        GO63,   1, 
        GO64,   1, 
        Offset (0xA0057), 
        GP61,   1, 
        GP62,   1, 
        GP63,   1, 
        GP64,   1, 
        Offset (0xA00AD), 
        STEN,   1
    }

    OperationRegion (PMIO, SystemIO, 0x0CD6, 0x02)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        INPM,   8, 
        DAPM,   8
    }

    IndexField (INPM, DAPM, ByteAcc, NoLock, Preserve)
    {
            ,   1, 
        TM1E,   1, 
        TM2E,   1, 
        Offset (0x01), 
            ,   1, 
        TM1S,   1, 
        TM2S,   1, 
        Offset (0x04), 
            ,   7, 
        SLPS,   1, 
        Offset (0x07), 
            ,   7, 
        CLPS,   1, 
        Offset (0x10), 
            ,   6, 
        PWDE,   1, 
        Offset (0x1C), 
            ,   3, 
        MKME,   1, 
        PI3E,   1, 
        PI2E,   1, 
        PI1E,   1, 
        PI0E,   1, 
            ,   3, 
        MKMS,   1, 
        PI3S,   1, 
        PI2S,   1, 
        PI1S,   1, 
        PI0S,   1, 
        Offset (0x20), 
        P1EB,   16, 
        Offset (0x36), 
            ,   6, 
        GV6P,   1, 
        GV7P,   1, 
            ,   3, 
        GM0P,   1, 
        GM1P,   1, 
        GM2P,   1, 
        GM3P,   1, 
        GM8P,   1, 
            ,   1, 
        GM4P,   1, 
        GM5P,   1, 
            ,   1, 
        GM6P,   1, 
        GM7P,   1, 
        Offset (0x3B), 
        GPX0,   1, 
        GPX4,   1, 
        GPX5,   1, 
        GPX1,   1, 
        GPX6,   1, 
        GPX7,   1, 
        GPX2,   1, 
        GPX3,   1, 
        Offset (0x55), 
        SPRE,   1, 
            ,   1, 
            ,   1, 
        EPNM,   1, 
        DPPF,   1, 
        FNGS,   1, 
        Offset (0x61), 
            ,   7, 
        R617,   1, 
        Offset (0x65), 
            ,   4, 
        RSTU,   1, 
        Offset (0x68), 
            ,   3, 
        TPDE,   1, 
            ,   1, 
        Offset (0x7C), 
            ,   2, 
        BLNK,   2, 
        Offset (0x92), 
            ,   7, 
        GV7S,   1, 
        Offset (0x96), 
        GP8I,   1, 
        GP9I,   1, 
        Offset (0x9A), 
            ,   7, 
        HECO,   1, 
        Offset (0xA8), 
        PI4E,   1, 
        PI5E,   1, 
        PI6E,   1, 
        PI7E,   1, 
        Offset (0xA9), 
        PI4S,   1, 
        PI5S,   1, 
        PI6S,   1, 
        PI7S,   1
    }

    OperationRegion (P1E0, SystemIO, P1EB, 0x04)
    Field (P1E0, ByteAcc, NoLock, Preserve)
    {
            ,   14, 
        PEWS,   1, 
        WSTA,   1, 
            ,   14, 
        PEWD,   1
    }

    Method (SPTS, 1, NotSerialized)
    {
        If ((Arg0 == 0x03))
        {
            RSTU = Zero
        }

        CLPS = One
        SLPS = One
        If ((\RVID <= 0x13))
        {
            \PWDE = Zero
        }
    }

    Method (SWAK, 1, NotSerialized)
    {
        HECO = One
        If ((Arg0 == 0x03))
        {
            RSTU = One
        }

        \PEWS = \PEWS
    }

    Method (TRMD, 1, NotSerialized)
    {
        SPRE = Arg0
        TPDE = Arg0
    }

    Scope (\)
    {
        Name (SBA1, 0x0B00)
        Name (SBA2, 0x0B10)
        Name (SIOP, 0x2E)
        Name (GIOB, 0x0220)
        OperationRegion (NCLK, SystemMemory, PCIE, 0x02000000)
        Field (NCLK, AnyAcc, NoLock, Preserve)
        {
            Offset (0x4C), 
            CLKE,   1, 
            Offset (0x1048), 
            P3HH,   12, 
                ,   19, 
            P3EE,   1, 
            P4EN,   1, 
            P4NM,   12, 
            P4HI,   12, 
            P4IO,   1, 
            Offset (0x1050), 
            P5EN,   1, 
            P5NM,   12, 
            P5HI,   12, 
            P5IO,   1, 
            Offset (0x1054), 
            P6EN,   1, 
            P6NM,   12, 
            P6HI,   12, 
            P6IO,   1, 
            Offset (0x10B0), 
            P1NM,   12, 
            P1HI,   12, 
            P1EN,   1, 
            P1IO,   1, 
            Offset (0x10B4), 
            P2NM,   12, 
            P2HI,   12, 
            P2EN,   1, 
            P2IO,   1, 
            Offset (0x10CC), 
            P3EN,   1, 
            P3NM,   12, 
            P3HI,   12, 
            P3IO,   1
        }

        OperationRegion (SOR1, SystemIO, SBA1, 0x10)
        Field (SOR1, ByteAcc, NoLock, Preserve)
        {
            SMSA,   8, 
            SSSA,   8, 
            SBCA,   8, 
            SHCA,   8, 
            SBAA,   8, 
            SD0A,   8, 
            SD1A,   8, 
            SBDA,   8, 
            SSCA,   8, 
            SMCA,   8, 
            SSEA,   16, 
            SSDA,   16, 
            SMTA,   8
        }

        OperationRegion (SOR2, SystemIO, SBA2, 0x10)
        Field (SOR2, ByteAcc, NoLock, Preserve)
        {
            SMSB,   8, 
            SSSB,   8, 
            SBCB,   8, 
            SHCB,   8, 
            SBAB,   8, 
            SD0B,   8, 
            SD1B,   8, 
            SBDB,   8, 
            SSCB,   8, 
            SMCB,   8, 
            SSEB,   16, 
            SSDB,   16, 
            SMTB,   8
        }

        Mutex (MSMB, 0x00)
        Method (RWBK, 5, NotSerialized)
        {
            Acquire (MSMB, 0xFFFF)
            If ((Arg0 == 0x00))
            {
                Local0 = SMSA /* \SMSA */
                Local0 &= 0x00
                Local0 |= 0xFF
                SMSA = Local0
                Sleep (0x02)
                Local0 = SBAA /* \SBAA */
                Local0 &= 0x00
                Local0 |= Arg1
                SBAA = Local0
                Sleep (0x02)
                Local0 = SHCA /* \SHCA */
                Local0 &= 0x00
                Local0 |= Arg2
                SHCA = Local0
                Sleep (0x02)
                Local0 = SBCA /* \SBCA */
                Local0 &= 0x00
                Local0 |= 0x14
                SBCA = Local0
                Sleep (0x02)
                Local0 = SD0A /* \SD0A */
                Local0 &= 0x00
                Local0 |= Arg3
                SD0A = Local0
                Sleep (0x02)
                Local1 = (Arg1 & 0x01)
                If ((Local1 == 0x00))
                {
                    Local2 = Arg3
                    Local3 = Arg2
                    While (Local2)
                    {
                        Local4 = DerefOf (Arg4 [Local3])
                        SBDA = Local4
                        Sleep (0x02)
                        Local2--
                        Local3++
                    }
                }

                Local0 = SBCA /* \SBCA */
                Local0 &= 0x00
                Local0 |= 0x54
                SBCA = Local0
                Sleep (0x02)
                Local1 = SMSA /* \SMSA */
                While (!(Local1 & 0x01))
                {
                    Local1 = SMSA /* \SMSA */
                    If ((Local1 & 0x1C))
                    {
                        Release (MSMB)
                        Return (0x01)
                    }

                    If ((Local1 & 0x02))
                    {
                        Break
                    }

                    Sleep (0x02)
                }

                Local1 = SMSA /* \SMSA */
                While ((Local1 & 0x01))
                {
                    Local1 = SMSA /* \SMSA */
                    Sleep (0x02)
                }

                Local1 = (Arg1 & 0x01)
                If (Local1)
                {
                    Local1 = Arg2
                    Local2 = Arg3
                    While (Local2)
                    {
                        Arg4 [Local1] = SBDA /* \SBDA */
                        Sleep (0x02)
                        Local1++
                        Local2--
                    }
                }
            }

            If ((Arg0 == 0x01)){}
            Release (MSMB)
            Return (0x00)
        }

        OperationRegion (IOOR, SystemIO, SIOP, 0x02)
        Field (IOOR, ByteAcc, NoLock, Preserve)
        {
            IOID,   8, 
            IODT,   8
        }

        OperationRegion (GBOR, SystemIO, GIOB, 0x02)
        Field (GBOR, ByteAcc, NoLock, Preserve)
        {
            Offset (0x01), 
                ,   5, 
            GP25,   1, 
            GP26,   1
        }

        Method (RSIO, 1, NotSerialized)
        {
            IOID = Arg0
            Return (IODT) /* \IODT */
        }

        Method (WSIO, 2, NotSerialized)
        {
            IOID = Arg0
            IODT = Arg1
        }

        Method (RWIO, 3, NotSerialized)
        {
            WSIO (Arg0, ((RSIO (Arg0) & Arg1) | Arg2))
        }

        Name (IPSW, Package (0x02)
        {
            Package (0x04)
            {
                0x87, 
                0x01, 
                0x55, 
                0x55
            }, 

            Package (0x04)
            {
                0x87, 
                0x01, 
                0x55, 
                0xAA
            }
        })
        Method (SLDN, 1, NotSerialized)
        {
            Local1 = 0x00
            If ((SIOP == 0x2E))
            {
                Local1 = 0x00
            }

            If ((SIOP == 0x4E))
            {
                Local1 = 0x01
            }

            Local0 = 0x00
            While ((Local0 != 0x04))
            {
                IOID = DerefOf (DerefOf (IPSW [Local1]) [Local0])
                Local0++
            }

            WSIO (0x07, Arg0)
        }

        Method (APTS, 1, NotSerialized)
        {
            \AOD.APTS (Arg0)
        }

        Method (AWAK, 1, NotSerialized)
        {
            \AOD.AWAK (Arg0)
        }

        Device (AOD)
        {
            Name (DBG, 0x01)
            Name (OBID, Package (0x1C)
            {
                0x04, 
                0x01010000, 
                0x01020000, 
                0x02010000, 
                0x02040000, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x01, 
                0x01, 
                0x00, 
                0x00, 
                0xFF, 
                0xFF, 
                0xFF, 
                0xFF, 
                0xFF, 
                "CPU Clock", 
                "PCIE Clock", 
                "Memory VDDQ", 
                "NB Core Voltage", 
                "", 
                "", 
                "", 
                "", 
                ""
            })
            Name (OBIT, Package (0x1E)
            {
                0x01010000, 
                0x00030D40, 
                0x0007A120, 
                0x00, 
                0x03E8, 
                0x00, 
                0x01020000, 
                0x000186A0, 
                0x000249F0, 
                0x00, 
                0x03E8, 
                0x00, 
                0x02010000, 
                0x0002BF20, 
                0x00033450, 
                0x00, 
                0x2710, 
                0x00, 
                0x02040000, 
                0x0001ADB0, 
                0x000222E0, 
                0x00, 
                0x2710, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (OBDT, Package (0x01)
            {
                0x00
            })
            Name (DOVT, Package (0x05)
            {
                0x0002BF20, 
                0x0002E630, 
                0x00030D40, 
                0x00033450, 
                0xFF
            })
            Name (NOVT, Package (0x05)
            {
                0x0001ADB0, 
                0x0001D4C0, 
                0x0001FBD0, 
                0x000222E0, 
                0xFF
            })
            Method (BM01, 0, NotSerialized)
            {
            }

            Method (XINI, 0, NotSerialized)
            {
            }

            Method (EM01, 0, NotSerialized)
            {
            }

            Method (BM05, 1, NotSerialized)
            {
            }

            Method (EM05, 1, NotSerialized)
            {
            }

            Method (HM06, 0, NotSerialized)
            {
            }

            Method (HM07, 1, NotSerialized)
            {
            }

            Method (DISC, 0, NotSerialized)
            {
                \SLDN (0x07)
                \RWIO (0x26, 0xFF, 0x40)
                \RWIO (0x2C, 0xEF, 0x00)
                \RWIO (0xC1, 0xFF, 0x40)
                \RWIO (0xC9, 0xFF, 0x40)
                \RWIO (0xB9, 0xFF, 0x40)
                \GP26 = 0x00
            }

            Name (ID01, 0x00)
            Name (ID02, 0x00)
            Method (SOID, 1, NotSerialized)
            {
                ID01 = (Arg0 >> 0x18)
                ID02 = ((Arg0 & 0x00FF0000) >> 0x10)
                Return (0x00)
            }

            Method (WROW, 4, NotSerialized)
            {
                Name (IFPK, Package (0x06)
                {
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00
                })
                CreateDWordField (Arg0, 0x00, BUF0)
                CreateDWordField (Arg0, 0x04, BUF1)
                CreateDWordField (Arg0, 0x08, BUF2)
                CreateDWordField (Arg0, 0x0C, BUF3)
                CreateDWordField (Arg0, 0x10, BUF4)
                CreateDWordField (Arg0, 0x14, BUF5)
                IFPK [0x00] = BUF0 /* \AOD_.WROW.BUF0 */
                IFPK [0x01] = BUF1 /* \AOD_.WROW.BUF1 */
                IFPK [0x02] = BUF2 /* \AOD_.WROW.BUF2 */
                IFPK [0x03] = BUF3 /* \AOD_.WROW.BUF3 */
                IFPK [0x04] = BUF4 /* \AOD_.WROW.BUF4 */
                IFPK [0x05] = BUF5 /* \AOD_.WROW.BUF5 */
                Local0 = Arg3
                Local1 = 0x00
                While (Local0)
                {
                    Arg1 [((Arg2 * Arg3) + Local1)] = DerefOf (
                        IFPK [Local1])
                    Local1++
                    Local0--
                }
            }

            Method (GROW, 4, NotSerialized)
            {
                Name (IFPK, Package (0x06)
                {
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00
                })
                Local0 = Arg3
                Local1 = 0x00
                While (Local0)
                {
                    IFPK [Local1] = DerefOf (Arg0 [((Arg2 * Arg3
                        ) + Local1)])
                    Local1++
                    Local0--
                }

                CreateDWordField (Arg1, 0x00, BUF0)
                CreateDWordField (Arg1, 0x04, BUF1)
                CreateDWordField (Arg1, 0x08, BUF2)
                CreateDWordField (Arg1, 0x0C, BUF3)
                CreateDWordField (Arg1, 0x10, BUF4)
                CreateDWordField (Arg1, 0x14, BUF5)
                BUF0 = DerefOf (IFPK [0x00])
                BUF1 = DerefOf (IFPK [0x01])
                BUF2 = DerefOf (IFPK [0x02])
                BUF3 = DerefOf (IFPK [0x03])
                BUF4 = DerefOf (IFPK [0x04])
                BUF5 = DerefOf (IFPK [0x05])
            }

            Method (CPTB, 2, NotSerialized)
            {
                Name (LOID, 0x00)
                CreateDWordField (Arg1, 0x00, BUF0)
                CreateDWordField (Arg1, 0x04, BUF1)
                CreateDWordField (Arg1, 0x08, BUF2)
                CreateDWordField (Arg1, 0x0C, BUF3)
                CreateDWordField (Arg1, 0x10, BUF4)
                Local0 = 0x00
                LOID = DerefOf (OBIT [Local0])
                While (LOID)
                {
                    If ((LOID == Arg0))
                    {
                        BUF0 = DerefOf (OBIT [(Local0 + 0x00)])
                        BUF1 = DerefOf (OBIT [(Local0 + 0x01)])
                        BUF2 = DerefOf (OBIT [(Local0 + 0x02)])
                        BUF3 = DerefOf (OBIT [(Local0 + 0x03)])
                        BUF4 = DerefOf (OBIT [(Local0 + 0x04)])
                        Break
                    }

                    Local0 += 0x06
                    LOID = DerefOf (OBIT [Local0])
                }

                If ((LOID == 0x00))
                {
                    Return (0xFF)
                }

                Return (0x00)
            }

            Method (CBTP, 1, NotSerialized)
            {
                Name (LOID, 0x00)
                CreateDWordField (Arg0, 0x00, BUF0)
                CreateDWordField (Arg0, 0x04, BUF1)
                CreateDWordField (Arg0, 0x08, BUF2)
                CreateDWordField (Arg0, 0x0C, BUF3)
                CreateDWordField (Arg0, 0x10, BUF4)
                CreateDWordField (Arg0, 0x14, BUF5)
                Local0 = 0x00
                LOID = DerefOf (OBIT [Local0])
                While (LOID)
                {
                    If ((LOID == BUF0))
                    {
                        OBIT [(Local0 + 0x00)] = BUF0 /* \AOD_.CBTP.BUF0 */
                        OBIT [(Local0 + 0x01)] = BUF1 /* \AOD_.CBTP.BUF1 */
                        OBIT [(Local0 + 0x02)] = BUF2 /* \AOD_.CBTP.BUF2 */
                        OBIT [(Local0 + 0x03)] = BUF3 /* \AOD_.CBTP.BUF3 */
                        OBIT [(Local0 + 0x04)] = BUF4 /* \AOD_.CBTP.BUF4 */
                        OBIT [(Local0 + 0x05)] = BUF5 /* \AOD_.CBTP.BUF5 */
                        Break
                    }

                    Local0 += 0x06
                    LOID = DerefOf (OBIT [Local0])
                }

                If ((LOID == 0x00))
                {
                    Return (0xFF)
                }

                Return (0x00)
            }

            Method (ABS, 2, NotSerialized)
            {
                If ((Arg0 < Arg1))
                {
                    Return ((Arg1 - Arg0))
                }
                Else
                {
                    Return ((Arg0 - Arg1))
                }
            }

            Name (EXBF, Buffer (0x78){})
            OperationRegion (ACMS, SystemIO, 0x72, 0x02)
            Field (ACMS, ByteAcc, NoLock, Preserve)
            {
                P72,    8, 
                P73,    8
            }

            Method (BSF, 1, NotSerialized)
            {
                Name (BIT0, 0x01)
                Local1 = 0x08
                While (Local1)
                {
                    Local2 = (Arg0 & BIT0) /* \AOD_.BSF_.BIT0 */
                    If (Local2)
                    {
                        Break
                    }

                    BIT0 <<= 0x01
                    Local1--
                }

                Return ((0x08 - Local1))
            }

            Method (GCMS, 1, NotSerialized)
            {
                Name (ADDR, 0x00)
                Name (MASK, 0x00)
                Name (TEMP, Buffer (0x06){})
                CreateDWordField (TEMP, 0x00, TMP1)
                CreateWordField (TEMP, 0x04, TMP2)
                ADDR = (Arg0 & 0xFF)
                MASK = (Arg0 >> 0x08)
                P72 = ADDR /* \AOD_.GCMS.ADDR */
                Local0 = P73 /* \AOD_.P73_ */
                Local0 &= MASK /* \AOD_.GCMS.MASK */
                Local0 >>= BSF (MASK)
                TMP1 = 0x00
                TMP2 = Local0
                Return (TEMP) /* \AOD_.GCMS.TEMP */
            }

            Method (SCMS, 2, NotSerialized)
            {
                Name (ADDR, 0x00)
                Name (MASK, 0x00)
                ADDR = (Arg0 & 0xFF)
                MASK = (Arg0 >> 0x08)
                P72 = ADDR /* \AOD_.SCMS.ADDR */
                Local0 = P73 /* \AOD_.P73_ */
                Local1 = (Arg1 << BSF (MASK))
                Local0 &= (~MASK & 0xFF)
                Local0 |= Local1
                P73 = Local0
                Return (0x00)
            }

            Name (CPUD, 0x00)
            Name (GFXD, 0x00)
            Name (SBCD, 0x00)
            Method (GETC, 1, NotSerialized)
            {
                If (\RWBK (0x00, 0xD3, 0x00, 0x20, TSBF))
                {
                    GVB2 = 0x01
                    GVB1 = 0x00
                    Return (GVBF) /* \AOD_.GVBF */
                }

                GVB2 = 0x00
                GVB1 = CCLK (Arg0)
                Return (GVBF) /* \AOD_.GVBF */
            }

            Method (SETC, 2, NotSerialized)
            {
                If (\RWBK (0x00, 0xD3, 0x20, 0x20, TSBF))
                {
                    Return (0x01)
                }
                Else
                {
                    TSBF [0x24] = (DerefOf (TSBF [0x24]) & 0x7F)
                    RWBK (0x00, 0xD2, 0x20, 0x20, TSBF)
                }

                If (\RWBK (0x00, 0xD3, 0x00, 0x20, TSBF))
                {
                    Return (0x01)
                }

                Local3 = 0x00
                If ((Arg0 == 0x01))
                {
                    Local0 = 0x02
                    Local1 = GCCX (0x0F, 0x11, 0x04)
                    Local2 = (Arg1 * Local0)
                    Local3 = RMPC (Local1, Local2, Arg0)
                }
                ElseIf ((Arg0 == 0x02))
                {
                    Local0 = GFXD /* \AOD_.GFXD */
                    Local1 = GCCX (0x10, 0x11, 0x00)
                    Local2 = (Arg1 * Local0)
                    Local3 = RMPC (Local1, Local2, Arg0)
                }

                If (Local3)
                {
                    Return (Local3)
                }

                Return (0x00)
            }

            Method (CINI, 0, NotSerialized)
            {
                If (\RWBK (0x00, 0xD3, 0x00, 0x20, TSBF))
                {
                    Return (0x01)
                }

                TSBF [0x0C] = (DerefOf (TSBF [0x0C]) & 0x1F)
                If (((DerefOf (TSBF [0x1F]) & 0x80) == 0x00))
                {
                    TSBF [0x0F] = 0x90
                    TSBF [0x11] = ((DerefOf (TSBF [0x11]) & 
                        0x8F) | 0x10)
                    TSBF [0x1F] = TSBF [0x1F] = (DerefOf (
                        TSBF [0x1F]) | 0x80)
                }

                If (((DerefOf (TSBF [0x1F]) & 0x10) == 0x00))
                {
                    If (((DerefOf (TSBF [0x1E]) & 0x80) == 0x00))
                    {
                        GFXD = 0x0A
                        TSBF [0x10] = 0xE8
                        TSBF [0x11] = ((DerefOf (TSBF [0x11]) & 
                            0xF8) | 0x03)
                    }
                    Else
                    {
                        GFXD = 0x06
                        TSBF [0x10] = 0x58
                        TSBF [0x11] = ((DerefOf (TSBF [0x11]) & 
                            0xF8) | 0x02)
                    }

                    TSBF [0x05] = TSBF [0x05] = (DerefOf (
                        TSBF [0x05]) | 0x20)
                    TSBF [0x1F] = TSBF [0x1F] = (DerefOf (
                        TSBF [0x1F]) | 0x10)
                }

                If (\RWBK (0x00, 0xD2, 0x00, 0x20, TSBF))
                {
                    Return (0x01)
                }

                Return (0x00)
            }

            Method (GCCX, 3, NotSerialized)
            {
                Local0 = DerefOf (TSBF [Arg0])
                Local1 = ((DerefOf (TSBF [Arg1]) >> Arg2) & 0x07
                    )
                Local1 <<= 0x08
                Local0 |= Local1
                Local0 *= 0x03E8
                Return (Local0)
            }

            Method (CCLK, 1, NotSerialized)
            {
                Name (VCOV, 0x00)
                Name (VCOD, 0x00)
                If ((Arg0 == 0x01))
                {
                    CPUD = 0x02
                    VCOD = CPUD /* \AOD_.CPUD */
                    VCOV = GCCX (0x0F, 0x11, 0x04)
                }
                ElseIf ((Arg0 == 0x02))
                {
                    If (((DerefOf (TSBF [0x1E]) & 0x80) == 0x80))
                    {
                        GFXD = 0x06
                    }
                    Else
                    {
                        GFXD = 0x0A
                    }

                    VCOD = GFXD /* \AOD_.GFXD */
                    VCOV = GCCX (0x10, 0x11, 0x00)
                }
                ElseIf ((Arg0 == 0x03))
                {
                    SBCD = 0x01
                    VCOD = 0x01
                    VCOV = 0x000186A0
                }

                Return ((VCOV / VCOD))
            }

            Method (SCCX, 4, NotSerialized)
            {
                Local0 = Arg0
                TSBF [Arg1] = (Local0 & 0xFF)
                Local0 = Arg0
                Local0 = ((Local0 & 0x0700) >> Arg3)
                Local1 = (0x0700 >> Arg3)
                Local1 ^= 0xFF
                Local1 = (DerefOf (TSBF [Arg2]) & Local1)
                Local0 |= Local1
                TSBF [Arg2] = Local0
                If (\RWBK (0x00, 0xD2, 0x00, 0x20, TSBF))
                {
                    Return (0x01)
                }

                Return (0x00)
            }

            Method (WTCX, 2, NotSerialized)
            {
                If ((Arg0 == 0x01))
                {
                    Return (SCCX (Arg1, 0x0F, 0x11, 0x04))
                }
                ElseIf ((Arg0 == 0x02))
                {
                    Return (SCCX (Arg1, 0x10, 0x11, 0x08))
                }
                ElseIf ((Arg0 == 0x03))
                {
                    Return (0x00)
                }

                Return (0x04)
            }

            Method (RMPC, 3, NotSerialized)
            {
                Name (STAT, 0x00)
                Local0 = Arg0
                Local1 = Arg1
                If ((Local0 != Local1))
                {
                    Local1 = (Local1 / 0x03E8)
                    STAT = WTCX (Arg2, Local1)
                    If (STAT)
                    {
                        Return (STAT) /* \AOD_.RMPC.STAT */
                    }
                }

                Return (0x00)
            }

            Method (VINI, 0, NotSerialized)
            {
            }

            Method (SETV, 2, NotSerialized)
            {
                If ((DBG == 0x01))
                {
                    Debug = "setv"
                }

                If ((Arg0 == 0x01))
                {
                    Local0 = 0x00
                    While (0x01)
                    {
                        If ((DerefOf (DOVT [Local0]) == 0xFF))
                        {
                            Local1 = 0x00
                            Break
                        }

                        If ((DerefOf (DOVT [Local0]) == Arg1))
                        {
                            Local1 = Local0
                            Break
                        }

                        Local0 += 0x01
                    }

                    Local1 = ~Local1
                    Local1 &= 0x03
                    Local2 = Local1
                    Local2 = (Local2 >>= 0x01 & 0x01)
                    GO59 = Local2
                    Local1 &= 0x01
                    GO60 = Local1
                }

                If ((Arg0 == 0x04))
                {
                    Local0 = 0x00
                    While (0x01)
                    {
                        If ((DerefOf (NOVT [Local0]) == 0xFF))
                        {
                            Local1 = 0x00
                            Break
                        }

                        If ((DerefOf (NOVT [Local0]) == Arg1))
                        {
                            Local1 = Local0
                            Break
                        }

                        Local0 += 0x01
                    }

                    Local1 = ~Local1
                    Local1 &= 0x03
                    Local2 = Local1
                    Local2 = (Local2 >>= 0x01 & 0x01)
                    GO55 = Local2
                    Local1 &= 0x01
                    GO56 = Local1
                }
            }

            Method (GETV, 1, NotSerialized)
            {
                If (DBG)
                {
                    Debug = "getv"
                }

                If ((Arg0 == 0x01))
                {
                    Local0 = GP59 /* \GP59 */
                    Local0 <<= 0x01
                    Local0 |= GP60
                    Local0 = ~Local0
                    Local0 &= 0x03
                    GVBF = DerefOf (DOVT [Local0])
                }

                If ((Arg0 == 0x04))
                {
                    Local0 = GP55 /* \GP55 */
                    Local0 <<= 0x01
                    Local0 |= GP56
                    Local0 = ~Local0
                    Local0 &= 0x03
                    GVBF = DerefOf (NOVT [Local0])
                }

                Return (GVBF) /* \AOD_.GVBF */
            }

            Name (GF01, 0x00)
            Name (OVFL, 0x01)
            Name (OCFL, 0x01)
            Name (TSBF, Buffer (0x40)
            {
                /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0010 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0020 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0030 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0038 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
            })
            Name (GVBF, Buffer (0x05)
            {
                 0x00, 0x00, 0x00, 0x00, 0x00                     // .....
            })
            CreateDWordField (GVBF, 0x00, GVB1)
            CreateByteField (GVBF, 0x04, GVB2)
            Method (AM01, 0, NotSerialized)
            {
                If (DBG)
                {
                    Debug = "AM01"
                }

                If (!GF01)
                {
                    BM01 ()
                    If (OCFL)
                    {
                        CINI ()
                    }

                    If (OVFL)
                    {
                        VINI ()
                    }

                    XINI ()
                    EM01 ()
                    GF01 = 0x01
                }

                Return (0x00)
            }

            Method (AM02, 0, NotSerialized)
            {
                If (DBG)
                {
                    Debug = "AM02"
                    Debug = OBID /* \AOD_.OBID */
                }

                Return (OBID) /* \AOD_.OBID */
            }

            Method (AM03, 1, NotSerialized)
            {
                If (DBG)
                {
                    Debug = "AM03"
                }

                SOID (Arg0)
                If (((ID01 == 0x01) && OCFL))
                {
                    Local0 = GETC (ID02)
                }
                ElseIf (((ID01 == 0x02) && OVFL))
                {
                    Local0 = GETV (ID02)
                }
                Else
                {
                    GVB1 = 0x00
                    GVB2 = 0x04
                    Local0 = GVBF /* \AOD_.GVBF */
                }

                If (DBG)
                {
                    Debug = "GVBF"
                    Debug = Local0
                }

                Return (Local0)
            }

            Method (AM04, 2, NotSerialized)
            {
                If (DBG)
                {
                    Debug = "AM04"
                }

                SOID (Arg0)
                If (((ID01 == 0x01) && OCFL))
                {
                    SETC (ID02, Arg1)
                }
                ElseIf (((ID01 == 0x02) && OVFL))
                {
                    SETV (ID02, Arg1)
                }
                Else
                {
                    Return (0x04)
                }

                Return (0x00)
            }

            Method (AM05, 1, NotSerialized)
            {
                Name (INFO, Buffer (0x14)
                {
                    /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0010 */  0x00, 0x00, 0x00, 0x00                           // ....
                })
                CreateDWordField (INFO, 0x00, IFID)
                CreateDWordField (INFO, 0x04, IFMI)
                CreateDWordField (INFO, 0x08, IFMX)
                CreateDWordField (INFO, 0x0C, IFSP)
                CreateField (INFO, 0x80, 0x03, IFST)
                If (DBG)
                {
                    Debug = "AM05"
                    Debug = OBIT /* \AOD_.OBIT */
                }

                SOID (Arg0)
                If (DBG)
                {
                    Debug = "ID"
                    Debug = ID01 /* \AOD_.ID01 */
                    Debug = ID02 /* \AOD_.ID02 */
                }

                BM05 (Arg0)
                If (DBG)
                {
                    Debug = "OBIT"
                    Debug = OBIT /* \AOD_.OBIT */
                }

                CPTB (Arg0, INFO)
                EM05 (Arg0)
                If (DBG)
                {
                    Debug = "info"
                    Debug = INFO /* \AOD_.AM05.INFO */
                }

                Return (INFO) /* \AOD_.AM05.INFO */
            }

            Method (AM06, 0, NotSerialized)
            {
                HM06 ()
                Return (0x00)
            }

            Method (AM07, 1, NotSerialized)
            {
                HM07 (Arg0)
                Return (0x00)
            }

            Method (AM08, 1, NotSerialized)
            {
                Name (LODT, Package (0x34)
                {
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00
                })
                Local0 = 0x00
                While (0x01)
                {
                    If ((DerefOf (OBDT [Local0]) == Arg0))
                    {
                        Local4 = 0x00
                        Break
                    }

                    If ((DerefOf (OBDT [Local0]) == 0x00))
                    {
                        Local4 = 0x04
                        Break
                    }

                    Local0 += DerefOf (OBDT [(Local0 + 0x01)])
                    Local0 += 0x02
                }

                If (Local4){}
                Else
                {
                    Local1 = DerefOf (OBDT [(Local0 + 0x01)])
                    Local1 += 0x02
                    Local2 = 0x00
                    While (Local1)
                    {
                        LODT [Local2] = DerefOf (OBDT [Local0])
                        Local1--
                        Local0++
                        Local2++
                    }
                }

                Return (LODT) /* \AOD_.AM08.LODT */
            }

            Name (OBSV, Package (0x09)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Method (APTS, 1, NotSerialized)
            {
                If ((GF01 && ((Arg0 == 0x04) || (Arg0 == 0x03))))
                {
                    Local0 = DerefOf (OBID [0x00])
                    Local1 = 0x01
                    Local2 = 0x00
                    While (Local0)
                    {
                        SOID (DerefOf (OBID [Local1]))
                        If (((ID01 == 0x01) && OCFL))
                        {
                            GETC (ID02)
                            Local3 = GVB1 /* \AOD_.GVB1 */
                        }
                        ElseIf (((ID01 == 0x02) && OVFL))
                        {
                            GETV (ID02)
                            Local3 = GVB1 /* \AOD_.GVB1 */
                        }
                        Else
                        {
                            Local3 = 0x00
                        }

                        OBSV [Local2] = Local3
                        Local0--
                        Local1++
                        Local2++
                    }
                }
            }

            Method (AWAK, 1, NotSerialized)
            {
                If ((GF01 && ((Arg0 == 0x04) || (Arg0 == 0x03))))
                {
                    Local0 = DerefOf (OBID [0x00])
                    Local1 = 0x01
                    Local2 = 0x00
                    While (Local0)
                    {
                        Local3 = DerefOf (OBSV [Local2])
                        SOID (DerefOf (OBID [Local1]))
                        If (((ID01 == 0x01) && OCFL))
                        {
                            SETC (ID02, Local3)
                        }
                        ElseIf (((ID01 == 0x02) && OVFL)){}
                        Else
                        {
                        }

                        Local0--
                        Local1++
                        Local2++
                    }
                }
            }

            Name (WQBA, Buffer (0x0BBB)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
                /* 0008 */  0xAB, 0x0B, 0x00, 0x00, 0x20, 0x4A, 0x00, 0x00,  // .... J..
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
                /* 0018 */  0x28, 0x5B, 0xA4, 0x00, 0x01, 0x06, 0x18, 0x42,  // ([.....B
                /* 0020 */  0x10, 0x15, 0x10, 0x22, 0x21, 0x04, 0x12, 0x01,  // ..."!...
                /* 0028 */  0xA1, 0xC8, 0x2C, 0x0C, 0x86, 0x10, 0x38, 0x2E,  // ..,...8.
                /* 0030 */  0x84, 0x1C, 0x40, 0x48, 0x1C, 0x14, 0x4A, 0x08,  // ..@H..J.
                /* 0038 */  0x84, 0xFA, 0x13, 0xC8, 0xAF, 0x00, 0x84, 0x0E,  // ........
                /* 0040 */  0x05, 0xC8, 0x14, 0x60, 0x50, 0x80, 0x53, 0x04,  // ...`P.S.
                /* 0048 */  0x11, 0xF4, 0x2A, 0xC0, 0xA6, 0x00, 0x93, 0x02,  // ..*.....
                /* 0050 */  0x2C, 0x0A, 0xD0, 0x2E, 0xC0, 0xB2, 0x00, 0xDD,  // ,.......
                /* 0058 */  0x02, 0xA4, 0xC3, 0x92, 0xAD, 0x08, 0x1C, 0x21,  // .......!
                /* 0060 */  0x06, 0x1C, 0xA5, 0x13, 0x5B, 0xB8, 0x61, 0x83,  // ....[.a.
                /* 0068 */  0x17, 0x8A, 0xA2, 0x19, 0x44, 0x49, 0x50, 0xB9,  // ....DIP.
                /* 0070 */  0x00, 0xDF, 0x08, 0x02, 0x2F, 0x57, 0x80, 0xE4,  // ..../W..
                /* 0078 */  0x09, 0x48, 0xB3, 0x00, 0xC3, 0x02, 0xAC, 0x0B,  // .H......
                /* 0080 */  0x90, 0x3D, 0x04, 0x2A, 0x75, 0x08, 0x28, 0x39,  // .=.*u.(9
                /* 0088 */  0x43, 0x40, 0x0D, 0xA0, 0xD5, 0x09, 0x08, 0xBF,  // C@......
                /* 0090 */  0xD2, 0x29, 0x21, 0x09, 0xC2, 0x19, 0xAB, 0x78,  // .)!....x
                /* 0098 */  0x7C, 0xCD, 0xA2, 0xE9, 0x39, 0xC9, 0x39, 0x86,  // |...9.9.
                /* 00A0 */  0x1C, 0x8F, 0x0B, 0x3D, 0x08, 0x1E, 0x47, 0x03,  // ...=..G.
                /* 00A8 */  0x08, 0x93, 0x3F, 0x64, 0x05, 0x80, 0x41, 0x49,  // ..?d..AI
                /* 00B0 */  0x18, 0x0B, 0x75, 0x31, 0x6A, 0xD4, 0x48, 0xD9,  // ..u1j.H.
                /* 00B8 */  0x80, 0x0C, 0x51, 0xDA, 0xA8, 0xD1, 0x03, 0x3A,  // ..Q....:
                /* 00C0 */  0xBF, 0x23, 0x39, 0xBB, 0xA3, 0x3B, 0x92, 0x04,  // .#9..;..
                /* 00C8 */  0x46, 0x3D, 0xA6, 0x63, 0x2C, 0x6C, 0x46, 0x42,  // F=.c,lFB
                /* 00D0 */  0x8D, 0xD1, 0x1C, 0x14, 0x09, 0x37, 0x68, 0xB4,  // .....7h.
                /* 00D8 */  0x44, 0x58, 0x8D, 0x2B, 0xF6, 0x99, 0x59, 0xF8,  // DX.+..Y.
                /* 00E0 */  0xB0, 0x84, 0x71, 0x04, 0x07, 0x76, 0xB0, 0x16,  // ..q..v..
                /* 00E8 */  0x0D, 0x23, 0xB4, 0x82, 0xE0, 0x34, 0x88, 0xA3,  // .#...4..
                /* 00F0 */  0x88, 0x12, 0x86, 0xE1, 0x19, 0x33, 0xD0, 0x51,  // .....3.Q
                /* 00F8 */  0x32, 0xA4, 0x30, 0x41, 0x4F, 0x20, 0xC8, 0xC9,  // 2.0AO ..
                /* 0100 */  0x33, 0x2C, 0x43, 0x9C, 0x01, 0xC7, 0x8A, 0x11,  // 3,C.....
                /* 0108 */  0x2A, 0x24, 0x66, 0x20, 0xC1, 0xFF, 0xFF, 0x27,  // *$f ...'
                /* 0110 */  0xD0, 0x35, 0x86, 0x3C, 0x03, 0x91, 0x7B, 0xC0,  // .5.<..{.
                /* 0118 */  0x09, 0x04, 0x89, 0x1E, 0x25, 0xB8, 0x71, 0x8D,  // ....%.q.
                /* 0120 */  0xCA, 0xC6, 0x74, 0x36, 0xB8, 0x81, 0x99, 0x20,  // ..t6... 
                /* 0128 */  0xCE, 0xE1, 0x61, 0x64, 0x40, 0x68, 0x02, 0xF1,  // ..ad@h..
                /* 0130 */  0x63, 0x87, 0x4F, 0x60, 0xF7, 0xC7, 0x01, 0x29,  // c.O`...)
                /* 0138 */  0x44, 0xD0, 0x85, 0xE0, 0x4C, 0x6B, 0x14, 0x60,  // D...Lk.`
                /* 0140 */  0xED, 0xEC, 0x20, 0x5B, 0x10, 0x3A, 0x0B, 0xC4,  // .. [.:..
                /* 0148 */  0x6A, 0x0C, 0x45, 0x10, 0x11, 0x82, 0x46, 0x31,  // j.E...F1
                /* 0150 */  0x5E, 0x84, 0x50, 0x21, 0xA2, 0x44, 0x3D, 0xE7,  // ^.P!.D=.
                /* 0158 */  0x20, 0xB5, 0x09, 0x50, 0x06, 0x22, 0xB4, 0x60,  //  ..P.".`
                /* 0160 */  0x46, 0x60, 0xF6, 0x07, 0x41, 0x24, 0x58, 0x80,  // F`..A$X.
                /* 0168 */  0xF8, 0x23, 0xB0, 0x84, 0x13, 0x81, 0x8C, 0x8C,  // .#......
                /* 0170 */  0x86, 0x1E, 0x16, 0x7C, 0x12, 0x60, 0x07, 0x04,  // ...|.`..
                /* 0178 */  0xCF, 0xE7, 0xD4, 0x4C, 0xE0, 0xC0, 0x10, 0xE2,  // ...L....
                /* 0180 */  0x95, 0x00, 0x51, 0x47, 0x0B, 0x4A, 0x60, 0x29,  // ..QG.J`)
                /* 0188 */  0x47, 0x03, 0x62, 0x7B, 0x60, 0xBA, 0x07, 0x1C,  // G.b{`...
                /* 0190 */  0xE1, 0xB9, 0xFB, 0x72, 0x70, 0x6A, 0xFE, 0x69,  // ...rpj.i
                /* 0198 */  0x78, 0x9A, 0x0F, 0x09, 0x98, 0x21, 0x7A, 0xAC,  // x....!z.
                /* 01A0 */  0x07, 0x11, 0xF0, 0x10, 0xD9, 0x29, 0xC1, 0x80,  // .....)..
                /* 01A8 */  0x78, 0xEF, 0xD7, 0x02, 0x32, 0x82, 0x97, 0x04,  // x...2...
                /* 01B0 */  0x03, 0x7A, 0x12, 0x0F, 0x08, 0x60, 0x39, 0x68,  // .z...`9h
                /* 01B8 */  0x1C, 0xF8, 0x09, 0x55, 0x7C, 0x07, 0xA0, 0x47,  // ...U|..G
                /* 01C0 */  0x02, 0x36, 0xA3, 0xF8, 0x26, 0x28, 0xEB, 0xF8,  // .6..&(..
                /* 01C8 */  0x80, 0x9E, 0x73, 0xB4, 0x67, 0x87, 0x97, 0x85,  // ..s.g...
                /* 01D0 */  0x66, 0xAF, 0x18, 0x84, 0xE0, 0x35, 0xC0, 0x37,  // f....5.7
                /* 01D8 */  0x05, 0x9F, 0x46, 0x2C, 0x69, 0x75, 0x72, 0xB2,  // ..F,iur.
                /* 01E0 */  0x2A, 0x8F, 0x98, 0x82, 0x7B, 0x08, 0x5C, 0x04,  // *...{.\.
                /* 01E8 */  0x9C, 0x86, 0xEE, 0xF1, 0x82, 0x43, 0xC1, 0x78,  // .....C.x
                /* 01F0 */  0xE9, 0xFF, 0x7F, 0xBC, 0xE0, 0x3E, 0x0F, 0x1C,  // .....>..
                /* 01F8 */  0x2F, 0x58, 0x4E, 0x09, 0x55, 0x5D, 0x36, 0x34,  // /XN.U]64
                /* 0200 */  0x87, 0xF3, 0x6D, 0x1E, 0x9F, 0x1C, 0x2D, 0x3C,  // ..m...-<
                /* 0208 */  0x61, 0x36, 0x96, 0xA3, 0x62, 0xC7, 0x10, 0x36,  // a6..b..6
                /* 0210 */  0x3A, 0x3E, 0x0A, 0x0F, 0xF8, 0xB5, 0xA1, 0x58,  // :>.....X
                /* 0218 */  0x10, 0x99, 0x80, 0xD0, 0x91, 0xE1, 0xC0, 0xC1,  // ........
                /* 0220 */  0xE2, 0xEC, 0x00, 0x21, 0x02, 0x0B, 0x1B, 0x39,  // ...!...9
                /* 0228 */  0x7A, 0xC4, 0x1E, 0xD4, 0x3B, 0x8C, 0x31, 0x1E,  // z...;.1.
                /* 0230 */  0x08, 0x8C, 0x7A, 0x48, 0x07, 0x0F, 0x3E, 0x40,  // ..zH..>@
                /* 0238 */  0x0F, 0x1E, 0x70, 0xFA, 0xFF, 0x27, 0xB0, 0xA0,  // ..p..'..
                /* 0240 */  0x21, 0x4B, 0xC4, 0xE0, 0xD1, 0xA7, 0x08, 0x0F,  // !K......
                /* 0248 */  0xE7, 0xDD, 0x87, 0x1F, 0x44, 0x12, 0x38, 0x3C,  // ....D.8<
                /* 0250 */  0x84, 0x06, 0x0F, 0x9E, 0xB3, 0x8F, 0x07, 0x0F,  // ........
                /* 0258 */  0x7E, 0x79, 0x83, 0x07, 0xD1, 0x14, 0x8E, 0x0D,  // ~y......
                /* 0260 */  0x77, 0xB0, 0xF1, 0xC0, 0xC1, 0x3D, 0x5C, 0xFC,  // w....=\.
                /* 0268 */  0x90, 0x70, 0x67, 0x2D, 0x78, 0x3E, 0x27, 0x4F,  // .pg-x>'O
                /* 0270 */  0x06, 0xF0, 0x12, 0x84, 0x3B, 0x6C, 0x01, 0x97,  // ....;l..
                /* 0278 */  0x11, 0x70, 0x99, 0xAB, 0xA4, 0x87, 0x2A, 0x0B,  // .p....*.
                /* 0280 */  0x83, 0x41, 0x9D, 0xAB, 0xC0, 0xFB, 0xFF, 0x3F,  // .A.....?
                /* 0288 */  0x57, 0x01, 0xF6, 0x2F, 0x53, 0xEF, 0x53, 0x3E,  // W../S.S>
                /* 0290 */  0x57, 0x81, 0x3B, 0xDA, 0x79, 0x40, 0xE7, 0x16,  // W.;.y@..
                /* 0298 */  0x72, 0x9A, 0x41, 0x1F, 0x0A, 0x7C, 0x06, 0x78,  // r.A..|.x
                /* 02A0 */  0x92, 0x01, 0xDB, 0xA1, 0x0A, 0x38, 0x9C, 0x64,  // .....8.d
                /* 02A8 */  0xC0, 0x73, 0x2B, 0x7B, 0x92, 0x61, 0xFF, 0xFF,  // .s+{.a..
                /* 02B0 */  0x93, 0x0C, 0x38, 0x0F, 0x62, 0x3E, 0xC9, 0x80,  // ..8.b>..
                /* 02B8 */  0xEF, 0xE8, 0x85, 0x3B, 0x81, 0xC0, 0xF3, 0x38,  // ...;...8
                /* 02C0 */  0x24, 0x21, 0x1F, 0x42, 0xF0, 0x43, 0x3A, 0xA6,  // $!.B.C:.
                /* 02C8 */  0x67, 0x10, 0x60, 0x28, 0xE4, 0x65, 0xE0, 0x03,  // g.`(.e..
                /* 02D0 */  0x08, 0x8D, 0x7E, 0x06, 0x01, 0xB4, 0xFF, 0xFF,  // ..~.....
                /* 02D8 */  0xCF, 0x20, 0xC0, 0xE5, 0xAC, 0xF0, 0x0C, 0x02,  // . ......
                /* 02E0 */  0x76, 0xF1, 0xAF, 0x3A, 0x9D, 0x07, 0x1C, 0x1C,  // v..:....
                /* 02E8 */  0x42, 0x4E, 0x8E, 0x8A, 0xA8, 0xE1, 0x58, 0xEB,  // BN....X.
                /* 02F0 */  0x41, 0x80, 0x8C, 0xE7, 0x45, 0xC0, 0x41, 0x4F,  // A...E.AO
                /* 02F8 */  0x8A, 0x40, 0xF7, 0xAC, 0x81, 0x3B, 0x1F, 0xC0,  // .@...;..
                /* 0300 */  0x3D, 0x12, 0xF2, 0x73, 0x07, 0xF8, 0xA2, 0x43,  // =..s...C
                /* 0308 */  0xE8, 0x98, 0x89, 0x3F, 0x51, 0x79, 0x88, 0x3E,  // ...?Qy.>
                /* 0310 */  0x1B, 0x98, 0xC0, 0xA3, 0x05, 0xD7, 0x39, 0x11,  // ......9.
                /* 0318 */  0x5C, 0xFF, 0xFF, 0xD1, 0xC2, 0x3B, 0x69, 0xE0,  // \....;i.
                /* 0320 */  0x46, 0x0B, 0xF7, 0x00, 0xFC, 0x58, 0x80, 0x39,  // F....X.9
                /* 0328 */  0x62, 0x82, 0xEB, 0xD0, 0x02, 0xA6, 0xEB, 0x02,  // b.......
                /* 0330 */  0xE6, 0xD2, 0x82, 0x3F, 0xB4, 0x00, 0x1F, 0xA1,  // ...?....
                /* 0338 */  0x27, 0x16, 0x94, 0xB4, 0x43, 0x0B, 0xA0, 0xF9,  // '...C...
                /* 0340 */  0xFF, 0x7F, 0x68, 0x01, 0x6E, 0x73, 0x7D, 0x68,  // ..h.ns}h
                /* 0348 */  0x01, 0x7B, 0xB8, 0x73, 0x18, 0x95, 0x73, 0x0E,  // .{.s..s.
                /* 0350 */  0x83, 0x76, 0x68, 0xF6, 0x39, 0x0C, 0xB8, 0x1E,  // .vh.9...
                /* 0358 */  0x26, 0xF0, 0x87, 0x4A, 0xB8, 0xB3, 0x88, 0x1F,  // &..J....
                /* 0360 */  0x27, 0xDA, 0x5B, 0x80, 0xCF, 0xA7, 0xC0, 0xED,  // '.[.....
                /* 0368 */  0xB0, 0x86, 0x3B, 0x82, 0xC0, 0xBB, 0x14, 0x9C,  // ..;.....
                /* 0370 */  0x96, 0xA7, 0xF6, 0xD4, 0x7F, 0x70, 0x8D, 0x5F,  // .....p._
                /* 0378 */  0x41, 0xC8, 0x3D, 0xC6, 0x77, 0x10, 0xF6, 0xFF,  // A.=.w...
                /* 0380 */  0x3F, 0x88, 0x01, 0x37, 0x19, 0x07, 0x31, 0x54,  // ?..7..1T
                /* 0388 */  0xF0, 0x43, 0x08, 0x40, 0xA1, 0xCB, 0xC2, 0x43,  // .C.@...C
                /* 0390 */  0x08, 0xD8, 0xA5, 0x1F, 0xC4, 0x68, 0xEC, 0x83,  // .....h..
                /* 0398 */  0x18, 0xEA, 0xFF, 0x7F, 0x82, 0xC7, 0x9F, 0xC3,  // ........
                /* 03A0 */  0x00, 0xA7, 0x67, 0x38, 0xB8, 0x51, 0x8F, 0x61,  // ..g8.Q.a
                /* 03A8 */  0x80, 0xA2, 0xB3, 0x28, 0x70, 0x82, 0x78, 0x0E,  // ...(p.x.
                /* 03B0 */  0x63, 0xFF, 0xFF, 0x73, 0x18, 0xF0, 0x14, 0xFC,  // c..s....
                /* 03B8 */  0x12, 0xF0, 0x81, 0x85, 0x4A, 0x84, 0x41, 0x9D,  // ....J.A.
                /* 03C0 */  0x59, 0x00, 0xDE, 0x1C, 0x90, 0x9F, 0x59, 0xC0,  // Y.....Y.
                /* 03C8 */  0x1E, 0xF2, 0xAD, 0xA1, 0x1F, 0x81, 0xFF, 0xFF,  // ........
                /* 03D0 */  0x67, 0x16, 0xC0, 0xF5, 0x99, 0xDC, 0x63, 0xC5,  // g.....c.
                /* 03D8 */  0x1D, 0x22, 0xD8, 0x48, 0x42, 0xBE, 0x0A, 0xBC,  // .".HB...
                /* 03E0 */  0x15, 0x98, 0xC0, 0x91, 0x0F, 0x2D, 0x40, 0xF7,  // .....-@.
                /* 03E8 */  0x6C, 0x82, 0x1B, 0x2D, 0xDC, 0xE3, 0xC8, 0x39,  // l..-...9
                /* 03F0 */  0x9E, 0xD0, 0xBB, 0xF9, 0xEB, 0x03, 0x3B, 0x4D,  // ......;M
                /* 03F8 */  0xB0, 0x21, 0x83, 0x57, 0xDE, 0x21, 0x10, 0xF5,  // .!.W.!..
                /* 0400 */  0xFF, 0x1F, 0xB2, 0x0F, 0x24, 0x9E, 0xC2, 0xCB,  // ....$...
                /* 0408 */  0x0C, 0x66, 0x26, 0x31, 0x0E, 0x24, 0xC2, 0xB1,  // .f&1.$..
                /* 0410 */  0x78, 0x78, 0xE4, 0x28, 0x08, 0xAA, 0x33, 0x3F,  // xx.(..3?
                /* 0418 */  0x19, 0x35, 0xE8, 0x67, 0xF7, 0x84, 0x0F, 0x9E,  // .5.g....
                /* 0420 */  0xE9, 0xBE, 0xE1, 0x83, 0xE1, 0x30, 0x08, 0x73,  // .....0.s
                /* 0428 */  0xCE, 0x1E, 0x3F, 0xF8, 0x8E, 0x3D, 0xB8, 0x73,  // ..?..=.s
                /* 0430 */  0x10, 0xBC, 0xEB, 0x8A, 0x91, 0x4F, 0xE8, 0x25,  // .....O.%
                /* 0438 */  0x00, 0x73, 0x6B, 0xC1, 0x9E, 0x05, 0x81, 0x93,  // .sk.....
                /* 0440 */  0xAC, 0x83, 0x20, 0x4A, 0xC8, 0x59, 0x10, 0x54,  // .. J.Y.T
                /* 0448 */  0xFF, 0xFF, 0x83, 0x10, 0xC0, 0x04, 0x6F, 0xF7,  // ......o.
                /* 0450 */  0x20, 0x5D, 0x83, 0x7C, 0x1B, 0x78, 0x1A, 0x78,  //  ].|.x.x
                /* 0458 */  0xF8, 0x89, 0xF2, 0x20, 0xE4, 0x8B, 0xC4, 0x0B,  // ... ....
                /* 0460 */  0x41, 0x84, 0x28, 0xC7, 0x7B, 0x02, 0x11, 0x9E,  // A.(.{...
                /* 0468 */  0x86, 0x3C, 0xE1, 0x30, 0xE1, 0x4E, 0x36, 0xCA,  // .<.0.N6.
                /* 0470 */  0x4B, 0x43, 0x18, 0x43, 0xC7, 0x0A, 0x14, 0x39,  // KC.C...9
                /* 0478 */  0x7E, 0x08, 0x1F, 0x85, 0x7C, 0x10, 0x62, 0x51,  // ~...|.bQ
                /* 0480 */  0xCE, 0xB7, 0xF4, 0xFC, 0x61, 0x23, 0x67, 0x11,  // ....a#g.
                /* 0488 */  0xD4, 0x49, 0xC0, 0x87, 0x0E, 0x0F, 0xEA, 0x09,  // .I......
                /* 0490 */  0x01, 0x13, 0x1A, 0x42, 0x47, 0x5C, 0xE0, 0x7A,  // ...BG\.z
                /* 0498 */  0xDA, 0xC0, 0xFD, 0xFF, 0x8F, 0x42, 0xE0, 0x38,  // .....B.8
                /* 04A0 */  0x80, 0xC0, 0x7B, 0x47, 0xF8, 0xB4, 0x0E, 0x2E,  // ..{G....
                /* 04A8 */  0x08, 0x9F, 0x3F, 0xE0, 0xFB, 0x44, 0x16, 0xEE,  // ..?..D..
                /* 04B0 */  0x5B, 0xC0, 0x0B, 0x0D, 0xEE, 0xEC, 0x01, 0x7C,  // [......|
                /* 04B8 */  0xE4, 0x1E, 0x6B, 0x51, 0x02, 0x61, 0x50, 0x67,  // ..kQ.aPg
                /* 04C0 */  0x0F, 0xC0, 0xF9, 0xFF, 0xFF, 0xEC, 0x01, 0xD6,  // ........
                /* 04C8 */  0x81, 0x3E, 0x7A, 0x1C, 0xE8, 0x31, 0x06, 0x89,  // .>z..1..
                /* 04D0 */  0x11, 0xC4, 0x77, 0x0E, 0x1F, 0x7C, 0xE2, 0xBC,  // ..w..|..
                /* 04D8 */  0x11, 0x3C, 0x7B, 0xF8, 0xC8, 0x71, 0x5C, 0x3E,  // .<{..q\>
                /* 04E0 */  0x80, 0xF8, 0xEC, 0xE1, 0x2B, 0x88, 0xF1, 0xC2,  // ....+...
                /* 04E8 */  0xC4, 0x7C, 0x38, 0xF2, 0x35, 0x21, 0x5E, 0xE4,  // .|8.5!^.
                /* 04F0 */  0xB0, 0x61, 0x22, 0xFB, 0xEC, 0xC1, 0x22, 0x1E,  // .a"...".
                /* 04F8 */  0x6B, 0xA9, 0x94, 0x83, 0x19, 0xFA, 0x4C, 0xE0,  // k.....L.
                /* 0500 */  0x5B, 0xC2, 0x99, 0xBD, 0x71, 0x44, 0x38, 0xAE,  // [...qD8.
                /* 0508 */  0x93, 0x3B, 0x9F, 0x38, 0x1E, 0xD2, 0x49, 0xFB,  // .;.8..I.
                /* 0510 */  0x6C, 0x06, 0xBE, 0xE3, 0x07, 0x70, 0x38, 0x9B,  // l....p8.
                /* 0518 */  0x81, 0x67, 0x74, 0x70, 0x0F, 0x53, 0xE0, 0x93,  // .gtp.S..
                /* 0520 */  0x75, 0x36, 0x43, 0x0F, 0xCB, 0xE7, 0x82, 0x57,  // u6C....W
                /* 0528 */  0x07, 0x0F, 0x82, 0x9D, 0xCB, 0xC0, 0x75, 0xB8,  // ......u.
                /* 0530 */  0x83, 0xF3, 0xFF, 0x3F, 0x97, 0x01, 0xAF, 0x73,  // ...?...s
                /* 0538 */  0xC7, 0x91, 0xB1, 0x53, 0x05, 0x47, 0x3C, 0xA8,  // ...S.G<.
                /* 0540 */  0x33, 0x79, 0x77, 0x39, 0x6B, 0x1F, 0x3C, 0x02,  // 3yw9k.<.
                /* 0548 */  0x9D, 0xE7, 0x29, 0xFB, 0x1C, 0x03, 0x73, 0x84,  // ..)...s.
                /* 0550 */  0x1E, 0x3B, 0xF8, 0x0E, 0x26, 0xF8, 0x83, 0x0C,  // .;..&...
                /* 0558 */  0x1C, 0x98, 0x13, 0x38, 0xBA, 0x40, 0xA7, 0x10,  // ...8.@..
                /* 0560 */  0xE7, 0x14, 0x9E, 0x63, 0x80, 0x91, 0x1C, 0x4B,  // ...c...K
                /* 0568 */  0x20, 0x2C, 0xC0, 0xB1, 0x40, 0xA2, 0x96, 0x49,  //  ,..@..I
                /* 0570 */  0x61, 0x7C, 0x32, 0xF0, 0x39, 0x06, 0xAE, 0x24,  // a|2.9..$
                /* 0578 */  0x38, 0xD4, 0xF8, 0x3C, 0xB2, 0x97, 0xBC, 0xE3,  // 8..<....
                /* 0580 */  0x3C, 0x91, 0x37, 0x04, 0x8F, 0xFF, 0x81, 0x06,  // <.7.....
                /* 0588 */  0xC6, 0xC0, 0x3D, 0xAD, 0x93, 0xF2, 0x4D, 0xEE,  // ..=...M.
                /* 0590 */  0xB1, 0xC4, 0x67, 0x43, 0x7E, 0x5C, 0x60, 0x68,  // ..gC~\`h
                /* 0598 */  0xFC, 0x74, 0x03, 0x86, 0xFF, 0xFF, 0xE9, 0x06,  // .t......
                /* 05A0 */  0xCE, 0x9D, 0xC1, 0x47, 0x0D, 0xB0, 0x5C, 0x6D,  // ...G..\m
                /* 05A8 */  0x30, 0x58, 0xA1, 0x62, 0x34, 0x7A, 0xD7, 0x23,  // 0X.b4z.#
                /* 05B0 */  0xA0, 0xC7, 0xD7, 0xD7, 0x45, 0x9A, 0x42, 0x45,  // ....E.BE
                /* 05B8 */  0x0C, 0xF1, 0x42, 0x60, 0x97, 0xC7, 0x71, 0xE4,  // ..B`..q.
                /* 05C0 */  0x59, 0x17, 0x5C, 0xD8, 0xCF, 0xBA, 0x60, 0x0F,  // Y.\...`.
                /* 05C8 */  0x75, 0x4E, 0xA2, 0x91, 0x46, 0x83, 0x3A, 0xC8,  // uN..F.:.
                /* 05D0 */  0xF0, 0x03, 0xC1, 0x63, 0x90, 0x4F, 0x1E, 0x06,  // ...c.O..
                /* 05D8 */  0x39, 0xD1, 0xD3, 0x7A, 0x5C, 0x78, 0x1A, 0xF0,  // 9..z\x..
                /* 05E0 */  0xB8, 0xD9, 0x35, 0xC1, 0x1F, 0x04, 0x1F, 0x0F,  // ..5.....
                /* 05E8 */  0xF0, 0x97, 0xA0, 0x80, 0x27, 0xFA, 0xF0, 0x01,  // ....'...
                /* 05F0 */  0xEB, 0x10, 0x82, 0x3F, 0x61, 0xC0, 0x1F, 0x8F,  // ...?a...
                /* 05F8 */  0x8F, 0x01, 0x3E, 0xD1, 0xFA, 0x48, 0x45, 0x06,  // ..>..HE.
                /* 0600 */  0x81, 0x3A, 0xBC, 0xF1, 0x91, 0x9E, 0xD6, 0xDB,  // .:......
                /* 0608 */  0x80, 0x0F, 0x09, 0x87, 0xC5, 0x0E, 0x1E, 0x3E,  // .......>
                /* 0610 */  0xA3, 0x80, 0x63, 0x3C, 0xF0, 0x6F, 0x9F, 0x4F,  // ..c<.o.O
                /* 0618 */  0x07, 0xFF, 0xFF, 0x08, 0xAF, 0x0C, 0x9E, 0xAF,  // ........
                /* 0620 */  0x0F, 0x66, 0x60, 0xB9, 0x75, 0xF8, 0xD0, 0x10,  // .f`.u...
                /* 0628 */  0xEA, 0xA9, 0xC3, 0x33, 0x78, 0xBF, 0xF0, 0x09,  // ...3x...
                /* 0630 */  0x04, 0x98, 0x04, 0x36, 0x34, 0x48, 0x26, 0x73,  // ...64H&s
                /* 0638 */  0x9D, 0xB2, 0x71, 0xDA, 0xA1, 0xC3, 0xB4, 0xC8,  // ..q.....
                /* 0640 */  0x03, 0x82, 0x8E, 0x06, 0x3E, 0xD2, 0xF8, 0x80,  // ....>...
                /* 0648 */  0xCB, 0x0F, 0x49, 0x86, 0xB0, 0x30, 0x0A, 0x9D,  // ..I..0..
                /* 0650 */  0x7C, 0x3C, 0x1A, 0x0F, 0x8F, 0xC0, 0x51, 0x10,  // |<....Q.
                /* 0658 */  0x8F, 0xDC, 0x21, 0x21, 0x64, 0xE4, 0x10, 0x80,  // ..!!d...
                /* 0660 */  0x3E, 0x2C, 0x30, 0x88, 0x87, 0x2E, 0x13, 0xF8,  // >,0.....
                /* 0668 */  0xD8, 0xE0, 0xF3, 0x1A, 0x9C, 0xE3, 0x91, 0x27,  // .......'
                /* 0670 */  0xE3, 0x69, 0x78, 0xDC, 0xB8, 0x53, 0x07, 0xDC,  // .ix..S..
                /* 0678 */  0x71, 0xE0, 0x0F, 0x3A, 0xF8, 0x53, 0x20, 0x3F,  // q..:.S ?
                /* 0680 */  0x27, 0x91, 0xF3, 0x1F, 0xA8, 0x04, 0x9E, 0x0B,  // '.......
                /* 0688 */  0x40, 0x01, 0xE4, 0xAB, 0x80, 0x95, 0x1E, 0x07,  // @.......
                /* 0690 */  0xE8, 0x14, 0x42, 0x84, 0x89, 0x66, 0x78, 0x4C,  // ..B..fxL
                /* 0698 */  0xF0, 0xD3, 0x17, 0x1D, 0x8F, 0x87, 0xE5, 0xFF,  // ........
                /* 06A0 */  0xFF, 0x20, 0xF9, 0xF1, 0x85, 0x61, 0x3F, 0x9D,  // . ...a?.
                /* 06A8 */  0xF8, 0xD4, 0x76, 0x8C, 0xEF, 0x05, 0x8F, 0x5F,  // ..v...._
                /* 06B0 */  0x18, 0x58, 0x0F, 0x9B, 0xC3, 0x1A, 0x2D, 0xEC,  // .X....-.
                /* 06B8 */  0xD1, 0x3E, 0x3E, 0xF8, 0xEA, 0xE1, 0x89, 0xF9,  // .>>.....
                /* 06C0 */  0x16, 0xE7, 0x43, 0x07, 0x58, 0x0E, 0x52, 0xC0,  // ..C.X.R.
                /* 06C8 */  0xE3, 0xFC, 0xC3, 0xE6, 0xF0, 0x02, 0xF1, 0x1C,  // ........
                /* 06D0 */  0xE6, 0x83, 0x07, 0x3B, 0xF1, 0xB1, 0x53, 0x1F,  // ...;..S.
                /* 06D8 */  0xD7, 0x75, 0x8E, 0x43, 0x9C, 0x21, 0xF8, 0x20,  // .u.C.!. 
                /* 06E0 */  0x1C, 0x67, 0x91, 0xF2, 0x38, 0x53, 0x72, 0x95,  // .g..8Sr.
                /* 06E8 */  0x7C, 0xE0, 0xA8, 0x1A, 0x45, 0xF0, 0xBE, 0x15,  // |...E...
                /* 06F0 */  0xB0, 0x08, 0xC7, 0x08, 0x94, 0x78, 0x0A, 0x49,  // .....x.I
                /* 06F8 */  0x3F, 0x46, 0xA0, 0xC4, 0xC2, 0x51, 0x10, 0x1F,  // ?F...Q..
                /* 0700 */  0x23, 0x7C, 0x90, 0xB0, 0x8D, 0x63, 0x04, 0x6A,  // #|...c.j
                /* 0708 */  0x8C, 0x3E, 0x0C, 0xF2, 0xA3, 0x00, 0x3F, 0x45,  // .>....?E
                /* 0710 */  0xC0, 0x3F, 0xF1, 0xE0, 0xC6, 0x0A, 0x77, 0x70,  // .?....wp
                /* 0718 */  0x6C, 0x85, 0x2F, 0x3D, 0x87, 0x76, 0x76, 0x0F,  // l./=.vv.
                /* 0720 */  0x09, 0x51, 0xDE, 0x5F, 0x8D, 0x18, 0x21, 0x60,  // .Q._..!`
                /* 0728 */  0xD8, 0x68, 0x1E, 0x23, 0xEE, 0xD8, 0xCE, 0x2E,  // .h.#....
                /* 0730 */  0x45, 0x9E, 0x53, 0xAC, 0x47, 0x25, 0x7E, 0xA4,  // E.S.G%~.
                /* 0738 */  0x80, 0xF7, 0xFF, 0x27, 0xF0, 0x31, 0x0F, 0x77,  // ...'.1.w
                /* 0740 */  0xA4, 0x80, 0x33, 0x93, 0xF3, 0xC0, 0xA8, 0x1B,  // ..3.....
                /* 0748 */  0x8B, 0xE0, 0x8D, 0xF6, 0x92, 0x8D, 0x3D, 0x58,  // ......=X
                /* 0750 */  0x00, 0x8F, 0x13, 0xA3, 0x0F, 0x16, 0xE0, 0x3A,  // .......:
                /* 0758 */  0x13, 0xF8, 0x60, 0x01, 0x5C, 0xCF, 0x07, 0x3E,  // ..`.\..>
                /* 0760 */  0x1D, 0x80, 0xF5, 0xF2, 0xC3, 0xEF, 0x07, 0x30,  // .......0
                /* 0768 */  0x4E, 0x18, 0x30, 0xCE, 0x07, 0x98, 0x1B, 0x86,  // N.0.....
                /* 0770 */  0xC3, 0x2C, 0x59, 0x27, 0x0C, 0x7E, 0x5C, 0x73,  // .,Y'.~\s
                /* 0778 */  0xA4, 0xD5, 0x6A, 0x20, 0xEC, 0x12, 0x86, 0x23,  // ..j ...#
                /* 0780 */  0x18, 0x04, 0x4C, 0x27, 0x0B, 0x8F, 0xDA, 0x11,  // ..L'....
                /* 0788 */  0x28, 0x24, 0xED, 0x80, 0x81, 0x12, 0x73, 0xC0,  // ($....s.
                /* 0790 */  0xA0, 0x20, 0x06, 0x74, 0x52, 0x08, 0x9D, 0x45,  // . .tR..E
                /* 0798 */  0xFD, 0xFF, 0x3F, 0x60, 0xF0, 0x83, 0x9D, 0x4F,  // ..?`...O
                /* 07A0 */  0x0D, 0xEC, 0x72, 0xEB, 0xEB, 0x85, 0xE7, 0xE9,  // ..r.....
                /* 07A8 */  0x29, 0x73, 0x3C, 0x1F, 0x43, 0x0C, 0xEB, 0x8B,  // )s<.C...
                /* 07B0 */  0x09, 0x78, 0x6E, 0x14, 0xEC, 0x34, 0x8B, 0xB9,  // .xn..4..
                /* 07B8 */  0xB8, 0xB1, 0xB3, 0x1D, 0x3B, 0x15, 0x18, 0xE5,  // ....;...
                /* 07C0 */  0x70, 0xDF, 0xC0, 0xAC, 0xE6, 0xAA, 0x80, 0x9A,  // p.......
                /* 07C8 */  0x11, 0x86, 0xC0, 0xE3, 0xF5, 0x81, 0x11, 0x4C,  // .......L
                /* 07D0 */  0xFA, 0x2E, 0x14, 0x20, 0x47, 0xE7, 0x32, 0x47,  // ... G.2G
                /* 07D8 */  0x8F, 0x3A, 0x47, 0xF9, 0x24, 0xC5, 0x47, 0xEF,  // .:G.$.G.
                /* 07E0 */  0xA3, 0xB9, 0x4F, 0x2B, 0x70, 0xCF, 0x52, 0x3E,  // ..O+p.R>
                /* 07E8 */  0x42, 0x01, 0xDF, 0x81, 0xF9, 0x52, 0x80, 0x3B,  // B....R.;
                /* 07F0 */  0xA0, 0x80, 0xE1, 0xFA, 0x80, 0xFD, 0xFF, 0xC3,  // ........
                /* 07F8 */  0xBC, 0xA2, 0xE0, 0xCF, 0x28, 0xC0, 0x24, 0xF0,  // ....(.$.
                /* 0800 */  0x59, 0x0A, 0x74, 0x90, 0x3E, 0xA3, 0x00, 0xD7,  // Y.t.>...
                /* 0808 */  0xA1, 0xE2, 0xCE, 0x28, 0xE0, 0x38, 0x10, 0x1E,  // ...(.8..
                /* 0810 */  0x3D, 0x3F, 0x47, 0xB1, 0x38, 0xC7, 0x12, 0x74,  // =?G.8..t
                /* 0818 */  0xA8, 0x97, 0x83, 0x6E, 0x9B, 0xEC, 0x58, 0x82,  // ...n..X.
                /* 0820 */  0x8D, 0x72, 0x2C, 0x41, 0x85, 0xA0, 0xD0, 0x09,  // .r,A....
                /* 0828 */  0xCA, 0x27, 0x09, 0x7E, 0xC6, 0xE3, 0x20, 0x06,  // .'.~.. .
                /* 0830 */  0x74, 0xF6, 0x93, 0x04, 0x5A, 0xC5, 0x49, 0x02,  // t...Z.I.
                /* 0838 */  0x19, 0xF6, 0x5C, 0x02, 0x84, 0xFE, 0xFF, 0xE7,  // ..\.....
                /* 0840 */  0x12, 0xF0, 0x9E, 0x13, 0x9F, 0x26, 0xC0, 0x35,  // .....&.5
                /* 0848 */  0x6B, 0xFC, 0x69, 0x02, 0x7F, 0x3E, 0x01, 0x16,  // k.i..>..
                /* 0850 */  0x47, 0x46, 0xC0, 0xD9, 0x41, 0x90, 0x1F, 0x19,  // GF..A...
                /* 0858 */  0x81, 0xEF, 0xB9, 0x84, 0xFF, 0xFF, 0xCF, 0x25,  // .......%
                /* 0860 */  0xE0, 0x19, 0xB6, 0xCF, 0x25, 0x80, 0x93, 0x9B,  // ....%...
                /* 0868 */  0x34, 0x3F, 0x97, 0xC0, 0x1D, 0xBA, 0xE3, 0x9C,  // 4?......
                /* 0870 */  0xBE, 0x10, 0x57, 0x58, 0xDF, 0x33, 0xE2, 0x27,  // ..WX.3.'
                /* 0878 */  0x18, 0xE3, 0x58, 0x82, 0x0A, 0x70, 0xF8, 0x02,  // ..X..p..
                /* 0880 */  0xB4, 0xFF, 0xFF, 0x4F, 0x23, 0xE0, 0x3F, 0x17,  // ...O#.?.
                /* 0888 */  0x7B, 0xF4, 0xFC, 0x40, 0xE2, 0x43, 0x06, 0x19,  // {..@.C..
                /* 0890 */  0x3D, 0x8D, 0x7C, 0xF8, 0x82, 0x1E, 0xF1, 0x30,  // =.|....0
                /* 0898 */  0x02, 0xB4, 0x07, 0xFA, 0xF0, 0x05, 0xC6, 0xDB,  // ........
                /* 08A0 */  0x03, 0x3F, 0x6E, 0x02, 0xAF, 0xD8, 0x87, 0x12,  // .?n.....
                /* 08A8 */  0xD0, 0xC1, 0xF2, 0x43, 0x09, 0xF8, 0xFF, 0xFF,  // ...C....
                /* 08B0 */  0x87, 0x12, 0xF0, 0x8C, 0x1E, 0x77, 0xF6, 0x02,  // .....w..
                /* 08B8 */  0xC7, 0x55, 0xC2, 0x83, 0x37, 0xE0, 0x31, 0x3D,  // .U..7.1=
                /* 08C0 */  0x16, 0x18, 0x90, 0x9D, 0x4B, 0x98, 0xEC, 0x73,  // ....K..s
                /* 08C8 */  0x09, 0xFA, 0x3C, 0x62, 0xAB, 0xB7, 0x63, 0x72,  // ..<b..cr
                /* 08D0 */  0x52, 0xC7, 0x08, 0x3F, 0x97, 0xA0, 0x24, 0x9F,  // R..?..$.
                /* 08D8 */  0x4B, 0x00, 0xDA, 0x1C, 0xBA, 0xC0, 0xF1, 0xFF,  // K.......
                /* 08E0 */  0x3F, 0x74, 0x01, 0x3C, 0xB8, 0x06, 0xFA, 0x40,  // ?t.<...@
                /* 08E8 */  0x02, 0xAE, 0x7B, 0x82, 0x0F, 0x24, 0xC0, 0xF5,  // ..{..$..
                /* 08F0 */  0x28, 0x00, 0x9E, 0x23, 0x08, 0xFE, 0xC8, 0xEC,  // (..#....
                /* 08F8 */  0x03, 0x3F, 0xEE, 0xA4, 0xEF, 0x53, 0x75, 0x5C,  // .?...Su\
                /* 0900 */  0xE3, 0x1F, 0xF1, 0x11, 0xFC, 0xFF, 0x1B, 0x3F,  // .......?
                /* 0908 */  0x7D, 0x91, 0x7B, 0x81, 0x8F, 0x25, 0x3A, 0xF0,  // }.{..%:.
                /* 0910 */  0xA3, 0x04, 0x53, 0x48, 0xEE, 0x01, 0x02, 0x25,  // ..SH...%
                /* 0918 */  0x10, 0x8E, 0x82, 0xF8, 0x00, 0xE1, 0xF0, 0xE7,  // ........
                /* 0920 */  0x24, 0xE8, 0x57, 0x4B, 0x7E, 0x7E, 0xC0, 0x5F,  // $.WK~~._
                /* 0928 */  0x47, 0xD8, 0x28, 0xD9, 0x71, 0x1E, 0x37, 0x4A,  // G.(.q.7J
                /* 0930 */  0xB8, 0x60, 0xAF, 0x0F, 0x86, 0xB8, 0xC3, 0x13,  // .`......
                /* 0938 */  0xE1, 0x67, 0x5B, 0xCC, 0x31, 0x1F, 0xEE, 0x51,  // .g[.1..Q
                /* 0940 */  0xE1, 0x51, 0x09, 0x5C, 0xB3, 0x86, 0x75, 0x58,  // .Q.\..uX
                /* 0948 */  0x02, 0x3C, 0x78, 0x38, 0x4C, 0x00, 0xAD, 0xFF,  // .<x8L...
                /* 0950 */  0xFF, 0x61, 0x09, 0xFC, 0xB3, 0xE7, 0x83, 0x38,  // .a.....8
                /* 0958 */  0x11, 0x0F, 0x1F, 0x03, 0x74, 0x2C, 0x6F, 0x07,  // ....t,o.
                /* 0960 */  0xEC, 0xD8, 0xAB, 0xC3, 0x12, 0x6A, 0x0C, 0x3E,  // .....j.>
                /* 0968 */  0xFA, 0xFA, 0xE8, 0xC4, 0x20, 0x1F, 0x0F, 0x31,  // .... ..1
                /* 0970 */  0xC7, 0x16, 0x76, 0xC2, 0x07, 0xF8, 0xF6, 0xFF,  // ..v.....
                /* 0978 */  0x3F, 0xE1, 0x03, 0xD6, 0xCE, 0x24, 0xBE, 0x3F,  // ?....$.?
                /* 0980 */  0x60, 0xAF, 0x2D, 0xF8, 0xA3, 0x09, 0xF0, 0x06,  // `.-.....
                /* 0988 */  0xF7, 0xD1, 0x04, 0x70, 0xF5, 0xFF, 0x3F, 0x9A,  // ...p..?.
                /* 0990 */  0xE0, 0x84, 0x9E, 0x9D, 0x50, 0x67, 0x03, 0x1F,  // ....Pg..
                /* 0998 */  0x98, 0x6C, 0x14, 0x95, 0x40, 0xBF, 0x69, 0xBC,  // .l..@.i.
                /* 09A0 */  0x9F, 0x07, 0x31, 0xF4, 0x49, 0xF0, 0x53, 0x13,  // ..1.I.S.
                /* 09A8 */  0x06, 0xC2, 0x47, 0x13, 0x9F, 0x24, 0x7C, 0x9C,  // ..G..$|.
                /* 09B0 */  0xE0, 0x52, 0xE0, 0x28, 0x88, 0x8F, 0x13, 0x8E,  // .R.(....
                /* 09B8 */  0x79, 0x36, 0x41, 0x9F, 0x0A, 0x7C, 0x3F, 0x38,  // y6A..|?8
                /* 09C0 */  0x09, 0x6C, 0xA8, 0xF3, 0x04, 0x50, 0x19, 0x07,  // .l...P..
                /* 09C8 */  0xFE, 0xE8, 0x04, 0x57, 0xD8, 0xC9, 0x04, 0x64,  // ...W...d
                /* 09D0 */  0x27, 0x72, 0x60, 0x6E, 0xE2, 0x1C, 0x01, 0x94,  // 'r`n....
                /* 09D8 */  0xFE, 0xFF, 0x27, 0x72, 0xE0, 0x70, 0x5A, 0xE5,  // ..'r.pZ.
                /* 09E0 */  0xA7, 0x01, 0x7C, 0xA0, 0xA3, 0x2A, 0x3A, 0xD6,  // ..|..*:.
                /* 09E8 */  0x93, 0x41, 0x23, 0x7E, 0x07, 0x08, 0x77, 0xEA,  // .A#~..w.
                /* 09F0 */  0xE7, 0xF9, 0x40, 0xC0, 0x8E, 0xE5, 0x3E, 0x2C,  // ..@...>,
                /* 09F8 */  0xF1, 0xF3, 0x92, 0x4F, 0x11, 0x3E, 0x41, 0x70,  // ...O.>Ap
                /* 0A00 */  0x49, 0x27, 0x08, 0x0A, 0x62, 0x40, 0xE7, 0x3D,  // I'..b@.=
                /* 0A08 */  0x5D, 0x7A, 0x10, 0xF4, 0x7C, 0xC3, 0x8F, 0xC5,  // ]z..|...
                /* 0A10 */  0xBE, 0xB6, 0x1C, 0xC5, 0x23, 0x51, 0x82, 0xF9,  // ....#Q..
                /* 0A18 */  0x0E, 0x01, 0xF4, 0xB6, 0x04, 0x4F, 0xDE, 0x6D,  // .....O.m
                /* 0A20 */  0x09, 0x44, 0x18, 0x77, 0x72, 0x16, 0x0C, 0xE1,  // .D.wr...
                /* 0A28 */  0x28, 0x7D, 0x80, 0x80, 0x31, 0xC0, 0xC7, 0x84,  // (}..1...
                /* 0A30 */  0x62, 0xDF, 0x37, 0xF4, 0xBE, 0x04, 0xF3, 0x8A,  // b.7.....
                /* 0A38 */  0x09, 0xAE, 0xF3, 0x12, 0x30, 0x9E, 0x89, 0xFF,  // ....0...
                /* 0A40 */  0xFF, 0x3E, 0xCF, 0x21, 0xE4, 0x02, 0xC0, 0x4F,  // .>.!...O
                /* 0A48 */  0xE5, 0x60, 0x39, 0x36, 0x80, 0x67, 0x1C, 0xEC,  // .`96.g..
                /* 0A50 */  0x0A, 0x80, 0x3F, 0x32, 0xC1, 0x3E, 0x35, 0xE2,  // ..?2.>5.
                /* 0A58 */  0x8E, 0x4C, 0x60, 0x98, 0x08, 0x3B, 0xE7, 0x1C,  // .L`..;..
                /* 0A60 */  0x08, 0xF6, 0x60, 0x02, 0xBC, 0x55, 0x1C, 0x4C,  // ..`..U.L
                /* 0A68 */  0x00, 0x2D, 0xC3, 0x0D, 0x72, 0x3E, 0x8F, 0xE4,  // .-..r>..
                /* 0A70 */  0xC6, 0x79, 0xC3, 0xF3, 0x89, 0x84, 0x9D, 0xC4,  // .y......
                /* 0A78 */  0xD9, 0xFF, 0xFF, 0x60, 0xC2, 0x25, 0x41, 0x48,  // ...`.%AH
                /* 0A80 */  0xFE, 0x61, 0x09, 0x89, 0x8D, 0x9D, 0xFE, 0x39,  // .a.....9
                /* 0A88 */  0xBC, 0xB9, 0x32, 0x82, 0x62, 0x8F, 0x4B, 0xA8,  // ..2.b.K.
                /* 0A90 */  0xC3, 0x84, 0x45, 0x9E, 0x26, 0x50, 0xA7, 0x69,  // ..E.&P.i
                /* 0A98 */  0x9F, 0x90, 0xC9, 0x69, 0x82, 0x46, 0x3E, 0x4D,  // ...i.F>M
                /* 0AA0 */  0xA0, 0x87, 0xE6, 0x89, 0x9D, 0x06, 0x6E, 0xDC,  // ......n.
                /* 0AA8 */  0xA7, 0xC1, 0x6F, 0x87, 0xFC, 0xC0, 0x04, 0x7C,  // ..o....|
                /* 0AB0 */  0x0F, 0x0F, 0xF8, 0xD3, 0x04, 0xEC, 0xF3, 0x0D,  // ........
                /* 0AB8 */  0x1B, 0x74, 0xC8, 0x77, 0x87, 0x17, 0x59, 0x1F,  // .t.w..Y.
                /* 0AC0 */  0x26, 0x80, 0xF9, 0xC8, 0x7D, 0x98, 0x00, 0xFF,  // &...}...
                /* 0AC8 */  0xFF, 0xFF, 0xD0, 0x04, 0x5C, 0x15, 0xDA, 0xF4,  // ....\...
                /* 0AD0 */  0xA9, 0xD1, 0xA8, 0x55, 0x83, 0x32, 0x35, 0xCA,  // ...U.25.
                /* 0AD8 */  0x34, 0xA8, 0xD5, 0xA7, 0x52, 0x63, 0xC6, 0xA4,  // 4...Rc..
                /* 0AE0 */  0x9D, 0x54, 0xBD, 0x54, 0x8D, 0xD5, 0x91, 0x9E,  // .T.T....
                /* 0AE8 */  0x0B, 0x02, 0x71, 0xD4, 0x05, 0x0B, 0xC4, 0xD1,  // ..q.....
                /* 0AF0 */  0x9F, 0x40, 0x02, 0xB1, 0xB8, 0x57, 0x88, 0x40,  // .@...W.@
                /* 0AF8 */  0x2C, 0xF5, 0x05, 0x21, 0x10, 0xCB, 0xD4, 0x01,  // ,..!....
                /* 0B00 */  0xC2, 0x82, 0xBC, 0xEF, 0x05, 0xE2, 0x60, 0x52,  // ......`R
                /* 0B08 */  0x06, 0x40, 0xAD, 0x80, 0xB0, 0x78, 0xCB, 0x12,  // .@...x..
                /* 0B10 */  0x88, 0x23, 0x9A, 0x39, 0x01, 0x50, 0x37, 0x20,  // .#.9.P7 
                /* 0B18 */  0x4C, 0xA0, 0x1E, 0x10, 0x26, 0xDC, 0x10, 0x08,  // L...&...
                /* 0B20 */  0x8B, 0xA3, 0x08, 0x84, 0x09, 0xB6, 0x04, 0xC2,  // ........
                /* 0B28 */  0xE2, 0x82, 0x50, 0xC1, 0x9E, 0x8E, 0xFD, 0x4C,  // ..P....L
                /* 0B30 */  0x3E, 0x88, 0x80, 0x1C, 0xDA, 0x14, 0x10, 0x93,  // >.......
                /* 0B38 */  0xA0, 0x0A, 0x88, 0x25, 0x78, 0x0C, 0x08, 0xC8,  // ...%x...
                /* 0B40 */  0x71, 0x40, 0x04, 0xE4, 0x50, 0xB6, 0x80, 0x58,  // q@..P..X
                /* 0B48 */  0x44, 0x10, 0x01, 0x59, 0xCF, 0x1B, 0x4E, 0x40,  // D..Y..N@
                /* 0B50 */  0x16, 0x07, 0x22, 0x20, 0x8B, 0x36, 0x06, 0xC4,  // .." .6..
                /* 0B58 */  0x22, 0x80, 0x08, 0xC8, 0xC9, 0x5E, 0x70, 0x81,  // "....^p.
                /* 0B60 */  0x48, 0x4C, 0x10, 0x01, 0x39, 0xEC, 0x8A, 0x05,  // HL..9...
                /* 0B68 */  0xE4, 0xE8, 0x20, 0x02, 0xB2, 0x4E, 0x6F, 0x40,  // .. ..No@
                /* 0B70 */  0x4C, 0x34, 0x88, 0x80, 0x2C, 0xFE, 0xB1, 0x21,  // L4..,..!
                /* 0B78 */  0x20, 0x47, 0x01, 0x11, 0x90, 0x03, 0x3E, 0x28,  //  G....>(
                /* 0B80 */  0x02, 0x91, 0xB8, 0x20, 0x02, 0xB2, 0x46, 0x7B,  // ... ..F{
                /* 0B88 */  0x40, 0x4C, 0x30, 0x88, 0x80, 0x2C, 0xFB, 0x07,  // @L0..,..
                /* 0B90 */  0x25, 0x20, 0x87, 0x00, 0xD1, 0x00, 0xC9, 0xEB,  // % ......
                /* 0B98 */  0x40, 0x03, 0x24, 0xBF, 0x89, 0x40, 0x44, 0xE2,  // @.$..@D.
                /* 0BA0 */  0xAB, 0x22, 0x10, 0xD1, 0x0B, 0x22, 0x20, 0xFF,  // ."..." .
                /* 0BA8 */  0xFF, 0xA5, 0xFF, 0x38, 0x04, 0xE4, 0x20, 0x20,  // ...8..  
                /* 0BB0 */  0x02, 0x26, 0x1A, 0x81, 0xE9, 0x0B, 0x21, 0x10,  // .&....!.
                /* 0BB8 */  0xF9, 0xFF, 0x03                                 // ...
            })
            Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, 0x00)  // _UID: Unique ID
            Name (_WDG, Buffer (0x28)
            {
                /* 0000 */  0x6A, 0x0F, 0xBC, 0xAB, 0xA1, 0x8E, 0xD1, 0x11,  // j.......
                /* 0008 */  0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10, 0x00, 0x00,  // ....)...
                /* 0010 */  0x41, 0x41, 0x01, 0x02, 0x21, 0x12, 0x90, 0x05,  // AA..!...
                /* 0018 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f.......
                /* 0020 */  0xC9, 0x06, 0x29, 0x10, 0x42, 0x41, 0x01, 0x00   // ..).BA..
            })
            Method (WMAA, 3, NotSerialized)
            {
                If ((Arg0 == 0x00))
                {
                    If ((((Arg1 != 0x01) || (Arg1 != 0x02)) || 
                        (Arg1 != 0x06)))
                    {
                        CreateDWordField (Arg2, 0x00, WIID)
                    }

                    If ((Arg1 == 0x01))
                    {
                        Return (AM01 ())
                    }
                    ElseIf ((Arg1 == 0x02))
                    {
                        Return (AM02 ())
                    }
                    ElseIf ((Arg1 == 0x03))
                    {
                        Return (AM03 (WIID))
                    }
                    ElseIf ((Arg1 == 0x04))
                    {
                        CreateDWordField (Arg2, 0x04, IVAL)
                        Return (AM04 (WIID, IVAL))
                    }
                    ElseIf ((Arg1 == 0x05))
                    {
                        Return (AM05 (WIID))
                    }
                    ElseIf ((Arg1 == 0x06))
                    {
                        Return (AM06 ())
                    }
                    ElseIf ((Arg1 == 0x07))
                    {
                        AM07 (Arg2)
                    }
                    ElseIf ((Arg1 == 0x08))
                    {
                        AM08 (WIID)
                    }
                }
            }
        }
    }

    OperationRegion (EXTM, SystemMemory, 0x000FF830, 0x12)
    Field (EXTM, WordAcc, NoLock, Preserve)
    {
        ROM1,   16, 
        RMS1,   16, 
        ROM2,   16, 
        RMS2,   16, 
        ROM3,   16, 
        RMS3,   16, 
        AMEM,   32, 
        AINF,   8
    }

    OperationRegion (AWYM, SystemMemory, 0x000FFFEA, 0x01)
    Field (AWYM, ByteAcc, NoLock, Preserve)
    {
            ,   1, 
            ,   1, 
        AWMD,   1, 
            ,   1, 
            ,   1, 
            ,   1, 
            ,   1, 
        Offset (0x01)
    }

    OperationRegion (\P01, SystemIO, 0x4001, 0x01)
    Field (\P01, ByteAcc, NoLock, Preserve)
    {
        P1,     8
    }

    OperationRegion (\PR20, SystemIO, 0x4020, 0x04)
    Field (\PR20, DWordAcc, NoLock, Preserve)
    {
        P20,    32
    }

    Name (OSFX, 0x01)
    Name (LINX, 0x00)
    Name (AMAC, 0x00)
    Name (OSFL, 0x01)
    Method (STRC, 2, NotSerialized)
    {
        If ((SizeOf (Arg0) != SizeOf (Arg1)))
        {
            Return (0x00)
        }

        Local0 = (SizeOf (Arg0) + 0x01)
        Name (BUF0, Buffer (Local0){})
        Name (BUF1, Buffer (Local0){})
        BUF0 = Arg0
        BUF1 = Arg1
        While (Local0)
        {
            Local0--
            If ((DerefOf (BUF0 [Local0]) != DerefOf (BUF1 [Local0]
                )))
            {
                Return (Zero)
            }
        }

        Return (One)
    }

    OperationRegion (INFO, SystemMemory, 0x000FF840, 0x01)
    Field (INFO, ByteAcc, NoLock, Preserve)
    {
        KBDI,   1, 
        RTCW,   1, 
        PS2F,   1, 
        IRFL,   2, 
        DISE,   1, 
        SSHU,   1
    }

    Scope (\)
    {
        Name (PICF, 0x00)
        Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
        {
            PICF = Arg0
            If (Arg0)
            {
                \_SB.PCI0.LPC0.DSPI ()
            }
        }
    }

    Method (\_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        Local0 = (Arg0 | 0xF0)
        DBG1 = Local0
        If ((Arg0 == 0x01)){}
        If ((Arg0 == 0x05)){}
        SPTS (Arg0)
        APTS (Arg0)
    }

    Method (\_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        DBG1 = 0xFF
        If ((Arg0 == 0x04))
        {
            If ((OSFL == 0x02))
            {
                SMIP = 0x57
            }

            If ((OSFL == 0x01))
            {
                SMIP = 0x56
            }

            If ((OSFL == 0x00))
            {
                If ((OSFX == 0x04))
                {
                    SMIP = 0x59
                }
                ElseIf ((OSFX == 0x03))
                {
                    SMIP = 0x59
                }
                Else
                {
                    SMIP = 0x58
                }
            }

            If ((OSFX == 0x03))
            {
                SMIP = 0x59
            }

            If ((OSFX == 0x04))
            {
                SMIP = 0x59
            }
        }

        SWAK (Arg0)
        AWAK (Arg0)
        If ((OSFL == 0x01))
        {
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }
        Else
        {
            If ((Arg0 == 0x01))
            {
                Local0 = (P1 & 0x04)
                If ((Local0 == 0x00))
                {
                    Notify (\_SB.PWRB, 0x02) // Device Wake
                }
            }

            If ((Arg0 == 0x03))
            {
                If ((RTCW == Zero))
                {
                    Notify (\_SB.PWRB, 0x02) // Device Wake
                }
            }
        }

        If ((Arg0 == 0x04))
        {
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }
    }

    Scope (\_SI)
    {
    }

    Scope (\_GPE)
    {
        Method (_L04, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.P2P, 0x02) // Device Wake
        }

        Method (_L18, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.PCE2, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCE3, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCE4, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCE5, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCE6, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCE7, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCE9, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCEA, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCEB, 0x02) // Device Wake
            Notify (\_SB.PCI0.PCEC, 0x02) // Device Wake
        }

        Method (_L03, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.PS2K, 0x02) // Device Wake
            Notify (\_SB.PCI0.PS2M, 0x02) // Device Wake
        }

        Method (_L0B, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.USB0, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB1, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB2, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB3, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB4, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB5, 0x02) // Device Wake
            Notify (\_SB.PCI0.USB6, 0x02) // Device Wake
        }

        Method (_L1B, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.SBAZ, 0x02) // Device Wake
        }
    }

    Scope (\_SB)
    {
        Device (\AWY)
        {
            Name (_HID, "AWY0001")  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (AWMD)
                {
                    Return (0x0F)
                }

                Return (0x00)
            }
        }

        Method (SMOD, 1, NotSerialized)
        {
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
            Name (_ADR, 0x00)  // _ADR: Address
            Scope (\)
            {
                OperationRegion (\SCPP, SystemIO, 0xB0, 0x01)
                Field (\SCPP, ByteAcc, NoLock, Preserve)
                {
                    SMIP,   8
                }
            }

            Method (\_SB.PCI0._INI, 0, NotSerialized)  // _INI: Initialize
            {
                If (STRC (\_OS, "Microsoft Windows")){}
                ElseIf (STRC (\_OS, "Microsoft Windows NT"))
                {
                    If (CondRefOf (\_OSI, Local0))
                    {
                        Local2 = 0x00
                        If (\_OSI ("Windows 2001"))
                        {
                            OSFL = 0x00
                            Local1 = 0x59
                            OSFX = 0x03
                            Local2 = 0x01
                        }

                        If (\_OSI ("Windows 2006")){}
                        If (\_OSI ("Windows 2009")){}
                        If ((Local2 != 0x00))
                        {
                            SMIP = Local1
                        }
                    }
                    Else
                    {
                        SMIP = 0x58
                        OSFL = 0x00
                    }
                }
                Else
                {
                    If (CondRefOf (\_OSI, Local0))
                    {
                        If (\_OSI ("Linux"))
                        {
                            LINX = 0x01
                        }

                        If (\_OSI ("Darwin"))
                        {
                            AMAC = 0x01
                        }
                    }

                    OSFL = 0x02
                }

                OSTY = OSFX /* \OSFX */
                If ((OSFX == 0x00))
                {
                    OSTY = 0x04
                }

                If ((OSFX == 0x03))
                {
                    OSTY = 0x05
                }

                If ((OSFX == 0x04))
                {
                    OSTY = 0x06
                }
            }

            Device (SYSR)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, 0x01)  // _UID: Unique ID
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    IO (Decode16,
                        0x0010,             // Range Minimum
                        0x0010,             // Range Maximum
                        0x01,               // Alignment
                        0x10,               // Length
                        )
                    IO (Decode16,
                        0x0022,             // Range Minimum
                        0x0022,             // Range Maximum
                        0x01,               // Alignment
                        0x1E,               // Length
                        )
                    IO (Decode16,
                        0x0044,             // Range Minimum
                        0x0044,             // Range Maximum
                        0x01,               // Alignment
                        0x1C,               // Length
                        )
                    IO (Decode16,
                        0x0062,             // Range Minimum
                        0x0062,             // Range Maximum
                        0x01,               // Alignment
                        0x02,               // Length
                        )
                    IO (Decode16,
                        0x0065,             // Range Minimum
                        0x0065,             // Range Maximum
                        0x01,               // Alignment
                        0x0B,               // Length
                        )
                    IO (Decode16,
                        0x0074,             // Range Minimum
                        0x0074,             // Range Maximum
                        0x01,               // Alignment
                        0x0C,               // Length
                        )
                    IO (Decode16,
                        0x0091,             // Range Minimum
                        0x0091,             // Range Maximum
                        0x01,               // Alignment
                        0x03,               // Length
                        )
                    IO (Decode16,
                        0x00A2,             // Range Minimum
                        0x00A2,             // Range Maximum
                        0x01,               // Alignment
                        0x1E,               // Length
                        )
                    IO (Decode16,
                        0x00E0,             // Range Minimum
                        0x00E0,             // Range Maximum
                        0x01,               // Alignment
                        0x10,               // Length
                        )
                    IO (Decode16,
                        0x04D0,             // Range Minimum
                        0x04D0,             // Range Maximum
                        0x01,               // Alignment
                        0x02,               // Length
                        )
                    IO (Decode16,
                        0x0220,             // Range Minimum
                        0x0220,             // Range Maximum
                        0x01,               // Alignment
                        0x06,               // Length
                        )
                    IO (Decode16,
                        0x0290,             // Range Minimum
                        0x0290,             // Range Maximum
                        0x01,               // Alignment
                        0x05,               // Length
                        )
                })
            }

            OperationRegion (BAR1, PCI_Config, 0x14, 0x04)
            Field (BAR1, ByteAcc, NoLock, Preserve)
            {
                MMIO,   32
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                If ((OSFL == 0x02))
                {
                    Return (0x02)
                }
                Else
                {
                    Return (0x03)
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    WordBusNumber (ResourceConsumer, MinNotFixed, MaxNotFixed, PosDecode,
                        0x0000,             // Granularity
                        0x0000,             // Range Minimum
                        0x00FF,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0100,             // Length
                        ,, )
                    IO (Decode16,
                        0x0CF8,             // Range Minimum
                        0x0CF8,             // Range Maximum
                        0x01,               // Alignment
                        0x08,               // Length
                        )
                    WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                        0x0000,             // Granularity
                        0x0000,             // Range Minimum
                        0x0CF7,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0CF8,             // Length
                        ,, , TypeStatic, DenseTranslation)
                    WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                        0x0000,             // Granularity
                        0x0D00,             // Range Minimum
                        0xFFFF,             // Range Maximum
                        0x0000,             // Translation Offset
                        0xF300,             // Length
                        ,, , TypeStatic, DenseTranslation)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000A0000,         // Range Minimum
                        0x000BFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00020000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000C0000,         // Range Minimum
                        0x000DFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00020000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x00100000,         // Range Minimum
                        0xFEBFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0xFEB00000,         // Length
                        ,, _Y00, AddressRangeMemory, TypeStatic)
                })
                CreateDWordField (BUF0, \_SB.PCI0._CRS._Y00._MIN, TCMM)  // _MIN: Minimum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._CRS._Y00._LEN, TOMM)  // _LEN: Length
                TCMM = (AMEM + 0x00010000)
                TCMM += 0x00100000
                TCMM += 0x00100000
                TCMM += SMEM /* \_SB_.SMEM */
                TOMM = (0xFEC00000 - TCMM) /* \_SB_.PCI0._CRS.TCMM */
                Return (BUF0) /* \_SB_.PCI0._CRS.BUF0 */
            }

            Name (PICM, Package (0x38)
            {
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNK0, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNK0, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNK0, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNK0, 
                    0x00
                }
            })
            Name (APIC, Package (0x35)
            {
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x03, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x00, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x01, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x03, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x00, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x01, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x02, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    0x03, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x02, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x03, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x00, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x01, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x01, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x02, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x03, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x02, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x03, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x02, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x03, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x03, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x03, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x02, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x03, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x00, 
                    0x00, 
                    0x16
                }
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (!PICF)
                {
                    Return (PICM) /* \_SB_.PCI0.PICM */
                }
                Else
                {
                    Return (APIC) /* \_SB_.PCI0.APIC */
                }
            }

            Device (SMB0)
            {
                Name (_ADR, 0x00140000)  // _ADR: Address
                OperationRegion (\_SB.PCI0.SMB0.HETT, PCI_Config, 0x64, 0x02)
                Scope (\)
                {
                    Field (\_SB.PCI0.SMB0.HETT, ByteAcc, NoLock, Preserve)
                    {
                        HP0,    8, 
                            ,   2, 
                        HPTF,   1, 
                        Offset (0x02)
                    }
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x00120000)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x00120001)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x00120002)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x00130000)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x00130001)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (USB5)
            {
                Name (_ADR, 0x00130002)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (USB6)
            {
                Name (_ADR, 0x00140005)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Device (SBAZ)
            {
                Name (_ADR, 0x00140002)  // _ADR: Address
                OperationRegion (PCI, PCI_Config, 0x00, 0x0100)
                Field (PCI, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x42), 
                    DNSP,   1, 
                    DNSO,   1, 
                    ENSR,   1
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x1B, 
                    0x04
                })
            }

            Device (SATA)
            {
                Name (_ADR, 0x00110000)  // _ADR: Address
                OperationRegion (SACS, PCI_Config, 0x00, 0x40)
                Field (SACS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x24), 
                    STB5,   32
                }

                Name (SPTM, Buffer (0x14)
                {
                    /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                    /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                    /* 0010 */  0x1F, 0x00, 0x00, 0x00                           // ....
                })
                Device (PRID)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Return (SPTM) /* \_SB_.PCI0.SATA.SPTM */
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                    }

                    Name (PRIS, 0x00)
                    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                    {
                        If (STEN)
                        {
                            OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                            Field (BAR, AnyAcc, NoLock, Preserve)
                            {
                                Offset (0x120), 
                                    ,   7, 
                                PMBY,   1, 
                                Offset (0x128), 
                                PMS0,   4, 
                                Offset (0x129), 
                                PMS1,   4, 
                                Offset (0x220), 
                                    ,   7, 
                                PSBY,   1, 
                                Offset (0x228), 
                                PSS0,   4, 
                                Offset (0x229), 
                                PSS1,   4, 
                                Offset (0x2A0), 
                                    ,   7
                            }

                            If (((OSTY == 0x06) || (OSTY == 0x04)))
                            {
                                If (PMS1)
                                {
                                    Local0 = 0x32
                                    While (((PMBY == 0x01) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }

                                If (PSS1)
                                {
                                    Local0 = 0x32
                                    While (((PSBY == 0x01) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }
                        }

                        PRIS = 0x00
                    }

                    Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                    {
                        PRIS = 0x03
                    }

                    Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                    {
                        Return (PRIS) /* \_SB_.PCI0.SATA.PRID.PRIS */
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, 0x00)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x128), 
                                    PMS0,   4, 
                                    Offset (0x129), 
                                    PMS1,   4
                                }

                                If (~(PMS1 == 0x00))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Name (S12P, 0x00)
                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x120), 
                                        ,   7, 
                                    PMBY,   1
                                }

                                Local0 = 0x32
                                While (((PMBY == 0x01) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }

                            S12P = 0x00
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                            S12P = 0x03
                        }

                        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                        {
                            Return (S12P) /* \_SB_.PCI0.SATA.PRID.P_D0.S12P */
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x228), 
                                    PSS0,   4, 
                                    Offset (0x229), 
                                    PSS1,   4
                                }

                                If (~(PSS1 == 0x00))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Name (S12P, 0x00)
                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x220), 
                                        ,   7, 
                                    PSBY,   1
                                }

                                Local0 = 0x32
                                While (((PSBY == 0x01) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }

                            S12P = 0x00
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                            S12P = 0x03
                        }

                        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                        {
                            Return (S12P) /* \_SB_.PCI0.SATA.PRID.P_D1.S12P */
                        }
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, 0x01)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Return (SPTM) /* \_SB_.PCI0.SATA.SPTM */
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                    }

                    Name (SECS, 0x00)
                    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                    {
                        If (STEN)
                        {
                            OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                            Field (BAR, AnyAcc, NoLock, Preserve)
                            {
                                Offset (0x1A0), 
                                    ,   7, 
                                SMBY,   1, 
                                Offset (0x1A8), 
                                SMS0,   4, 
                                Offset (0x1A9), 
                                SMS1,   4, 
                                Offset (0x2A0), 
                                    ,   7, 
                                SSBY,   1, 
                                Offset (0x2A8), 
                                SSS0,   4, 
                                Offset (0x2A9), 
                                SSS1,   4, 
                                Offset (0x2AC)
                            }

                            If (((OSTY == 0x06) || (OSTY == 0x04)))
                            {
                                If (SMS1)
                                {
                                    Local0 = 0x32
                                    While (((SMBY == 0x01) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }

                                If (SSS1)
                                {
                                    Local0 = 0x32
                                    While (((SSBY == 0x01) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }
                        }

                        SECS = 0x00
                    }

                    Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                    {
                        SECS = 0x03
                    }

                    Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                    {
                        Return (SECS) /* \_SB_.PCI0.SATA.SECD.SECS */
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, 0x00)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x1A8), 
                                    SMS0,   4, 
                                    Offset (0x1A9), 
                                    SMS1,   4
                                }

                                If (~(SMS1 == 0x00))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Name (S12P, 0x00)
                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x1000)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x1A0), 
                                        ,   7, 
                                    SMBY,   1
                                }

                                Local0 = 0x32
                                While (((SMBY == 0x01) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }

                            S12P = 0x00
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                            S12P = 0x03
                        }

                        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                        {
                            Return (S12P) /* \_SB_.PCI0.SATA.SECD.S_D0.S12P */
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x2A8), 
                                    SSS0,   4, 
                                    Offset (0x2A9), 
                                    SSS1,   4
                                }

                                If (~(SSS1 == 0x00))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Name (S12P, 0x00)
                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            If (STEN)
                            {
                                OperationRegion (BAR, SystemMemory, STB5, 0x0400)
                                Field (BAR, AnyAcc, NoLock, Preserve)
                                {
                                    Offset (0x2A0), 
                                        ,   7, 
                                    SSBY,   1
                                }

                                Local0 = 0x32
                                While (((SSBY == 0x01) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }

                            S12P = 0x00
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                            S12P = 0x03
                        }

                        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                        {
                            Return (S12P) /* \_SB_.PCI0.SATA.SECD.S_D1.S12P */
                        }
                    }
                }
            }

            Device (LPC0)
            {
                Name (_ADR, 0x00140003)  // _ADR: Address
                Device (PMIO)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x03)  // _UID: Unique ID
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x4100,             // Range Minimum
                                0x4100,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IO (Decode16,
                                0x0228,             // Range Minimum
                                0x0228,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x040B,             // Range Minimum
                                0x040B,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x04D6,             // Range Minimum
                                0x04D6,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x0C00,             // Range Minimum
                                0x0C00,             // Range Maximum
                                0x01,               // Alignment
                                0x02,               // Length
                                )
                            IO (Decode16,
                                0x0C14,             // Range Minimum
                                0x0C14,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x0C50,             // Range Minimum
                                0x0C50,             // Range Maximum
                                0x01,               // Alignment
                                0x03,               // Length
                                )
                            IO (Decode16,
                                0x0C6C,             // Range Minimum
                                0x0C6C,             // Range Maximum
                                0x01,               // Alignment
                                0x02,               // Length
                                )
                            IO (Decode16,
                                0x0C6F,             // Range Minimum
                                0x0C6F,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x0CD0,             // Range Minimum
                                0x0CD0,             // Range Maximum
                                0x01,               // Alignment
                                0x02,               // Length
                                )
                            IO (Decode16,
                                0x0CD2,             // Range Minimum
                                0x0CD2,             // Range Maximum
                                0x01,               // Alignment
                                0x02,               // Length
                                )
                            IO (Decode16,
                                0x0CD4,             // Range Minimum
                                0x0CD4,             // Range Maximum
                                0x01,               // Alignment
                                0x0C,               // Length
                                )
                            IO (Decode16,
                                0x4000,             // Range Minimum
                                0x4000,             // Range Maximum
                                0x01,               // Alignment
                                0xFF,               // Length
                                )
                            IO (Decode16,
                                0x4210,             // Range Minimum
                                0x4210,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0B00,             // Range Minimum
                                0x0B00,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0x0B10,             // Range Minimum
                                0x0B10,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0x0B20,             // Range Minimum
                                0x0B20,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                                0x00000000,         // Granularity
                                0xE0000000,         // Range Minimum
                                0xE0000000,         // Range Maximum
                                0x00000000,         // Translation Offset
                                0x00000001,         // Length
                                ,, _Y01, AddressRangeMemory, TypeStatic)
                            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                                0x00000000,         // Granularity
                                0xFEE00400,         // Range Minimum
                                0xFEE00FFF,         // Range Maximum
                                0x00000000,         // Translation Offset
                                0x00000C00,         // Length
                                ,, , AddressRangeMemory, TypeStatic)
                        })
                        CreateDWordField (BUF0, \_SB.PCI0.LPC0.PMIO._CRS._Y01._MIN, BARX)  // _MIN: Minimum Base Address
                        CreateDWordField (BUF0, \_SB.PCI0.LPC0.PMIO._CRS._Y01._LEN, GALN)  // _LEN: Length
                        CreateDWordField (BUF0, \_SB.PCI0.LPC0.PMIO._CRS._Y01._MAX, GAMX)  // _MAX: Maximum Base Address
                        GALN = 0x1000
                        Local0 = \_SB.PCI0.MMIO
                        BARX = (Local0 & 0xFFFFFFF0)
                        GAMX = (Local0 + GALN) /* \_SB_.PCI0.LPC0.PMIO._CRS.GALN */
                        GAMX -= 0x01
                        Return (BUF0) /* \_SB_.PCI0.LPC0.PMIO._CRS.BUF0 */
                    }
                }

                OperationRegion (PIRQ, SystemIO, 0x0C00, 0x02)
                Field (PIRQ, ByteAcc, NoLock, Preserve)
                {
                    PIID,   8, 
                    PIDA,   8
                }

                Name (IPRS, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,7,10,11}
                })
                IndexField (PIID, PIDA, ByteAcc, NoLock, Preserve)
                {
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    PIRS,   8, 
                    Offset (0x09), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIR0,   8, 
                    PIR1,   8
                }

                Method (DSPI, 0, NotSerialized)
                {
                    PIRA = 0x00
                    PIRB = 0x00
                    PIRC = 0x00
                    PIRD = 0x00
                    PIRE = 0x00
                    PIRF = 0x00
                    PIR0 = 0x00
                    PIR1 = 0x00
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x01)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIRA)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIRA = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIRA) /* \_SB_.PCI0.LPC0.PIRA */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIRA = Local0
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIRB)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIRB = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIRB) /* \_SB_.PCI0.LPC0.PIRB */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIRB = Local0
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x03)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIRC)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIRC = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIRC) /* \_SB_.PCI0.LPC0.PIRC */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIRC = Local0
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x04)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIRD)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIRD = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIRD) /* \_SB_.PCI0.LPC0.PIRD */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIRD = Local0
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x05)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIRE)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIRE = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIRE) /* \_SB_.PCI0.LPC0.PIRE */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIRE = Local0
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x06)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIRF)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIRF = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIRF) /* \_SB_.PCI0.LPC0.PIRF */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIRF = Local0
                    }
                }

                Device (LNK0)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x07)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIR0)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIR0 = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIR0) /* \_SB_.PCI0.LPC0.PIR0 */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIR0 = Local0
                    }
                }

                Device (LNK1)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x08)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (PIR1)
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (0x09)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                    {
                        Return (IPRS) /* \_SB_.PCI0.LPC0.IPRS */
                    }

                    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                    {
                        PIR1 = 0x00
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Local0 = IPRS /* \_SB_.PCI0.LPC0.IPRS */
                        CreateWordField (Local0, 0x01, IRQ0)
                        IRQ0 = (0x01 << PIR1) /* \_SB_.PCI0.LPC0.PIR1 */
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PIR1 = Local0
                    }
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (DMA1)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        DMA (Compatibility, BusMaster, Transfer8, )
                            {4}
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0094,             // Range Minimum
                            0x0094,             // Range Maximum
                            0x01,               // Alignment
                            0x0C,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (ATT5, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                    Name (ATT6, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        If ((OSFX >= 0x03))
                        {
                            If (HPTF)
                            {
                                Return (ATT6) /* \_SB_.PCI0.LPC0.TMR_.ATT6 */
                            }
                            Else
                            {
                                Return (ATT5) /* \_SB_.PCI0.LPC0.TMR_.ATT5 */
                            }
                        }
                        Else
                        {
                            Return (ATT5) /* \_SB_.PCI0.LPC0.TMR_.ATT5 */
                        }
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (ATT3, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    Name (ATT4, Buffer (0x02)
                    {
                         0x79, 0x00                                       // y.
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((OSFX >= 0x03))
                        {
                            If (HPTF)
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        If ((OSFX >= 0x03))
                        {
                            If (HPTF)
                            {
                                Return (ATT3) /* \_SB_.PCI0.LPC0.HPET.ATT3 */
                            }
                            Else
                            {
                                Return (ATT4) /* \_SB_.PCI0.LPC0.HPET.ATT4 */
                            }
                        }
                        Else
                        {
                            Return (ATT4) /* \_SB_.PCI0.LPC0.HPET.ATT4 */
                        }
                    }
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (ATT0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                    Name (ATT1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Name (ATT2, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                    Name (ATT3, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        If ((OSFX >= 0x03))
                        {
                            If (HPTF)
                            {
                                Return (ATT1) /* \_SB_.PCI0.LPC0.RTC_.ATT1 */
                            }
                            Else
                            {
                                Return (ATT0) /* \_SB_.PCI0.LPC0.RTC_.ATT0 */
                            }
                        }
                        Else
                        {
                            If ((AMAC == 0x01))
                            {
                                Return (ATT2) /* \_SB_.PCI0.LPC0.RTC_.ATT2 */
                            }

                            Return (ATT0) /* \_SB_.PCI0.LPC0.RTC_.ATT0 */
                        }
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800") /* Microsoft Sound System Compatible Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }
            }

            Device (P2P)
            {
                Name (_ADR, 0x00140004)  // _ADR: Address
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    If ((OSFL == 0x02))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x04, 
                        0x05
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKE, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x01, 
                        \_SB.PCI0.LPC0.LNKF, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x02, 
                        \_SB.PCI0.LPC0.LNK0, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x03, 
                        \_SB.PCI0.LPC0.LNK1, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x00, 
                        0x00, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x01, 
                        0x00, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x02, 
                        0x00, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x03, 
                        0x00, 
                        0x17
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.P2P_.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.P2P_.APIC */
                    }
                }
            }

            Device (IDE)
            {
                Name (_ADR, 0x00140001)  // _ADR: Address
                Name (UDMT, Package (0x08)
                {
                    0x78, 
                    0x5A, 
                    0x3C, 
                    0x2D, 
                    0x1E, 
                    0x14, 
                    0x0F, 
                    0x00
                })
                Name (PIOT, Package (0x06)
                {
                    0x0258, 
                    0x0186, 
                    0x010E, 
                    0xB4, 
                    0x78, 
                    0x00
                })
                Name (PITR, Package (0x06)
                {
                    0x99, 
                    0x47, 
                    0x34, 
                    0x22, 
                    0x20, 
                    0x99
                })
                Name (MDMT, Package (0x04)
                {
                    0x01E0, 
                    0x96, 
                    0x78, 
                    0x00
                })
                Name (MDTR, Package (0x04)
                {
                    0x77, 
                    0x21, 
                    0x20, 
                    0xFF
                })
                OperationRegion (IDE, PCI_Config, 0x40, 0x20)
                Field (IDE, AnyAcc, NoLock, Preserve)
                {
                    PPIT,   16, 
                    SPIT,   16, 
                    PMDT,   16, 
                    SMDT,   16, 
                    PPIC,   8, 
                    SPIC,   8, 
                    PPIM,   8, 
                    SPIM,   8, 
                    Offset (0x14), 
                    PUDC,   2, 
                    SUDC,   2, 
                    Offset (0x16), 
                    PUDM,   8, 
                    SUDM,   8
                }

                Method (GETT, 1, NotSerialized)
                {
                    Local0 = (Arg0 & 0x0F)
                    Local1 = (Arg0 >> 0x04)
                    Return ((0x1E * ((Local0 + 0x01) + (Local1 + 0x01)
                        )))
                }

                Method (GTM, 1, NotSerialized)
                {
                    CreateByteField (Arg0, 0x00, PIT1)
                    CreateByteField (Arg0, 0x01, PIT0)
                    CreateByteField (Arg0, 0x02, MDT1)
                    CreateByteField (Arg0, 0x03, MDT0)
                    CreateByteField (Arg0, 0x04, PICX)
                    CreateByteField (Arg0, 0x05, UDCX)
                    CreateByteField (Arg0, 0x06, UDMX)
                    Name (BUF, Buffer (0x14)
                    {
                        /* 0000 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                        /* 0008 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                        /* 0010 */  0x00, 0x00, 0x00, 0x00                           // ....
                    })
                    CreateDWordField (BUF, 0x00, PIO0)
                    CreateDWordField (BUF, 0x04, DMA0)
                    CreateDWordField (BUF, 0x08, PIO1)
                    CreateDWordField (BUF, 0x0C, DMA1)
                    CreateDWordField (BUF, 0x10, FLAG)
                    If ((PICX & 0x01))
                    {
                        Return (BUF) /* \_SB_.PCI0.IDE_.GTM_.BUF_ */
                    }

                    PIO0 = GETT (PIT0)
                    PIO1 = GETT (PIT1)
                    If ((UDCX & 0x01))
                    {
                        FLAG |= 0x01
                        DMA0 = DerefOf (^UDMT [(UDMX & 0x0F)])
                    }
                    Else
                    {
                        DMA0 = GETT (MDT0)
                    }

                    If ((UDCX & 0x02))
                    {
                        FLAG |= 0x04
                        DMA1 = DerefOf (^UDMT [(UDMX >> 0x04)])
                    }
                    Else
                    {
                        DMA1 = GETT (MDT1)
                    }

                    FLAG |= 0x1A
                    Return (BUF) /* \_SB_.PCI0.IDE_.GTM_.BUF_ */
                }

                Method (STM, 3, NotSerialized)
                {
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Name (BUF, Buffer (0x07)
                    {
                         0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         // .......
                    })
                    CreateByteField (BUF, 0x00, PIT1)
                    CreateByteField (BUF, 0x01, PIT0)
                    CreateByteField (BUF, 0x02, MDT1)
                    CreateByteField (BUF, 0x03, MDT0)
                    CreateByteField (BUF, 0x04, PIMX)
                    CreateByteField (BUF, 0x05, UDCX)
                    CreateByteField (BUF, 0x06, UDMX)
                    Local0 = Match (^PIOT, MLE, PIO0, MTR, 0x00, 0x00)
                    Local0 %= 0x05
                    Local1 = Match (^PIOT, MLE, PIO1, MTR, 0x00, 0x00)
                    Local1 %= 0x05
                    PIMX = ((Local1 << 0x04) | Local0)
                    PIT0 = DerefOf (^PITR [Local0])
                    PIT1 = DerefOf (^PITR [Local1])
                    If ((FLAG & 0x01))
                    {
                        Local0 = Match (^UDMT, MLE, DMA0, MTR, 0x00, 0x00)
                        Local0 %= 0x07
                        UDMX |= Local0
                        UDCX |= 0x01
                    }
                    ElseIf ((DMA0 != 0xFFFFFFFF))
                    {
                        Local0 = Match (^MDMT, MLE, DMA0, MTR, 0x00, 0x00)
                        MDT0 = DerefOf (^MDTR [Local0])
                    }

                    If ((FLAG & 0x04))
                    {
                        Local0 = Match (^UDMT, MLE, DMA1, MTR, 0x00, 0x00)
                        Local0 %= 0x07
                        UDMX |= (Local0 << 0x04)
                        UDCX |= 0x02
                    }
                    ElseIf ((DMA1 != 0xFFFFFFFF))
                    {
                        Local0 = Match (^MDMT, MLE, DMA1, MTR, 0x00, 0x00)
                        MDT1 = DerefOf (^MDTR [Local0])
                    }

                    Return (BUF) /* \_SB_.PCI0.IDE_.STM_.BUF_ */
                }

                Method (GTF, 2, NotSerialized)
                {
                    CreateByteField (Arg1, 0x00, MDT1)
                    CreateByteField (Arg1, 0x01, MDT0)
                    CreateByteField (Arg1, 0x02, PIMX)
                    CreateByteField (Arg1, 0x03, UDCX)
                    CreateByteField (Arg1, 0x04, UDMX)
                    If ((Arg0 == 0xA0))
                    {
                        Local0 = (PIMX & 0x0F)
                        Local1 = MDT0 /* \_SB_.PCI0.IDE_.GTF_.MDT0 */
                        Local2 = (UDCX & 0x01)
                        Local3 = (UDMX & 0x0F)
                    }
                    Else
                    {
                        Local0 = (PIMX >> 0x04)
                        Local1 = MDT1 /* \_SB_.PCI0.IDE_.GTF_.MDT1 */
                        Local2 = (UDCX & 0x02)
                        Local3 = (UDMX >> 0x04)
                    }

                    Name (BUF, Buffer (0x0E)
                    {
                        /* 0000 */  0x03, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF, 0x03,  // ........
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF               // ......
                    })
                    CreateByteField (BUF, 0x01, PMOD)
                    CreateByteField (BUF, 0x08, DMOD)
                    CreateByteField (BUF, 0x05, CMDA)
                    CreateByteField (BUF, 0x0C, CMDB)
                    CMDA = Arg0
                    CMDB = Arg0
                    PMOD = (Local0 | 0x08)
                    If (Local2)
                    {
                        DMOD = (Local3 | 0x40)
                    }
                    Else
                    {
                        Local4 = Match (^MDMT, MLE, GETT (Local1), MTR, 0x00, 0x00)
                        If ((Local4 < 0x03))
                        {
                            DMOD = (0x20 | Local4)
                        }
                    }

                    Return (BUF) /* \_SB_.PCI0.IDE_.GTF_.BUF_ */
                }

                Device (PRID)
                {
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         // .......
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIC)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        VPIT = ^^PPIT /* \_SB_.PCI0.IDE_.PPIT */
                        VMDT = ^^PMDT /* \_SB_.PCI0.IDE_.PMDT */
                        VPIC = ^^PPIC /* \_SB_.PCI0.IDE_.PPIC */
                        VUDC = ^^PUDC /* \_SB_.PCI0.IDE_.PUDC */
                        VUDM = ^^PUDM /* \_SB_.PCI0.IDE_.PUDM */
                        Return (GTM (BUF))
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIM)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        BUF = STM (Arg0, Arg1, Arg2)
                        ^^PPIT = VPIT /* \_SB_.PCI0.IDE_.PRID._STM.VPIT */
                        ^^PMDT = VMDT /* \_SB_.PCI0.IDE_.PRID._STM.VMDT */
                        ^^PPIM = VPIM /* \_SB_.PCI0.IDE_.PRID._STM.VPIM */
                        ^^PUDC = VUDC /* \_SB_.PCI0.IDE_.PRID._STM.VUDC */
                        ^^PUDM = VUDM /* \_SB_.PCI0.IDE_.PRID._STM.VUDM */
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, 0x00)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = ^^^PMDT /* \_SB_.PCI0.IDE_.PMDT */
                            VPIM = ^^^PPIM /* \_SB_.PCI0.IDE_.PPIM */
                            VUDC = ^^^PUDC /* \_SB_.PCI0.IDE_.PUDC */
                            VUDM = ^^^PUDM /* \_SB_.PCI0.IDE_.PUDM */
                            Return (GTF (0xA0, BUF))
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = ^^^PMDT /* \_SB_.PCI0.IDE_.PMDT */
                            VPIM = ^^^PPIM /* \_SB_.PCI0.IDE_.PPIM */
                            VUDC = ^^^PUDC /* \_SB_.PCI0.IDE_.PUDC */
                            VUDM = ^^^PUDM /* \_SB_.PCI0.IDE_.PUDM */
                            Return (GTF (0xB0, BUF))
                        }
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, 0x01)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         // .......
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIC)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        VPIT = ^^SPIT /* \_SB_.PCI0.IDE_.SPIT */
                        VMDT = ^^SMDT /* \_SB_.PCI0.IDE_.SMDT */
                        VPIC = ^^SPIC /* \_SB_.PCI0.IDE_.SPIC */
                        VUDC = ^^SUDC /* \_SB_.PCI0.IDE_.SUDC */
                        VUDM = ^^SUDM /* \_SB_.PCI0.IDE_.SUDM */
                        Return (GTM (BUF))
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         // .......
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIM)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        BUF = STM (Arg0, Arg1, Arg2)
                        ^^SPIT = VPIT /* \_SB_.PCI0.IDE_.SECD._STM.VPIT */
                        ^^SMDT = VMDT /* \_SB_.PCI0.IDE_.SECD._STM.VMDT */
                        ^^SPIM = VPIM /* \_SB_.PCI0.IDE_.SECD._STM.VPIM */
                        ^^SUDC = VUDC /* \_SB_.PCI0.IDE_.SECD._STM.VUDC */
                        ^^SUDM = VUDM /* \_SB_.PCI0.IDE_.SECD._STM.VUDM */
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, 0x00)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = ^^^SMDT /* \_SB_.PCI0.IDE_.SMDT */
                            VPIM = ^^^SPIM /* \_SB_.PCI0.IDE_.SPIM */
                            VUDC = ^^^SUDC /* \_SB_.PCI0.IDE_.SUDC */
                            VUDM = ^^^SUDM /* \_SB_.PCI0.IDE_.SUDM */
                            Return (GTF (0xA0, BUF))
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, 0x01)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = ^^^SMDT /* \_SB_.PCI0.IDE_.SMDT */
                            VPIM = ^^^SPIM /* \_SB_.PCI0.IDE_.SPIM */
                            VUDC = ^^^SUDC /* \_SB_.PCI0.IDE_.SUDC */
                            VUDM = ^^^SUDM /* \_SB_.PCI0.IDE_.SUDM */
                            Return (GTF (0xB0, BUF))
                        }
                    }
                }
            }

            Device (PCE2)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKB, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE2.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE2.APIC */
                    }
                }
            }

            Device (PCE3)
            {
                Name (_ADR, 0x00030000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKC, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x12
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE3.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE3.APIC */
                    }
                }
            }

            Device (PCE4)
            {
                Name (_ADR, 0x00040000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE4.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE4.APIC */
                    }
                }
            }

            Device (PCE5)
            {
                Name (_ADR, 0x00050000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKA, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE5.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE5.APIC */
                    }
                }
            }

            Device (PCE6)
            {
                Name (_ADR, 0x00060000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKB, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE6.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE6.APIC */
                    }
                }
            }

            Device (PCE7)
            {
                Name (_ADR, 0x00070000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKC, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x12
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE7.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE7.APIC */
                    }
                }
            }

            Device (PCE9)
            {
                Name (_ADR, 0x00090000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKA, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCE9.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCE9.APIC */
                    }
                }
            }

            Device (PCEA)
            {
                Name (_ADR, 0x000A0000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKB, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCEA.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCEA.APIC */
                    }
                }
            }

            Device (PCEB)
            {
                Name (_ADR, 0x000B0000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKC, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x12
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCEB.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCEB.APIC */
                    }
                }
            }

            Device (PCEC)
            {
                Name (_ADR, 0x000C0000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (Package (0x02)
                    {
                        0x18, 
                        0x04
                    })
                }

                Name (PICM, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        0x00
                    }
                })
                Name (APIC, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.PCEC.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.PCEC.APIC */
                    }
                }
            }

            Scope (\)
            {
                Method (DISD, 1, NotSerialized)
                {
                }

                Method (CKIO, 2, NotSerialized)
                {
                }

                Method (SLDM, 2, NotSerialized)
                {
                }
            }

            Scope (\)
            {
                OperationRegion (WIN1, SystemIO, 0x2E, 0x02)
                Field (WIN1, ByteAcc, NoLock, Preserve)
                {
                    INDP,   8, 
                    DATP,   8
                }

                OperationRegion (GPIO, SystemIO, 0x0800, 0x05)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    GO01,   8, 
                    GO02,   8, 
                    GO03,   8, 
                    GO04,   8, 
                    GO05,   8
                }

                IndexField (INDP, DATP, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    CFG,    8, 
                    Offset (0x07), 
                    LDN,    8, 
                    Offset (0x20), 
                    IDHI,   8, 
                    IDLO,   8, 
                    POWC,   8, 
                    Offset (0x30), 
                    ACTR,   8, 
                    Offset (0x60), 
                    IOAH,   8, 
                    IOAL,   8, 
                    IO2H,   8, 
                    IO2L,   8, 
                    Offset (0x70), 
                    INTR,   8, 
                    Offset (0x72), 
                    INT1,   8, 
                    Offset (0x74), 
                    DMCH,   8, 
                    Offset (0xC0), 
                    GP40,   8, 
                    Offset (0xF0), 
                    OPT1,   8, 
                    OPT2,   8, 
                    OPT3,   8, 
                    OPT4,   8
                }

                Method (ENFG, 0, NotSerialized)
                {
                    INDP = 0x87
                    INDP = 0x01
                    INDP = 0x55
                    INDP = 0x55
                }

                Method (EXFG, 0, NotSerialized)
                {
                    CFG = 0x02
                }

                Method (GSRG, 1, NotSerialized)
                {
                    INDP = Arg0
                    Return (DATP) /* \DATP */
                }

                Method (SSRG, 2, NotSerialized)
                {
                    INDP = Arg0
                    DATP = Arg1
                }
            }

            Device (FDC0)
            {
                Name (_HID, EisaId ("PNP0700"))  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    ENFG ()
                    LDN = Zero
                    If (ACTR)
                    {
                        EXFG ()
                        Return (0x0F)
                    }
                    ElseIf ((IOAH || IOAL))
                    {
                        EXFG ()
                        Return (0x0D)
                    }
                    Else
                    {
                        EXFG ()
                        Return (0x00)
                    }
                }

                Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                {
                    ENFG ()
                    LDN = 0x00
                    ACTR = Zero
                    SLDM (DMCH, 0x04)
                    EXFG ()
                    DISD (0x03)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x03F0,             // Range Minimum
                            0x03F0,             // Range Maximum
                            0x01,               // Alignment
                            0x06,               // Length
                            _Y02)
                        IO (Decode16,
                            0x03F7,             // Range Minimum
                            0x03F7,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {6}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {2}
                    })
                    CreateByteField (BUF0, \_SB.PCI0.FDC0._CRS._Y02._MIN, IOLO)  // _MIN: Minimum Base Address
                    CreateByteField (BUF0, 0x03, IOHI)
                    CreateByteField (BUF0, \_SB.PCI0.FDC0._CRS._Y02._MAX, IORL)  // _MAX: Maximum Base Address
                    CreateByteField (BUF0, 0x05, IORH)
                    ENFG ()
                    EXFG ()
                    Return (BUF0) /* \_SB_.PCI0.FDC0._CRS.BUF0 */
                }

                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03F0,             // Range Minimum
                            0x03F0,             // Range Maximum
                            0x01,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x03F7,             // Range Minimum
                            0x03F7,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {6}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {2}
                    }
                    EndDependentFn ()
                })
                Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                {
                    CreateByteField (Arg0, 0x02, IOLO)
                    CreateByteField (Arg0, 0x03, IOHI)
                    CreateWordField (Arg0, 0x02, IOAD)
                    CreateWordField (Arg0, 0x19, IRQW)
                    CreateByteField (Arg0, 0x1C, DMAV)
                    ENFG ()
                    LDN = Zero
                    ACTR = One
                    SLDM (DMCH, DMCH)
                    CKIO (IOAD, 0x03)
                    EXFG ()
                }
            }

            Device (UAR1)
            {
                Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                Name (_UID, 0x01)  // _UID: Unique ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    ENFG ()
                    LDN = 0x01
                    If (ACTR)
                    {
                        EXFG ()
                        Return (0x0F)
                    }
                    ElseIf ((IOAH || IOAL))
                    {
                        EXFG ()
                        Return (0x0D)
                    }
                    Else
                    {
                        EXFG ()
                        Return (0x00)
                    }

                    EXFG ()
                }

                Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                {
                    ENFG ()
                    LDN = 0x01
                    ACTR = Zero
                    EXFG ()
                    DISD (0x00)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            _Y03)
                        IRQNoFlags (_Y04)
                            {}
                    })
                    CreateByteField (BUF1, \_SB.PCI0.UAR1._CRS._Y03._MIN, IOLO)  // _MIN: Minimum Base Address
                    CreateByteField (BUF1, 0x03, IOHI)
                    CreateByteField (BUF1, \_SB.PCI0.UAR1._CRS._Y03._MAX, IORL)  // _MAX: Maximum Base Address
                    CreateByteField (BUF1, 0x05, IORH)
                    CreateWordField (BUF1, \_SB.PCI0.UAR1._CRS._Y04._INT, IRQW)  // _INT: Interrupts
                    ENFG ()
                    LDN = 0x01
                    IOLO = IOAL /* \IOAL */
                    IORL = IOAL /* \IOAL */
                    IOHI = IOAH /* \IOAH */
                    IORH = IOAH /* \IOAH */
                    Local0 = One
                    IRQW = (Local0 << INTR) /* \INTR */
                    EXFG ()
                    Return (BUF1) /* \_SB_.PCI0.UAR1._CRS.BUF1 */
                }

                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03F8,             // Range Minimum
                            0x03F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x02F8,             // Range Minimum
                            0x02F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03E8,             // Range Minimum
                            0x03E8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x02E8,             // Range Minimum
                            0x02E8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    EndDependentFn ()
                })
                Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                {
                    CreateByteField (Arg0, 0x02, IOLO)
                    CreateByteField (Arg0, 0x03, IOHI)
                    CreateWordField (Arg0, 0x02, IOAD)
                    CreateWordField (Arg0, 0x09, IRQW)
                    ENFG ()
                    LDN = 0x01
                    ACTR = One
                    IOAL = IOLO /* \_SB_.PCI0.UAR1._SRS.IOLO */
                    IOAH = IOHI /* \_SB_.PCI0.UAR1._SRS.IOHI */
                    FindSetRightBit (IRQW, Local0)
                    INTR = (Local0 - 0x01)
                    EXFG ()
                    CKIO (IOAD, 0x00)
                }
            }

            Device (LPT1)
            {
                Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port */)  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    ENFG ()
                    LDN = 0x03
                    Local0 = (OPT1 & 0x02)
                    If ((Local0 != 0x02))
                    {
                        If (ACTR)
                        {
                            EXFG ()
                            Return (0x0F)
                        }
                        ElseIf ((IOAH || IOAL))
                        {
                            EXFG ()
                            Return (0x0D)
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }
                    }
                    Else
                    {
                        EXFG ()
                        Return (0x00)
                    }
                }

                Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                {
                    ENFG ()
                    LDN = 0x03
                    ACTR = Zero
                    EXFG ()
                    DISD (0x02)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF5, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            _Y05)
                        IRQNoFlags (_Y06)
                            {}
                    })
                    CreateByteField (BUF5, \_SB.PCI0.LPT1._CRS._Y05._MIN, IOLO)  // _MIN: Minimum Base Address
                    CreateByteField (BUF5, 0x03, IOHI)
                    CreateByteField (BUF5, \_SB.PCI0.LPT1._CRS._Y05._MAX, IORL)  // _MAX: Maximum Base Address
                    CreateByteField (BUF5, 0x05, IORH)
                    CreateByteField (BUF5, \_SB.PCI0.LPT1._CRS._Y05._LEN, IOLE)  // _LEN: Length
                    CreateWordField (BUF5, \_SB.PCI0.LPT1._CRS._Y06._INT, IRQW)  // _INT: Interrupts
                    ENFG ()
                    LDN = 0x03
                    IOLO = IOAL /* \IOAL */
                    IORL = IOLO /* \_SB_.PCI0.LPT1._CRS.IOLO */
                    IOHI = IOAH /* \IOAH */
                    IORH = IOHI /* \_SB_.PCI0.LPT1._CRS.IOHI */
                    If ((IOLO == 0xBC))
                    {
                        IOLE = 0x04
                    }
                    Else
                    {
                        IOLE = 0x08
                    }

                    Local0 = One
                    Local5 = INTR /* \INTR */
                    IRQW = (Local0 << Local5)
                    EXFG ()
                    Return (BUF5) /* \_SB_.PCI0.LPT1._CRS.BUF5 */
                }

                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0378,             // Range Minimum
                            0x0378,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0278,             // Range Minimum
                            0x0278,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03BC,             // Range Minimum
                            0x03BC,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                    }
                    EndDependentFn ()
                })
                Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                {
                    CreateByteField (Arg0, 0x02, IOLO)
                    CreateByteField (Arg0, 0x03, IOHI)
                    CreateWordField (Arg0, 0x02, IOAD)
                    CreateByteField (Arg0, 0x04, IORL)
                    CreateByteField (Arg0, 0x05, IORH)
                    CreateWordField (Arg0, 0x09, IRQW)
                    ENFG ()
                    LDN = 0x03
                    ACTR = One
                    IOAL = IOLO /* \_SB_.PCI0.LPT1._SRS.IOLO */
                    IOAH = IOHI /* \_SB_.PCI0.LPT1._SRS.IOHI */
                    FindSetLeftBit (IRQW, Local0)
                    Local0 -= 0x01
                    INTR = Local0
                    EXFG ()
                    CKIO (IOAD, 0x02)
                }
            }

            Device (ECP1)
            {
                Name (_HID, EisaId ("PNP0401") /* ECP Parallel Port */)  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    ENFG ()
                    LDN = 0x03
                    Local0 = (OPT1 & 0x02)
                    If ((Local0 == 0x02))
                    {
                        If (ACTR)
                        {
                            EXFG ()
                            Return (0x0F)
                        }
                        ElseIf ((IOAH || IOAL))
                        {
                            EXFG ()
                            Return (0x0D)
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }
                    }
                    Else
                    {
                        EXFG ()
                        Return (0x00)
                    }
                }

                Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                {
                    ENFG ()
                    LDN = 0x03
                    ACTR = Zero
                    SLDM (DMCH, 0x04)
                    EXFG ()
                    DISD (0x02)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF6, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            _Y07)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            _Y08)
                        IRQNoFlags (_Y09)
                            {}
                        DMA (Compatibility, NotBusMaster, Transfer8, _Y0A)
                            {}
                    })
                    CreateByteField (BUF6, \_SB.PCI0.ECP1._CRS._Y07._MIN, IOLO)  // _MIN: Minimum Base Address
                    CreateByteField (BUF6, 0x03, IOHI)
                    CreateByteField (BUF6, \_SB.PCI0.ECP1._CRS._Y07._MAX, IORL)  // _MAX: Maximum Base Address
                    CreateByteField (BUF6, 0x05, IORH)
                    CreateByteField (BUF6, \_SB.PCI0.ECP1._CRS._Y07._LEN, IOLE)  // _LEN: Length
                    CreateByteField (BUF6, \_SB.PCI0.ECP1._CRS._Y08._MIN, IOEL)  // _MIN: Minimum Base Address
                    CreateByteField (BUF6, 0x0B, IOEH)
                    CreateByteField (BUF6, \_SB.PCI0.ECP1._CRS._Y08._MAX, IOML)  // _MAX: Maximum Base Address
                    CreateByteField (BUF6, 0x0D, IOMH)
                    CreateWordField (BUF6, \_SB.PCI0.ECP1._CRS._Y09._INT, IRQW)  // _INT: Interrupts
                    CreateByteField (BUF6, \_SB.PCI0.ECP1._CRS._Y0A._DMA, DMAC)  // _DMA: Direct Memory Access
                    ENFG ()
                    LDN = 0x03
                    Local2 = IOAL /* \IOAL */
                    IOLO = Local2
                    Local3 = IOAH /* \IOAH */
                    IOHI = Local3
                    Local3 |= 0x04
                    IOEH = Local3
                    IOMH = Local3
                    IORL = IOLO /* \_SB_.PCI0.ECP1._CRS.IOLO */
                    IOEL = IOLO /* \_SB_.PCI0.ECP1._CRS.IOLO */
                    IOML = IOLO /* \_SB_.PCI0.ECP1._CRS.IOLO */
                    IORH = IOHI /* \_SB_.PCI0.ECP1._CRS.IOHI */
                    If ((IOLO == 0xBC))
                    {
                        IOLE = 0x04
                    }
                    Else
                    {
                        IOLE = 0x08
                    }

                    Local0 = One
                    Local5 = INTR /* \INTR */
                    IRQW = (Local0 << Local5)
                    Local0 = One
                    Local5 = DMCH /* \DMCH */
                    DMAC = (Local0 << Local5)
                    EXFG ()
                    Return (BUF6) /* \_SB_.PCI0.ECP1._CRS.BUF6 */
                }

                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0378,             // Range Minimum
                            0x0378,             // Range Maximum
                            0x00,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0778,             // Range Minimum
                            0x0778,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {0,1,3}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x0278,             // Range Minimum
                            0x0278,             // Range Maximum
                            0x00,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0678,             // Range Minimum
                            0x0678,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {0,1,3}
                    }
                    StartDependentFnNoPri ()
                    {
                        IO (Decode16,
                            0x03BC,             // Range Minimum
                            0x03BC,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x07BC,             // Range Minimum
                            0x07BC,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {3,4,5,7,9,10,11,12}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {0,1,3}
                    }
                    EndDependentFn ()
                })
                Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                {
                    CreateByteField (Arg0, 0x02, IOLO)
                    CreateByteField (Arg0, 0x03, IOHI)
                    CreateWordField (Arg0, 0x02, IOAD)
                    CreateWordField (Arg0, 0x11, IRQW)
                    CreateByteField (Arg0, 0x14, DMAC)
                    ENFG ()
                    LDN = 0x03
                    ACTR = One
                    IOAL = IOLO /* \_SB_.PCI0.ECP1._SRS.IOLO */
                    IOAH = IOHI /* \_SB_.PCI0.ECP1._SRS.IOHI */
                    FindSetLeftBit (IRQW, Local0)
                    Local0 -= 0x01
                    INTR = Local0
                    FindSetLeftBit (DMAC, Local1)
                    Local0 = DMCH /* \DMCH */
                    DMCH = (Local1 - 0x01)
                    SLDM (Local0, DMCH)
                    EXFG ()
                    CKIO (IOAD, 0x02)
                }
            }

            OperationRegion (KBCT, SystemIO, 0x60, 0x05)
            Field (KBCT, ByteAcc, NoLock, Preserve)
            {
                P060,   8, 
                Offset (0x04), 
                P064,   8
            }

            Device (PS2M)
            {
                Name (_HID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((PS2F == 0x00))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (0x00)
                    }
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF1, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                    Name (BUF2, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {12}
                    })
                    If ((KBDI == 0x01))
                    {
                        If ((OSFL == 0x02))
                        {
                            Return (BUF1) /* \_SB_.PCI0.PS2M._CRS.BUF1 */
                        }

                        If ((OSFL == 0x01))
                        {
                            Return (BUF1) /* \_SB_.PCI0.PS2M._CRS.BUF1 */
                        }
                        Else
                        {
                            Return (BUF2) /* \_SB_.PCI0.PS2M._CRS.BUF2 */
                        }
                    }
                    Else
                    {
                        Return (BUF1) /* \_SB_.PCI0.PS2M._CRS.BUF1 */
                    }
                }
            }

            Device (PS2K)
            {
                Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((KBDI == 0x01))
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    IO (Decode16,
                        0x0060,             // Range Minimum
                        0x0060,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0064,             // Range Minimum
                        0x0064,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IRQNoFlags ()
                        {1}
                })
            }

            Device (PSMR)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((KBDI == 0x00))
                    {
                        Return (0x00)
                    }

                    If ((PS2F == 0x00))
                    {
                        If ((OSFL == 0x02))
                        {
                            Return (0x0F)
                        }

                        If ((OSFL == 0x01))
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }

                    Return (0x00)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    IO (Decode16,
                        0x0060,             // Range Minimum
                        0x0060,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0064,             // Range Minimum
                        0x0064,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                })
            }

            Method (\_SB.PCI0.PS2M._PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x03, 
                    0x05
                })
            }

            Method (\_SB.PCI0.PS2K._PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x03, 
                    0x05
                })
            }

            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x04, 
                    0x05
                })
            }

            Device (AGP)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Name (PICM, Package (0x06)
                {
                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x01, 
                        \_SB.PCI0.LPC0.LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x02, 
                        \_SB.PCI0.LPC0.LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x03, 
                        \_SB.PCI0.LPC0.LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0007FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0007FFFF, 
                        0x01, 
                        \_SB.PCI0.LPC0.LNKD, 
                        0x00
                    }
                })
                Name (APIC, Package (0x06)
                {
                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x00, 
                        0x00, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x01, 
                        0x00, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x02, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x03, 
                        0x00, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0x0007FFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0x0007FFFF, 
                        0x01, 
                        0x00, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (!PICF)
                    {
                        Return (PICM) /* \_SB_.PCI0.AGP_.PICM */
                    }
                    Else
                    {
                        Return (APIC) /* \_SB_.PCI0.AGP_.APIC */
                    }
                }
            }
        }

        OperationRegion (SXTM, SystemMemory, 0x000FFEA1, 0x04)
        Field (SXTM, WordAcc, NoLock, Preserve)
        {
            SMEM,   32
        }

        Device (MEM)
        {
            Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x000F0000,         // Address Base
                        0x00004000,         // Address Length
                        _Y0C)
                    Memory32Fixed (ReadWrite,
                        0x000F4000,         // Address Base
                        0x00004000,         // Address Length
                        _Y0D)
                    Memory32Fixed (ReadWrite,
                        0x000F8000,         // Address Base
                        0x00004000,         // Address Length
                        _Y0E)
                    Memory32Fixed (ReadWrite,
                        0x000FC000,         // Address Base
                        0x00004000,         // Address Length
                        _Y0F)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00010000,         // Address Length
                        _Y0B)
                    Memory32Fixed (ReadWrite,
                        0xFFFF0000,         // Address Base
                        0x00010000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x000A0000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x00100000,         // Address Base
                        0x00000000,         // Address Length
                        _Y10)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y11)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y12)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y13)
                    Memory32Fixed (ReadWrite,
                        0xFEC00000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFEE00000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFFF80000,         // Address Base
                        0x00070000,         // Address Length
                        )
                })
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0B._BAS, ACMM)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0C._BAS, RMA1)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0C._LEN, RSS1)  // _LEN: Length
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0D._BAS, RMA2)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0D._LEN, RSS2)  // _LEN: Length
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0E._BAS, RMA3)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0E._LEN, RSS3)  // _LEN: Length
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0F._BAS, RMA4)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y0F._LEN, RSS4)  // _LEN: Length
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y10._LEN, EXTM)  // _LEN: Length
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y11._BAS, USMA)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y11._LEN, USMS)  // _LEN: Length
                USMA = (AMEM + 0x00010000)
                USMS += 0x00100000
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y12._BAS, TSMA)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y12._LEN, TSMS)  // _LEN: Length
                TSMA = (AMEM + 0x00010000)
                TSMA += 0x00100000
                TSMS += 0x00100000
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y13._BAS, SXT1)  // _BAS: Base Address
                CreateDWordField (BUF0, \_SB.MEM._CRS._Y13._LEN, SXT2)  // _LEN: Length
                If ((SMEM != Zero))
                {
                    SXT1 = (AMEM + 0x00010000)
                    SXT1 += 0x00100000
                    SXT1 += 0x00100000
                }
                Else
                {
                    SXT1 = Zero
                }

                SXT2 = SMEM /* \_SB_.SMEM */
                EXTM = (AMEM - 0x00100000)
                If ((ROM1 != Zero))
                {
                    RMA2 = RMA1 /* \_SB_.MEM_._CRS.RMA1 */
                    Local0 = (ROM1 << 0x08)
                    RMA1 = Local0
                    Local0 = (RMS1 << 0x08)
                    RSS1 = Local0
                    RSS2 = 0x8000
                }

                If ((ROM2 != Zero))
                {
                    RMA3 = RMA2 /* \_SB_.MEM_._CRS.RMA2 */
                    Local0 = (ROM2 << 0x08)
                    RMA2 = Local0
                    Local0 = (RMS2 << 0x08)
                    RSS2 = Local0
                    RSS3 = 0xC000
                }

                If ((ROM3 != Zero))
                {
                    RMA4 = RMA3 /* \_SB_.MEM_._CRS.RMA3 */
                    Local0 = (ROM3 << 0x08)
                    RMA3 = Local0
                    Local0 = (RMS3 << 0x08)
                    RSS3 = Local0
                    RSS4 = 0x00010000
                }

                ACMM = AMEM /* \AMEM */
                Return (BUF0) /* \_SB_.MEM_._CRS.BUF0 */
            }
        }

        Device (\_SB.PCI0.EXPL)
        {
            Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0xE0000000,         // Address Base
                        0x10000000,         // Address Length
                        )
                })
                Return (BUF0) /* \_SB_.PCI0.EXPL._CRS.BUF0 */
            }
        }
    }
}

