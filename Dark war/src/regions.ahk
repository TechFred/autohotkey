#Requires AutoHotkey v2.0

/*
======== Regions ========
*/

class Regions {
    static AppRegion := [0, 0, 1950, 1024]
    static AppMaximize := [595, 6, 628, 36]
    static AllRegion := [330, 0, 1950, 1024]

    static general := {
        splash: Regions.AllRegion
    }

    static menus := {
        left: [829, 587, 897, 912],
        top: [825, 34, 1383, 108],
        bottom: [824, 914, 1382, 1029], 
        left_2nd: Regions.AllRegion,
        right_2nd: Regions.AllRegion,
        lensIcon: [853, 800, 859, 803]
    }

    static icons := {
        lens: [837, 770, 893, 810],
        world_Shelter: [1276, 908, 1375, 1025],
        optimise: [1105, 29, 1128, 54],
        vip: [830, 124, 899, 197],
        combat: [845, 775, 877, 819],
        escort: [843, 635, 878, 676],
        alliance: [1314, 675, 1385, 740],
        pack_shop: [1253, 34, 1382, 98],
        premium_center: [1308, 113, 1375, 197],
        events: [1301,192,1382,285],
        battle_rewards: [839, 697, 884, 749],
        tasks: [836, 839, 882, 891],
        player: [826, 33, 897, 110],
        back: [838, 931, 904, 1005],
        heal: [908, 767, 970, 828],
        levelup: [1130,846,1263,961],
        Heroes: [823,908,948,1028]
    }

    static Events := {
        main: [822, 95, 1383, 922],
        bottom: Regions.menus.bottom
    }

    static APC := {
        APC1: [846, 803, 963, 889],
        APC2: [976, 799, 1097, 895],
        APC3: [1108, 800, 1229, 894]
    }

    static APC_MontlyPass := {
        APC1: [Regions.APC.APC1[1], Regions.APC.APC1[2] + 70, Regions.APC.APC1[3], Regions.APC.APC1[4] + 70],
        APC2: [Regions.APC.APC2[1], Regions.APC.APC2[2] + 70, Regions.APC.APC2[3], Regions.APC.APC2[4] + 70],
        APC3: [Regions.APC.APC3[1], Regions.APC.APC3[2] + 70, Regions.APC.APC3[3], Regions.APC.APC3[4] + 70],
        APC4: [1241, 870, 1359, 959]
    }

    static popups := {
        allianceHelp: [1264, 692, 1300, 730],
        healing: [900, 760, 956, 817]
    }

    static vip := {
        claim: [1330, 200, 1355, 220],
        freebies: [1200, 625, 1350, 700]
    }
}
