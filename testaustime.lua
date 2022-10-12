VERSION = "1.0.0"

local micro = import("micro")
local config = import("micro/config")
local util = import("micro/util")
local shell = import("micro/shell")
local goOs = import("os")

local ua = "micro/" .. util.SemVersion:String() .. " testaustime-micro/" .. VERSION
local lastHeartbeat = 0

function init()
    if config.GetGlobalOption("testaustime.token") == nil then
        config.RegisterGlobalOption("testaustime", "token", "")
    end
    if config.GetGlobalOption("testaustime.api") == nil then
        config.RegisterGlobalOption("testaustime", "api", "https://api.testaustime.fi")
    end
    
    micro.Log("Started Testaustime v" .. VERSION)
end

function sendFlush()
    if config.GetGlobalOption("testaustime.token") == "" then
        return
    end
    micro.Log("Testaustime data flushed")
    shell.RunCommand("curl -sX POST -H 'User-Agent: " .. ua .. "' -H 'Authorization: Bearer " .. config.GetGlobalOption("testaustime.token") .. "' " .. config.GetGlobalOption("testaustime.api") .. "/activity/flush")
end

function onExit()
    sendFlush()
    return true
end

function onQuit()
    return onExit()
end
function onQuitAll()
    return onExit()
end
function onSave()
    return onExit()
end
function onSaveAll()
    return onExit()
end
function onSaveAs()
    return onExit()
end



function getGitRoot()
    local out, err = shell.RunCommand("sh -c 'git rev-parse --show-toplevel 2>/dev/null'")
    if err ~= nil then
        return "" 
    end
    return out
end

function getPwd()
    local out, err = shell.RunCommand("pwd")
    if err ~= nil then
        return "" 
    end
    return out
end

function getHostname()
    local out, err = goOs.Hostname()
    if err ~= nil then
        return "" 
    end
    return out
end

function getHeartbeatData()
    local root = getGitRoot()
    if root == "" then
        root = getPwd()
    end

    local projectName = string.gsub(root:match("/([^/]+)$"), "%s+", "")
    local bp = micro.CurPane()

    return {
        language = bp.Buf.SyntaxDef and bp.Buf.SyntaxDef.FileType or "",
        hostname = getHostname(),
        editorName = "micro",
        projectName = projectName
    }
end

function heartbeatToJSON(hb)
    return string.format([[{"language":"%s","hostname":"%s","editor_name":"%s","project_name":"%s"}]], hb.language, hb.hostname, hb.editorName, hb.projectName)
end

function sendHeartbeat()
    if config.GetGlobalOption("testaustime.token") == "" then
        return
    end
    local data = getHeartbeatData()
    local json = heartbeatToJSON(data)
    shell.RunCommand("curl -sd '" .. json .. "' -H 'Content-Type: application/json' -H 'User-Agent: " .. ua .. "' -H 'Authorization: Bearer " .. config.GetGlobalOption("testaustime.token") .. "' " .. config.GetGlobalOption("testaustime.api") .. "/activity/update")
end

function onAll()
    local now = os.time()
    if now - lastHeartbeat > 30 then
        sendHeartbeat() 
        lastHeartbeat = now
    end
    return true
end

function onBeforeTextEvent()
    return onAll()
end
function onCursorUp()
    return onAll()
end
function onCursorDown()
    return onAll()
end
function onCursorPageUp()
    return onAll()
end
function onCursorPageDown()
    return onAll()
end
function onCursorLeft()
    return onAll()
end
function onCursorRight()
    return onAll()
end
function onCursorStart()
    return onAll()
end
function onCursorEnd()
    return onAll()
end
function onSelectToStart()
    return onAll()
end
function onSelectToEnd()
    return onAll()
end
function onSelectUp()
    return onAll()
end
function onSelectDown()
    return onAll()
end
function onSelectLeft()
    return onAll()
end
function onSelectRight()
    return onAll()
