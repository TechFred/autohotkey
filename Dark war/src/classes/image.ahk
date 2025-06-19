#Requires AutoHotkey v2.0

class Image {
    __New(path, tolerance := 0, region := Regions.AllRegion, transcolor := "") {
        this.path := path
        this.tolerance := tolerance
        this.region := region

        if (transcolor != "") {
            if (SubStr(transcolor, 1, 1) != "*") {
                this.transcolor := "*" transcolor
            } else {
                this.transcolor := transcolor
            }
        } else {
            this.transcolor := ""
        }
    }

    ; Example: prepare args for ImageSearch
    GetSearchParams() {
        return {
            path: this.path,
            tolerance: this.tolerance,
            region: this.region,
            transcolor: this.transcolor
        }
    }

    Clone(Tolerance := this.tolerance, Region := this.region) {
        return Image(this.path, Tolerance, Region, this.transcolor)
    }

    ClickOffsetTopLeft(ClickDelay := 2000) {
        img := ImageFinderInstance.FindAnyImageObjects(1000, false, this)
        if img {
            MouseClick("left", img.x + 10, img.y + 10)
            Sleep(ClickDelay)

        }
        return img
    }
}
