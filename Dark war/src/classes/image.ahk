#Requires AutoHotkey v2.0

class Image {
    __New(path, tolerance := 0, region := Regions.AllRegion, transcolor := "") {
        this.path := path
        this.tolerance := tolerance
        this.region := region

        if !(transcolor = "") {
            this.transcolor := "*" transcolor
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

    Clone() {
        return Image(this.path, this.tolerance, this.region, this.transcolor)
    }
}
