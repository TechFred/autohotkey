#Requires AutoHotkey v2.0

/*
======== Users ========
*/
Users := [ ;
    { name: "LeBalafré", active: false, state: 148, img: "switch_NIILeBalafre.bmp", order: 1, boomer_run: true }, ;
    { name: "Balafré", active: false, state: 148, img: "switch_balafre.bmp", order: 2, boomer_run: true }, ;
    { name: "MiniBalafré", active: false, state: 148, img: "switch_minibalafre.bmp", order: 3, boomer_run: true }, ;
] ;


/*
======== Regions ========
*/

class Regions {
    Static AllRegion:= [330, 0, 1950, 1024]

    static general := {
        splash: Regions.AllRegion 
    }

    static menus := {
        left: Regions.AllRegion ,
        top: [330, 0, 70, 1024],
        bottom: [824,914,1382,1029], ; used with most icons
        left_2nd: Regions.AllRegion ,
        right_2nd: Regions.AllRegion ,
        lensIcon: [853, 800, 859, 803]
    }

    static icons := {
        lens: [837, 770, 893, 810],
        world_Shelter: [1096,40,1129,73],
        optimise: [1096, 40, 1135, 70],
        vip: [830,124,899,197],
        combat: [845,775,877,819],
        escort: [843,635,878,676],
        alliance: [1314,686,1356,731],
        pack_shop: [1253,34,1382,98],
        premium_center: [1308,113,1375,197],
        events: [1303,201,1378,278],
        battle_rewards: [839,697,884,749],
        tasks: [836,839,882,891],
        player: [826,33,897,110],
        back: [838,931,904,1005]
    }

    static APC :={
           APC1 :[846,803,963,889],
           APC2 :[976,799,1097,895],
           APC3 :[1108,800,1229,894]
    }

        static APC_MontlyPass :={
           APC1 :[Regions.APC.APC1[1],Regions.APC.APC1[2] + 70,Regions.APC.APC1[3],Regions.APC.APC1[4]+ 70],
           APC2 :[Regions.APC.APC2[1],Regions.APC.APC2[2] + 70,Regions.APC.APC2[3],Regions.APC.APC2[4]+ 70],
           APC3 :[Regions.APC.APC3[1],Regions.APC.APC3[2] + 70,Regions.APC.APC3[3],Regions.APC.APC3[4]+ 70],
           APC4: [1241,870,1359,959]
    }

    static popups := {
        allianceHelp: [1264,692,1300,730],
        healing: [900, 760, 956, 817]
    }

    static vip := {
        claim: [1330, 200, 1355, 220],
        freebies: [1200, 625, 1350, 700]
    }
}



/*
======== Regions ========


class Regions {
    static AllRegion := [330, 0, 1950, 1024]

    ; General
    

    ; Menus
    static leftMenu := Regions.AllRegion
    static topMenu := [330, 0, 70, 1024]
    static topMenuOptimise := [1000, 0, 1135, 70]
    static bottomMenu := [823, 905, 1950, 1024]
    static leftMenu2 := Regions.AllRegion
    static rightMenu2 := Regions.AllRegion
    static lensIcon := [853, 800, 859, 803]

    ; Icons
    static lens := [837, 770, 893, 810]
    static worldShelter := Regions.AllRegion

    ; Popups
    static allianceHelp := Regions.AllRegion
    static healing := [900, 760, 956, 817]

    ; VIP
    static vip := [830, 130, 900, 160]
    static vipClaim := [1330, 200, 1355, 220]
    static vipFreebies := [1200, 625, 1350, 700]

    static general := {
        AllRegion: [0, 0, A_ScreenWidth, A_ScreenHeight],
        splash : Regions.general.AllRegion
    }

    static Menus := {
        Top: [330, 0, 70, 1024],
        TopOptimise: [1000, 0, 1135, 70],
        Bottom: [823, 905, 1950, 1024]
    }

    static Icons := {
        Lens: [837, 770, 893, 810],
        WorldShelter: [330, 0, 1950, 1024]
    }

    static Popups := {
        Healing: [900, 760, 956, 817],
        AllianceHelp: Regions.AllRegion
    }

    static VIP := {
        Main: [830, 130, 900, 160],
        Claim: [1330, 200, 1355, 220],
        Freebies: [1200, 625, 1350, 700]
    }
}
; Optional full screen override
; static AllRegion := [0, 0, A_ScreenWidth, A_ScreenHeight]
*/