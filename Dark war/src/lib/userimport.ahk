#Requires AutoHotkey v2.0

importuser() {
    Users := []
    for u in Json.Parse(FileRead(A_ScriptDir "\config.json")) {
        Users.Push(
            User(
                u["name"],
                u["active"],
                u["state"],
                u["img"],
                u["order"],
                u["boomer_run"],
                u["energy_run"]
            )
        )
    }
    return Users
}
