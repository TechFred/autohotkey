#Requires AutoHotkey v2.0

global imageLogFile := "ImageLog.csv"
global imageStats := Map()

UpdateImageStats(path) {
    global imageStats
    now := FormatTime(, "yyyy-MM-dd HH:mm:ss")

    if imageStats.Has(path) {
        imageStats[path].lastdetect := now
        if imageStats[path].matchcount == ""
            imageStats[path].matchcount := 1
        else
            imageStats[path].matchcount += 1
    } else {
        imageStats[path] := { lastdetect: now, matchcount: 1 }
    }
}

LoadImageStatsFromCSV() {
    global imageStats, imageLogFile
    if !FileExist(imageLogFile)
        return
    loop read imageLogFile {
        if A_Index = 1 ; Skip header
            continue
        fields := StrSplit(A_LoopReadLine, ";")
        if fields.Length = 3
            matchCount := (fields[3] != "") ? Integer(fields[3]) : ""
        imageStats[fields[1]] := { lastdetect: fields[2], matchcount: matchCount }
    }
}

SaveImageStatsToCSV() {
    global imageStats, imageLogFile
    file := FileOpen(imageLogFile, "w")
    file.WriteLine("path,lastdetect,matchcount")
    for path, data in imageStats
        file.WriteLine(Format('{};{};{}', path, data.lastdetect, data.matchcount))
    file.Close()
}
