#Requires AutoHotkey v2.0

O_premium_title := Image("premium_title.bmp", 25, Regions.AllRegion)

premiumCenter() {

    iconPremiumCenterClick()

    if ImageFinderInstance.FindAnyImageObjects(1000, false, O_premium_title).found {
        LoggerInstance.Debug("premium menu")

        i := 0
        loop 20 {

            ;ImageFinderInstance.FindAnyImageObjects(2000, true, O_reddot_number_transblack)

            if ImageFinderInstance.FindAnyImageObjects(2000, true, O_reddot_number_transblack_bottom).found {
                ClickReddot(1000, Regions.events.main) ;If reddot, click on it
                ClickReddot(1000, Regions.events.main) ;If reddot, click on it
                ClickReddot(1000, Regions.events.main) ;If reddot, click on it
                Remove_Congrat()
                ClaimOCR()
                ClaimAllOCR()
                

            } else if (ImageFinderInstance.FindAnyImageObjects(2000, true, ImagesNew*).found) {

            } else if ClickReddot(1000, Regions.menus.bottom).found {
                ClickReddot(1000, Regions.events.main) ;If reddot, click on it
                ClickReddot(1000, Regions.events.main) ;If reddot, click on it
                ClickReddot(1000, Regions.events.main) ;If reddot, click on it
                Remove_Congrat()
                ClaimOCR()
                ClaimAllOCR()

            } else if (ImageFinderInstance.FindAnyImageObjects(2000, true, ImagesExclamation*).found) {
     
            } else {
                LoggerInstance.Debug("Nothing found, looping: " i)
                i += 1
            }


            ;if title is lost, try to go back until it's found
            if !(ImageFinderInstance.FindAnyImageObjects(1000, false, O_premium_title).found) {
                LoggerInstance.Debug("Premium title not found -> starting recovery sequence")

                actions := [iconPlayerClickBlind(), clickAnyX(), clickAnyBack()]

                for action in actions {
                    action.Call()
                    if (ImageFinderInstance.FindAnyImageObjects(1000, false, O_premium_title).found) {
                        LoggerInstance.Debug("Premium title found after action: " action.Name)
                        break
                    }
                }
            }

            /*
                        if !(ImageFinderInstance.FindAnyImageObjects(1000, false, O_premium_title).found) { ;If events menu is not found, go back
                            LoggerInstance.Debug("Events title not found -> going back")
                            iconPlayerClickBlind()
                            if !(ImageFinderInstance.FindAnyImageObjects(1000, false, O_premium_title).found) {
                                clickAnyX()
                                if !(ImageFinderInstance.FindAnyImageObjects(1000, false, O_premium_title).found) {
                                    clickAnyBack()
                                }
                            }
            
                        }
            */

            ;Click on reddot in the menu?

        } until i > 5
    }
    clickAnyBack()
}
