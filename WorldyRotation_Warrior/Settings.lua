local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
  -- Addon
local addonName, addonTable = ...
-- WorldyRotation
local WR = WorldyRotation

local HL = HeroLib
-- File Locals
local GUI = HL.GUI
local CreateChildPanel = GUI.CreateChildPanel
local CreatePanelOption = GUI.CreatePanelOption
local CreateARPanelOption = WR.GUI.CreateARPanelOption
local CreateARPanelOptions = WR.GUI.CreateARPanelOptions

--- ============================ CONTENT ============================
-- All settings here should be moved into the GUI someday.
WR.GUISettings.APL.Warrior = {
  Commons = {
    Enabled = {
      Charge = true,
      HeroicLeap = true,
    },
    HP = {
      VictoryRushHP = 80,
    },
  },
  Arms = {
  },
  Fury = {
  },
  Protection = {
    Enabled = {
      Intervene = true,
    },
    RageCapValue = 80,
  },
}

WR.GUI.LoadSettingsRecursively(WR.GUISettings)
local ARPanel = WR.GUI.Panel
local CP_Warrior = CreateChildPanel(ARPanel, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('xxTVkRQaVzwYpGuCmcgjtckdqyxFHqGjuvSUGmWuKLnlJVpqzKXlWoAV2Fycmlvcg=='))
local CP_Arms = CreateChildPanel(CP_Warrior, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('xcBnnoovjhLEbdRFrboBzHBccddekxnBGAjJeThdWfxacxfaYwwPTkFQXJtcw=='))
local CP_Fury = CreateChildPanel(CP_Warrior, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('kIEHBcJAfVHKqVYznsCwHhZdaZXBkyAUdVTxnsqoRawIEPyRPtzCwtoRnVyeQ=='))
local CP_Protection = CreateChildPanel(CP_Warrior, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('UxrFaYkPCNYRrhtqluCHWYGuhVQDNMIYowxdTldtrEGDujOccFeoBNJUHJvdGVjdGlvbg=='))

CreateARPanelOptions(CP_Warrior, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('VgGgBStryQSEOMYkpADIdLDzXWfCQuhkaFUgljVYWpatzbqeurWAyLRQVBMLldhcnJpb3IuQ29tbW9ucw=='))

-- Arms Settings
CreateARPanelOptions(CP_Arms, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('cjLxOCYKSayKEtVeaUcUjbhSHxTyNGHNHXcDYmoUKZsLMfjEMbTWLVqQVBMLldhcnJpb3IuQXJtcw=='))

-- Fury Settings
CreateARPanelOptions(CP_Fury, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('qMmBbFQBiqXvEuySCSSxbeZrsNtALvnQyexsLSIUzPUrOrVmpXUrHTKQVBMLldhcnJpb3IuRnVyeQ=='))

-- Protection Settings
CreateARPanelOptions(CP_Protection, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('wdRNCjuOnqyNepXkGEUvNVTjENaPONhfYHIpptYFmJZgHDdySiCunuyQVBMLldhcnJpb3IuUHJvdGVjdGlvbg=='))
CreatePanelOption(AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('baWsADpCxwlRmfgxOTqYbeSwlPCuNfeuLZRGXqbmbOQtFjRSzPLqwRRU2xpZGVy'), CP_Protection, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('HOJytDzvZUYMvFKTKWIkqEnaKcVFsFqEnlpPoERsCTrQxHtbpwTQZGpQVBMLldhcnJpb3IuUHJvdGVjdGlvbi5SYWdlQ2FwVmFsdWU='), {30, 100, 5}, AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('SVTVkxSLvzYsGaQdfBmRyBvwFNsuTkFlUYxVqyxHqfpOEkkgViIalOgUmFnZSBDYXAgVmFsdWU='), AJubtWrpbgbXDeTCcjwDzUarYBQgRBqxDQKOcDhNMAAfFllWqvoFnzJGmuSvTmEzharb('zpckLybGOkyXfJVYGaDTvSjmwYLtEpzLVoitgMuHpVfaOPijXYGGwXQU2V0IHRoZSBoaWdoZXN0IGFtb3VudCBvZiBSYWdlIHdlIHNob3VsZCBhbGxvdyB0byBwb29sIGJlZm9yZSBkdW1waW5nIFJhZ2Ugd2l0aCBJZ25vcmUgUGFpbi4gU2V0dGluZyB0aGlzIHZhbHVlIHRvIDMwIHdpbGwgYWxsb3cgeW91IHRvIG92ZXItY2FwIFJhZ2Uu'))
    