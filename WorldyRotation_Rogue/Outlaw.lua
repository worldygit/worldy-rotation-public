local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function jvZuFHMBBsuotrRvjlCbxRDfYoUS(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


-- Bind Focus Macros Need to add Mouseover
--WR.Bind(M.FocusTarget)
--WR.Bind(M.FocusPlayer)
--for i = 1, 4 do
--  local FocusUnitKey = stringformat(jvZuFHMBBsuotrRvjlCbxRDfYoUS('pvcnNAqPCUCVhCCiMdYoFFfhJjbgSEvRyAAFyplylhwbBJNOGtsXRBkRm9jdXNQYXJ0eSVk'), i)
--  WR.Bind(M[FocusUnitKey])
--end
---------- Set MO as focus if we should CC, Interrupt or stun
--Mouseover:IsAPlayer()
-- Check MO for CC, Stuns and Interrupts
--  if Mouseover and Mouseover:NPCID() == ExplosiveNPCID and S.ShadowWordPain:IsReady() then
--    if Cast(M.ShadowWordPainMouseover, not Mouseover:IsSpellInRange(S.ShadowWordPain)) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('rpUxKSCGeUIQvNyLqwBPwtzSblhcwXmLbXHTIobbmPjoqVtHMzxFOtFc2hhZG93X3dvcmRfcGFpbiBkYW1hZ2UgMg=='); end
--  end


--local ExplosiveNPCID = 120651
--if Target:NPCID() == ExplosiveNPCID and S.ShadowWordPain:IsReady() then
--    if Cast(S.ShadowWordPain, not Target:IsSpellInRange(S.ShadowWordPain)) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('CLtrPQkVAKwMzaHZUSceOsaIRrhFOQpztOqnSVFcuTorgrmFXehrUeic2hhZG93X3dvcmRfcGFpbiBkYW1hZ2UgMQ=='); end
--  end
--  if Mouseover and Mouseover:NPCID() == ExplosiveNPCID and S.ShadowWordPain:IsReady() then
--    if Cast(M.ShadowWordPainMouseover, not Mouseover:IsSpellInRange(S.ShadowWordPain)) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('YoXpPqRQxJqOZKlHSEborFUnvFRfcOimszcmdIVoOqdLjNuLGHLNpHfc2hhZG93X3dvcmRfcGFpbiBkYW1hZ2UgMg=='); end
--  end

-- use_trinket
--if (Settings.General.Enabled.Trinkets) then
--  local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
--  if TrinketToUse then
--    if Utils.ValueIsInArray(TrinketToUse:SlotIDs(), 13) then
--      if Cast(M.Trinket1) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('rSvBuRQBkIpbYoKUtNrGczcwqGCLxaqtrgCiFhEhaMANhBYUNQGWzGudXNlX3RyaW5rZXQg') .. TrinketToUse:Name() .. jvZuFHMBBsuotrRvjlCbxRDfYoUS('QINylWPFtHPQezQnWjPKCIhJHexiaiVCXjSNXWWpYsriKErdhpAvtoBIGRhbWFnZSAx'); end
--    elseif Utils.ValueIsInArray(TrinketToUse:SlotIDs(), 14) then
--      if Cast(M.Trinket2) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('rERhOrHFXfqCzNRDAlfpMOlfdMrDKeROFTEoGEleNqDOZluXRjHupPjdXNlX3RyaW5rZXQg') .. TrinketToUse:Name() .. jvZuFHMBBsuotrRvjlCbxRDfYoUS('lkTmiuENEQxRujJjbwCboyhvKYdvkKCPQgMWIqYYndSxhaYWhFpZHLjIGRhbWFnZSAy'); end
--    end
--  end
--end

--local TTD = ThisUnit:TimeToDie()




--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Focus      = Unit.Focus
local Mouseover  = Unit.MouseOver
local Pet        = Unit.Pet
local Spell      = HL.Spell
local Item       = HL.Item
local Utils      = HL.Utils
-- WorldyRotation
local WR         = WorldyRotation
local Macro      = WR.Macro
local AoEON      = WR.AoEON
local CDsON      = WR.CDsON
local Cast       = WR.Cast
-- Lua
local stringformat = string.format
local mathmin = math.min
local mathabs = math.abs


--- ============================ CONTENT ============================
--- ======= APL LOCALS =======
-- Commons
local Everyone = WR.Commons.Everyone
local Rogue = WR.Commons.Rogue

-- GUI Settings
local Settings = {
  General = WR.GUISettings.General,
  Commons = WR.GUISettings.APL.Rogue.Commons,
  Commons2 = WR.GUISettings.APL.Rogue.Commons2,
  Outlaw = WR.GUISettings.APL.Rogue.Outlaw,
}

-- Define S/I for spell and item arrays
local S = Spell.Rogue.Outlaw
local I = Item.Rogue.Outlaw
--local M = Macro.Rogue.Outlaw


-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
  I.ComputationDevice:ID(),
  I.VigorTrinket:ID(),
  I.FontOfPower:ID(),
  I.RazorCoral:ID()
}

S.Dispatch:RegisterDamageFormula(
  -- Dispatch DMG Formula (Pre-Mitigation):
  --- Player Modifier
    -- AP * CP * EviscR1_APCoef * Aura_M * NS_M * DS_M * DSh_M * SoD_M * Finality_M * Mastery_M * Versa_M
  --- Target Modifier
    -- Ghostly_M * Sinful_M
  function ()
    return
      --- Player Modifier
        -- Attack Power
        Player:AttackPowerDamageMod() *
        -- Combo Points
        Rogue.CPSpend() *
        -- Eviscerate R1 AP Coef
        0.35 *
        -- Aura Multiplier (SpellID: 137036)
        1.13 *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct() / 100) *
      --- Target Modifier
        -- Ghostly Strike Multiplier
        (Target:DebuffUp(S.GhostlyStrike) and 1.1 or 1) *
        -- Sinful Revelation Enchant
        (Target:DebuffUp(S.SinfulRevelationDebuff) and 1.06 or 1)
  end
)

-- Rotation Var
local Enemies30y, EnemiesBF, EnemiesBFCount
local ShouldReturn; -- Used to get the return string
local BladeFlurryRange = 6
local BetweenTheEyesDMGThreshold
local EffectiveComboPoints, ComboPoints, ComboPointsDeficit
local Energy, EnergyRegen, EnergyDeficit, EnergyTimeToMax, EnergyMaxOffset


-- Legendaries
local CovenantId = Player:CovenantID()
local IsKyrian, IsVenthyr, IsNightFae, IsNecrolord = (CovenantId == 1), (CovenantId == 2), (CovenantId == 3), (CovenantId == 4)
local DeathlyShadowsEquipped = Player:HasLegendaryEquipped(129)
local MarkoftheMasterAssassinEquipped = Player:HasLegendaryEquipped(117)
local TinyToxicBladeEquipped = Player:HasLegendaryEquipped(116)
local ConcealedBlunderbussEquipped = Player:HasLegendaryEquipped(122)
local InvigoratingShadowdustEquipped = Player:HasLegendaryEquipped(114)
local GreenskinsWickersEquipped = Player:HasLegendaryEquipped(125)
HL:RegisterForEvent(function()
  CovenantId = Player:CovenantID()
  IsKyrian, IsVenthyr, IsNightFae, IsNecrolord = (CovenantId == 1), (CovenantId == 2), (CovenantId == 3), (CovenantId == 4)
  DeathlyShadowsEquipped = Player:HasLegendaryEquipped(129)
  MarkoftheMasterAssassinEquipped = Player:HasLegendaryEquipped(117)
  TinyToxicBladeEquipped = Player:HasLegendaryEquipped(116)
  ConcealedBlunderbussEquipped = Player:HasLegendaryEquipped(122)
  InvigoratingShadowdustEquipped = Player:HasLegendaryEquipped(114)
  GreenskinsWickersEquipped = Player:HasLegendaryEquipped(125)
end, jvZuFHMBBsuotrRvjlCbxRDfYoUS('GDawRoSiBnqRZLkRPllUYNwyyuxgXLIjtMGhjuvVrLGowWqhufTeTNuUExBWUVSX0VRVUlQTUVOVF9DSEFOR0VE'), jvZuFHMBBsuotrRvjlCbxRDfYoUS('CgbqWTdZOCOEWxBDlJJPCnMkdMouwLICkYgispuvDMEYwJAePIwcGEHQ09WRU5BTlRfQ0hPU0VO') )

-- Utils
local function num(val)
  if val then return 1 else return 0 end
end

-- Stable Energy Prediction
local PrevEnergyTimeToMaxPredicted, PrevEnergyPredicted = 0, 0
local function EnergyTimeToMaxStable (MaxOffset)
  local EnergyTimeToMaxPredicted = Player:EnergyTimeToMaxPredicted(nil, MaxOffset)
  if mathabs(PrevEnergyTimeToMaxPredicted - EnergyTimeToMaxPredicted) > 1 then
    PrevEnergyTimeToMaxPredicted = EnergyTimeToMaxPredicted
  end
  return PrevEnergyTimeToMaxPredicted
end
local function EnergyPredictedStable (MaxOffset)
  local EnergyPredicted = Player:EnergyPredicted(nil, MaxOffset)
  if mathabs(PrevEnergyPredicted - EnergyPredicted) > 9 then
    PrevEnergyPredicted = EnergyPredicted
  end
  return PrevEnergyPredicted
end

--- ======= ACTION LISTS =======
local RtB_BuffsList = {
  S.Broadside,
  S.BuriedTreasure,
  S.GrandMelee,
  S.RuthlessPrecision,
  S.SkullandCrossbones,
  S.TrueBearing
}
local function RtB_List (Type, List)
  if not Cache.APLVar.RtB_List then Cache.APLVar.RtB_List = {} end
  if not Cache.APLVar.RtB_List[Type] then Cache.APLVar.RtB_List[Type] = {} end
  local Sequence = table.concat(List)
  -- All
  if Type == jvZuFHMBBsuotrRvjlCbxRDfYoUS('PaUfPcDgVjOiXkwikVMIdhEVTNrXsFyElxhMbdEscRtxjHzHGBVChgiQWxs') then
    if not Cache.APLVar.RtB_List[Type][Sequence] then
      local Count = 0
      for i = 1, #List do
        if Player:BuffUp(RtB_BuffsList[List[i]]) then
          Count = Count + 1
        end
      end
      Cache.APLVar.RtB_List[Type][Sequence] = Count == #List and true or false
    end
  -- Any
  else
    if not Cache.APLVar.RtB_List[Type][Sequence] then
      Cache.APLVar.RtB_List[Type][Sequence] = false
      for i = 1, #List do
        if Player:BuffUp(RtB_BuffsList[List[i]]) then
          Cache.APLVar.RtB_List[Type][Sequence] = true
          break
        end
      end
    end
  end
  return Cache.APLVar.RtB_List[Type][Sequence]
end
-- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs ()
  if not Cache.APLVar.RtB_Buffs then
    Cache.APLVar.RtB_Buffs = 0
    for i = 1, #RtB_BuffsList do
      if Player:BuffUp(RtB_BuffsList[i]) then
        Cache.APLVar.RtB_Buffs = Cache.APLVar.RtB_Buffs + 1
      end
    end
  end
  return Cache.APLVar.RtB_Buffs
end