end
function onSelectToStartOfText()
    return onAll()
end
function onSelectToStartOfTextToggle()
    return onAll()
end
function onWordRight()
    return onAll()
end
function onWordLeft()
    return onAll()
end
function onSelectWordRight()
    return onAll()
end
function onSelectWordLeft()
    return onAll()
end
function onMoveLinesUp()
    return onAll()
end
function onMoveLinesDown()
    return onAll()
end
function onDeleteWordRight()
    return onAll()
end
function onDeleteWordLeft()
    return onAll()
end
function onSelectLine()
    return onAll()
end
function onSelectToStartOfLine()
    return onAll()
end
function onSelectToEndOfLine()
    return onAll()
end
function onInsertNewline()
    return onAll()
end
function onInsertSpace()
    return onAll()
end
function onBackspace()
    return onAll()
end
function onDelete()
    return onAll()
end
function onCenter()
    return onAll()
end
function onInsertTab()
    return onAll()
end
function onFind()
    return onAll()
end
function onFindLiteral()
    return onAll()
end
function onFindNext()
    return onAll()
end
function onFindPrevious()
    return onAll()
end
function onUndo()
    return onAll()
end
function onRedo()
    return onAll()
end
function onCopy()
    return onAll()
end
function onCopyLine()
    return onAll()
end
function onCut()
    return onAll()
end
function onCutLine()
    return onAll()
end
function onDuplicateLine()
    return onAll()
end
function onDeleteLine()
    return onAll()
end
function onIndentSelection()
    return onAll()
end
function onOutdentSelection()
    return onAll()
end
function onOutdentLine()
    return onAll()
end
function onIndentLine()
    return onAll()
end
function onPaste()
    return onAll()
end
function onSelectAll()
    return onAll()
end
function onOpenFile()
    return onAll()
end
function onStart()
    return onAll()
end
function onEnd()
    return onAll()
end
function onPageUp()
    return onAll()
end
function onPageDown()
    return onAll()
end
function onSelectPageUp()
    return onAll()
end
function onSelectPageDown()
    return onAll()
end
function onHalfPageUp()
    return onAll()
end
function onHalfPageDown()
    return onAll()
end
function onStartOfLine()
    return onAll()
end
function onEndOfLine()
    return onAll()
end
function onStartOfText()
    return onAll()
end
function onStartOfTextToggle()
    return onAll()
end
function onParagraphPrevious()
    return onAll()
end
function onParagraphNext()
    return onAll()
end
function onToggleHelp()
    return onAll()
end
function onToggleDiffGutter()
    return onAll()
end
function onToggleRuler()
    return onAll()
end
function onJumpLine()
    return onAll()
end
function onClearStatus()
    return onAll()
end
function onShellMode()
    return onAll()
end
function onCommandMode()
    return onAll()
end
function onAddTab()
    return onAll()
end
function onPreviousTab()
    return onAll()
end
function onNextTab()
    return onAll()
end
function onNextSplit()
    return onAll()
end
function onUnsplit()
    return onAll()
end
function onVSplit()
    return onAll()
end
function onHSplit()
    return onAll()
end
function onPreviousSplit()
    return onAll()
end
function onToggleMacro()
    return onAll()
end
function onPlayMacro()
    return onAll()
end
function onScrollUp()
    return onAll()
end
function onScrollDown()
    return onAll()
end
function onSpawnMultiCursor()
    return onAll()
end
function onSpawnMultiCursorUp()
    return onAll()
end
function onSpawnMultiCursorDown()
    return onAll()
end
function onSpawnMultiCursorSelect()
    return onAll()
end
function onRemoveMultiCursor()
    return onAll()
end
function onRemoveAllMultiCursors()
    return onAll()
end
function onSkipMultiCursor()
    return onAll()
end
function onJumpToMatchingBrace()
    return onAll()
end
function onAutocomplete()
    return onAll()
end
