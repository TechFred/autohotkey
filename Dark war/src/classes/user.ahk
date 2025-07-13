#Requires AutoHotkey v2.0

class User {
    name := ""
    active := false
    state := 0
    img := ""
    order := 0
    boomer_run := false
    energy_run := false
    heal_mode := false
    boomer_heal := 500 
    normal_heal := 60

    __New(name, active, state, imgPath, regex, order, boomer_run, energy_run, heal_mode, boomer_heal, normal_heal) {
        this.name := name
        this.active := active
        this.state := state
        this.img := Image(imgPath, 50, Regions.AllRegion)
        this.Regex := regex
        this.order := order
        this.boomer_run := boomer_run
        this.energy_run := energy_run
        this.heal_mode := heal_mode
        this.boomer_heal := boomer_heal
        this.normal_heal := normal_heal

    }
}


displayUsers(users) {
    for i, user in users {
        LoggerInstance.Info("User " i ": " user.name ", img: " user.img.path ", order: " user.order ", Boomers: " user.boomer_run ", Energy: " user.energy_run)
    }
}