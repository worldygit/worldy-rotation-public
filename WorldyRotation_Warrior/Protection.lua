local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL         = HeroLib
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Spell      = HL.Spell
local Item       = HL.Item
local Utils      = HL.Utils
-- WorldyRotation
local WR         = WorldyRotation
local Cast       = WR.Cast
local AoEON      = WR.AoEON
local CDsON      = WR.CDsON
local Macro      = WR.Macro
-- lua
local mathfloor  = math.floor

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
local S = Spell.Warrior.Protection
local I = Item.Warrior.Protection
local M = Macro.Warrior.Protection

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
}

-- Variables
local TargetInMeleeRange

-- Enemies Variables
local Enemies8y
local EnemiesCount8

-- GUI Settings
local Everyone = WR.Commons.Everyone
local Settings = {
  General = WR.GUISettings.General,
  Commons = WR.GUISettings.APL.Warrior.Commons,
  Protection = WR.GUISettings.APL.Warrior.Protection
}

-- Legendaries
local ReprisalEquipped = Player:HasLegendaryEquipped(193)
local GloryEquipped = Player:HasLegendaryEquipped(214)

-- Event Registrations
HL:RegisterForEvent(function()
  ReprisalEquipped = Player:HasLegendaryEquipped(193)
  GloryEquipped = Player:HasLegendaryEquipped(214)
end, vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('dsTBMhBsQgiMsJbsegujauFjMpFaOeMFkfaHVEfnVwAecPsTLXPiCJEUExBWUVSX0VRVUlQTUVOVF9DSEFOR0VE'))

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('BJFeivYDtHtEFExOrvOfooBncWvsRjZPwtIMqAWmDPaLaZmzsnbeKAeQ09WRU5BTlRfQ0hPU0VO'))

local function IsCurrentlyTanking()
  return Player:IsTankingAoE(16) or Player:IsTanking(Target) or Target:IsDummy()
end

local function IgnorePainWillNotCap()
  if Player:BuffUp(S.IgnorePain) then
    local absorb = Player:AttackPowerDamageMod() * 3.5 * (1 + Player:VersatilityDmgPct() / 100)
    local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, IPAmount = Player:AuraInfo(S.IgnorePain, nil, true)
    --return IPAmount < (0.5 * mathfloor(absorb * 1.3))
    -- Ignore Pain appears to cap at 2 times its absorb value now
    return IPAmount < absorb
  else
    return true
  end
end

local function ShouldPressShieldBlock()
  return IsCurrentlyTanking() and S.ShieldBlock:IsReady() and ((Player:BuffDown(S.ShieldBlockBuff) or Player:BuffRemains(S.ShieldBlockBuff) < S.ShieldSlam:CooldownRemains()) and Player:BuffDown(S.LastStandBuff))
end

