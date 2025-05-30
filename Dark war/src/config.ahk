#Requires AutoHotkey v2.0

/*
======== Users ========
*/
/*
Users := [ ;
    { name: "LeBalafré", active: false, state: 148, img: "switch_NIILeBalafre.bmp", order: 1, boomer_run: true }, ;
    { name: "Balafré", active: false, state: 148, img: "switch_balafre.bmp", order: 2, boomer_run: true }, ;
    { name: "MiniBalafré", active: false, state: 148, img: "switch_minibalafre.bmp", order: 3, boomer_run: true }, ;
] ;
*/




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