local function RtB_Reroll ()
  if not Cache.APLVar.RtB_Reroll then
    -- 1+ Buff
    if Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('VuZMVGNitXXEMwmgtHZANAZQDYlyuEKCOkZxsdYyIUOLpWAjueQwTWSMSsgQnVmZg==') then
      Cache.APLVar.RtB_Reroll = (RtB_Buffs() <= 0) and true or false
    -- Broadside
    elseif Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('ZgLGOACCRZccDihznPAketieCeWyXgsmEuKoziLaqIYVOfFVPIlHqgaQnJvYWRzaWRl') then
      Cache.APLVar.RtB_Reroll = (not Player:BuffUp(S.Broadside)) and true or false
    -- Buried Treasure
    elseif Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('OyLZbSGvMimfNOISonsxJMYaIfTkqMHciAjiJfUpyclfIlBWIzzDKxxQnVyaWVkIFRyZWFzdXJl') then
      Cache.APLVar.RtB_Reroll = (not Player:BuffUp(S.BuriedTreasure)) and true or false
    -- Grand Melee
    elseif Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('MWFjRrwiAUDSBZMMquirBOTKtxDDTvvgvpkCiAhQCXvRdBPXkagkABIR3JhbmQgTWVsZWU=') then
      Cache.APLVar.RtB_Reroll = (not Player:BuffUp(S.GrandMelee)) and true or false
    -- Skull and Crossbones
    elseif Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('dssOlCXsUsDMxAhcxWrBbciNyFIqfDTiOodUCwqFwZyToJQniXBZlUwU2t1bGwgYW5kIENyb3NzYm9uZXM=') then
      Cache.APLVar.RtB_Reroll = (not Player:BuffUp(S.SkullandCrossbones)) and true or false
    -- Ruthless Precision
    elseif Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('YJQTTxwaMBmxsgNHseWCnKPjNgfyYMnIGzAlLNmlMbazTgWtsWDDRfgUnV0aGxlc3MgUHJlY2lzaW9u') then
      Cache.APLVar.RtB_Reroll = (not Player:BuffUp(S.RuthlessPrecision)) and true or false
    -- True Bearing
    elseif Settings.Outlaw.RolltheBonesLogic == jvZuFHMBBsuotrRvjlCbxRDfYoUS('VYniDXYgRgnNyylCFkgFSmKXagYMpKZUjNESxsVwHMAsDMERdpDUCFcVHJ1ZSBCZWFyaW5n') then
      Cache.APLVar.RtB_Reroll = (not Player:BuffUp(S.TrueBearing)) and true or false
    -- SimC Default
    else
      -- # Reroll BT + GM or single buffs early other than Broadside, TB with Shadowdust, or SnC with Blunderbuss
      -- actions+=/variable,name=rtb_reroll,value=rtb_buffs<2&(!buff.broadside.up&(!runeforge.concealed_blunderbuss|!buff.skull_and_crossbones.up)&(!runeforge.invigorating_shadowdust|!buff.true_bearing.up))|rtb_buffs=2&buff.buried_treasure.up&buff.grand_melee.up
      if RtB_Buffs() == 2 and Player:BuffUp(S.BuriedTreasure) and Player:BuffUp(S.GrandMelee) then
        Cache.APLVar.RtB_Reroll = true
      elseif RtB_Buffs() < 2 and (not Player:BuffUp(S.Broadside) and (not ConcealedBlunderbussEquipped or not Player:BuffUp(S.SkullandCrossbones))
        and (not InvigoratingShadowdustEquipped or not Player:BuffUp(S.TrueBearing))) then
        Cache.APLVar.RtB_Reroll = true
      else
        Cache.APLVar.RtB_Reroll = false
      end
    end

    -- Defensive Override : Grand Melee if HP < 60
    --if Everyone.IsSoloMode() then
    --  if Player:BuffUp(S.GrandMelee) then
    --    if Player:IsTanking(Target) or Player:HealthPercentage() < mathmin(Settings.Outlaw.RolltheBonesLeechKeepHP, Settings.Outlaw.RolltheBonesLeechRerollHP) then
    --      Cache.APLVar.RtB_Reroll = false
    --    end
    --  elseif Player:HealthPercentage() < 40 then
    --    Cache.APLVar.RtB_Reroll = true
    --  end
    --end
  end
  return Cache.APLVar.RtB_Reroll
end

-- # Finish at max possible CP without overflowing bonus combo points, unless for BtE which always should be 5+ CP
-- # Always attempt to use BtE at 5+ CP, regardless of CP gen waste
local function Finish_Condition ()
  -- actions+=/variable,name=finish_condition,value=combo_points>=cp_max_spend-buff.broadside.up-(buff.opportunity.up*talent.quick_draw.enabled|buff.concealed_blunderbuss.up)|effective_combo_points>=cp_max_spend
  -- actions+=/variable,name=finish_condition,op=reset,if=cooldown.between_the_eyes.ready&effective_combo_points<5
  if S.BetweentheEyes:CooldownUp() and EffectiveComboPoints < 5 then
    return false
  end

  return ComboPoints >= (Rogue.CPMaxSpend() - num(Player:BuffUp(S.Broadside)) - (num(Player:BuffUp(S.Opportunity)) *
    num(S.QuickDraw:IsAvailable() or Player:BuffUp(S.ConcealedBlunderbuss)))) or EffectiveComboPoints >= Rogue.CPMaxSpend()
end

