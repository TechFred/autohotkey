#Requires AutoHotkey v2.0

O_reddot_transblack_local := Image("reddot_transblack.bmp", 50, Regions.AllRegion, TransBlack)
O_reddot_transblack_local_2 := Image("reddot_transblack_2.bmp", 50, Regions.AllRegion, TransBlack)

ClickReddot(ClickDelay := 1000, Region := Regions.AllRegion) {

    O_reddot_transblack_local.Region := Region
    i := ImageFinderInstance.FindAnyImageObjects(ClickDelay, false, 0, 2, O_reddot_transblack_local_2)

    if (i.found) {
        MouseClick("left", i.x, i.y + 20)
        Sleep(ClickDelay)
    }

    return i
}

GetReddot(Region := Regions.AllRegion) {

    O_reddot_transblack_local.Region := Region

    return ImageFinderInstance.FindAnyImageObjects(10000, false, 0, 2, O_reddot_transblack_local_2)

}
