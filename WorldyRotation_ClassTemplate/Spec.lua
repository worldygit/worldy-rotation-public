local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function iciSNwmxWtJblrfLRLFtSBuHpVLmzNlyyTcFlbvmTKmlnXqAjuuKzzeLqOcKWkliOmXNryDRV(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Spell = HL.Spell
local MultiSpell = HL.MultiSpell
local Item = HL.Item
-- WorldyRotation
local WR = WorldyRotation
local AoEON = WR.AoEON
local CDsON = WR.CDsON
local Cast = WR.Cast
-- Lua

--- ============================ CONTENT ============================
--- ======= APL LOCALS =======
-- Commons
local Everyone = WR.Commons.Everyone
local Class = WR.Commons.Class

-- GUI Settings
local Settings = {
  General = WR.GUISettings.General,
  Commons = WR.GUISettings.APL.Class.Commons,
  Spec = WR.GUISettings.APL.Class.Spec
}

-- Spells
local S = Spell.Class.Spec

-- Items
local I = Item.Class.Spec
local TrinketsOnUseExcludes = {
  --  I.TrinketName:ID(),
}

-- Enemies

-- Rotation Variables

-- Interrupts


--- ======= HELPERS =======


--- ======= ACTION LISTS =======
-- Put here action lists only if they are called multiple times in the APL
-- If iticiSNwmxWtJblrfLRLFtSBuHpVLmzNlyyTcFlbvmTKmlnXqAjuuKzzeLqOcKWkliOmXNryDRV('zsFhSZMvrtcILrsunefRZVZMPFrzSQTebWmQKRAULnUOMSeiSzUacLOcyBvbmx5IHB1dCBvbmUgdGltZSwgaXQ=')s doing a closure call for nothing.


--- ======= MAIN =======
local function APL()
  -- Rotation Variables Update

  -- Unit Update

  -- Defensives

  -- Out of Combat
  if not Player:AffectingCombat() then
    -- Flask
    -- Food
    -- Rune
    -- PrePot w/ Bossmod Countdown
    -- Opener
    if Everyone.TargetIsValid() then

    end
    return
  end

  -- In Combat
  if Everyone.TargetIsValid() then

    return
  end
end

local function OnInit()
end

WR.SetAPL(000, APL, OnInit)


--- ======= SIMC =======
-- Last Update: 12/31/2999

-- APL goes here
    