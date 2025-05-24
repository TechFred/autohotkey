class Logger {
    __New(logPath := A_ScriptDir "\run.log", minLevel := "INFO") {
        this.logFile := logPath
        this.levels := ["DEBUG", "INFO", "WARN"]
        this.minLevel := minLevel
    }

    _levelValue(level) {
        for index, val in this.levels
            if (val = level)
                return index
        return 0
    }

    Log(msg, level := "INFO") {
        if (this._levelValue(level) < this._levelValue(this.minLevel))
            return  ; skip because below minimum level

        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm")
        entry := "[" level "] " timestamp " - " msg
        FileAppend(entry, this.logFile)
        OutputDebug(entry)
    }

    Debug(msg) {
        this.Log(msg, "DEBUG")
    }

    Info(msg) {
        this.Log(msg, "INFO")
    }

    Warn(msg) {
        this.Log(msg, "WARN")
    }

    Clear() {
        FileDelete(this.logFile)
    }
}
