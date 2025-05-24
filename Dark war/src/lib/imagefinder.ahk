class ImageFinder {
    __New(assetsPath) {
        this.assetsPath := assetsPath
    }

    ; Cherche le fichier image dans le répertoire assets
    ; @param path : le nom du fichier image
    ; @param region : la région de l'écran où chercher l'image
    ; @param tolerance : la tolérance de la recherche d'image
    ; @param clickDelay : le délai de sommeil après la recherche
    ; @param doClick : si vrai, clique sur l'image trouvée
    ; @return : un objet contenant les coordonnées x et y de l'image trouvée, et un booléen indiquant si l'image a été trouvée
    FindImage(path, region, tolerance := 0, clickDelay := 1000, doClick := true) {
        LoggerInstance.Debug("Searching for image: " path)
        x1 := region[1]
        y1 := region[2]
        x2 := region[3]
        y2 := region[4]
        FoundX := -1
        FoundY := -1
        found := false

        try {
            if ImageSearch(&FoundX, &FoundY, x1, y1, x2, y2, "*" tolerance " " this.assetsPath path) {
                if (doClick) {
                    MouseClick("left", FoundX, FoundY)
                }
                Sleep(clickDelay)
                found := true
            }
        } catch as e {
            LoggerInstance.Warn("Error in FindImage: " e.Message)
            LoggerInstance.Debug("Image path: " this.assetsPath path)
            FoundX := -1
            FoundY := -1
            found := false
        }

        return { x: FoundX, y: FoundY, Found: found }
    }

    ; Cherche le fichier image dans le répertoire assets plusieurs fois
    ; @param path : le nom du fichier image
    ; @param region : la région de l'écran où chercher l'image
    ; @param attempts : le nombre de tentatives de recherche
    ; @param tolerance : la tolérance de la recherche d'image
    ; @param loopDelay : le délai de sommeil après la recherche
    ; @param clickDelay : le délai de clic après la recherche
    ; @param doClick : si vrai, clique sur l'image trouvée
    ; @return : un objet contenant les coordonnées x et y de l'image trouvée, et un booléen indiquant si l'image a été trouvée
    LoopFindImage(path, region, tolerance := 0, clickDelay := 1000, doClick := true, loopDelay := 1000,  attempts := 5) {
        loop attempts {
            res := this.FindImage(path, region, tolerance, clickDelay, doClick)
            if (res.Found)
                return res
            Sleep(loopDelay)
        }
        return { x: -1, y: -1, Found: false }
    }

    ; Cherche plusieurs fichiers image dans le répertoire assets
    ; @param region : la région de l'écran où chercher l'image  
    ; @param tolerance : la tolérance de la recherche d'image
    ; @param clickDelay : le délai de clic après la recherche
    ; @param doClick : si vrai, clique sur l'image trouvée
    FindAnyImage(region, tolerance := 0, clickDelay := 1000, doClick := true, paths*) {
        for path in paths {
            res := this.FindImage(path, region, tolerance, clickDelay, doClick)
            if (res.Found)
                return res
        }
        return { x: -1, y: -1, Found: false }
    }

    ; Cherche plusieurs fichiers image dans le répertoire assets plusieurs fois
    ; @param region : la région de l'écran où chercher l'image
    ; @param tolerance : la tolérance de la recherche d'image
    ; @param clickDelay : le délai de clic après la recherche
    ; @param doClick : si vrai, clique sur l'image trouvée
    ; @param loopDelay : le délai de sommeil après la recherche
    ; @param attempts : le nombre de tentatives de recherche
    ; @param paths : les noms des fichiers image à chercher
    ; @return : un objet contenant les coordonnées x et y de l'image trouvée, et un booléen indiquant si l'image a été trouvée
    LoopFindAnyImage(region, tolerance := 0, clickDelay := 1000, doClick := true, loopDelay := 1000,  attempts := 5, paths*) {
        loop attempts {
            res := this.FindAnyImage(region, tolerance, clickDelay, doClick, paths*)
            if (res.Found)
                return res
            Sleep(loopDelay)
        }
        return { x: -1, y: -1, Found: false }
    }
}
