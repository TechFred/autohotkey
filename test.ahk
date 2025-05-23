; AutoHotkey v2 version
#Requires AutoHotkey v2.0+
#Warn All, OutputDebug
OutputDebug "Starting script"

winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
CoordMode("Pixel", "Client")
CoordMode("Mouse", "Client")
SetWorkingDir A_ScriptDir
SetTitleMatchMode(2)

;parameters
Boomers_run := false

;Stuffs
BlockInput("MouseMove")
loopCount := 60
count := 0

; users
/*
User := Map()
User["MiniBalafré"] := { active: false, state: 148, img: "switch_minibalafre.bmp", order: 1 }
User["LeBalafré"] := { active: false, state: 148, img: "switch_NIILeBalafre.bmp", order: 2 }
User["Balafré"] := { active: false, state: 148, img: "switch_balafre.bmp", order: 3 }
*/

Users := [ ;
    ;{ name: "LeBalafré", active: false, state: 148, img: "switch_NIILeBalafre.bmp", order: 1,boomer_run: true }, ;
    { name: "Balafré", active: false, state: 148, img: "switch_balafre.bmp", order: 2, boomer_run: true }, ;
    { name: "MiniBalafré", active: false, state: 148, img: "switch_minibalafre.bmp", order: 3, boomer_run: true }, ;
] ;

;Assets path
AssetsPath := "Assets\Darkwars_hospital\"
; Define image regions
;AllRegion := [0, 0, A_ScreenWidth, A_ScreenHeight]
AllRegion := [330, 0, 1950, 1024]
allianceHelpRegion := AllRegion
lens_region := [837, 770, 893, 810]
left_menu_region := AllRegion
splash_region := AllRegion
world_shelter_region := AllRegion
top_menu_region := [330, 0, 70, 1024]
top_menu_optimise_region := [1000, 0, 1135, 70]
Bottom_Menu_region := [823, 905, 1950, 1024]
left_menu2_region := AllRegion
healing_region := [900, 760, 956, 817]
right_menu2_region := AllRegion

lens_icon_region := [853, 800, 859, 803]

;VIP
VIP_region := [830, 130, 900, 160]
VIP_claim_region := [1330, 200, 1355, 220]
VIP_freebies_region := [1200, 625, 1350, 700]

;Colors
RedDotColor := 0x0000FF

; Activate the game window
if WinExist(winTitle) {
    WinMaximize(winTitle)
    WinActivate(winTitle)
    WinWaitActive(winTitle)
}

; ======= Debugging =======

debug := true
debug := false
if debug {
    OutputDebug "Debugging mode enabled"

    BlockInput("MouseMoveOff")
    res := FindImage("red_cross.bmp", healing_region, 50, 1000, true)
    MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y

    ;res := FindImage("reddot.bmp", VIP_region, 30, 2000, true)
    ;res :=FindImage("optimise_food.bmp", AllRegion, 100, 1000, true)
    ;MsgBox "optimise:`nFound: " res.Found "`nx: " res.x "`ny: " res.y
    ;res :=FindImage(User["[NII]LeBalafré"].img, AllRegion, 20, 1000, false)
    ;MsgBox "Le:`nFound: " res.Found "`nx: " res.x "`ny: " res.y
    ;res :=FindImage(User["MiniBalafré"].img, AllRegion, 20, 1000, false)
    ;MsgBox "mini:`nFound: " res.Found "`nx: " res.x "`ny: " res.y
    ;MsgBox GetEnergyExist()
    ;res := FindImage(User["[NII]LeBalafré"].img, AllRegion, 50, 1000, false)
    ;MsgBox "optimise:`nFound: " res.Found "`nx: " res.x "`ny: " res.y
    ;DailyTasks()
    ;Alliance()

    ;VIP_claim()

    ExitApp()
}

;*/
;Main

; ===== Specials ======

