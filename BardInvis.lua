-- BardInvis.lua
-- Project Lazarus – EMU-safe Group Invis Controller
-- Version: 1.3.7
-- Author: Alektra <Lederhosen>
--
-- CHANGELOG:
-- v1.3.7
--  * UI polish: Invis status now color-coded
--    - GREEN = invisible
--    - RED   = visible
--  * No logic or behavior changes
--
-- Notes:
--  * EMU-safe
--  * Controller-side only

local mq = require('mq')
local ImGui = require('ImGui')
local ui = require('ui_helpers')

-- =========================
-- CONFIG FILE (UI STATE)
-- =========================
local config_dir = mq.TLO.MacroQuest.Path('config')()
local config_path = string.format('%s/BardInvis.ini', config_dir)

local function load_config()
    local cfg = { show_names = false }
    local f = io.open(config_path, 'r')
    if not f then return cfg end
    for line in f:lines() do
        if line == 'show_names=1' then cfg.show_names = true end
    end
    f:close()
    return cfg
end

local function save_show_names(val)
    local f = io.open(config_path, 'w')
    if not f then return end
    f:write(val and 'show_names=1' or 'show_names=0')
    f:close()
end

local cfg = load_config()

-- =========================
-- OPTIONS
-- =========================
local BARD_NAME = 'Zerayn'
local TRAVEL_MELODY = 'Travel'
local EXIT_MELODY = 'main'
local INVIS_SONG_NAME = "Shauri's Sonorous Clouding"

-- =========================
-- STATE
-- =========================
local state = 'IDLE'
local state_ts = 0
local show_names = cfg.show_names

-- =========================
-- HELPERS
-- =========================
local function now() return mq.gettime() end
local function elapsed(ms) return (now() - state_ts) >= ms end
local function group_size() return mq.TLO.Group.Members() or 0 end
local function member(i) return mq.TLO.Group.Member(i) end

local function member_name(i)
    local m = member(i)
    if not m() then return '' end
    return m.Name() or ''
end

local function member_has_invis(i)
    local m = member(i)
    if not m() then return false end
    return m.Invis() == true
end

-- =========================
-- COMMANDS
-- =========================
local function make_visible_all()
    mq.cmd('/e3bcga /make me visible')
end

local function remove_invis_song()
    mq.cmdf('/e3bcga /removebuff "%s"', INVIS_SONG_NAME)
end

local function play_travel()
    mq.cmdf('/e3bct %s /playmelody %s', BARD_NAME, TRAVEL_MELODY)
end

local function play_exit()
    mq.cmdf('/e3bct %s /playmelody %s', BARD_NAME, EXIT_MELODY)
end

-- =========================
-- FSM
-- =========================
local function fsm()
    if state == 'IDLE' then return end

    if state == 'ENABLE_RESET' then
        make_visible_all()
        state = 'ENABLE_WAIT'
        state_ts = now()
        return
    end

    if state == 'ENABLE_WAIT' and elapsed(2000) then
        play_travel()
        state = 'ACTIVE'
        return
    end

    if state == 'DISABLING' then
        remove_invis_song()
        make_visible_all()
        state = 'DISABLE_WAIT'
        state_ts = now()
        return
    end

    if state == 'DISABLE_WAIT' and elapsed(250) then
        play_exit()
        state = 'IDLE'
    end
end

-- =========================
-- GUI
-- =========================
local function draw_gui()
    local _, open = ImGui.Begin('Bard Group Invis v1.3.7', true)
    if not open then ImGui.End() return end

    if state == 'IDLE' then
        if ImGui.Button('GROUP INVIS (ON)', 220, 40) then
            state = 'ENABLE_RESET'
            state_ts = now()
        end
    else
        if ImGui.Button('GROUP INVIS (OFF)', 220, 40) then
            state = 'DISABLING'
            state_ts = now()
        end
    end

    ImGui.Separator()
    local total, invis = 0, 0
    for i = 1, group_size() do
        local name = member_name(i)
        if name ~= '' then
            total = total + 1
            if member_has_invis(i) then invis = invis + 1 end
        end
    end

    if invis == total and total > 0 then
        ImGui.TextColored(0,1,0,1,'Status: ALL INVISIBLE')
    else
        ImGui.TextColored(1,0.8,0,1,string.format('Status: %d/%d invisible', invis, total))
    end

    ImGui.Separator()
    show_names = ui.checkbox('Show Names', show_names, save_show_names)

    if show_names then
        if ImGui.BeginTable('names', 2, ImGuiTableFlags.Borders) then
            ImGui.TableSetupColumn('Name')
            ImGui.TableSetupColumn('Invis')
            ImGui.TableHeadersRow()
            for i = 1, group_size() do
                local name = member_name(i)
                if name ~= '' then
                    ImGui.TableNextRow()
                    ImGui.TableNextColumn()
                    ImGui.Text(name)
                    ImGui.TableNextColumn()
                    if member_has_invis(i) then
                        ImGui.TextColored(0,1,0,1,'YES')
                    else
                        ImGui.TextColored(1,0,0,1,'NO')
                    end
                end
            end
            ImGui.EndTable()
        end
    end

    ImGui.End()
end

mq.imgui.init('BardGroupInvis', draw_gui)

while true do
    fsm()
    mq.delay(50)
end
