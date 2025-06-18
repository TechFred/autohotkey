#Requires AutoHotkey v2.0

/*
======== Regions ========
*/
;1600 par 900
; All regions : [656,0,1263,1080]

class Regions {
    static AppRegion := [0, 0, 1950, 1024]
    static AppMaximize := [595, 6, 628, 36]
    static AllRegion := [656, 0, 1263, 1079]

    static general := {
        splash: Regions.AllRegion
    }

    static menus := {
        left: [668, 483, 716, 953],
        top: [651, 0, 1268, 86],
        bottom: [650, 974, 1345, 1079],
        left_2nd: Regions.AllRegion,
        right_2nd: Regions.AllRegion
            ;lensIcon: [661,825,722,885]
    }

    static DailyTasks := {
        ClaimAll: [738, 803, 1452, 938],  ; bad
        Claim: [1188, 328, 1350, 864]  ; bad
    }

    static icons := {
        lens: [661, 825, 722, 885],
        world_Shelter: [1149, 961, 1256, 1072],
        optimise: [894, 0, 969, 40],
        vip: [661, 82, 742, 163],
        combat: [663, 823, 725, 891],
        escort: [662, 682, 726, 755],
        alliance: [1189, 734, 1252, 806],
        pack_shop: [1136,0,1263,62],
        premium_center: [1183, 77, 1263, 164],
        events: [1188, 161, 1259, 237],
        battle_rewards: [664, 751, 722, 820],
        tasks: [661, 890, 728, 947],
        player: [656, 1, 736, 77],
        back: [658, 976, 748, 1071],
        heal: [729,745,801,893],  
        levelup: [979, 896, 1147, 1029],
        Heroes: [661, 955, 776, 1074],
        Seasonmgt: [843, 635, 878, 676],
        help: [1135, 741, 1196, 801]
    }

    static Events := {
        main: [655, 60, 1264, 980],
        bottom: [656, 959, 1305, 1079]
    }

    static Profile := {
        Survivor: [656, 0, 729, 71]
    }

    static APC := {
        APC1: [708, 852, 829, 948],
        APC2: [976, 799, 1097, 895],  ; bad
        APC3: [1108, 800, 1229, 894]  ; bad
    }

    static APC_MontlyPass := {
        APC1: [Regions.APC.APC1[1], Regions.APC.APC1[2] + 70, Regions.APC.APC1[3], Regions.APC.APC1[4] + 70],
        APC2: [Regions.APC.APC2[1], Regions.APC.APC2[2] + 70, Regions.APC.APC2[3], Regions.APC.APC2[4] + 70],
        APC3: [Regions.APC.APC3[1], Regions.APC.APC3[2] + 70, Regions.APC.APC3[3], Regions.APC.APC3[4] + 70],
        APC4: [1241, 870, 1359, 959]  ;bad
    }

    static popups := {
        allianceHelp: [1264, 692, 1300, 730],  ;bad
        healing: [900, 760, 956, 817]  ;bad
    }

    static vip := {
        claim: [1330, 200, 1355, 220],  ;bad
        freebies: [1200, 625, 1350, 700]  ;bad
    }

    static Boomers := {
        boomers: [794, 702, 962, 849]
    }
}

class Positions {
    static icons := {
        survivor: [687, 27, 694, 36],
        heroes: [689, 1026, 695, 1033],
        levelupchat: [1120, 40, 1120, 40]
    }
    static boomers := {
        boomers: [844, 771, 844, 771],
        search: [1118, 1009, 1118, 1009],
        march1: [759, 899, 759, 899]
    }
    static titan := {
        claim: [829, 776, 829, 776]
    }

}
