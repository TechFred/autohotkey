#Requires AutoHotkey v2.0

O_GetEnergy1 := Image("get_energy.jpg", 50, Regions.AllRegion)
O_GetEnergy2 := Image("get_energy_2.bmp", 50, Regions.AllRegion)
O_GetEnergy3 := Image("get_energy_3.bmp", 50, Regions.AllRegion)
O_GetEnergy4 := Image("get_energy_4.bmp", 50, Regions.AllRegion)

ImagesEnergy := [O_GetEnergy1, O_GetEnergy2, O_GetEnergy3, O_GetEnergy4]

GetEnergy(){

return ImageFinderInstance.FindAnyImageObjects(1000, false, ImagesEnergy*).found
}