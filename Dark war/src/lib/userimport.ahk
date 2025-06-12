#Requires AutoHotkey v2.0

importuser() {
    Users := []
    for u in JSON.Parse(FileRead(A_ScriptDir "\config.json", "UTF-8")) {
        if u["active"] {
            Users.Push(
                ; (name, active, state, imgPath, regex, order, boomer_run, energy_run)
                User(
                    u["name"],
                    u["active"],
                    u["state"],
                    u["img"],
                    u["regex"],
                    u["order"],
                    u["boomer_run"],
                    u["energy_run"]
                )
            )

        }

    }
    SortUsersByOrder(Users)
    displayUsers(Users)
    return Users
}

SortUsersByOrder(users) {
    ; Simple Bubble Sort (can be replaced with better one)
    for i, _ in users {
        for j, _ in users {
            if users[i].order < users[j].order {
                temp := users[i]
                users[i] := users[j]
                users[j] := temp
            }
        }
    }
}