;mutabeast
/*
OutputDebug "Mutabeast"
MutaBeast(false)
ExitApp()
*/
restart_app:
    ; try {
    ; Worldmap -> healing
    if FindImage("heal.bmp", AllRegion, 80, 1000, false).Found {
        count := 0
        FindImage("red_cross.bmp", healing_region, 50, 2000, true) ;return to worldmap
        OutputDebug "Heal screen -> healing"
        loop {
            healing := heal_check()
            OutputDebug "healing status " healing
            Sleep(2000)
            ; return to worldmap
            FindImage("heal_progress.bmp", left_menu2_region, 50, 1000, true)

            ;click help
            FindImage("help.bmp", right_menu2_region, 50, 1000, true)

            if !healing {
                count+= 1
                OutputDebug "healing not found " count
                if (count > 60) {
                    OutputDebug "healing not found " count

                    break
                }
                
            }
        }
        MsgBox "done"
        ExitApp()
    }

    ; Worldmap -> boomers
    if FindImage("shelter.bmp", world_shelter_region, 80, 1000, false).Found {
        OutputDebug "Shelter region -> boomers"
        Boomers()
        MsgBox "done"
        ExitApp()
    }

    ;===== Normal ======

    ;BlockInput("MouseMoveOff")

    for User in Users {

        OutputDebug "Current user: " User.name
        loop {
            OutputDebug "Checking user"
            if (LoginAndSetUser(user)) {
                break
            }
        }
        OutputDebug "Starting main loop"
        Crash_check()
        main_full_run(User.boomer_run)
    }
    Crash_check()
    BlockInput("MouseMoveOff")
    Sleep(1000)
    MsgBox "Done"
    ExitApp()
    /*
        } catch e {
            if e.Message = "GameCrashed" {
                ; Restart the script
                Reload()
            } else {
                OutputDebug "Error: " e.Message
            }
            goto restart_app
        }
    */
    main_full_run(Boomers_run := true) {

        /*
        ; splash
        if splash_run {
            OutputDebug "Splash"
            splash()
            sleep (3000)
        }
        */

        ; food
        OutputDebug "Food"
        FindImage("optimise_food.bmp", AllRegion, 100, 1000, true)
        FindImage("optimise_food_2.bmp", AllRegion, 100, 1000, true)
        FindImage("optimise_food_3.bmp", AllRegion, 100, 1000, true)
        Sleep(1000)

        ;click help
        FindImage("help.bmp", right_menu2_region, 50, 1000, true)

        ;optimise residents
        ;ToolTip("optimise")
        OutputDebug "Optimise"
        Optimise_residents()
        Sleep(1000)

        ;combat
        ;ToolTip("combat")
        OutputDebug "Combat"
        Combat()
        Sleep(1000)

        ;escorts
        ;ToolTip("escorts")
        OutputDebug "Escorts"
        Escorts()
        Sleep(1000)

        ;expeditions
        ;ToolTip("expeditions")
        OutputDebug "Expeditions"
        Expeditions()
        Sleep(1000)

        ; Alliance
        ;ToolTip("Alliance")
        OutputDebug "Alliance"
        Alliance()
        Sleep(1000)

        ;dayly tasks
        OutputDebug "Daily tasks"
        DailyTasks()

        ;VIP
        OutputDebug "VIP"
        VIP_claim()

        ;Switch to world
        OutputDebug "World"
        FindImage("world.bmp", world_shelter_region, 80, 1000, true)
        Sleep(1000)

        ;heal troops
        heal_check()

        ;boomers
        if (Boomers_run) {
            OutputDebug "Boomers"
            Boomers()
            Sleep(1000)
        }

        ;Switch to shelter
        FindImage("shelter.bmp", world_shelter_region, 80, 4000, true)

    }

    ;==== Actions ====

    LoginAndSetUser(CurrentUser) {

        OutputDebug "LoadingWait"
        LoadingWait()

        OutputDebug "Splash"
        splash()

        sleep (1000)

        ;player profile
        FindImage("switch_playericon.bmp", AllRegion, 50, 1000, true)
        FindImage("switch_playericon_2.bmp", AllRegion, 50, 1000, true)

        ; Swtich account menu
        FindImage("switch_account.bmp", AllRegion, 50, 1000, true)
        FindImage("switch_character.bmp", AllRegion, 50, 1000, true)

        ; check if the user is active. Swtich if not
        if FindImage(CurrentUser.img, AllRegion, 50, 1000, false).Found {
            CurrentUser.active := false
            OutputDebug "CurrentUser is not active"
            SelectUser(CurrentUser.img)
        } else {
            CurrentUser.active := true
            OutputDebug "CurrentUser is active"
            ClickProfile()
            ClickProfile()
            FindImage("btn_return.bmp", Bottom_Menu_region, 50, 2000, true)
        }
        return CurrentUser.active

    }

    ;==== Functions ====
    ; Splash
    splash() {
        sleep (1000)
        count := 0
        loop 6 {
            if (FindImage("world.bmp", world_shelter_region, 50, 1000, false)).Found {
                count += 1
                if count > 2 {
                    OutputDebug "World found"
                    break
                }

            }
            FindImage("splash_guy_x.bmp", AllRegion, 20, 2000, true)
            FindImage("splash_x.bmp", AllRegion, 20, 2000, true)
            ClickProfile()
            Sleep(500)
        }
        FindImage("splash_event_x.bmp", AllRegion, 20, 2000, true)
        FindImage("btn_return.bmp", Bottom_Menu_region, 50, 2000, true)
        Sleep(1000)
        FindImage("btn_return.bmp", Bottom_Menu_region, 50, 2000, true)

    }

    ; wait for the game to load
    LoadingWait() {

        World := 0
        loop 30 {
            if (FindImage("splash_guy.bmp", AllRegion, 100, 1000, false)).Found {
                Sleep(5000) ; Give time to load
                OutputDebug "Splash guy found"
                break
            }

            Crash_check()

            ; If world is shown for more than 6 seconds, break
            if (FindImage("world.bmp", AllRegion, 80, 1000, false)).Found {
                World += 1
                OutputDebug "World found : " World
                if (World > 3) {
                    OutputDebug "World found"
                    break
                }

            } else {
                World := 0
            }
            Sleep(2000)

        }
    }
    ; Optimise residents
    Optimise_residents() {
        res := FindImage("reddot.bmp", top_menu_optimise_region, 50, 2000, true)
        ;MsgBox "optimise:`nFound: " res.Found "`nx: " res.x "`ny: " res.y

        if res.Found {
            res := FindImage("optimise_btn.bmp", AllRegion, 100, 4000, true)
            loop 5 {
                sleep (2000)
                res := FindImage("optimise_resident_status.bmp", AllRegion, 100, 1000, false)
                if res.Found {
                    MouseClick("left", res.x + 100, res.y - 100)
                    break
                }

            }

        }
    }

    ;combat
    Combat() {
        res := FindImage("combat.bmp", left_menu_region, 50, 3000, true)
        if res.found {
            FindImage("combat_claim.bmp", left_menu_region, 50, 2000, true)
            FindImage("combat_claim_blue.bmp", left_menu_region, 50, 3000, true)
            MouseclickMiddle(1000)
            FindImage("btn_return.bmp", left_menu_region, 50, 1000, true)
        }

    }

    ;escorts
    Escorts() {
        nbnotfound := 0

        FindImage("escort_truck.bmp", left_menu_region, 100, 1000, true)
        FindImage("escort.bmp", AllRegion, 50, 1000, true)
        loop {
            res := FindImage("expedition_gift.bmp", AllRegion, 100, 2000, true)
            res2 := FindImage("escort_gift.bmp", AllRegion, 20, 2000, true)

            if (res.found or res2.found) {
                MouseclickMiddle(2000)
                FindImage("btn_return.bmp", Bottom_Menu_region, 50, 1000, true)
                nbnotfound := 0
            } else {
                nbnotfound += 1
                sleep (100)
                if (nbnotfound > 50) {
                    break
                }

            }
        }
        sleep (2000)
        if !FindImage("btn_return_white.bmp", Bottom_Menu_region, 50, 1000, true).found
            FindImage("btn_return_white_2.bmp", Bottom_Menu_region, 50, 1000, true)
    }

    ;Expeditions
    Expeditions() {
        nbnotfound := 0

        loop 25 {
            res := FindImage("expedition_chest.bmp", AllRegion, 100, 1000, true)
            sleep (100)
            if res.found {
                loop {
                    exp := FindImage("expedition_chest_animation.bmp", AllRegion, 50, 2000, true)
                    if exp.Found {
                        FindImage("expedition_claim.bmp", Bottom_Menu_region, 50, 3000, true)
                        MouseclickMiddle(2000)
                        nbnotfound := 0
                    } else {
                        nbnotfound += 1
                        sleep (200)
                        if (nbnotfound > 50) {
                            sleep (2000)
                            if !FindImage("btn_return_white.bmp", Bottom_Menu_region, 50, 1000, true).found
                                FindImage("btn_return_white_2.bmp", Bottom_Menu_region, 50, 1000, true)
                            OutputDebug "Expedition not found : " nbnotfound
                            break
                        }

                    }
                }
            }
        }

    }

    ;alliance
    Alliance() {

        alliance := FindImage("Alliance.bmp", AllRegion, 50, 3000, true)

        OutputDebug "Alliance tech"
        ;Tech
        if alliance.Found {
            if FindImage("alliance_tech.bmp", AllRegion, 50, 1000, true).found {
                if FindImage("tech_thumb.bmp", AllRegion, 70, 1000, true).Found {
                    loop 50 {
                        FindImage("tech_donate.bmp", AllRegion, 50, 300, true)

                        ;Sortir si le bouton est gris
                        if FindImage("tech_donate_done.bmp", AllRegion, 50, 100, false).Found
                            break
                    }
                    FindImage("wars_x.bmp", AllRegion, 50, 1000, true)
                }

                FindImage("btn_return.bmp", Bottom_Menu_region, 50, 1000, true)
            }
        }

        ;Gifts
        OutputDebug "Alliance gifts"
        count := 0
        if FindImage("alliance_gift.bmp", AllRegion, 50, 1000, true).found {
            FindImage("gifts_claim_all.bmp", AllRegion, 50, 4000, true)
            MouseclickMiddle(2000)

            ;rare gifts
            FindImage("gift_rare.bmp", AllRegion, 50, 1000, true)
            FindImage("gifts_claim_all.bmp", AllRegion, 50, 4000, true)
            MouseclickMiddle(2000)

            ;claim all gifts individually
            loop {
                result := FindImage("gift_claim.bmp", AllRegion, 50, 1000, true)
                if !result.Found {  ; if not found, break the loop
                    OutputDebug "Gifts not found : " count
                    Sleep(1000)
                    count += 1
                    if (count > 5)
                        break
                } else {
                    count := 0
                }

            }
            FindImage("btn_return.bmp", Bottom_Menu_region, 50, 1000, true)
        }

        ;Wars
        OutputDebug "Alliance wars"
        if FindImage("alliance_wars.bmp", AllRegion, 50, 1000, true).found {
            FindImage("wars_clock.bmp", AllRegion, 50, 1000, true)
            FindImage("wars_auto_group.bmp", AllRegion, 50, 1000, true)
            FindImage("wars_enable.bmp", AllRegion, 50, 1000, true)
            FindImage("wars_x.bmp", AllRegion, 50, 1000, true)
            FindImage("btn_return.bmp", Bottom_Menu_region, 50, 1000, true)
        }

        FindImage("btn_return.bmp", Bottom_Menu_region, 50, 1000, true)

    }

    ;start boomers
    Boomers() {

        count := 0
        loop {

            ;get energy shown-> break
            if (GetEnergyExist()) {
                OutputDebug "out of energy"
                ClickProfile()
                ClickProfile()
                ClickProfile()
                FindImage("btn_return.bmp", Bottom_Menu_region, 50, 2000, true)
                FindImage("world_shelter_icon.bmp", AllRegion, 50, 4000, true)
                FindImage("shelter.bmp", world_shelter_region, 50, 4000, true)
                return
            }

            ; click cancel if stuck in existing boomer
            FindImage("cancel.bmp", AllRegion, 50, 1000, true)

            ;click on shelter icon if exist.
            FindImage("world_shelter_icon.bmp", AllRegion, 50, 4000, true)

            ;click on the healing done icon
            heal_check()

            ; check if game crashed
            Crash_check

            ;click help
            FindImage("help.bmp", right_menu2_region, 50, 1000, true)

            ;Click on the lens
            FindPixelColour(0xDEDEFA, lens_icon_region, 25, sleepDelay := 2000, doClick := true)

            FindImage("boomers_BW.bmp", AllRegion, 10, 2000, true) ;select boomers
            FindImage("search.jpg", AllRegion, 50, 2000, true) ; search
            FindImage("group.jpg ", AllRegion, 50, 2000, true) ; group

            loop {
                ; apc1
                if !(FindImage("APC1.bmp", AllRegion, 50, 250, true).found) {
                    if !(FindImage("APC1_2.bmp", AllRegion, 50, 250, true).found) {
                        count += 1
                        break
                    }
                }

                ; march
                march_1 := (FindImage("March.jpg ", AllRegion, 50, 3000, true))
                march_2 := (FindImage("March_2.bmp ", AllRegion, 50, 3000, true))
                march_3 := (FindImage("March_3.bmp ", AllRegion, 50, 3000, true))

                if (march_1.Found or march_2.Found or march_3.Found) {
                    Sleep(60000) ;wait for march
                    count := 0
                    break
                } else {
                    count += 1
                    if (count > loopCount OR (GetEnergyExist())) {
                        ClickProfile()
                        ClickProfile()
                        ClickProfile()
                        FindImage("btn_return.bmp", Bottom_Menu_region, 50, 2000, true)
                        FindImage("world_shelter_icon.bmp", AllRegion, 50, 4000, true)
                        FindImage("shelter.bmp", Bottom_Menu_region, 50, 4000, true)
                        OutputDebug "Boomers not found : " count
                        return ; Exit the script when count exceeds 20
                    }
                    OutputDebug ("Count:" count)
                    Sleep(10000)
                }

            }
        }

    }

    DailyTasks() {

        ;click on the dayly tasks
        if !(FindImage("daily_task.bmp", left_menu_region, 50, 2000, true)).Found {
            OutputDebug "Daily task not found"
            return
        }

        ClaimAll()

        loop {
            if !(FindImage("daily_task_exit.bmp", AllRegion, 50, 2000, true)).Found {
                OutputDebug "X not found"
                Sleep(1000)
                MouseclickMiddle(2000)
            } else {
                OutputDebug "X found"
                break
            }

        }

    }

    ;Claim and Claim all
    ClaimAll() {
        ;click on the claim all button
        count := 0
        FindImage("gifts_claim_all.bmp", AllRegion, 50, 4000, true)
        FindImage("daily_task_claim_all.bmp", AllRegion, 50, 4000, true)
        MouseclickMiddle(2000)

        ;claim all gifts individually
        loop {
            result := FindImage("claim_green.bmp", AllRegion, 3, 1000, true)
            if !result.Found {  ; if not found, break the loop
                OutputDebug "Gifts not found : " count
                Sleep(1000)
                count += 1
                if (count > 5)
                    break
            } else {
                count := 0
            }

        }
    }

    ;start mutabeast
    MutaBeast(group := false) {

        count := 0
        loop {

            ;get energy shown-> break
            if (FindImage("get_energy.jpg", AllRegion, 50, 1000, true)).found {
                OutputDebug "out of energy"
                break
            }
            if (FindImage("get_energy_2.bmp", AllRegion, 50, 1000, true)).found {
                OutputDebug "out of energy"
                break
            }

            ; click cancel if stuck in existing boomer
            ;FindImage("cancel.bmp", AllRegion, 50, 1000, true)

            ;click help
            OutputDebug "help"
            FindImage("help.bmp", right_menu2_region, 50, 1000, true)

            FindImage("mb_icon.bmp", AllRegion, 50, 2000, true) ;select mutabeast

            searchloop := 0
            loop {
                if FindImage("mb_search.bmp", AllRegion, 50, 2000, true).Found {
                    OutputDebug "search found"
                    Sleep(20000) ;wait for the APC to return home.
                    break

                } ; search
                sleep (2000)
                OutputDebug "searching mutabeast " searchloop
                searchloop += 1
                if (searchloop > 50) {
                    OutputDebug "searchloop exceeded" searchloop
                    ExitApp()

                }
            }

            if group {
                OutputDebug "group"
                FindImage("mb_group.bmp ", AllRegion, 50, 2000, true) ; group
            } else {
                OutputDebug "solo"
                FindImage("mb_attack.bmp ", AllRegion, 50, 2000, true) ; solo
            }

            loop {
                ; apc1
                if !(FindImage("APC1.bmp", AllRegion, 50, 250, true).found) {
                    if !(FindImage("APC1_2.bmp", AllRegion, 50, 250, true).found) {
                        count += 1
                        break
                    }
                }

                ; march
                march_1 := (FindImage("March.jpg ", AllRegion, 50, 3000, true))
                march_2 := (FindImage("March_2.bmp ", AllRegion, 50, 3000, true))
                march_3 := (FindImage("March_3.bmp ", AllRegion, 50, 3000, true))

                if (march_1.Found or march_2.Found or march_3.Found) {
                    Sleep(10000) ;wait for march
                    count := 0
                    break
                } else {
                    count += 1
                    if (count > loopCount) {
                        ExitApp ; Exit the script when count exceeds 20
                    }
                    ToolTip("Count:" count)
                    Sleep(10000)
                }

            }
        }

    }

    ;VIP
    VIP_claim() {
        if FindImage("reddot.bmp", VIP_region, 40, 2000, true).Found {
            OutputDebug "VIP found"
            if FindImage("reddot.bmp", VIP_claim_region, 5, 2000, true).Found {
                MouseclickMiddle(2000)
            }
            if FindImage("reddot.bmp", VIP_freebies_region, 5, 2000, true).Found {
                MouseclickMiddle(2000)
            }
            FindImage("btn_return.bmp", AllRegion, 50, 2000, true)
        } else {
            OutputDebug "VIP not found"
        }
    }

    ;heal
    heal() {
        ;FindImage("red_cross.bmp", left_menu2_region, 50, 2000, true) ;red cross icon

        ; Heal button exist
        if FindImage("heal.bmp", AllRegion, 50, 2000, false).found {

            loop 10 {
                FindImage("heal_selectall.bmp", AllRegion, 50, 500, true)

                ; If heal button is grayed out, all units are 0
                if FindImage("heal_grayed.bmp", AllRegion, 50, 2000, false).found {
                    FindImage("heal_0.bmp", AllRegion, 50, 1000, true)

                    ; Heal 50 troops
                    SendText("50")
                    Sleep(250)
                    Send("{Enter}")
                    Sleep(2000)

                    ; Heal all troops and ask for help
                    FindImage("heal.bmp", AllRegion, 50, 1000, true)
                    FindImage("heal_alliance_help.bmp", AllRegion, 50, 1000, true)

                    ;click sheler to exit
                    FindImage("shelter.bmp", world_shelter_region, 50, 1000, true)

                    ;failsafe, click wordlmap
                    FindImage("world.bmp", world_shelter_region, 50, 1000, true)
                    break
                }
            }
        }

    }

    heal_check() {
        healing := false ;check if healing is in progress, exist

        if (FindImage("heal_progress.bmp", left_menu2_region, 50, 2000, false)).Found {
            OutputDebug "healing in progress"
            healing := true
        } else {
            ;click on the healing done icon
            FindImage("heal_done.bmp", left_menu2_region, 50, 4000, true)
            FindImage("heal_done_shooters.bmp", left_menu2_region, 50, 4000, true)
            FindImage("heal_done_riders.bmp", left_menu2_region, 50, 4000, true)

        }
        ;click on the red cross and heal
        if FindImage("red_cross.bmp", healing_region, 50, 1000, true).found { ;red cross icon
            heal()
            healing := true
        }
        return healing
    }

    Crash_check() {
        if (FindImage("crash_darkwar_icon.bmp", AllRegion, 50, 4000, true).Found) {
            OutputDebug "crash detected - restarting"
            Reload
            sleep (2000)
            OutputDebug "reload failed"
            ;throw Error("GameCrashed")
        }

    }

    ;switch user
    SelectUser(userimg) {
        FindImage(userimg, AllRegion, 50, 1000, true)
        FindImage("switch_yes.bmp", AllRegion, 50, 1000, true)
        FindImage("btn_return.bmp", AllRegion, 50, 1000, true)
    }

    FindImage(path, region, tolerance := 0, sleepDelay := 1000, doClick := true) {
        x1 := region[1]
        y1 := region[2]
        x2 := region[3]
        y2 := region[4]
        FoundX := -1
        FoundY := -1

        try
        {
            if ImageSearch(&FoundX, &FoundY, x1, y1, x2, y2, "*" tolerance " " AssetsPath path) {

                ;MsgBox "The icon was found at " FoundX "x" FoundY
                if (doClick) {
                    MouseClick("left", FoundX, FoundY)
                }
                Sleep(sleepDelay)
                found := true
            } else {
                ;MsgBox "Icon could not be found on the screen."
                found := false

            }
        } catch as exc {
            found := false
            OutputDebug "Could not conduct the search due to the following error:`n" exc.Message
            OutputDebug AssetsPath path
            FoundX := -1
            FoundY := -1
        }

        result := { x: FoundX, y: FoundY, Found: found }

        return result
    }

    FindPixelColour(colour, region, tolerance := 0, sleepDelay := 1000, doClick := true) {

        x1 := region[1]
        y1 := region[2]
        x2 := region[3]
        y2 := region[4]
        FoundX := -1
        FoundY := -1
        OutputDebug "debug - Pixel search " colour " " x1 " " y1 " " x2 " " y2 " " tolerance
        try {
            if PixelSearch(&FoundX, &FoundY, x1, y1, x2, y2, colour, tolerance) {
                if (doClick) {
                    MouseClick("left", FoundX, FoundY)
                }
                Sleep(sleepDelay)
                found := true
            } else {
                ;MsgBox "Icon could not be found on the screen."
                found := false
            }
        } catch as exc {
            found := false
            OutputDebug "Could not conduct the search due to the following error:`n" exc.Message
            FoundX := 400
            FoundY := 400
        }

        return { x: FoundX, y: FoundY, Found: found }

    }

    MouseclickMiddle(sleepDelay := 1000) {
        MouseClick("left", 1101, 482) ;middle
        Sleep(sleepDelay)
    }

    ClickProfile() {
        MouseClick("left", 848, 68)
        Sleep(1000)
    }

    GetEnergyExist() {

        get_energy_1 := (FindImage("get_energy.jpg", AllRegion, 50, 1000, false))
        get_energy_2 := (FindImage("get_energy_2.bmp", AllRegion, 50, 1000, false))
        get_energy_3 := (FindImage("get_energy_3.bmp", AllRegion, 50, 1000, false))
        get_energy_4 := (FindImage("get_energy_4.bmp", AllRegion, 50, 1000, false))

        return get_energy_1.Found or get_energy_2.Found or get_energy_3.Found or get_energy_4.Found

    }
    ; ===== HOTKEY: ESC to exit =====
    Esc:: {
        BlockInput("MouseMoveOff")
        BlockInput("Off")
        ExitApp()
    }
