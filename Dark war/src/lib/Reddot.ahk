#Requires AutoHotkey v2.0

O_reddot_transblack_local := Image("reddot_transblack.bmp", 50, Regions.AllRegion, TransBlack)
O_reddot_transblack_local_2 := Image("reddot_transblack_2.bmp", 50, Regions.AllRegion, TransBlack)
O_reddot_transblack_local_3 := Image("reddot_transblack_3.bmp", 50, Regions.AllRegion, TransBlack)

reddot_group := [O_reddot_transblack_local, O_reddot_transblack_local_2, O_reddot_transblack_local_3]

ClickReddot(ClickDelay := 1000, Region := Regions.AllRegion) {

    i := ImageFinderInstance.FindAnyImageObjects(10000, false, 0, 2, SetGroupRegion(reddot_group, Region)*)

    if (i.found) {
        MouseClick("left", i.x, i.y + 20)
        Sleep(ClickDelay)
    }

    return i
}

GetReddot(Region := Regions.AllRegion) {

    return ImageFinderInstance.FindAnyImageObjects(10000, false, 0, 2, SetGroupRegion(reddot_group, Region)*)

}

SetGroupRegion(group, Region) {

    newgroup := []
    for img in group
        newgroup.Push(img.clone(, Region))

    return newgroup

}
