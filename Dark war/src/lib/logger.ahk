class Logger {
    __New(basePath := A_ScriptDir, minLevel := "DEBUG") {
        this.minLevel := minLevel
        this.levels := ["DEBUG", "INFO", "WARN"]
        this.basePath := basePath
        this.infoLog := basePath "\run-info.log"
        this.debugLog := Format("{1}\{2}-run-debug.log", basePath, FormatTime(A_Now, "yyyy-MM-dd"))
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

        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        entry := "[" level "] " timestamp " - " msg

        this.WriteWithRetry(entry, this.debugLog)

        ; Always write to debug log

        if (level != "DEBUG") {
            this.WriteWithRetry(entry, this.infoLog)  ; Only INFO and WARN go here
        }

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
        FileDelete(this.infoLog)
        FileDelete(this.debugLog)
    }

    WriteWithRetry(text, filePath, retries := 5, delayMs := 200) {
        loop retries {
            try {
                FileAppend(text "`n", filePath)
                return true  ; Success
            } catch {
                Sleep delayMs
            }
        }
        return false  ; Failed after all retries
    }

}
