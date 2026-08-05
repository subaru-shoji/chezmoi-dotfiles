-- User Hyprland overrides (Caelestia)
-- nwg-displays writes ~/.config/hypr/monitors.lua and workspaces.lua;
-- load them so Apply / hyprctl reload actually take effect.

local home = os.getenv("HOME")
local hypr = home .. "/.config/hypr"

local function load_if_exists(path)
    local f = io.open(path, "r")
    if not f then
        return
    end
    f:close()
    dofile(path)
end

load_if_exists(hypr .. "/monitors.lua")
load_if_exists(hypr .. "/workspaces.lua")

-- Bar toggle (no built-in kb* var)
hl.bind("SUPER + B", hl.dsp.exec_cmd("caelestia shell drawers toggle bar"))

-- IME (fcitx5)
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("aw-qt")
end)