-- # Ensure we get full Ambush CP gains and arenjvZuFHMBBsuotrRvjlCbxRDfYoUS('aYiCPXaWNJhVboQgapvKzBqeKBzAIfaDHDLuwzatruPXctbbOxsILAddCByZXJvbGxpbmcgQ291bnQgdGhlIE9kZHMgYnVmZnMgYXdheQ0KbG9jYWwgZnVuY3Rpb24gQW1idXNoX0NvbmRpdGlvbiAoKQ0KICAtLSBhY3Rpb25zKz0vdmFyaWFibGUsbmFtZT1hbWJ1c2hfY29uZGl0aW9uLHZhbHVlPWNvbWJvX3BvaW50cy5kZWZpY2l0Pj0yK2J1ZmYuYnJvYWRzaWRlLnVwJmVuZXJneT49NTAmKCFjb25kdWl0LmNvdW50X3RoZV9vZGRzfGJ1ZmYucm9sbF90aGVfYm9uZXMucmVtYWlucz49MTApDQogIHJldHVybiBDb21ib1BvaW50c0RlZmljaXQgPj0gMiArIG51bShQbGF5ZXI6QnVmZlVwKFMuQnJvYWRzaWRlKSkgYW5kIEVmZmVjdGl2ZUNvbWJvUG9pbnRzIDwgUm9ndWUuQ1BNYXhTcGVuZCgpDQogICAgYW5kIEVuZXJneSA+IDUwIGFuZCAobm90IFMuQ291bnRUaGVPZGRzOkNvbmR1aXRFbmFibGVkKCkgb3IgUm9ndWUuUnRCUmVtYWlucygpID4gMTApDQplbmQNCi0tICMgV2l0aCBtdWx0aXBsZSB0YXJnZXRzLCB0aGlzIHZhcmlhYmxlIGlzIGNoZWNrZWQgdG8gZGVjaWRlIHdoZXRoZXIgc29tZSBDRHMgc2hvdWxkIGJlIHN5bmNlZCB3aXRoIEJsYWRlIEZsdXJyeQ0KLS0gYWN0aW9ucys9L3ZhcmlhYmxlLG5hbWU9YmxhZGVfZmx1cnJ5X3N5bmMsdmFsdWU9c3BlbGxfdGFyZ2V0cy5ibGFkZV9mbHVycnk8MiZyYWlkX2V2ZW50LmFkZHMuaW4+MjB8YnVmZi5ibGFkZV9mbHVycnkucmVtYWlucz4xK3RhbGVudC5raWxsaW5nX3NwcmVlLmVuYWJsZWQNCmxvY2FsIGZ1bmN0aW9uIEJsYWRlX0ZsdXJyeV9TeW5jICgpDQogIHJldHVybiBub3QgQW9FT04oKSBvciBFbmVtaWVzQkZDb3VudCA8IDIgb3IgKFBsYXllcjpCdWZmUmVtYWlucyhTLkJsYWRlRmx1cnJ5KSA+IDEgKyBudW0oUy5LaWxsaW5nU3ByZWU6SXNBdmFpbGFibGUoKSkpDQplbmQNCg0KLS0gRGV0ZXJtaW5lIGlmIHdlIGFyZSBhbGxvd2VkIHRvIHVzZSBWYW5pc2ggb2ZmZW5zaXZlbHkgaW4gdGhlIGN1cnJlbnQgc2l0dWF0aW9uDQpsb2NhbCBmdW5jdGlvbiBWYW5pc2hfRFBTX0NvbmRpdGlvbiAoKQ0KICByZXR1cm4gU2V0dGluZ3MuT3V0bGF3LkVuYWJsZWQuVXNlRFBTVmFuaXNoIGFuZCBDRHNPTigpIGFuZCBub3QgKEV2ZXJ5b25lLklzU29sb01vZGUoKSBhbmQgUGxheWVyOklzVGFua2luZyhUYXJnZXQpKQ0KZW5kDQoNCi0tIE1hcmtlZCBmb3IgRGVhdGggVGFyZ2V0X2lmIEZ1bmN0aW9ucw0KLS0gYWN0aW9ucy5jZHMrPS9tYXJrZWRfZm9yX2RlYXRoLHRhcmdldF9pZj1taW46dGFyZ2V0LnRpbWVfdG9fZGllLGlmPXJhaWRfZXZlbnQuYWRkcy51cCYodGFyZ2V0LnRpbWVfdG9fZGllPGNvbWJvX3BvaW50cy5kZWZpY2l0fCFzdGVhbHRoZWQucm9ndWUmY29tYm9fcG9pbnRzLmRlZmljaXQ+PWNwX21heF9zcGVuZC0xKQ0KbG9jYWwgZnVuY3Rpb24gRXZhbHVhdGVNZkRUYXJnZXRJZkNvbmRpdGlvbihUYXJnZXRVbml0KQ0KICByZXR1cm4gVGFyZ2V0VW5pdDpUaW1lVG9EaWUoKQ0KZW5kDQpsb2NhbCBmdW5jdGlvbiBFdmFsdWF0ZU1mRENvbmRpdGlvbihUYXJnZXRVbml0KQ0KICAtLSBOb3RlOiBJbmNyZWFzZWQgdGhlIFNpbUMgY29uZGl0aW9uIGJ5IDUwJSBzaW5jZSB3ZSBhcmUgc2xvd2VyLg0KICByZXR1cm4gVGFyZ2V0VW5pdDpGaWx0ZXJlZFRpbWVUb0RpZSg=')<jvZuFHMBBsuotrRvjlCbxRDfYoUS('UMmGnEgQjqupyAsKXYpIWpwVmgHmInzQHkLdmQLNlYmSstPPUXDyhZFLCBDb21ib1BvaW50c0RlZmljaXQqMS41KSBvciAobm90IFBsYXllcjpTdGVhbHRoVXAodHJ1ZSwgZmFsc2UpIGFuZCBDb21ib1BvaW50c0RlZmljaXQgPj0gUm9ndWUuQ1BNYXhTcGVuZCgpIC0gMSkNCmVuZA0KDQotLSBGbGFnZWxsYXRpb24gVGFyZ2V0X2lmIEZ1bmN0aW9ucw0KLS0gYWN0aW9ucy5jZHMrPS9mbGFnZWxsYXRpb24sdGFyZ2V0X2lmPW1heDp0YXJnZXQudGltZV90b19kaWUsaWY9IXN0ZWFsdGhlZC5hbGwmKHZhcmlhYmxlLmZpbmlzaF9jb25kaXRpb24mdGFyZ2V0LnRpbWVfdG9fZGllPjEwfGZpZ2h0X3JlbWFpbnM8MTMpDQpsb2NhbCBmdW5jdGlvbiBFdmFsdWF0ZUZsYWdlbGxhdGlvblRhcmdldElmQ29uZGl0aW9uKFRhcmdldFVuaXQpDQogIHJldHVybiBUYXJnZXRVbml0OlRpbWVUb0RpZSgpDQplbmQNCmxvY2FsIGZ1bmN0aW9uIEV2YWx1YXRlRmxhZ2VsbGF0aW9uQ29uZGl0aW9uKFRhcmdldFVuaXQpDQogIHJldHVybiBGaW5pc2hfQ29uZGl0aW9uKCkgYW5kIFRhcmdldDpGaWx0ZXJlZFRpbWVUb0RpZSg=')>jvZuFHMBBsuotrRvjlCbxRDfYoUS('narvBrGagcdSoxcmeVyQcOkcngjDroqaupOkxlSqsOJmSmYoqChcMbMLCAxMCkgb3IgSEwuQm9zc0ZpbHRlcmVkRmlnaHRSZW1haW5zKA==')<jvZuFHMBBsuotrRvjlCbxRDfYoUS('dUzpduwektsjKUpkyqSRrVDDcVSHJZCUZJeWKpEHbKKirlxefKVsowELCAxMykNCmVuZA0KbG9jYWwgZnVuY3Rpb24gQ0RzKCkNCiAgLS0gYWN0aW9ucy5jZHMrPS9ibGFkZV9mbHVycnksaWY9c3BlbGxfdGFyZ2V0cz49MiYhYnVmZi5ibGFkZV9mbHVycnkudXANCiAgaWYgUy5CbGFkZUZsdXJyeTpJc1JlYWR5KCkgYW5kIEFvRU9OKCkgYW5kIEVuZW1pZXNCRkNvdW50ID49IDIgYW5kIG5vdCBQbGF5ZXI6QnVmZlVwKFMuQmxhZGVGbHVycnkpIHRoZW4NCiAgICBpZiBXUi5DYXN0KFMuQmxhZGVGbHVycnkpIHRoZW4gcmV0dXJuIA==')Cast Blade FlurryjvZuFHMBBsuotrRvjlCbxRDfYoUS('xGKohDUANhDtkfOOTCSPZnBGynudnbvCfJBEAqjScqhRaWGIbHKJtDVIGVuZA0KICBlbmQNCiAgaWYgVGFyZ2V0OklzU3BlbGxJblJhbmdlKFMuU2luaXN0ZXJTdHJpa2UpIHRoZW4NCiAgICAtLSAjIFVzaW5nIEFtYnVzaCBpcyBhIDIlIGluY3JlYXNlLCBzbyBWYW5pc2ggY2FuIGJlIHNvbWV0aW1lcyBiZSB1c2VkIGFzIGEgdXRpbGl0eSBzcGVsbCB1bmxlc3MgdXNpbmcgTWFzdGVyIEFzc2Fzc2luIG9yIERlYXRobHkgU2hhZG93cw0KICAgIGlmIFMuVmFuaXNoOklzQ2FzdGFibGUoKSBhbmQgVmFuaXNoX0RQU19Db25kaXRpb24oKSBhbmQgbm90IFBsYXllcjpTdGVhbHRoVXAodHJ1ZSwgdHJ1ZSkgdGhlbg0KICAgICAgaWYgbm90IE1hcmtvZnRoZU1hc3RlckFzc2Fzc2luRXF1aXBwZWQgYW5kIG5vdCBJbnZpZ29yYXRpbmdTaGFkb3dkdXN0RXF1aXBwZWQgdGhlbg0KICAgICAgICAtLSBhY3Rpb25zLmNkcys9L3ZhbmlzaCxpZj0hcnVuZWZvcmdlLm1hcmtfb2ZfdGhlX21hc3Rlcl9hc3Nhc3NpbiYhcnVuZWZvcmdlLmludmlnb3JhdGluZ19zaGFkb3dkdXN0JiFzdGVhbHRoZWQuYWxsJih2YXJpYWJsZS5hbWJ1c2hfY29uZGl0aW9uJighYnVmZi5mbGFnZWxsYXRpb25fYnVmZi51cHxydW5lZm9yZ2UuZGVhdGhseV9zaGFkb3dzKXx2YXJpYWJsZS5maW5pc2hfY29uZGl0aW9uKSYoIXJ1bmVmb3JnZS5kZWF0aGx5X3NoYWRvd3N8YnVmZi5kZWF0aGx5X3NoYWRvd3MuZG93biZjb21ib19wb2ludHM8PTIpDQogICAgICAgIGlmIChBbWJ1c2hfQ29uZGl0aW9uKCkgYW5kIChEZWF0aGx5U2hhZG93c0VxdWlwcGVkIG9yIG5vdCBTLkZsYWdlbGxhdGlvbjpBbnlEZWJ1ZmZVcCgpKSBvciBGaW5pc2hfQ29uZGl0aW9uKCkpDQogICAgICAgICAgYW5kIChub3QgRGVhdGhseVNoYWRvd3NFcXVpcHBlZCBvciBub3QgUGxheWVyOkJ1ZmZVcChTLkRlYXRobHlTaGFkb3dzQnVmZikgYW5kIENvbWJvUG9pbnRzIDw9IDIpIHRoZW4NCiAgICAgICAgICBpZiBXUi5DYXN0KFMuVmFuaXNoLCBuaWwsIG5pbCwgdHJ1ZSkgdGhlbiByZXR1cm4g')Cast VanishjvZuFHMBBsuotrRvjlCbxRDfYoUS('MTmOBpwXIikPMUcPxXpPsrtXsJhGbdvYGVbddsAzaVQjMJkiuuKSJVFIGVuZA0KICAgICAgICBlbmQNCiAgICAgIGVsc2UNCiAgICAgICAgLS0gYWN0aW9ucy5jZHMrPS92YXJpYWJsZSxuYW1lPXZhbmlzaF9tYV9jb25kaXRpb24saWY9cnVuZWZvcmdlLm1hcmtfb2ZfdGhlX21hc3Rlcl9hc3Nhc3NpbiYhdGFsZW50Lm1hcmtlZF9mb3JfZGVhdGguZW5hYmxlZCx2YWx1ZT0oIWNvb2xkb3duLmJldHdlZW5fdGhlX2V5ZXMucmVhZHkmdmFyaWFibGUuZmluaXNoX2NvbmRpdGlvbil8KGNvb2xkb3duLmJldHdlZW5fdGhlX2V5ZXMucmVhZHkmdmFyaWFibGUuYW1idXNoX2NvbmRpdGlvbikNCiAgICAgICAgLS0gYWN0aW9ucy5jZHMrPS92YXJpYWJsZSxuYW1lPXZhbmlzaF9tYV9jb25kaXRpb24saWY9cnVuZWZvcmdlLm1hcmtfb2ZfdGhlX21hc3Rlcl9hc3Nhc3NpbiZ0YWxlbnQubWFya2VkX2Zvcl9kZWF0aC5lbmFibGVkLHZhbHVlPXZhcmlhYmxlLmZpbmlzaF9jb25kaXRpb24NCiAgICAgICAgLS0gYWN0aW9ucy5jZHMrPS92YW5pc2gsaWY9dmFyaWFibGUudmFuaXNoX21hX2NvbmRpdGlvbiZtYXN0ZXJfYXNzYXNzaW5fcmVtYWlucz0wJnZhcmlhYmxlLmJsYWRlX2ZsdXJyeV9zeW5jDQogICAgICAgIGlmIFJvZ3VlLk1hc3RlckFzc2Fzc2luc01hcmtSZW1haW5zKCkgPD0gMCBhbmQgQmxhZGVfRmx1cnJ5X1N5bmMoKSB0aGVuDQogICAgICAgICAgaWYgUy5NYXJrZWRmb3JEZWF0aDpJc0F2YWlsYWJsZSgpIHRoZW4NCiAgICAgICAgICAgIGlmIEZpbmlzaF9Db25kaXRpb24oKSB0aGVuDQogICAgICAgICAgICAgIGlmIFdSLkNhc3QoUy5WYW5pc2gsIG5pbCwgbmlsLCB0cnVlKSB0aGVuIHJldHVybiA=')Cast Vanish (MA+MfD)jvZuFHMBBsuotrRvjlCbxRDfYoUS('vfQTzzfGtaTSaWRYFkJzkyRLSwTNKaOveQrfcRlUNPIfLiwzEtOoycXIGVuZA0KICAgICAgICAgICAgZW5kDQogICAgICAgICAgZWxzZQ0KICAgICAgICAgICAgaWYgKG5vdCBTLkJldHdlZW50aGVFeWVzOkNvb2xkb3duVXAoKSBhbmQgRmluaXNoX0NvbmRpdGlvbigpIG9yIFMuQmV0d2VlbnRoZUV5ZXM6Q29vbGRvd25VcCgpIGFuZCBBbWJ1c2hfQ29uZGl0aW9uKCkpIHRoZW4NCiAgICAgICAgICAgICAgaWYgV1IuQ2FzdChTLlZhbmlzaCwgbmlsLCBuaWwsIHRydWUpIHRoZW4gcmV0dXJuIA==')Cast Vanish (MA)jvZuFHMBBsuotrRvjlCbxRDfYoUS('dFjzjshnUUBSBKuedDRUuUGMtXodpeoplJcKNKuSOHBsiidVzyykOXCIGVuZA0KICAgICAgICAgICAgZW5kDQogICAgICAgICAgZW5kDQogICAgICAgIGVuZA0KICAgICAgZW5kDQogICAgZW5kDQogICAgLS0gYWN0aW9ucy5jZHMrPS9hZHJlbmFsaW5lX3J1c2gsaWY9IWJ1ZmYuYWRyZW5hbGluZV9ydXNoLnVwDQogICAgaWYgQ0RzT04oKSBhbmQgUy5BZHJlbmFsaW5lUnVzaDpJc0Nhc3RhYmxlKCkgYW5kIG5vdCBQbGF5ZXI6QnVmZlVwKFMuQWRyZW5hbGluZVJ1c2gpIGFuZCAoVGFyZ2V0OkZpbHRlcmVkVGltZVRvRGllKA==')>jvZuFHMBBsuotrRvjlCbxRDfYoUS('YbRzVhzUWGcOvlFablDDeRTPOLRgrlLQpppLszhggVpbLTttemYBcjiLCAxMCkgb3IgVGFyZ2V0OlRpbWVUb0RpZUlzTm90VmFsaWQoKSkgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLkFkcmVuYWxpbmVSdXNoLCBuaWwsIG5pbCwgdHJ1ZSkgdGhlbiByZXR1cm4g')Cast Adrenaline RushjvZuFHMBBsuotrRvjlCbxRDfYoUS('UHFsKTfLXvbkusVnetyoizmQXpzZHmrDlWMUFKXHJEWwkonaLgqbGLgIGVuZA0KICAgIGVuZA0KICAgIC0tIGFjdGlvbnMuY2RzKz0vZmxlc2hjcmFmdCxpZj0oc291bGJpbmQucHVzdHVsZV9lcnVwdGlvbnxzb3VsYmluZC52b2xhdGlsZV9zb2x2ZW50KSYhc3RlYWx0aGVkLmFsbCYoIWJ1ZmYuYmxhZGVfZmx1cnJ5LnVwfHNwZWxsX3RhcmdldHMuYmxhZGVfZmx1cnJ5PDIpJighYnVmZi5hZHJlbmFsaW5lX3J1c2gudXB8ZW5lcmd5LnRpbWVfdG9fbWF4PjIpDQogICAgaWYgUy5GbGVzaGNyYWZ0OklzQ2FzdGFibGUoKSBhbmQgKFMuUHVzdHVsZUVydXB0aW9uOlNvdWxiaW5kRW5hYmxlZCgpIG9yIFMuVm9sYXRpbGVTb2x2ZW50OlNvdWxiaW5kRW5hYmxlZCgpKQ0KICAgICAgYW5kIChub3QgUGxheWVyOkJ1ZmZVcChTLkJsYWRlRmx1cnJ5KSBvciBFbmVtaWVzQkZDb3VudCA8IDIpIGFuZCAobm90IFBsYXllcjpCdWZmVXAoUy5BZHJlbmFsaW5lUnVzaCkgb3IgRW5lcmd5VGltZVRvTWF4ID4gMikgdGhlbg0KICAgICAgV1IuQ2FzdFN1Z2dlc3RlZChTLkZsZXNoY3JhZnQpDQogICAgZW5kDQogICAgLS0gYWN0aW9ucy5jZHMrPS9mbGFnZWxsYXRpb24sdGFyZ2V0X2lmPW1heDp0YXJnZXQudGltZV90b19kaWUsaWY9IXN0ZWFsdGhlZC5hbGwmKHZhcmlhYmxlLmZpbmlzaF9jb25kaXRpb24mdGFyZ2V0LnRpbWVfdG9fZGllPjEwfGZpZ2h0X3JlbWFpbnM8MTMpDQogICAgaWYgQ0RzT04oKSBhbmQgUy5GbGFnZWxsYXRpb246SXNSZWFkeSgpIGFuZCBub3QgUGxheWVyOlN0ZWFsdGhVcCh0cnVlLCB0cnVlKSBhbmQgRmluaXNoX0NvbmRpdGlvbigpIHRoZW4NCiAgICAgIGlmIFRhcmdldDpJc0luTWVsZWVSYW5nZSg1KSBhbmQgKFRhcmdldDpGaWx0ZXJlZFRpbWVUb0RpZSg=')>jvZuFHMBBsuotrRvjlCbxRDfYoUS('ZFBgEwJINmULSpzRLZjvZDwMCEgMSmPEyBDfPhnCEyjshzwPKugIUwqLCAxMCkgb3IgVGFyZ2V0OlRpbWVUb0RpZUlzTm90VmFsaWQoKSkgdGhlbiANCiAgICAgICAgaWYgV1IuQ2FzdChTLkZsYWdlbGxhdGlvbikgdGhlbiByZXR1cm4g')truejvZuFHMBBsuotrRvjlCbxRDfYoUS('qDiNQxBIUuyjhsdpTPpYMOMsVQUHxWVUyXlpSwZkQYhnbWdOLcsgOvDIGVuZA0KICAgICAgZW5kDQogICAgZW5kDQogICAgLS0gYWN0aW9ucy5jZHMrPS9kcmVhZGJsYWRlcyxpZj0hc3RlYWx0aGVkLmFsbCZjb21ib19wb2ludHM8PTImKCFjb3ZlbmFudC52ZW50aHlyfGJ1ZmYuZmxhZ2VsbGF0aW9uX2J1ZmYudXApJighdGFsZW50Lm1hcmtlZF9mb3JfZGVhdGh8IWNvb2xkb3duLm1hcmtlZF9mb3JfZGVhdGgucmVhZHkpDQogICAgaWYgUy5EcmVhZGJsYWRlczpJc1JlYWR5KCkgYW5kIFRhcmdldDpJc1NwZWxsSW5SYW5nZShTLkRyZWFkYmxhZGVzKSBhbmQgbm90IFBsYXllcjpTdGVhbHRoVXAodHJ1ZSwgdHJ1ZSkgYW5kIENvbWJvUG9pbnRzIDw9IDIgDQogICAgICBhbmQgKG5vdCBJc1ZlbnRoeXIgb3IgUy5GbGFnZWxsYXRpb246QW55RGVidWZmVXAoKSkgYW5kIChub3QgUy5NYXJrZWRmb3JEZWF0aDpJc0F2YWlsYWJsZSgpIG9yIG5vdCBTLk1hcmtlZGZvckRlYXRoOkNvb2xkb3duVXAoKSkgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLkRyZWFkYmxhZGVzLCBuaWwsIG5pbCwgdHJ1ZSkgdGhlbiByZXR1cm4g')Cast DreadbladesjvZuFHMBBsuotrRvjlCbxRDfYoUS('ywXAuoFfDMHfCXentiQhSLrhfaGdOntsETgPfIoudxFzfVzlxipxwBlIGVuZA0KICAgIGVuZA0KICAgIC0tIGFjdGlvbnMuY2RzKz0vcm9sbF90aGVfYm9uZXMsaWY9bWFzdGVyX2Fzc2Fzc2luX3JlbWFpbnM9MCZidWZmLmRyZWFkYmxhZGVzLmRvd24mKGJ1ZmYucm9sbF90aGVfYm9uZXMucmVtYWluczw9M3x2YXJpYWJsZS5ydGJfcmVyb2xsKQ0KICAgIGlmIFMuUm9sbHRoZUJvbmVzOklzUmVhZHkoKSBhbmQgUm9ndWUuTWFzdGVyQXNzYXNzaW5zTWFya1JlbWFpbnMoKSA8PSAwIGFuZCBub3QgUGxheWVyOkJ1ZmZVcChTLkRyZWFkYmxhZGVzKSBhbmQgKFJvZ3VlLlJ0QlJlbWFpbnMoKSA8PSAzIG9yIFJ0Ql9SZXJvbGwoKSkgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLlJvbGx0aGVCb25lcykgdGhlbiByZXR1cm4g')Cast Roll the BonesjvZuFHMBBsuotrRvjlCbxRDfYoUS('EIHbPfkQcqHqUGHSwJVPLpSiPhjgEnHLZuELasXPMUhnnqGYxvTfilyIGVuZA0KICAgIGVuZA0KICBlbmQNCiAgaWYgQmxhZGVfRmx1cnJ5X1N5bmMoKSB0aGVuDQogICAgLS0gIyBBdHRlbXB0IHRvIHN5bmMgS2lsbGluZyBTcHJlZSB3aXRoIFZhbmlzaCBmb3IgTWFzdGVyIEFzc2Fzc2luDQogICAgLS0gYWN0aW9ucy5jZHMrPS92YXJpYWJsZSxuYW1lPWtpbGxpbmdfc3ByZWVfdmFuaXNoX3N5bmMsdmFsdWU9IXJ1bmVmb3JnZS5tYXJrX29mX3RoZV9tYXN0ZXJfYXNzYXNzaW58Y29vbGRvd24udmFuaXNoLnJlbWFpbnM+MTB8bWFzdGVyX2Fzc2Fzc2luX3JlbWFpbnM+Mg0KICAgIC0tICMgVXNlIGluIDEtMlQgaWYgQnRFIGlzIHVwIGFuZCB3b24=')t cap Energy, or at 3T+ (2T+ with Deathly Shadows) or when Master Assassin is up.
    -- actions.cds+=/killing_spree,if=variable.blade_flurry_sync&variable.killing_spree_vanish_sync&!stealthed.rogue&(debuff.between_the_eyes.up&buff.dreadblades.down&energy.deficit>(energy.regen*2+15)|spell_targets.blade_flurry>(2-buff.deathly_shadows.up)|master_assassin_remains>0)
    if CDsON() and S.KillingSpree:IsCastable() and Target:IsSpellInRange(S.KillingSpree) and not Player:StealthUp(true, false)
        and (not MarkoftheMasterAssassinEquipped or S.Vanish:CooldownRemains() > 10 or Rogue.MasterAssassinsMarkRemains() > 2 or not Vanish_DPS_Condition())
        and (Target:DebuffUp(S.BetweentheEyes) and not Player:BuffUp(S.Dreadblades) and EnergyDeficit > (EnergyRegen * 2 + 10)
          or EnemiesBFCount > (2 - num(Player:BuffUp(S.DeathlyShadowsBuff))) or Rogue.MasterAssassinsMarkRemains() > 0) then
      if WR.Cast(S.KillingSpree) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('hEQdHXKXwEVnvGuvlnDBtCmbcGyaBWEsebTBzIwfAcnLmhvyrwGIFjrQ2FzdCBLaWxsaW5nIFNwcmVl') end
    end
    -- blade_rush,if=variable.blade_flurry_sync&(energy.time_to_max>2|spell_targets>2)
    -- actions.cds+=/blade_rush,if=variable.blade_flurry_sync&(energy.time_to_max>2&buff.dreadblades.down|energy<=30|spell_targets>2)
    if S.BladeRush:IsCastable() and Target:IsSpellInRange(S.BladeRush) and (EnergyTimeToMax > 2 and not Player:BuffUp(S.Dreadblades)
      or Energy <= 30 or EnemiesBFCount > 2) then
      if WR.Cast(S.BladeRush, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('jlnnBwxVrGYeZSjOjNwkmhptuJHvGVKnIAWTbQvphwNalKpYuSrnTIYQ2FzdCBCbGFkZSBSdXNo') end
    end
  end
  if Target:IsSpellInRange(S.SinisterStrike) then
    -- # If using Invigorating Shadowdust, use normal logic in addition to checking major CDs.
    -- actions.cds+=/vanish,if=runeforge.invigorating_shadowdust&covenant.venthyr&!stealthed.all&variable.ambush_condition&(!cooldown.flagellation.ready&(!talent.dreadblades|!cooldown.dreadblades.ready|!buff.flagellation_buff.up))
    -- actions.cds+=/vanish,if=runeforge.invigorating_shadowdust&!covenant.venthyr&!stealthed.all&(cooldown.echoing_reprimand.remains>6|!cooldown.sepsis.ready|cooldown.serrated_bone_spike.full_recharge_time>20)
    if InvigoratingShadowdustEquipped and S.Vanish:IsCastable() and Vanish_DPS_Condition() and not Player:StealthUp(true, true) then
      if IsVenthyr and Ambush_Condition() and (not S.Flagellation:CooldownUp() and (not S.Dreadblades:IsAvailable()
        or not S.Dreadblades:CooldownUp() or not S.Flagellation:AnyDebuffUp())) then
        if WR.Cast(S.Vanish, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('WRcxLBmgxdSEbJFCzTKUYbcvfKINqPswUbbmhRWSYLdCeDQhqAMWZSHQ2FzdCBWYW5pc2ggKFZlbnRoeXIgU2hhZG93ZHVzdCk=') end
      elseif not IsVenthyr and (IsKyrian and S.EchoingReprimand:CooldownRemains() > 6 or IsNightFae and not S.Sepsis:CooldownUp()
        or IsNecrolord and S.SerratedBoneSpike:FullRechargeTime() > 20) then
        if WR.Cast(S.Vanish, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('ZDDsDQupiJMskringGGIyvlUqfxfAkRBsChRfQoMPTOMtvHCndqyVXgQ2FzdCBWYW5pc2ggKFNoYWRvd2R1c3Qp') end
      end
    end

    if CDsON() then
      -- actions.cds+=/shadowmeld,if=!stealthed.all&(conduit.count_the_odds&variable.finish_condition|!talent.weaponmaster.enabled&variable.ambush_condition)
      if Settings.Outlaw.UseDPSVanish and S.Shadowmeld:IsCastable() and
        (S.CountTheOdds:ConduitEnabled() and Finish_Condition() or not S.Weaponmaster:IsAvailable() and Ambush_Condition()) then
        if WR.Cast(S.Shadowmeld, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('VtuUXfoJAfuvWYJDPGLJjEDqywVmYqPGvRfNcBPhRmOJSYUBAHrVtyVQ2FzdCBTaGFkb3dtZWxk') end
      end

      -- actions.cds=potion,if=buff.bloodlust.react|target.time_to_die<=60|buff.adrenaline_rush.up

      -- Racials
      -- actions.cds+=/blood_fury
      if S.BloodFury:IsCastable() then
        if WR.Cast(S.BloodFury, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('PTegBnFTLsFqWrJlTccYujMJSvspmwrMkbjOkUJUVKJUanuRVAUfwgfQ2FzdCBCbG9vZCBGdXJ5') end
      end
      -- actions.cds+=/berserking
      if S.Berserking:IsCastable() then
        if WR.Cast(S.Berserking, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('FxRooNdpEBPjdcbkhFDVYlCPjNZSXlDeEiHaNHyKzndFiylmphiYrZJQ2FzdCBCZXJzZXJraW5n') end
      end
      -- actions.cds+=/fireblood
      if S.Fireblood:IsCastable() then
        if WR.Cast(S.Fireblood, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('jRfOOgGtBVNmcJvPSpFMUKZxnlEPKEgWhFAdExROuOPjlTBXzAvnltGQ2FzdCBGaXJlYmxvb2Q=') end
      end
      -- actions.cds+=/ancestral_call
      if S.AncestralCall:IsCastable() then
        if WR.Cast(S.AncestralCall, nil,nil,true) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('ypJePzIXGRXeTaMnfqjzTROppBLlPLBmIDEvdULXUXPWAQewQwqfAtsQ2FzdCBBbmNlc3RyYWwgQ2FsbA==') end
      end

      -- Trinkets
      if Settings.Commons.UseTrinkets then
        -- TODO actions.cds+=/use_item,name=windscar_whetstone,if=spell_targets.blade_flurry>desired_targets|raid_event.adds.in>60|fight_remains<7
        -- actions.cds+=/use_item,name=cache_of_acquired_treasures,if=buff.acquired_axe.up|fight_remains<25
        if I.CacheOfAcquiredTreasures:IsEquippedAndReady() and Player:BuffUp(S.AcquiredAxe) then
          if WR.Cast(I.CacheOfAcquiredTreasures, nil, Settings.Commons.TrinketDisplayStyle) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('ocXbfHxjBfTGAwyLZtAiUwKKxTcBCHDhxAHBbDHHolhztkdrKDmEhacQ2FjaGUgQXhl') end
        end
        -- actions.cds+=/use_items,slots=trinket1,if=debuff.between_the_eyes.up|trinket.1.has_stat.any_dps|fight_remains<=20
        -- actions.cds+=/use_items,slots=trinket2,if=debuff.between_the_eyes.up|trinket.2.has_stat.any_dps|fight_remains<=20
        local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
        if TrinketToUse and (Target:DebuffUp(S.BetweentheEyes) or HL.BossFilteredFightRemains(jvZuFHMBBsuotrRvjlCbxRDfYoUS('YECApWWaJhQoyuAcKJtaDeaHRdvcEIXVxtDURiZTJDPfBZLwZHhSKpcPA=='), 20) or TrinketToUse:TrinketHasStatAnyDps()) then
          if WR.Cast(TrinketToUse, nil, Settings.Commons.TrinketDisplayStyle) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('LmoFmJgWRTHTKqCxsbdcChPSGLguuLLpdFKBSVBQtMOqArsJLYTjUzZR2VuZXJpYyB1c2VfaXRlbXMgZm9yIA==') .. TrinketToUse:Name() end
        end
      end
    end
  end
end

local function Stealth()
  -- ER FW Bug
  if Settings.Outlaw.Enabled.VanishEchoingReprimand and CDsON() and S.EchoingReprimand:IsReady() and Target:IsSpellInRange(S.EchoingReprimand) then
    if WR.Cast(S.EchoingReprimand) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('TCPfcfxfZAEpMPJLaujNIWWgQeojqdMOmKFNYcpickbjWYWxVFnayrVQ2FzdCBFY2hvaW5nIFJlcHJpbWFuZA==') end
  end
  -- actions.stealth=dispatch,if=variable.finish_condition
  if S.Dispatch:IsCastable() and Target:IsSpellInRange(S.Dispatch) and Finish_Condition() then
    if WR.Cast(S.Dispatch) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('EKVcmcynIyWwAxmNJucFhXrnyxGDSrZKiEHLKewyyDzkxHJaQqhKxTmQ2FzdCBEaXNwYXRjaA==') end
  end
    -- actions.stealth=ambush
  if S.Ambush:IsCastable() and Target:IsSpellInRange(S.Ambush) then
    if WR.Cast(S.Ambush) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('KaZXDrPKIfJobftLMJHtvzlYTgiiVXSwrnflMowuWTFskIiATIxvgZuQ2FzdCBBbWJ1c2g=') end
  end
end

local function Finish()
  -- # BtE to keep the Crit debuff up, if RP is up, or for Greenskins, unless the target is about to die.
  -- actions.finish=between_the_eyes,if=target.time_to_die>3&(debuff.between_the_eyes.remains<4|runeforge.greenskins_wickers&!buff.greenskins_wickers.up|!runeforge.greenskins_wickers&buff.ruthless_precision.up)
  -- Note: Increased threshold to 4s to account for player reaction time
  if S.BetweentheEyes:IsCastable() and Target:IsSpellInRange(S.BetweentheEyes)
    and (Target:FilteredTimeToDie(jvZuFHMBBsuotrRvjlCbxRDfYoUS('MZsEIMGipbuMBxEVRzyOiYtmkWiCoPEEQApqrxWaThUBPuBmsWMfpbrPg=='), 4) or Target:TimeToDieIsNotValid()) and Rogue.CanDoTUnit(Target, BetweenTheEyesDMGThreshold)
    and (Target:DebuffRemains(S.BetweentheEyes) < 4 or GreenskinsWickersEquipped and not Player:BuffUp(S.GreenskinsWickers)
      or not GreenskinsWickersEquipped and Player:BuffUp(S.RuthlessPrecision)) then
    if WR.Cast(S.BetweentheEyes) then return jvZuFHMBBsuotrRvjlCbxRDfYoUS('jGXLHqRLMNyTSiimjALRLdkfXrkqnrRokFNVzldxJJCVHSwEIuXIwspQ2FzdCBCZXR3ZWVuIHRoZSBFeWVz') end
  end
  -- actions.finish=slice_and_dice,if=buff.slice_and_dice.remains<fight_remains&refreshable
  -- Note: Added Player:BuffRemains(S.SliceandDice) == 0 to maintain the buff while TTD is invalid (itjvZuFHMBBsuotrRvjlCbxRDfYoUS('rHDmRftDkweJwkpnCbDHqzNrqqUNKchzAYHqBNJNoCCFwtWKGcvWbXacyBtYWlubHkgZm9yIFNvbG8sIG5vdCBhbiBpc3N1ZSBpbiByYWlkcykNCiAgaWYgUy5TbGljZWFuZERpY2U6SXNDYXN0YWJsZSgpIGFuZCAoSEwuRmlsdGVyZWRGaWdodFJlbWFpbnMoRW5lbWllc0JGLCA=')>jvZuFHMBBsuotrRvjlCbxRDfYoUS('fukszYdPXagzbDeaWBidiYXQxGbZMbEVwAftKSwetCOgDjHJgUdqTBXLCBQbGF5ZXI6QnVmZlJlbWFpbnMoUy5TbGljZWFuZERpY2UpLCB0cnVlKSBvciBQbGF5ZXI6QnVmZlJlbWFpbnMoUy5TbGljZWFuZERpY2UpID09IDApDQogICAgYW5kIFBsYXllcjpCdWZmUmVtYWlucyhTLlNsaWNlYW5kRGljZSkgPCAoMSArIENvbWJvUG9pbnRzKSAqIDEuOCB0aGVuDQogICAgaWYgV1IuQ2FzdChTLlNsaWNlYW5kRGljZSkgdGhlbiByZXR1cm4g')Cast Slice and DicejvZuFHMBBsuotrRvjlCbxRDfYoUS('AITlLvUUInNtpRRxOrnfngyIHhcMpwTWTfHeGsKGfxtAJktWPZVVjUXIGVuZA0KICBlbmQNCiAgLS0gYWN0aW9ucy5maW5pc2grPS9kaXNwYXRjaA0KICBpZiBTLkRpc3BhdGNoOklzQ2FzdGFibGUoKSBhbmQgVGFyZ2V0OklzU3BlbGxJblJhbmdlKFMuRGlzcGF0Y2gpIHRoZW4NCiAgICBpZiBXUi5DYXN0KFMuRGlzcGF0Y2gpIHRoZW4gcmV0dXJuIA==')Cast DispatchjvZuFHMBBsuotrRvjlCbxRDfYoUS('HWjYwiUDlsVBisErVZdrTlYzIKymBPRCNYjioFzJaBNOtLBOJAKyBqJIGVuZA0KICBlbmQNCmVuZA0KDQpsb2NhbCBmdW5jdGlvbiBCdWlsZCgpDQogIC0tIGFjdGlvbnMuYnVpbGQ9c2Vwc2lzDQogIGlmIENEc09OKCkgYW5kIFMuU2Vwc2lzOklzUmVhZHkoKSBhbmQgVGFyZ2V0OklzU3BlbGxJblJhbmdlKFMuU2Vwc2lzKSBhbmQgUm9ndWUuTWFzdGVyQXNzYXNzaW5zTWFya1JlbWFpbnMoKSA8PSAwIHRoZW4NCiAgICBpZiBXUi5DYXN0KFMuU2Vwc2lzKSB0aGVuIHJldHVybiA=')Cast SepsisjvZuFHMBBsuotrRvjlCbxRDfYoUS('RZbFVKhMCxkVGISPpxICgDsHpKbIQPTYmkQumTcGFvAgrpPMXTOCzTyIGVuZA0KICBlbmQNCiAgLS0gYWN0aW9ucy5idWlsZCs9L2dob3N0bHlfc3RyaWtlLGlmPWRlYnVmZi5naG9zdGx5X3N0cmlrZS5yZW1haW5zPD0zDQogIGlmIFMuR2hvc3RseVN0cmlrZTpJc1JlYWR5KCkgYW5kIFRhcmdldDpJc1NwZWxsSW5SYW5nZShTLkdob3N0bHlTdHJpa2UpIGFuZCBUYXJnZXQ6RGVidWZmUmVtYWlucyhTLkdob3N0bHlTdHJpa2UpIDw9IDMgdGhlbg0KICAgIGlmIFdSLkNhc3QoUy5HaG9zdGx5U3RyaWtlKSB0aGVuIHJldHVybiA=')Cast Ghostly StrikejvZuFHMBBsuotrRvjlCbxRDfYoUS('IRpJEdiizVbpimZVvjuuYNIUTfbXuTYELIusbUgkdkhXPXVCtFzAOPzIGVuZA0KICBlbmQNCiAgLS0gYWN0aW9ucy5idWlsZD1zaGl2LGlmPXJ1bmVmb3JnZS50aW55X3RveGljX2JsYWRlLmVxdWlwcGVkDQogIGlmIFMuU2hpdjpJc1JlYWR5KCkgYW5kIFRpbnlUb3hpY0JsYWRlRXF1aXBwZWQgdGhlbg0KICAgIGlmIFdSLkNhc3QoUy5TaGl2KSB0aGVuIHJldHVybiA=')Cast Shiv (TTB)jvZuFHMBBsuotrRvjlCbxRDfYoUS('XchFweaFBVYzbFOlCtLpymDHCPXJBfqVxTmeATvECrVzsrKvkaVqXuaIGVuZA0KICBlbmQNCiAgLS0gYWN0aW9ucy5idWlsZCs9L2VjaG9pbmdfcmVwcmltYW5kLGlmPSFzb3VsYmluZC5lZmZ1c2l2ZV9hbmltYV9hY2NlbGVyYXRvcnx2YXJpYWJsZS5ibGFkZV9mbHVycnlfc3luYw0KICBpZiBDRHNPTigpIGFuZCBTLkVjaG9pbmdSZXByaW1hbmQ6SXNSZWFkeSgpIGFuZCAobm90IFMuRWZmdXNpdmVBbmltYUFjY2VsZXJhdG9yOlNvdWxiaW5kRW5hYmxlZCgpIG9yIEJsYWRlX0ZsdXJyeV9TeW5jKCkpIHRoZW4NCiAgICBpZiBXUi5DYXN0KFMuRWNob2luZ1JlcHJpbWFuZCkgdGhlbiByZXR1cm4g')Cast Echoing ReprimandjvZuFHMBBsuotrRvjlCbxRDfYoUS('eezkcYtpyjdmCWhrNTuJcApmzYOyxUlhmvrwABDOFlpIklsMlStXjXDIGVuZA0KICBlbmQNCiAgLS0gYWN0aW9ucy5idWlsZCs9L3NlcnJhdGVkX2JvbmVfc3Bpa2UsY3ljbGVfdGFyZ2V0cz0xLGlmPWJ1ZmYuc2xpY2VfYW5kX2RpY2UudXAmIWRvdC5zZXJyYXRlZF9ib25lX3NwaWtlX2RvdC50aWNraW5nfGZpZ2h0X3JlbWFpbnM8PTV8Y29vbGRvd24uc2VycmF0ZWRfYm9uZV9zcGlrZS5jaGFyZ2VzX2ZyYWN0aW9uYWw+PTIuNzUNCiAgaWYgUy5TZXJyYXRlZEJvbmVTcGlrZTpJc1JlYWR5KCkgdGhlbg0KICAgIGlmIChQbGF5ZXI6QnVmZlVwKFMuU2xpY2VhbmREaWNlKSBhbmQgbm90IFRhcmdldDpEZWJ1ZmZVcChTLlNlcnJhdGVkQm9uZVNwaWtlRGVidWZmKSkgb3IgKFNldHRpbmdzLk91dGxhdy5EdW1wU3Bpa2VzIGFuZCBITC5Cb3NzRmlsdGVyZWRGaWdodFJlbWFpbnMo')<jvZuFHMBBsuotrRvjlCbxRDfYoUS('hrjFUbfToxDKfccSEhjyhwfUBLTKDMXyUpfnbzVDWuDXQRTTYwtNnYPLCA1KSkgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLlNlcnJhdGVkQm9uZVNwaWtlKSB0aGVuIHJldHVybiA=')Cast Serrated Bone SpikejvZuFHMBBsuotrRvjlCbxRDfYoUS('rEuXBiVgCUjONopeAWTQWbaYKbzSDWcRayUbmzYlJjzAGeBBKPlhtjJIGVuZA0KICAgIGVuZA0KICAgIGlmIEFvRU9OKCkgdGhlbg0KICAgICAgLS0gUHJlZmVyIG1lbGVlIGN5Y2xlIHVuaXRzDQogICAgICBsb2NhbCBCZXN0VW5pdCwgQmVzdFVuaXRUVEQgPSBuaWwsIDQNCiAgICAgIGxvY2FsIFRhcmdldEdVSUQgPSBUYXJnZXQ6R1VJRCgpDQogICAgICBmb3IgXywgQ3ljbGVVbml0IGluIHBhaXJzKEVuZW1pZXMzMHkpIGRvDQogICAgICAgIGlmIEN5Y2xlVW5pdDpHVUlEKCkgfj0gVGFyZ2V0R1VJRCBhbmQgRXZlcnlvbmUuVW5pdElzQ3ljbGVWYWxpZChDeWNsZVVuaXQsIEJlc3RVbml0VFRELCAtQ3ljbGVVbml0OkRlYnVmZlJlbWFpbnMoUy5TZXJyYXRlZEJvbmVTcGlrZSkpDQogICAgICAgIGFuZCBub3QgQ3ljbGVVbml0OkRlYnVmZlVwKFMuU2VycmF0ZWRCb25lU3Bpa2VEZWJ1ZmYpIHRoZW4NCiAgICAgICAgICBCZXN0VW5pdCwgQmVzdFVuaXRUVEQgPSBDeWNsZVVuaXQsIEN5Y2xlVW5pdDpUaW1lVG9EaWUoKQ0KICAgICAgICBlbmQNCiAgICAgIGVuZA0KICAgICAgaWYgQmVzdFVuaXQgdGhlbg0KICAgICAgICBXUi5DYXN0TGVmdE5hbWVwbGF0ZShCZXN0VW5pdCwgUy5TZXJyYXRlZEJvbmVTcGlrZSkNCiAgICAgIGVuZA0KICAgIGVuZA0KICAgIGlmIFMuU2VycmF0ZWRCb25lU3Bpa2U6Q2hhcmdlc0ZyYWN0aW9uYWwoKSA+IDIuNzUgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLlNlcnJhdGVkQm9uZVNwaWtlKSB0aGVuIHJldHVybiA=')Cast Serrated Bone Spike FillerjvZuFHMBBsuotrRvjlCbxRDfYoUS('xaaMyhbcPLXIXAtKRYtAiUNwNUYcXrTJvWWLKpGgYBUrumzNQuJtwAGIGVuZA0KICAgIGVuZA0KICBlbmQNCiAgaWYgUy5QaXN0b2xTaG90OklzQ2FzdGFibGUoKSBhbmQgVGFyZ2V0OklzU3BlbGxJblJhbmdlKFMuUGlzdG9sU2hvdCkgYW5kIFBsYXllcjpCdWZmVXAoUy5PcHBvcnR1bml0eSkgdGhlbg0KICAgIC0tIGFjdGlvbnMuYnVpbGQrPS9waXN0b2xfc2hvdCxpZj1idWZmLm9wcG9ydHVuaXR5LnVwJihidWZmLmdyZWVuc2tpbnNfd2lja2Vycy51cHxidWZmLmNvbmNlYWxlZF9ibHVuZGVyYnVzcy51cHxidWZmLnRvcm5hZG9fdHJpZ2dlci51cCkNCiAgICBpZiBQbGF5ZXI6QnVmZlVwKFMuR3JlZW5za2luc1dpY2tlcnMpIG9yIFBsYXllcjpCdWZmVXAoUy5Db25jZWFsZWRCbHVuZGVyYnVzcykgb3IgUGxheWVyOkJ1ZmZVcChTLlRvcm5hZG9UcmlnZ2VyQnVmZikgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLlBpc3RvbFNob3QpIHRoZW4gcmV0dXJuIA==')Cast Pistol Shot (Buffed)jvZuFHMBBsuotrRvjlCbxRDfYoUS('BMSbqUjAYyTVydlRDZlCYpYVYWDtoSAkFedaLsVnNcLJIZBivGwCYdnIGVuZA0KICAgIGVuZA0KICAgIC0tIGFjdGlvbnMuYnVpbGQrPS9waXN0b2xfc2hvdCxpZj1idWZmLm9wcG9ydHVuaXR5LnVwJihlbmVyZ3kuYmFzZV9kZWZpY2l0PmVuZXJneS5yZWdlbioxLjV8IXRhbGVudC53ZWFwb25tYXN0ZXImY29tYm9fcG9pbnRzLmRlZmljaXQ8PTErYnVmZi5icm9hZHNpZGUudXB8dGFsZW50LnF1aWNrX2RyYXcuZW5hYmxlZCkNCiAgICBpZiBFbmVyZ3lEZWZpY2l0ID4gKEVuZXJneVJlZ2VuICogMS41KSBvciBTLlF1aWNrRHJhdzpJc0F2YWlsYWJsZSgpDQogICAgICBvciBub3QgUy5XZWFwb25tYXN0ZXI6SXNBdmFpbGFibGUoKSBhbmQgQ29tYm9Qb2ludHNEZWZpY2l0IDw9IDEgKyBudW0oUGxheWVyOkJ1ZmZVcChTLkJyb2Fkc2lkZSkpIHRoZW4NCiAgICAgIGlmIFdSLkNhc3QoUy5QaXN0b2xTaG90KSB0aGVuIHJldHVybiA=')Cast Pistol ShotjvZuFHMBBsuotrRvjlCbxRDfYoUS('wmQKTDWUDfBaNuZUQvrdUVHZFjlnFwTQxYGHjFPnJqaFpOshotboxlgIGVuZA0KICAgIGVuZA0KICBlbmQNCiAgLS0gVE9ETzogYWN0aW9ucy5idWlsZCs9L3NpbmlzdGVyX3N0cmlrZSx0YXJnZXRfaWY9bWluOmRvdC52aWNpb3VzX3dvdW5kLnJlbWFpbnMsaWY9YnVmZi5hY3F1aXJlZF9heGVfZHJpdmVyLnVwDQogIC0tIGFjdGlvbnMuYnVpbGQrPS9zaW5pc3Rlcl9zdHJpa2UNCiAgaWYgUy5TaW5pc3RlclN0cmlrZTpJc0Nhc3RhYmxlKCkgYW5kIFRhcmdldDpJc1NwZWxsSW5SYW5nZShTLlNpbmlzdGVyU3RyaWtlKSB0aGVuDQogICAgaWYgV1IuQ2FzdChTLlNpbmlzdGVyU3RyaWtlKSB0aGVuIHJldHVybiA=')Cast Sinister StrikejvZuFHMBBsuotrRvjlCbxRDfYoUS('nhQedbzUrUNVWqoIWAoootXFLADlGBiSLnPDQFIziuAPsphkZpWLIaMIGVuZA0KICBlbmQNCmVuZA0KDQotLS0gPT09PT09PSBNQUlOID09PT09PT0NCmxvY2FsIGZ1bmN0aW9uIEFQTCAoKQ0KICAtLSBMb2NhbCBVcGRhdGUNCiAgQmxhZGVGbHVycnlSYW5nZSA9IFMuQWNyb2JhdGljU3RyaWtlczpJc0F2YWlsYWJsZSgpIGFuZCA5IG9yIDYNCiAgQmV0d2VlblRoZUV5ZXNETUdUaHJlc2hvbGQgPSBTLkRpc3BhdGNoOkRhbWFnZSgpICogMS4yNQ0KICBDb21ib1BvaW50cyA9IFBsYXllcjpDb21ib1BvaW50cygpDQogIEVmZmVjdGl2ZUNvbWJvUG9pbnRzID0gUm9ndWUuRWZmZWN0aXZlQ29tYm9Qb2ludHMoQ29tYm9Qb2ludHMpDQogIENvbWJvUG9pbnRzRGVmaWNpdCA9IFBsYXllcjpDb21ib1BvaW50c0RlZmljaXQoKQ0KICBFbmVyZ3lNYXhPZmZzZXQgPSBQbGF5ZXI6QnVmZlVwKFMuQWRyZW5hbGluZVJ1c2gpIGFuZCAtNTAgb3IgMCAtLSBGb3IgYmFzZV90aW1lX3RvX21heCBlbXVsYXRpb24NCiAgRW5lcmd5ID0gRW5lcmd5UHJlZGljdGVkU3RhYmxlKEVuZXJneU1heE9mZnNldCkNCiAgRW5lcmd5UmVnZW4gPSBQbGF5ZXI6RW5lcmd5UmVnZW4oKQ0KICBFbmVyZ3lUaW1lVG9NYXggPSBFbmVyZ3lUaW1lVG9NYXhTdGFibGUoRW5lcmd5TWF4T2Zmc2V0KQ0KICBFbmVyZ3lEZWZpY2l0ID0gUGxheWVyOkVuZXJneURlZmljaXRQcmVkaWN0ZWQobmlsLCBFbmVyZ3lNYXhPZmZzZXQpDQoNCiAgLS0gVW5pdCBVcGRhdGUNCiAgaWYgQW9FT04oKSB0aGVuDQogICAgRW5lbWllczMweSA9IFBsYXllcjpHZXRFbmVtaWVzSW5SYW5nZSgzMCkgLS0gU2VycmF0ZWQgQm9uZSBTcGlrZSBjeWNsZQ0KICAgIEVuZW1pZXNCRiA9IFBsYXllcjpHZXRFbmVtaWVzSW5SYW5nZShCbGFkZUZsdXJyeVJhbmdlKQ0KICAgIEVuZW1pZXNCRkNvdW50ID0gI0VuZW1pZXNCRg0KICBlbHNlDQogICAgRW5lbWllc0JGQ291bnQgPSAxDQogIGVuZA0KDQogIC0tIERlZmVuc2l2ZXMNCiAgLS0gQ3JpbXNvbiBWaWFsDQogIC0tU2hvdWxkUmV0dXJuID0gUm9ndWUuQ3JpbXNvblZpYWwoKQ0KICAtLWlmIFNob3VsZFJldHVybiB0aGVuIHJldHVybiBTaG91bGRSZXR1cm4gZW5kDQogIC0tIEZlaW50DQogIC0tU2hvdWxkUmV0dXJuID0gUm9ndWUuRmVpbnQoKQ0KICAtLWlmIFNob3VsZFJldHVybiB0aGVuIHJldHVybiBTaG91bGRSZXR1cm4gZW5kDQoNCiAgLS0gUG9pc29ucw0KICAtLVJvZ3VlLlBvaXNvbnMoKQ0KDQogIC0tIE91dCBvZiBDb21iYXQNCiAgaWYgbm90IFBsYXllcjpBZmZlY3RpbmdDb21iYXQoKSB0aGVuDQogICAgLS0gU3RlYWx0aA0KICAgIGlmIG5vdCBQbGF5ZXI6QnVmZlVwKFMuVmFuaXNoQnVmZikgdGhlbg0KICAgICAgU2hvdWxkUmV0dXJuID0gUm9ndWUuU3RlYWx0aChTLlN0ZWFsdGgpDQogICAgICBpZiBTaG91bGRSZXR1cm4gdGhlbiByZXR1cm4gU2hvdWxkUmV0dXJuIGVuZA0KICAgIGVuZA0KICAgIC0tIEZsYXNrDQogICAgLS0gRm9vZA0KICAgIC0tIFJ1bmUNCiAgICAtLSBQcmVQb3Qgdy8gQm9zc21vZCBDb3VudGRvd24NCiAgICAtLSBPcGVuZXINCiAgICBpZiBFdmVyeW9uZS5UYXJnZXRJc1ZhbGlkKCkgdGhlbg0KICAgICAgLS0gUHJlY29tYmF0IENEcw0KICAgICAgLS0gYWN0aW9ucy5wcmVjb21iYXQrPS9tYXJrZWRfZm9yX2RlYXRoLHByZWNvbWJhdF9zZWNvbmRzPTEwLGlmPXJhaWRfZXZlbnQuYWRkcy5pbj4yNQ0KICAgICAgaWYgQ0RzT04oKSBhbmQgUy5NYXJrZWRmb3JEZWF0aDpJc0Nhc3RhYmxlKCkgYW5kIENvbWJvUG9pbnRzRGVmaWNpdCA+PSBSb2d1ZS5DUE1heFNwZW5kKCkgLSAxIHRoZW4NCiAgICAgICAgaWYgU2V0dGluZ3MuQ29tbW9ucy5TVE1mREFzRFBTQ0QgdGhlbg0KICAgICAgICAgIGlmIFdSLkNhc3QoUy5NYXJrZWRmb3JEZWF0aCkgdGhlbiByZXR1cm4g')Cast Marked for Death (OOC)jvZuFHMBBsuotrRvjlCbxRDfYoUS('cnVrnooLfMZanMUwBQCxsFquCRpDwTquETrYxrNdjQZMiEBqCWDNGIOIGVuZA0KICAgICAgICBlbHNlDQogICAgICAgICAgaWYgV1IuQ2FzdFN1Z2dlc3RlZChTLk1hcmtlZGZvckRlYXRoKSB0aGVuIHJldHVybiA=')Cast Marked for Death (OOC)jvZuFHMBBsuotrRvjlCbxRDfYoUS('NicwboZQcigLENsbhjqSyEjGxEueUEDTLrILMmzBdNUZxznIRKtDAqDIGVuZA0KICAgICAgICBlbmQNCiAgICAgIGVuZA0KICAgICAgLS0gVE9ETyBhY3Rpb25zLnByZWNvbWJhdCs9L2ZsZXNoY3JhZnQsaWY9c291bGJpbmQucHVzdHVsZV9lcnVwdGlvbnxzb3VsYmluZC52b2xhdGlsZV9zb2x2ZW50DQogICAgICAtLSBhY3Rpb25zLnByZWNvbWJhdCs9L3JvbGxfdGhlX2JvbmVzLHByZWNvbWJhdF9zZWNvbmRzPTINCiAgICAgIGlmIFMuUm9sbHRoZUJvbmVzOklzUmVhZHkoKSBhbmQgKFJvZ3VlLlJ0QlJlbWFpbnMoKSA8PSAzIG9yIFJ0Ql9SZXJvbGwoKSkgdGhlbg0KICAgICAgICBpZiBXUi5DYXN0KFMuUm9sbHRoZUJvbmVzKSB0aGVuIHJldHVybiA=')Cast Roll the Bones (Opener)jvZuFHMBBsuotrRvjlCbxRDfYoUS('fSzSyTzwgtXEdGPwbhTTkRciUKuPvOrmKasEzlIkkNBEjgXPPsTVtfZIGVuZA0KICAgICAgZW5kDQogICAgICAtLSBhY3Rpb25zLnByZWNvbWJhdCs9L3NsaWNlX2FuZF9kaWNlLHByZWNvbWJhdF9zZWNvbmRzPTENCiAgICAgIGlmIFMuU2xpY2VhbmREaWNlOklzUmVhZHkoKSBhbmQgUGxheWVyOkJ1ZmZSZW1haW5zKFMuU2xpY2VhbmREaWNlKSA8ICgxICsgQ29tYm9Qb2ludHMpICogMS44IHRoZW4NCiAgICAgICAgaWYgV1IuQ2FzdChTLlNsaWNlYW5kRGljZSkgdGhlbiByZXR1cm4g')Cast Slice and Dice (Opener)jvZuFHMBBsuotrRvjlCbxRDfYoUS('WlwCRYXTobbsdVOLHYyNVtVDXJUYKTCovhdbzwABAUeRukLwdvPQwGcIGVuZA0KICAgICAgZW5kDQogICAgICBpZiBQbGF5ZXI6U3RlYWx0aFVwKHRydWUsIHRydWUpIHRoZW4NCiAgICAgICAgU2hvdWxkUmV0dXJuID0gU3RlYWx0aCgpDQogICAgICAgIGlmIFNob3VsZFJldHVybiB0aGVuIHJldHVybiA=')Stealth (Opener): jvZuFHMBBsuotrRvjlCbxRDfYoUS('UHMyxrQYHZmWFYHviVuObteshquizmsUwWKBOgRpbvhXRSEyHtaoxYVIC4uIFNob3VsZFJldHVybiBlbmQNCiAgICAgIGVsc2VpZiBGaW5pc2hfQ29uZGl0aW9uKCkgdGhlbg0KICAgICAgICBTaG91bGRSZXR1cm4gPSBGaW5pc2goKQ0KICAgICAgICBpZiBTaG91bGRSZXR1cm4gdGhlbiByZXR1cm4g')Finish (Opener): jvZuFHMBBsuotrRvjlCbxRDfYoUS('LSILheLtYZQJkzMbdekpWQxVhgmxLINTItvcSZprdBvjzAaLxrsFfizIC4uIFNob3VsZFJldHVybiBlbmQNCiAgICAgIGVsc2VpZiBTLlNpbmlzdGVyU3RyaWtlOklzQ2FzdGFibGUoKSB0aGVuDQogICAgICAgIGlmIFdSLkNhc3QoUy5TaW5pc3RlclN0cmlrZSkgdGhlbiByZXR1cm4g')Cast Sinister Strike (Opener)jvZuFHMBBsuotrRvjlCbxRDfYoUS('rhRRaWZkBBnHeNdjSmMAdRBVHingkHmJGBLNvgEAiVTuNnWvfiOTIVPIGVuZA0KICAgICAgZW5kDQogICAgZW5kDQogICAgcmV0dXJuDQogIGVuZA0KDQogIC0tIEluIENvbWJhdA0KICAtLSBNZkQgU25pcGluZyAoSGlnaGVyIFByaW9yaXR5IHRoYW4gQVBMKQ0KICAtLSBhY3Rpb25zLmNkcys9L21hcmtlZF9mb3JfZGVhdGgsdGFyZ2V0X2lmPW1pbjp0YXJnZXQudGltZV90b19kaWUsaWY9dGFyZ2V0LnRpbWVfdG9fZGllPGNvbWJvX3BvaW50cy5kZWZpY2l0fCgocmFpZF9ldmVudC5hZGRzLmluPjQwfGJ1ZmYudHJ1ZV9iZWFyaW5nLnJlbWFpbnM+MTUtYnVmZi5hZHJlbmFsaW5lX3J1c2gudXAqNSkmIXN0ZWFsdGhlZC5yb2d1ZSZjb21ib19wb2ludHMuZGVmaWNpdD49Y3BfbWF4X3NwZW5kLTEpDQogIC0tIGFjdGlvbnMuY2RzKz0vbWFya2VkX2Zvcl9kZWF0aCxpZj1yYWlkX2V2ZW50LmFkZHMuaW4+MzAtcmFpZF9ldmVudC5hZGRzLmR1cmF0aW9uJiFzdGVhbHRoZWQucm9ndWUmY29tYm9fcG9pbnRzLmRlZmljaXQ+PWNwX21heF9zcGVuZC0xJighY292ZW5hbnQudmVudGh5cnxjb29sZG93bi5mbGFnZWxsYXRpb24ucmVtYWlucz4xMHxidWZmLmZsYWdlbGxhdGlvbl9idWZmLnVwKQ0KICAtLWlmIFMuTWFya2VkZm9yRGVhdGg6SXNDYXN0YWJsZSgpIHRoZW4NCiAgLS0gIGlmIEVuZW1pZXNCRkNvdW50ID4gMSBhbmQgRXZlcnlvbmUuQ2FzdFRhcmdldElmKFMuTWFya2VkZm9yRGVhdGgsIEVuZW1pZXMzMHksIA==')minjvZuFHMBBsuotrRvjlCbxRDfYoUS('MOCLzkFbKeuZVnoPMjmRuLVERGoULQsQXenGBUrNOxwavtgYYUNtNTGLCBFdmFsdWF0ZU1mRFRhcmdldElmQ29uZGl0aW9uLCBFdmFsdWF0ZU1mRENvbmRpdGlvbiwgbmlsLCBTZXR0aW5ncy5Db21tb25zLk9mZkdDRGFzT2ZmR0NELk1hcmtlZGZvckRlYXRoKSB0aGVuDQogIC0tICAgIHJldHVybiA=')Cast Marked for Death (Cycle)jvZuFHMBBsuotrRvjlCbxRDfYoUS('hUpZQEORfrpzgEvLylGakrqUzVjavgZtezqnJxdlfQtbKRNBAiSSaDEDQogIC0tICBlbHNlaWYgRW5lbWllc0JGQ291bnQgPT0gMSBhbmQgbm90IFBsYXllcjpTdGVhbHRoVXAodHJ1ZSwgZmFsc2UpIGFuZCBDb21ib1BvaW50c0RlZmljaXQgPj0gUm9ndWUuQ1BNYXhTcGVuZCgpIC0gMQ0KICAtLSAgICBhbmQgKG5vdCBJc1ZlbnRoeXIgb3IgUy5GbGFnZWxsYXRpb246Q29vbGRvd25SZW1haW5zKCkgPiAxMCBvciBTLkZsYWdlbGxhdGlvbjpBbnlEZWJ1ZmZVcCgpKSB0aGVuDQogIC0tICAgIGlmIFNldHRpbmdzLkNvbW1vbnMuU1RNZkRBc0RQU0NEIHRoZW4NCiAgLS0gICAgICBpZiBXUi5DYXN0KFMuTWFya2VkZm9yRGVhdGgpIHRoZW4gcmV0dXJuIA==')Cast Marked for Death (ST)jvZuFHMBBsuotrRvjlCbxRDfYoUS('KaMVgoNMaktxrSTCPblGhshEPFThtLaNcKIkYFJrvZmQiCFImTvIhMoIGVuZA0KICAtLSAgICBlbHNlDQogIC0tICAgICAgV1IuQ2FzdFN1Z2dlc3RlZChTLk1hcmtlZGZvckRlYXRoKQ0KICAtLSAgICBlbmQNCiAgLS0gIGVuZA0KICAtLWVuZA0KDQogIGlmIEV2ZXJ5b25lLlRhcmdldElzVmFsaWQoKSB0aGVuDQogICAgLS0gSW50ZXJydXB0cw0KICAgIC0tU2hvdWxkUmV0dXJuID0gRXZlcnlvbmUuSW50ZXJydXB0KFMuS2ljaywgNSwgdHJ1ZSkNCiAgICAtLWlmIFNob3VsZFJldHVybiB0aGVuIHJldHVybiBTaG91bGRSZXR1cm4gZW5kDQoNCiAgICAtLSBhY3Rpb25zKz0vY2FsbF9hY3Rpb25fbGlzdCxuYW1lPXN0ZWFsdGgsaWY9c3RlYWx0aGVkLmFsbA0KICAgIGlmIFBsYXllcjpTdGVhbHRoVXAodHJ1ZSwgdHJ1ZSkgdGhlbg0KICAgICAgU2hvdWxkUmV0dXJuID0gU3RlYWx0aCgpDQogICAgICBpZiBTaG91bGRSZXR1cm4gdGhlbiByZXR1cm4g')Stealth: jvZuFHMBBsuotrRvjlCbxRDfYoUS('GLokJGUXaBbNOaIBXaZwGXiOEyZGYnjQhKBgVVHIuJtkhCTzWieptqqIC4uIFNob3VsZFJldHVybiBlbmQNCiAgICBlbmQNCiAgICAtLSBhY3Rpb25zKz0vY2FsbF9hY3Rpb25fbGlzdCxuYW1lPWNkcw0KICAgIFNob3VsZFJldHVybiA9IENEcygpDQogICAgaWYgU2hvdWxkUmV0dXJuIHRoZW4gcmV0dXJuIA==')CDs: jvZuFHMBBsuotrRvjlCbxRDfYoUS('ixgMdVFxVsRtKlrOeRnrqnGofdByRqhDzEvvvgXUyfPqbzTMPgyDAxZIC4uIFNob3VsZFJldHVybiBlbmQNCiAgICAtLSBhY3Rpb25zKz0vcnVuX2FjdGlvbl9saXN0LG5hbWU9ZmluaXNoLGlmPXZhcmlhYmxlLmZpbmlzaF9jb25kaXRpb24NCiAgICBpZiBGaW5pc2hfQ29uZGl0aW9uKCkgdGhlbg0KICAgICAgU2hvdWxkUmV0dXJuID0gRmluaXNoKCkNCiAgICAgIGlmIFNob3VsZFJldHVybiB0aGVuIHJldHVybiA=')Finish: jvZuFHMBBsuotrRvjlCbxRDfYoUS('iqjBKzCXSAcQbqPPBygENSEdSkvSCCxvuPXtjZMqOstUrQPJXZtwQPuIC4uIFNob3VsZFJldHVybiBlbmQNCiAgICAgIC0tIHJ1bl9hY3Rpb25fbGlzdCBmb3JjZXMgdGhlIHJldHVybg0KICAgICAgLS1XUi5DYXN0KFMuUG9vbEVuZXJneSkNCiAgICAgIC0tcmV0dXJuIA==')Finish PoolingjvZuFHMBBsuotrRvjlCbxRDfYoUS('DbIjgxOkiLEnkNyAYbHGiPwjorFDnqwqLtpuyatdMwDQTunUzrtnkXADQogICAgZW5kDQogICAgLS0gYWN0aW9ucys9L2NhbGxfYWN0aW9uX2xpc3QsbmFtZT1idWlsZA0KICAgIFNob3VsZFJldHVybiA9IEJ1aWxkKCkNCiAgICBpZiBTaG91bGRSZXR1cm4gdGhlbiByZXR1cm4g')Build: jvZuFHMBBsuotrRvjlCbxRDfYoUS('rYutrihYmzODOoQRuZGfQLmStXvQdfRiRAuhPFzvjguVVjgDQHhJObbIC4uIFNob3VsZFJldHVybiBlbmQNCiAgICAtLSBhY3Rpb25zKz0vYXJjYW5lX3RvcnJlbnQsaWY9ZW5lcmd5LmRlZmljaXQ+PTE1K2VuZXJneS5yZWdlbg0KICAgIGlmIFMuQXJjYW5lVG9ycmVudDpJc0Nhc3RhYmxlKCkgYW5kIFRhcmdldDpJc1NwZWxsSW5SYW5nZShTLlNpbmlzdGVyU3RyaWtlKSBhbmQgRW5lcmd5RGVmaWNpdCA+IDE1ICsgRW5lcmd5UmVnZW4gdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLkFyY2FuZVRvcnJlbnQpIHRoZW4gcmV0dXJuIA==')Cast Arcane TorrentjvZuFHMBBsuotrRvjlCbxRDfYoUS('lLrikOuPLhkQFOwKGaCycjvPXpmSbOXSCSlVxZRoafHmxyGrXLDazimIGVuZA0KICAgIGVuZA0KICAgIC0tIGFjdGlvbnMrPS9hcmNhbmVfcHVsc2UNCiAgICBpZiBTLkFyY2FuZVB1bHNlOklzQ2FzdGFibGUoKSBhbmQgVGFyZ2V0OklzU3BlbGxJblJhbmdlKFMuU2luaXN0ZXJTdHJpa2UpIHRoZW4NCiAgICAgIGlmIFdSLkNhc3QoUy5BcmNhbmVQdWxzZSkgdGhlbiByZXR1cm4g')Cast Arcane PulsejvZuFHMBBsuotrRvjlCbxRDfYoUS('AmzETbZYCEKASccQgIPBxbbrAmzXdZuqyNluiNFiDtbYhnBqXcwpYFRIGVuZA0KICAgIGVuZA0KICAgIC0tIGFjdGlvbnMrPS9saWdodHNfanVkZ21lbnQNCiAgICBpZiBTLkxpZ2h0c0p1ZGdtZW50OklzQ2FzdGFibGUoKSBhbmQgVGFyZ2V0OklzSW5NZWxlZVJhbmdlKDUpIHRoZW4NCiAgICAgIGlmIFdSLkNhc3QoUy5MaWdodHNKdWRnbWVudCkgdGhlbiByZXR1cm4g')Cast Lights JudgmentjvZuFHMBBsuotrRvjlCbxRDfYoUS('zhpVUznLaQMzygwMGVgMLVipEXsmvJNBeuCWDjNkqHZHlaZWBZGGBLsIGVuZA0KICAgIGVuZA0KICAgIC0tIGFjdGlvbnMrPS9iYWdfb2ZfdHJpY2tzDQogICAgaWYgUy5CYWdvZlRyaWNrczpJc0Nhc3RhYmxlKCkgYW5kIFRhcmdldDpJc0luTWVsZWVSYW5nZSg1KSB0aGVuDQogICAgICBpZiBXUi5DYXN0KFMuQmFnb2ZUcmlja3MpIHRoZW4gcmV0dXJuIA==')Cast Bag of TricksjvZuFHMBBsuotrRvjlCbxRDfYoUS('nSUecQuoOCYTEFXYMnXzspFCVUzxcbChrgzcKPNHmoPUxnpcNLLZxSDIGVuZA0KICAgIGVuZA0KICAgIC0tIE91dG9mUmFuZ2UgUGlzdG9sIFNob3QNCiAgICBpZiBTLlBpc3RvbFNob3Q6SXNDYXN0YWJsZSgpIGFuZCBUYXJnZXQ6SXNTcGVsbEluUmFuZ2UoUy5QaXN0b2xTaG90KSBhbmQgbm90IFRhcmdldDpJc0luUmFuZ2UoQmxhZGVGbHVycnlSYW5nZSkgYW5kIG5vdCBQbGF5ZXI6U3RlYWx0aFVwKHRydWUsIHRydWUpDQogICAgICBhbmQgRW5lcmd5RGVmaWNpdCA8IDI1IGFuZCAoQ29tYm9Qb2ludHNEZWZpY2l0ID49IDEgb3IgRW5lcmd5VGltZVRvTWF4IDw9IDEuMikgdGhlbg0KICAgICAgaWYgV1IuQ2FzdChTLlBpc3RvbFNob3QpIHRoZW4gcmV0dXJuIA==')Cast Pistol Shot (OOR)jvZuFHMBBsuotrRvjlCbxRDfYoUS('JAUtStWDIZjEDvMQZFJOtvFRuXNGUfdcxnaedlKEeBMrGFDdTauZasNIGVuZA0KICAgIGVuZA0KICBlbmQNCmVuZA0KDQpsb2NhbCBmdW5jdGlvbiBBdXRvQmluZCgpDQogIC0tIFNwZWxsIEJpbmRzDQogIFdSLkJpbmQoUy5BZHJlbmFsaW5lUnVzaCkNCiAgV1IuQmluZChTLkFtYnVzaCkNCiAgV1IuQmluZChTLkJldHdlZW50aGVFeWVzKQ0KICBXUi5CaW5kKFMuQmxhZGVGbHVycnkpDQogIFdSLkJpbmQoUy5CbGFkZVJ1c2gpDQogIFdSLkJpbmQoUy5EaXNwYXRjaCkNCiAgV1IuQmluZChTLkZsYWdlbGxhdGlvbikNCiAgV1IuQmluZChTLlBpc3RvbFNob3QpDQogIFdSLkJpbmQoUy5Sb2xsdGhlQm9uZXMpDQogIFdSLkJpbmQoUy5TaGl2KQ0KICBXUi5CaW5kKFMuU2luaXN0ZXJTdHJpa2UpDQogIFdSLkJpbmQoUy5TdGVhbHRoKQ0KICBXUi5CaW5kKFMuVmFuaXNoKQ0KICBXUi5CaW5kKFMuQXJjYW5lVG9ycmVudCkNCiAgV1IuQmluZChTLk1hcmtlZGZvckRlYXRoKQ0KICBXUi5CaW5kKFMuU2xpY2VhbmREaWNlKQ0KICBXUi5CaW5kKFMuQmxvb2RGdXJ5KQ0KICAtLVdSLkJpbmQoUy5EZWFkbHlQb2lzb24pDQogIFdSLkJpbmQoUy5OdW1iaW5nUG9pc29uKQ0KICBXUi5CaW5kKFMuSW5zdGFudFBvaXNvbikNCiAgLS1XUi5CaW5kKFMuV291bmRQb2lzb24pDQogIC0tV1IuQmluZChTLkNyaXBwbGluZ1BvaXNvbikNCiAgV1IuQmluZChTLkNyaW1zb25WaWFsKQ0KICBXUi5CaW5kKFMuRmVpbnQpDQogIC0tV1IuQmluZChNLkhlYWx0aHN0b25lKQ0KICAtLVdSLkJpbmQoTS5Qb3Rpb25vZlNwZWN0cmFsU3RyZW5ndGgpDQogIC0tV1IuQmluZChNLlBoaWFsb2ZTZXJlbml0eSkNCmVuZA0KDQpsb2NhbCBmdW5jdGlvbiBJbml0ICgpDQogIFdSLlByaW50KA==')Outlaw Rogue by Worldy')
  AutoBind()
  S.Flagellation:RegisterAuraTracking()
end

WR.SetAPL(260, APL, Init)
    