-- A bit of logic to decide whether to pre-cast-rage-dump on ignore pain.
local function SuggestRageDump(RageFromSpell)
  -- Get RageMax from setting (default 80)
  local RageMax = Settings.Protection.RageCapValue
  -- If the setting value is lower than 35, itvUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('QpZdRUtnQkTRYnHczywFtnOSNVxeZUQtyejCzYEPqBMmCZDnSCNshggcyBub3QgcG9zc2libGUgdG8gY2FzdCBJZ25vcmUgUGFpbiwgc28ganVzdCByZXR1cm4gZmFsc2UNCiAgaWYgKFJhZ2VNYXggPCAzNSBvciBQbGF5ZXI6UmFnZSgpIDwgMzUpIHRoZW4gcmV0dXJuIGZhbHNlIGVuZA0KICBsb2NhbCBTaG91bGRQcmVSYWdlRHVtcCA9IGZhbHNlDQogIC0tIE1ha2Ugc3VyZSB3ZSBoYXZlIGVub3VnaCBSYWdlIHRvIGNhc3QgSVAsIHRoYXQgaXQ=')s not on CD, and that we shouldnvUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('fBOgKijYatQlbVbzWddsbALrBSpbqISWwNHtCAVmkkbpcKTMdAcGtNxdCB1c2UgU2hpZWxkIEJsb2NrDQogIGxvY2FsIEFibGVUb0Nhc3RJUCA9IChQbGF5ZXI6UmFnZSgpID49IDM1IGFuZCBub3QgU2hvdWxkUHJlc3NTaGllbGRCbG9jaygpKQ0KICBpZiBBYmxlVG9DYXN0SVAgYW5kIChQbGF5ZXI6UmFnZSgpICsgUmFnZUZyb21TcGVsbCA+PSBSYWdlTWF4IG9yIFMuRGVtb3JhbGl6aW5nU2hvdXQ6SXNSZWFkeSgpKSB0aGVuDQogICAgLS0gc2hvdWxkIHByZS1kdW1wIHJhZ2UgaW50byBJUCBpZiByYWdlICsgUmFnZUZyb21TcGVsbCA+PSBSYWdlTWF4IG9yIERlbW8gU2hvdXQgaXMgcmVhZHkNCiAgICBTaG91bGRQcmVSYWdlRHVtcCA9IHRydWUNCiAgZW5kDQogIGlmIFNob3VsZFByZVJhZ2VEdW1wIHRoZW4NCiAgICBpZiBJZ25vcmVQYWluV2lsbE5vdENhcCgpIHRoZW4NCiAgICAgIGlmIENhc3QoUy5JZ25vcmVQYWluKSB0aGVuIHJldHVybiA=')ignore_pain rage cappedvUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('IggYQzJsSGoxTwIROOjqaGMQRaeksbkwLcsOvAHCwpqyrJMMnMRZMWlOyBlbmQNCiAgICBlbHNlDQogICAgICBpZiBDYXN0KFMuUmV2ZW5nZSwgbm90IFRhcmdldEluTWVsZWVSYW5nZSkgdGhlbiByZXR1cm4g')revenge rage cappedvUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('cvuQUABeCeiydOQpgAQciDQseAyBxSwARHOXZfHBxbVtWZCEMzFxNTIOyBlbmQNCiAgICBlbmQNCiAgZW5kDQplbmQNCg0KbG9jYWwgZnVuY3Rpb24gUHJlY29tYmF0KCkNCiAgLS0gZmxhc2sNCiAgLS0gZm9vZA0KICAtLSBhdWdtZW50YXRpb24NCiAgLS0gc25hcHNob3Rfc3RhdHMNCiAgLS0gZmxlc2hjcmFmdA0KICAtLSBOb3RlOiBNYW51YWxseSBtb3ZlZCB0aGlzIGFib3ZlIGNvbnF1ZXJvcnNfYmFubmVyIHNvIHdlIGRvbg==')t waste 3s of the banner buff
  if S.Fleshcraft:IsCastable() then
    if Cast(S.Fleshcraft) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('BIYLGlDzPEEZvywliXiYqdijaamyJGruSpxTkKdzicarWmIaQqSFUHNZmxlc2hjcmFmdCBwcmVjb21iYXQ='); end
  end
  -- conquerors_banner
  if S.ConquerorsBanner:IsCastable() then
    if Cast(S.ConquerorsBanner) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('qrMFofRJsnanFItqrmWFrqUBSmeXjBaIEVUHzgLXZLEbgQUEFGzCJlxY29ucXVlcm9yc19iYW5uZXIgcHJlY29tYmF0'); end
  end
  -- Manually added opener
  if Target:IsInMeleeRange(12) then
    if S.ThunderClap:IsCastable() then
      if Cast(S.ThunderClap) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('leeFWvvbegsHTXRRvOdAkOrtYhGlaJhZNAChpqtEITKuUfkkSdeeAkNdGh1bmRlcl9jbGFwIHByZWNvbWJhdA=='); end
    end
  else
    if Settings.Commons.Enabled.Charge and S.Charge:IsCastable() and not Target:IsInRange(8) then
      if Cast(S.Charge, not Target:IsSpellInRange(S.Charge)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('iQLxpPcGULENQBrRkuXqKiHcsoCIdSlrQiAgtLnYtImdtzVIqLAdVjEY2hhcmdlIHByZWNvbWJhdA=='); end
    end
  end
end

local function Defensive()
  if ShouldPressShieldBlock() then
    if Cast(S.ShieldBlock) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('vWxOoJuejZmyuKwNDXDUbHOsQgTukOxMFVbIhffBhcvraDqJnnPQpmbc2hpZWxkX2Jsb2NrIGRlZmVuc2l2ZQ==') end
  end
  if S.LastStand:IsCastable() and (Player:BuffDown(S.ShieldBlockBuff) and S.ShieldBlock:Recharge() > 1) then
    if Cast(S.LastStand) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('VgrEfCnucsdQZIcDbCSuPgkFDswZIsgaMHhcpYTfUvwAbHjTablsBIMbGFzdF9zdGFuZCBkZWZlbnNpdmU=') end
  end
  if Player:HealthPercentage() < Settings.Commons.HP.VictoryRushHP then
    if S.VictoryRush:IsReady() then
      if Cast(S.VictoryRush) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('FxbNyfpJdiFjxJRxUFdrGDuQxoRgwhDSMfwnIAqPpBOQwKisCVJyibDdmljdG9yeV9ydXNoIGRlZmVuc2l2ZQ==') end
    end
    if S.ImpendingVictory:IsReady() then
      if Cast(S.ImpendingVictory) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('jhikPSmckparbujcjgLeVAlnccEJtdGAfaSHTjuhcxUppbIRFUnRAUlaW1wZW5kaW5nX3ZpY3RvcnkgZGVmZW5zaXZl') end
    end
  end
  -- healthstone
  if Player:HealthPercentage() <= Settings.Commons.HP.Healthstone and I.Healthstone:IsReady() then
    if Cast(M.Healthstone, nil, nil, true) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('tCaJbngYceiNpVavgZlgYYZjWDzBAcqlHStTCYIFqgJBGXpeHQHMZyQaGVhbHRoc3RvbmUgZGVmZW5zaXZlIDM='); end
  end
  -- phial_of_serenity
  if Player:HealthPercentage() <= Settings.Commons.HP.PhialOfSerenity and I.PhialofSerenity:IsReady() then
    if Cast(M.PhialofSerenity, nil, nil, true) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('EJGQOcbsDwdQoODXZzpnHcLKpbJczorSBOImdeXyWHPPubTrVtcEvdzcGhpYWxfb2Zfc2VyZW5pdHkgZGVmZW5zaXZlIDQ='); end
  end
end

local function Aoe()
  -- ravager
  if S.Ravager:IsCastable() then
    SuggestRageDump(10)
    if Cast(M.RavagerPlayer, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('CBvEBiVipjcUnYbnfwMQkRCUSRtvvbUozrmcOoLHgrAzXkSjfwmeltscmF2YWdlciBhb2UgMg=='); end
  end
  -- dragon_roar
  if S.DragonRoar:IsCastable() then
    SuggestRageDump(20)
    if Cast(S.DragonRoar, not Target:IsInMeleeRange(12)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('xEiXtsgZVpcIjktmdSDrFgQzSnpsrKtmiSnooWITcOsWmBlxNhwsdWCZHJhZ29uX3JvYXIgYW9lIDQ='); end
  end
  -- thunder_clap,if=buff.outburst.up
  if S.ThunderClap:IsCastable() and (Player:BuffUp(S.OutburstBuff)) then
    SuggestRageDump(5)
    if Cast(S.ThunderClap, not Target:IsInMeleeRange(12)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('QeCdtlPbXcflVCPEfMgGLEkmBQAUvjdkoHWRcIyDRHSgrLlMhxenRcMdGh1bmRlcl9jbGFwIGFvZSA2'); end
  end
  -- revenge
  -- Manually added: Reserve 30 Rage for ShieldBlock
  if S.Revenge:IsReady() and (Player:Rage() >= 50 and not ShouldPressShieldBlock()) then
    if Cast(S.Revenge, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('ubhUWGJkUDTELelBoOedYXHlsJPUdWtodGHKpijxCwAsLfIGqolwgzIcmV2ZW5nZSBhb2UgOA=='); end
  end
  -- thunder_clap
  if S.ThunderClap:IsCastable() then
    SuggestRageDump(5)
    if Cast(S.ThunderClap, not Target:IsInMeleeRange(12)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('nvLnbEztSbYjAyAXakPaLTmMTCtCvtITmqGDRRurvNJGJUBSxcKCbWpdGh1bmRlcl9jbGFwIGFvZSA2'); end
  end
  -- shield_slam
  if S.ShieldSlam:IsCastable() then
    SuggestRageDump(15)
    if Cast(S.ShieldSlam, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('kBYOIdkXwPffcqwZcWyfYqDEllzbWRQWInMrQdINleFnZoTsNnhwxnQc2hpZWxkX3NsYW0gYW9lIDEw'); end
  end
end

local function Generic()
  -- ravager
  if S.Ravager:IsCastable() then
    SuggestRageDump(10)
    if Cast(M.RavagerPlayer, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('uLfYWnKvVlcCYQYRzzviRGmPQYCcFryubWReAOulXcnFpYduKSnJaXDcmF2YWdlciBnZW5lcmljIDI='); end
  end
  -- dragon_roar
  if S.DragonRoar:IsCastable() then
    SuggestRageDump(20)
    if Cast(S.DragonRoar, not Target:IsInMeleeRange(12)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('pUKBhebCXwniJfqEDoAjheQWGQqLzylparaInJGRXkPcqdNOKOeHectZHJhZ29uX3JvYXIgZ2VuZXJpYyA0'); end
  end
  if (not ShouldPressShieldBlock()) then
    -- execute
    if S.Execute:IsReady() then
      if Cast(S.Execute, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('TACScBcJKltaCOcedwtPRqmpyNHcVDCmseBtDzOeliYNYmSogvxpYSxZXhlY3V0ZSBnZW5lcmljIDY='); end
    end
    -- condemn
    if S.Condemn:IsReady() then
      if Cast(S.Condemn, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('OIDKkrRSeVQiZLxCMxATcmkwobhviiDDRAVlljDtNLalCuYYXxQRWbqY29uZGVtbiBnZW5lcmljIDg='); end
    end
  end
  -- shield_slam
  if S.ShieldSlam:IsCastable() then
    SuggestRageDump(15)
    if Cast(S.ShieldSlam, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('DIIPtQdfpvrxguzhAVMpXruKxiYBRhGiVYOmdvuRCdIStDvSmiuvJRBc2hpZWxkX3NsYW0gZ2VuZXJpYyAxMA=='); end
  end
  -- thunder_clap,if=buff.outburst.down
  if S.ThunderClap:IsCastable() and (Player:BuffDown(S.OutburstBuff)) then
    SuggestRageDump(5)
    if Cast(S.ThunderClap, not Target:IsInMeleeRange(12)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('qkSsIZiYTdSmPQMTiUyRbYtWOejNcKLmmKnVOwWVJqJavnUYlWpQuJDdGh1bmRlcl9jbGFwIGdlbmVyaWMgMjA='); end
  end
  -- revenge
  -- Manually added: Reserve 30 Rage for ShieldBlock
  if S.Revenge:IsReady() and (Player:Rage() >= 50 and not ShouldPressShieldBlock()) then
    if Cast(S.Revenge, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('DVaNPjAfglNtrkCErKGBoyETUfFLiLUErLBTGYXDBuqddmepVszdwEqcmV2ZW5nZSBnZW5lcmljIDIy'); end
  end
  -- devastate
  if S.Devastate:IsCastable() then
    if Cast(S.Devastate, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('oSMLDTIoqUyvYUjAjIuOBREHukFQzvpJsZoFKejeYMhafvhdgVvKzViZGV2YXN0YXRlIGdlbmVyaWMgMjQ='); end
  end
end

--- ======= ACTION LISTS =======
local function APL()
  if AoEON() then
    Enemies8y = Player:GetEnemiesInMeleeRange(8) -- Multiple Abilities
    EnemiesCount8 = #Enemies8y
  else
    EnemiesCount8 = 1
  end

  -- Range check
  TargetInMeleeRange = Target:IsInMeleeRange(5)

  if Everyone.TargetIsValid() then
    -- call precombat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- Check defensives if tanking
    if IsCurrentlyTanking() then
      local ShouldReturn = Defensive(); if ShouldReturn then return ShouldReturn; end
    end
    -- Interrupt
    local ShouldReturn = Everyone.Interrupt(S.Pummel, 5, true); if ShouldReturn then return ShouldReturn; end
    local ShouldReturn = Everyone.InterruptWithStun(S.IntimidatingShout, 5); if ShouldReturn then return ShouldReturn; end
    -- auto_attack
    -- charge,if=time=0
    -- Note: Handled in Precombat
    -- heroic_charge,if=buff.revenge.down&(rage<60|rage<44&buff.last_stand.up)
    --if (not Settings.Protection.Enabled.DisableHeroicCharge) and S.HeroicLeap:IsCastable() and S.Charge:IsCastable() and (Player:BuffDown(S.RevengeBuff) and (Player:Rage() < 60 or Player:Rage() < 44 and Player:BuffUp(S.LastStandBuff))) then
    --  if Cast(S.HeroicLeap, S.Charge) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('XLhbhlDsReaUVjyvhWVcthzPGFsNEGIHoPnRaLAGenyvmhMTEwZjIyfaGVyb2ljX2xlYXAvY2hhcmdlIG1haW4gMg=='); end
    --end
    -- intervene,if=buff.revenge.down&(rage<80|rage<77&buff.last_stand.up)&runeforge.reprisal
    --if (not Settings.Protection.Enabled.DisableIntervene) and S.Intervene:IsCastable() and (Player:BuffDown(S.RevengeBuff) and (Player:Rage() < 80 or Player:Rage() < 77 and Player:BuffUp(S.LastStandBuff)) and ReprisalEquipped) then
    --  if Cast(S.Intervene) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('cvUNLNySvXHvDWQTItMrWEZulPCKsvhLZijwhOGpgFrxGpLmhLRWYYWaW50ZXJ2ZW5lIG1haW4gNA=='); end
    --end
    -- use_items,if=cooldown.avatar.remains<=gcd|buff.avatar.up
    if Settings.General.Enabled.Trinkets and (S.Avatar:CooldownRemains() <= Player:GCD() or Player:BuffUp(S.AvatarBuff)) then
      local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
      if TrinketToUse then
        if Utils.ValueIsInArray(TrinketToUse:SlotIDs(), 13) then
          if Cast(M.Trinket1) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('WUhKIDDPqAjvBEtbmxhYBstfTwYUPVCTJCQNtpwdHLasENwAbqrQTJmdXNlX3RyaW5rZXQg') .. TrinketToUse:Name() .. vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('EyiHTYmIldBQgkPBdrFvIjdsAuCICpdCtNzdqgafrFKnMnOfIRUPoJRIGRhbWFnZSAx'); end
        elseif Utils.ValueIsInArray(TrinketToUse:SlotIDs(), 14) then
          if Cast(M.Trinket2) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('pDbcDnBzQhhfgeyUFSDnLPHiRKSaBwyNqHCZtpGpVAfBRREUwDHzBPEdXNlX3RyaW5rZXQg') .. TrinketToUse:Name() .. vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('dZHculkBTabHyiCFkxtbeRsvQWVFptIEoeVBEtQiveDOVdqouVBxDhqIGRhbWFnZSAy'); end
        end
      end
    end
    if (CDsON() and Player:BuffUp(S.AvatarBuff)) then
      -- blood_fury,if=buff.avatar.up
      if S.BloodFury:IsCastable() then
        if Cast(S.BloodFury) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('oYmdPVvPGktHRadhTGcQqlfmWfPgnUnJEfpkJgfZyclGYJJlVWQTQQKYmxvb2RfZnVyeSByYWNpYWw='); end
      end
      -- berserking,if=buff.avatar.up
      if S.Berserking:IsCastable() then
        if Cast(S.Berserking) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('oJkvWvfKOjUhgSdemouZJljANreBbNwmYObnbWhJLvIGptScNzYumgVYmVyc2Vya2luZyByYWNpYWw='); end
      end
      -- fireblood,if=buff.avatar.up
      if S.Fireblood:IsCastable() then
        if Cast(S.Fireblood) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('rgxkEdYPGGqbvdZIYKWWdKzzCyTRDdfgRNiShFyLOpHUcvFVJvmZVllZmlyZWJsb29kIHJhY2lhbA=='); end
      end
      -- ancestral_call,if=buff.avatar.up
      if S.AncestralCall:IsCastable() then
        if Cast(S.AncestralCall) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('jnirDdYTCQtawkbnlQtGIKcjusrVkCQTLrdsILvgBDgQThsawEhLRsHYW5jZXN0cmFsX2NhbGwgcmFjaWFs'); end
      end
    end
    -- thunder_clap,if=buff.outburst.up&((buff.seeing_red.stack>6&cooldown.shield_slam.remains>2))
    if S.ThunderClap:IsCastable() and (Player:BuffUp(S.OutburstBuff) and (Player:BuffStack(S.SeeingRedBuff) > 6 and S.ShieldSlam:CooldownRemains() > 2)) then
      if Cast(S.ThunderClap, not Target:IsInMeleeRange(8)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('CPCEZqfwPRPvusrwkOnHcPLEveMlElrBTQgSboHiwhjmvjhjqnkgKLgdGh1bmRlcl9jbGFwIG1haW4gNg=='); end
    end
    -- avatar,if=buff.outburst.down
    if S.Avatar:IsCastable() and (Player:BuffDown(S.OutburstBuff)) then
      if Cast(S.Avatar, nil, nil, true) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('QmZcEfRNQXOcvnQgzKKgrZUiLqgQKrOpFnLHAcULJzXnanLElXTjVxSYXZhdGFyIG1haW4gOA=='); end
    end
    -- potion
    if Settings.General.Enabled.Potions and I.PotionofSpectralStrength:IsReady() and (Player:BloodlustUp() or Target:TimeToDie() <= 30) then
      if Cast(M.PotionofSpectralStrength, nil, nil, true) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('QegOGXDgXtjBCMckPYwYspDuhbhPeGhiLxduxWGULIDNRwiVffcPmaBcG90aW9uIG1haW4gNg=='); end
    end
    if CDsON() then
      -- conquerors_banner
      if S.ConquerorsBanner:IsCastable() then
        if Cast(S.ConquerorsBanner) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('qDBAnEvFPPCCUWGfxihBlOXnNnRRoMWgvqBvgkajRMiDCctcuGyXOdWY29ucXVlcm9yc19iYW5uZXIgbWFpbiAxMg=='); end
      end
      -- ancient_aftershock
      if S.AncientAftershock:IsCastable() then
        if Cast(S.AncientAftershock, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('bBcNWYfCAbDchLEkaSRwCBqbIYXtJDIVYrcvmYprtoVkQSPqxpJiWvDYW5jaWVudF9hZnRlcnNob2NrIG1haW4gMTQ='); end
      end
      -- spear_of_bastion
      if S.SpearofBastion:IsCastable() then
        if Cast(M.SpearofBastionPlayer, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('QVQgjCktlBfTcbLQPVEHxPDCjadlyNMsQAtOdSXhKGfmKZSjiYcJGXqc3BlYXJfb2ZfYmFzdGlvbiBtYWluIDE2'); end
      end
    end
    -- revenge,if=buff.revenge.up&(target.health.pct>20|spell_targets.thunder_clap>3)&cooldown.shield_slam.remains
    if S.Revenge:IsReady() and (Player:BuffUp(S.RevengeBuff) and (Target:HealthPercentage() > 20 or EnemiesCount8 > 3) and S.ShieldSlam:CooldownRemains() > 0) then
      if Cast(S.Revenge, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('dqgUYwjZWPNMhFYOAJVleAGKwrYzefgyeTvDwVKuwVAnCVbBiyptnpFcmV2ZW5nZSBtYWluIDE4'); end
    end
    -- ignore_pain,if=target.health.pct>=20&(target.health.pct>=80&!covenant.venthyr)&(rage>=85&cooldown.shield_slam.ready&buff.shield_block.up|rage>=60&cooldown.demoralizing_shout.ready&talent.booming_voice.enabled|rage>=70&cooldown.avatar.ready|rage>=40&cooldown.demoralizing_shout.ready&talent.booming_voice.enabled&buff.last_stand.up|rage>=55&cooldown.avatar.ready&buff.last_stand.up|rage>=80|rage>=55&cooldown.shield_slam.ready&buff.outburst.up&buff.shield_block.up|rage>=30&cooldown.shield_slam.ready&buff.outburst.up&buff.last_stand.up&buff.shield_block.up),use_off_gcd=1
    if S.IgnorePain:IsReady() and IgnorePainWillNotCap() and (Target:HealthPercentage() >= 20 and (Target:HealthPercentage() >= 80 and CovenantID ~= 2) and (Player:Rage() >= 85 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.ShieldBlockBuff) or Player:Rage() >= 60 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() or Player:Rage() >= 70 and S.Avatar:CooldownUp() or Player:Rage() >= 40 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() and Player:BuffUp(S.LastStandBuff) or Player:Rage() >= 55 and S.Avatar:CooldownUp() and Player:BuffUp(S.LastStandBuff) or Player:Rage() >= 80 or Player:Rage() >= 55 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.OutburstBuff) and Player:BuffUp(S.ShieldBlockBuff) or Player:Rage() >= 30 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.OutburstBuff) and Player:BuffUp(S.LastStandBuff) and Player:BuffUp(S.ShieldBlockBuff))) then
      if Cast(S.IgnorePain) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('TUZpUZsOlxrHaslXztiHZANxzHeCsqNDxTBjLeKrzqgRYJGPSvdYBxgaWdub3JlX3BhaW4gbWFpbiAyMA=='); end
    end
    -- shield_block,if=(buff.shield_block.down|buff.shield_block.remains<cooldown.shield_slam.remains)&target.health.pct>20
    -- Note: Handled via Defensive()
    -- last_stand,if=target.health.pct>=90|target.health.pct<=20
    -- Note: Handled via Defensive()
    -- demoralizing_shout,if=talent.booming_voice.enabled&rage<60
    if S.DemoralizingShout:IsCastable() and (S.BoomingVoice:IsAvailable() and Player:Rage() < 60) then
      SuggestRageDump(40)
      if Cast(S.DemoralizingShout, not Target:IsInRange(10)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('VMpCdTIBRpgDZHjoggrOpUZDvYVIWTBLkyKotTEAPefXsKtLWYJntAJZGVtb3JhbGl6aW5nX3Nob3V0IG1haW4gMjI='); end
    end
    -- shield_slam,if=buff.outburst.up&rage<=55
    if S.ShieldSlam:IsCastable() and (Player:BuffUp(S.OutburstBuff) and Player:Rage() <= 55) then
      if Cast(S.ShieldSlam, not TargetInMeleeRange) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('CdkpPqpXQELnYfweLzzXpQugCMUdWFJLtKckqDEeVsvtJoUqbyvPsOYc2hpZWxkX3NsYW0gbWFpbiAyNA=='); end
    end
    -- run_action_list,name=aoe,if=spell_targets.thunder_clap>3
    if (EnemiesCount8 > 3) then
      local ShouldReturn = Aoe(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=generic
    local ShouldReturn = Generic(); if ShouldReturn then return ShouldReturn; end
    if CDsON() and Settings.General.Enabled.Racials then
      -- bag_of_tricks
      if S.BagofTricks:IsCastable() then
        if Cast(S.BagofTricks, not Target:IsInRange(40)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('dhhmHpzRPoIRabzWrSmSkWSsgFiklqeWXolzWIWpWXNICxzEOMLmYeMYmFnX29mX3RyaWNrcyByYWNpYWw='); end
      end
      -- arcane_torrent,if=rage<80
      if S.ArcaneTorrent:IsCastable() and (Player:Rage() < 80) then
        if Cast(S.ArcaneTorrent, not Target:IsInRange(8)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('LvmdglnKGFayipTAuIKoHnnUKXEGvkpdmhMhUTlIWoVbPvrvolkwMcBYXJjYW5lX3RvcnJlbnQgcmFjaWFs'); end
      end
      -- lights_judgment
      if S.LightsJudgment:IsCastable() then
        if Cast(S.LightsJudgment, not Target:IsInRange(40)) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('cWUAEhBHTIbvLRUgQfqqdqQWChzyYGKVWMPmnBybEPgPtFUDDXuaCJobGlnaHRzX2p1ZGdtZW50IHJhY2lhbA=='); end
      end
    end
    -- If nothing else to do, show the Pool icon
    if Cast(S.Pool) then return vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('PiwzRRciBGPlqASmrswXFTETbgJPZBlzyhgqNeykliYNxZWzSGPdknxV2FpdC9Qb29sIFJlc291cmNlcw=='); end
  end
end

local function AutoBind()
  -- Racials
  WR.Bind(S.AncestralCall)
  WR.Bind(S.ArcaneTorrent)
  WR.Bind(S.BagofTricks)
  WR.Bind(S.Berserking)
  WR.Bind(S.BloodFury)
  WR.Bind(S.Fireblood)
  WR.Bind(S.LightsJudgment)
  -- Bind Spells
  WR.Bind(S.Avatar)
  WR.Bind(S.BattleShout)
  WR.Bind(S.Charge)
  WR.Bind(S.DemoralizingShout)
  WR.Bind(S.Devastate)
  WR.Bind(S.Execute)
  WR.Bind(S.HeroicLeap)
  WR.Bind(S.IgnorePain)
  WR.Bind(S.IntimidatingShout)
  WR.Bind(S.LastStand)
  WR.Bind(S.Pummel)
  WR.Bind(S.Revenge)
  WR.Bind(S.ShieldBlock)
  WR.Bind(S.ShieldSlam)
  WR.Bind(S.ThunderClap)
  WR.Bind(S.VictoryRush)
  -- Bind Items
  WR.Bind(M.Trinket1)
  WR.Bind(M.Trinket2)
  WR.Bind(M.Healthstone)
  WR.Bind(M.PotionofSpectralStrength)
  WR.Bind(M.PhialofSerenity)
  -- Bind Macros
  WR.Bind(M.RavagerPlayer)
  WR.Bind(M.SpearofBastionPlayer)
end

local function Init()
  WR.Print(vUmgZqyrEhstosoXkpZbtJYDUSylaiTeAzeeAAXHABkCUwvxrlhyCZWSlvrcPDKhWtmuYStWl('RHBQwDFlGlGsXArVtEGtOufkglWTlaYIBgWNnGYjvmXkczjgUzTDfhnUHJvdGVjdGlvbiBXYXJyaW9yIGJ5IFdvcmxkeQ=='))
  AutoBind()
end

WR.SetAPL(73, APL, Init)
    