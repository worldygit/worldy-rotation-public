local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


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
local Mouseover  = Unit.MouseOver
local Spell      = HL.Spell
local Item       = HL.Item
local Utils      = HL.Utils
-- WorldyRotation
local WR         = WorldyRotation
local Cast       = WR.Cast
local AoEON      = WR.AoEON
local CDsON      = WR.CDsON
local Macro      = WR.Macro


--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Define S/I/M for spell, item and macro arrays
local S = Spell.Warrior.Fury
local I = Item.Warrior.Fury
local M = Macro.Warrior.Fury

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
  --I.FlameofBattle:ID(),
  --I.InscrutableQuantumDevice:ID(),
  --I.InstructorsDivineBell:ID(),
  --I.MacabreSheetMusic:ID(),
  --I.OverwhelmingPowerCrystal:ID(),
  --I.WakenersFrond:ID(),
  --I.SinfulGladiatorsBadge:ID(),
  --I.UnchainedGladiatorsBadge:ID(),
}

-- Variables
local EnrageUp
local VarExecutePhase
local VarUniqueLegendaries

-- Enemies Variables
local Enemies8y, EnemiesCount8
local TargetInMeleeRange

-- GUI Settings
local Everyone = WR.Commons.Everyone
local Settings = {
  General = WR.GUISettings.General,
  Commons = WR.GUISettings.APL.Warrior.Commons,
  Fury = WR.GUISettings.APL.Warrior.Fury
}

-- Legendaries
local SignetofTormentedKingsEquipped = Player:HasLegendaryEquipped(181)
local WilloftheBerserkerEquipped = Player:HasLegendaryEquipped(189)
local ElysianMightEquipped = Player:HasLegendaryEquipped(263)
local SinfulSurgeEquipped = Player:HasLegendaryEquipped(215)

-- Event Registrations
HL:RegisterForEvent(function()
  SignetofTormentedKingsEquipped = Player:HasLegendaryEquipped(181)
  WilloftheBerserkerEquipped = Player:HasLegendaryEquipped(189)
  ElysianMightEquipped = Player:HasLegendaryEquipped(263)
  SinfulSurgeEquipped = Player:HasLegendaryEquipped(215)
end, dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('tfSAfRPqFqLmpuaxneZVHkqZpjetlboVffvKvGcfwOTTYYsMAPGBQlXUExBWUVSX0VRVUlQTUVOVF9DSEFOR0VE'))

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('tHuxEVQBVQHvzpmreHTbElpRSkBYssysKmlxRimGaEAgDHMtwMtmKqDQ09WRU5BTlRfQ0hPU0VO'))

local function AOE()
  -- cancel_buff,name=bladestorm,if=spell_targets.whirlwind>1&gcd.remains=0&soulbind.first_strike&buff.first_strike.remains&buff.enrage.remains<gcd
  -- ancient_aftershock,if=buff.enrage.up&cooldown.recklessness.remains>5&spell_targets.whirlwind>1
  if CDsON() and S.AncientAftershock:IsCastable() and (EnrageUp and S.Recklessness:CooldownRemains() > 5 and EnemiesCount8 > 1) then
    if Cast(S.AncientAftershock, not Target:IsInMeleeRange(12)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('YZjPxuCJysFpDeHvlzFQNJMjnSvPvgYwERAMhJvpjfRpiOGsmYmgjgrYW5jaWVudF9hZnRlcnNob2NrIGFvZSAy'); end
  end
  -- spear_of_bastion,if=buff.enrage.up&rage<40&spell_targets.whirlwind>1
  if CDsON() and S.SpearofBastion:IsCastable() and (EnrageUp and Player:Rage() < 40 and EnemiesCount8 > 1) then
    if Cast(M.SpearofBastionPlayer, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('xHvKNmWydPfFZiFrlFaoypuNSWRtvyVSNhispCJvBPhhqvuALDfGGQcc3BlYXJfb2ZfYmFzdGlvbiBhb2UgNA=='); end
  end
  -- bladestorm,if=buff.enrage.up&spell_targets.whirlwind>2
  if CDsON() and S.Bladestorm:IsCastable() and (EnrageUp and EnemiesCount8 > 2) then
    if Cast(S.Bladestorm, not Target:IsInRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('bZzXqOySSZihCvhQgJEYcRYlFjwsZozhQduhYCnbZlLUHiLxKPtiodFYmxhZGVzdG9ybSBhb2UgNg=='); end
  end
  -- condemn,if=spell_targets.whirlwind>1&(buff.enrage.up|buff.recklessness.up&runeforge.sinful_surge)&variable.execute_phase
  if S.Condemn:IsCastable() and (EnemiesCount8 > 1 and (EnrageUp or Player:BuffUp(S.RecklessnessBuff) and SinfulSurgeEquipped) and VarExecutePhase) then
    if Cast(S.Condemn, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('rufgwmyPzquggcHagtWqNjJhJJBKxGnfdmKFybiFCajfhmLAXcHLtihY29uZGVtbiBhb2UgOA=='); end
  end
  -- siegebreaker,if=spell_targets.whirlwind>1
  if S.Siegebreaker:IsCastable() and (EnemiesCount8 > 1) then
    if Cast(S.Siegebreaker, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('AmfQvkgioItgskNFqxAPzYnPDKvWPKpeDuOtjrdcZDbqlThRkhIvEwgc2llZ2VicmVha2VyIGFvZSAxMA=='); end
  end
  -- rampage,if=spell_targets.whirlwind>1
  if S.Rampage:IsReady() and (EnemiesCount8 > 1) then
    if Cast(S.Rampage, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('HKuEZikWfFrgZLboFAuZHYiTwfSmoAJhtqYzATSlJqQZzWvewEVYHntcmFtcGFnZSBhb2UgMTI='); end
  end
  -- spear_of_bastion,if=buff.enrage.up&cooldown.recklessness.remains>5&spell_targets.whirlwind>1
  if Settings.Commons.Enabled.Covenant and CDsON() and S.SpearofBastion:IsCastable() and (EnrageUp and S.Recklessness:CooldownRemains() > 5 and EnemiesCount8 > 1) then
    if Cast(M.SpearofBastionPlayer, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('qdENcVJwungSgHzvmpAjrywuGEtkFSZcXiZHoTFWfseoAUhreZJHBgPc3BlYXJfb2ZfYmFzdGlvbiBhb2UgMTQ='); end
  end
  -- bladestorm,if=buff.enrage.remains>gcd*2.5&spell_targets.whirlwind>1
  if CDsON() and S.Bladestorm:IsCastable() and (Player:BuffRemains(S.EnrageBuff) > Player:GCD() * 2.5 and EnemiesCount8 > 1) then
    if Cast(S.Bladestorm, not Target:IsInRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('WICRHyiFBLxkQdaNhcAInHDVjHgsDbzRhzyRhCtIeLfQsTgeyMzjTTUYmxhZGVzdG9ybSBhb2UgMTY='); end
  end
end

local function SingleTarget()
  -- raging_blow,if=runeforge.will_of_the_berserker.equipped&buff.will_of_the_berserker.remains<gcd
  if S.RagingBlow:IsCastable() and (WilloftheBerserkerEquipped and Player:BuffRemains(S.WilloftheBerserkerBuff) < Player:GCD()) then
    if Cast(S.RagingBlow, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('UKTAcoMruvXHNGySMlWJgepSUhguPkGiJsXFLuGxvFMNukLbLzQKODjcmFnaW5nX2Jsb3cgc2luZ2xlX3RhcmdldCAy'); end
  end
  -- crushing_blow,if=runeforge.will_of_the_berserker.equipped&buff.will_of_the_berserker.remains<gcd
  if S.CrushingBlow:IsCastable() and (WilloftheBerserkerEquipped and Player:BuffRemains(S.WilloftheBerserkerBuff) < Player:GCD()) then
    if Cast(S.CrushingBlow, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('MIhGPjLIUXCccUqKVRuxKBjSmyNmOIjQDnPmPDPVZzGCghjKsmuOxlnY3J1c2hpbmdfYmxvdyBzaW5nbGVfdGFyZ2V0IDQ='); end
  end
  -- cancel_buff,name=bladestorm,if=spell_targets.whirlwind=1&gcd.remains=0&(talent.massacre.enabled|covenant.venthyr.enabled)&variable.execute_phase&(rage>90|!cooldown.condemn.remains)
  if Player:BuffUp(S.BladestormBuff) and EnemiesCount8 == 1 and (S.Massacre:IsAvailable() or CovenantID == 2) and VarExecutePhase and (Player:Rage() > 90 or S.Condemn:IsCastable()) then
    if Cast(M.CancelBladestorm, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('AZdyGOnPYKBUpjcMYLnujizWFPnerkGvDplEQcfGYSNjzLeFtGFrAAhY2FuY2VsX2JsYWRlc3Rvcm0gc2luZ2xlX3RhcmdldCA2'); end
  end
    -- condemn,if=(buff.enrage.up|buff.recklessness.up&runeforge.sinful_surge)&variable.execute_phase
  if S.Condemn:IsCastable() and ((EnrageUp or Player:BuffUp(S.RecklessnessBuff) and SinfulSurgeEquipped) and VarExecutePhase) then
    if Cast(S.Condemn, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('LGDHiKYTJGpQNVlkneMfpQhtkIFhXAbYDwpXxsHzECTBBIGDnVpLqJIY29uZGVtbiBzaW5nbGVfdGFyZ2V0IDg='); end
  end
  -- siegebreaker,if=spell_targets.whirlwind>1|raid_event.adds.in>15
  if S.Siegebreaker:IsCastable() then
    if Cast(S.Siegebreaker, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('gXstsYtDDEjBQxgZTBekPqZCirDfEPdugzcBPoRLboMQTKzwZhFZbhVc2llZ2VicmVha2VyIHNpbmdsZV90YXJnZXQgMTA='); end
  end
  -- rampage,if=buff.recklessness.up|(buff.enrage.remains<gcd|rage>80)|buff.frenzy.remains<1.5
  if S.Rampage:IsReady() and (Player:BuffUp(S.RecklessnessBuff) or (Player:BuffRemains(S.EnrageBuff) < Player:GCD() or Player:Rage() > 80) or Player:BuffRemains(S.FrenzyBuff) < 1.5) then
    if Cast(S.Rampage, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('jTHMDmmkwofeJKDWVMLHlfadZoTfKjpxhGMqaPgkLdDVkvYxABCRvGZcmFtcGFnZSBzaW5nbGVfdGFyZ2V0IDEy'); end
  end
  -- condemn
  if S.Condemn:IsReady() then
    if Cast(S.Condemn, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('QWKtsyTfngItKUCDerwmuejYVOxBYKCewKkjPeAHPPjjFWehZRqeXBqY29uZGVtbiBzaW5nbGVfdGFyZ2V0IDE0'); end
  end
  -- ancient_aftershock,if=buff.enrage.up&cooldown.recklessness.remains>5&(target.time_to_die>95|buff.recklessness.up|target.time_to_die<20)&raid_event.adds.in>75
  if CDsON() and S.AncientAftershock:IsCastable() and (EnrageUp and S.Recklessness:CooldownRemains() > 5 and (Target:TimeToDie() > 95 or Player:BuffUp(S.RecklessnessBuff) or Target:TimeToDie() < 20)) then
    if Cast(S.AncientAftershock, not Target:IsInRange(12)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('NHqQQHTMSdussClZTOEDFetJULQOElnZdbkyvgrZShWmkxkRaukeIDKYW5jaWVudF9hZnRlcnNob2NrIHNpbmdsZV90YXJnZXQgMTY='); end
  end
  -- crushing_blow,if=set_bonus.tier28_2pc|charges=2|(buff.recklessness.up&variable.execute_phase&talent.massacre.enabled)
  if S.CrushingBlow:IsCastable() and (Player:HasTier(28, 2) or S.CrushingBlow:Charges() == 2 or (Player:BuffUp(S.RecklessnessBuff) and VarExecutePhase and S.Massacre:IsAvailable())) then
    if Cast(S.CrushingBlow, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('KgooyJmDEzYIXrjxeTodZllkgjiFZOjEAyzxCQgZZHCZMUEdFfTTnyxY3J1c2hpbmdfYmxvdyBzaW5nbGVfdGFyZ2V0IDE4'); end
  end
  -- execute
  if S.Execute:IsReady() then
    if Cast(S.Execute, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('QYQTvsHsYZNApHKjqPEhJPVHscjIlPKXIWqUUzdwtazSYKLbfRVmENGZXhlY3V0ZSBzaW5nbGVfdGFyZ2V0IDIw'); end
  end
  if CDsON() then
    -- spear_of_bastion,if=runeforge.elysian_might&buff.enrage.up&cooldown.recklessness.remains>5&(buff.recklessness.up|target.time_to_die<20|debuff.siegebreaker.up|!talent.siegebreaker&target.time_to_die>68)&raid_event.adds.in>55
    if S.SpearofBastion:IsCastable() and (ElysianMightEquipped and EnrageUp and S.Recklessness:CooldownRemains() > 5 and (Player:BuffUp(S.RecklessnessBuff) or Target:TimeToDie() < 20 or Target:DebuffUp(S.SiegebreakerDebuff) or not S.Siegebreaker:IsAvailable() and Target:TimeToDie() > 68)) then
      if Cast(M.SpearofBastionPlayer, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('KzfuTeVVnWaELVveWVegbHYUEvaZbAEsMuYyrbmOQUxYsdpSyZTXAUHc3BlYXJfb2ZfYmFzdGlvbiBzaW5nbGVfdGFyZ2V0IDIy'); end
    end
    -- bladestorm,if=buff.enrage.up&(!buff.recklessness.remains|rage<50)&(spell_targets.whirlwind=1&raid_event.adds.in>45|spell_targets.whirlwind=2)
    if S.Bladestorm:IsCastable() and (EnrageUp and (Player:BuffDown(S.RecklessnessBuff) or Player:Rage() < 50) and (EnemiesCount8 == 1 or EnemiesCount8 == 2)) then
      if Cast(S.Bladestorm, not Target:IsInRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('TxslgyKXSwhphwCkOGkwriYHrmMkhzUbVDLbzWgUyhzYeKIcCZQXoGbYmxhZGVzdG9ybSBzaW5nbGVfdGFyZ2V0IDI0'); end
    end
    -- spear_of_bastion,if=buff.enrage.up&cooldown.recklessness.remains>5&(buff.recklessness.up|target.time_to_die<20|debuff.siegebreaker.up|!talent.siegebreaker&target.time_to_die>68)&raid_event.adds.in>55
    if Settings.Commons.Enabled.Covenant and S.SpearofBastion:IsCastable() and (EnrageUp and S.Recklessness:CooldownRemains() > 5 and (Player:BuffUp(S.RecklessnessBuff) or Target:TimeToDie() < 20 or Target:DebuffUp(S.SiegebreakerDebuff) or not S.Siegebreaker:IsAvailable() and Target:TimeToDie() > 68)) then
      if Cast(M.SpearofBastionPlayer, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('wUUmgJoLGvUkXNfYOVREbJIVpZszIQyiGQVQvdukorHtWgUMzStyoIQc3BlYXJfb2ZfYmFzdGlvbiBzaW5nbGVfdGFyZ2V0IDI2'); end
    end
  end
  -- raging_blow,if=set_bonus.tier28_2pc|charges=2|buff.recklessness.up&variable.execute_phase&talent.massacre.enabled
  if S.RagingBlow:IsCastable() and (Player:HasTier(28, 2) or S.RagingBlow:Charges() == 2 or Player:BuffUp(S.RecklessnessBuff) and VarExecutePhase and S.Massacre:IsAvailable()) then
    if Cast(S.RagingBlow, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('rDTpaIGUZDubEygeQKPaaeUovlkEqhnFdsoZHSRkNEYeAPBZeqqoZfGcmFnaW5nX2Jsb3cgc2luZ2xlX3RhcmdldCAyOA=='); end
  end
  -- bloodthirst,if=buff.enrage.down|conduit.vicious_contempt.rank>5&target.health.pct<35
  if S.Bloodthirst:IsCastable() and ((not EnrageUp) or S.ViciousContempt:ConduitRank() > 5 and Target:HealthPercentage() < 35) then
    if Cast(S.Bloodthirst, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('MwHbrMzmAxeLkYQPciaPjjHQattKfZeSXkfVyOhsYSukChdIROVozulYmxvb2R0aGlyc3Qgc2luZ2xlX3RhcmdldCAzMA=='); end
  end
  -- bloodbath,if=buff.enrage.down|conduit.vicious_contempt.rank>5&target.health.pct<35&!talent.cruelty.enabled
  if S.Bloodbath:IsCastable() and ((not EnrageUp) or S.ViciousContempt:ConduitRank() > 5 and Target:HealthPercentage() < 35 and not S.Cruelty:IsAvailable()) then
    if Cast(S.Bloodbath, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('gmbhtmWpxfPRIlgiKvgzqgZZuIvvNEmOpkYajrVKFJuZRxraoxHqyqxYmxvb2RiYXRoIHNpbmdsZV90YXJnZXQgMzI='); end
  end
  -- dragon_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
  if S.DragonRoar:IsCastable() and (EnrageUp) then
    if Cast(S.DragonRoar, not Target:IsInRange(12)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('xXvsRbmtUWZglOniOblOTVOpVyZuXwlsbcROAJmaLvyimJxzOKUrcsFZHJhZ29uX3JvYXIgc2luZ2xlX3RhcmdldCAzNA=='); end
  end
  -- whirlwind,if=buff.merciless_bonegrinder.up&spell_targets.whirlwind>3
  if S.Whirlwind:IsCastable() and (Player:BuffUp(S.MercilessBonegrinderBuff) and EnemiesCount8 > 3) then
    if Cast(S.Whirlwind, not Target:IsInRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('NYoNtoAVZnpLFIEFhyvHEhFpEKZSDdNmIGukADlwiiTkMEsyFwGKbXFd2hpcmx3aW5kIHNpbmdsZV90YXJnZXQgMzY='); end
  end
  -- onslaught,if=buff.enrage.up
  if S.Onslaught:IsReady() and (EnrageUp) then
    if Cast(S.Onslaught, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('EHFrvBgXbCXelpqYBkxfAMiBthufiVoZSLLHxwjGRClArLQAoIXLqpRb25zbGF1Z2h0IHNpbmdsZV90YXJnZXQgMzg='); end
  end
  -- bloodthirst
  if S.Bloodthirst:IsCastable() then
    if Cast(S.Bloodthirst, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('fnlHFNBpDrXipOnkwDLOtEzwasUsfboGLHIdWjqUXsXBXCyfcMtiEbCYmxvb2R0aGlyc3Qgc2luZ2xlX3RhcmdldCA0MA=='); end
  end
  -- bloodbath
  if S.Bloodbath:IsCastable() then
    if Cast(S.Bloodbath, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('TwyQwlqglngkOsnMqDaHbKsroOsoKdJszStWKLFBteBhSnnfoqWloFlYmxvb2RiYXRoIHNpbmdsZV90YXJnZXQgNDI='); end
  end
  -- raging_blow
  if S.RagingBlow:IsCastable() then
    if Cast(S.RagingBlow, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('NBvCQHjksxetBaycqYoLYBbGqwlWXKlJFZSTfWfefZxCjGwVGNUnmqpcmFnaW5nX2Jsb3cgc2luZ2xlX3RhcmdldCA0NA=='); end
  end
  -- crushing_blow
  if S.CrushingBlow:IsCastable() then
    if Cast(S.CrushingBlow, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('WRhGDLOarGZXKSLgBVQwcLvTHudycUqdXUDtQOGbVFrqFVoZCJwnyQmY3J1c2hpbmdfYmxvdyBzaW5nbGVfdGFyZ2V0IDQ2'); end
  end
  -- whirlwind
  if S.Whirlwind:IsCastable() then
    if Cast(S.Whirlwind, not Target:IsInRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('dUOVEYONtJKjqaVBQzcmxNgofwLwJXOUFVUoXZrFByflXhYFqeiZHoDd2hpcmx3aW5kIHNpbmdsZV90YXJnZXQgNDg='); end
  end
end

local function Movement()
  -- heroic_leap
  if Settings.Commons.Enabled.HeroicLeap and S.HeroicLeap:IsCastable() and not Target:IsInMeleeRange(8) and Mouseover and Mouseover:GUID() == Target:GUID() then
    if Cast(M.HeroicLeapCursor) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('wmpTILPPmLzhPONAviHtOfsQIooOxjusYkdpIxRJxzNHYLwPOAfDQGlaGVyb2ljX2xlYXAgbW92ZW1lbnQgMg=='); end
  end
end

local function OutOfCombat()
  -- flask
  -- food
  -- augmentation
  -- snapshot_stats
  -- Manually added: battle_shout,if=buff.battle_shout.remains<60
  if S.BattleShout:IsCastable() and (Player:BuffRemains(S.BattleShoutBuff, true) < 5) then
    if Cast(S.BattleShout) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('blGrUKLrTJdrQgBPuWqicuOHznDoyfubeZkIcGULtcoedwozeHBOPlEYmF0dGxlX3Nob3V0IHByZWNvbWJhdCAy'); end
  end
end

local function Combat()
  if AoEON() then
    Enemies8y = Player:GetEnemiesInMeleeRange(8)
    EnemiesCount8 = #Enemies8y
  else
    EnemiesCount8 = 1
  end
  
  -- Enrage check
  EnrageUp = Player:BuffUp(S.EnrageBuff)

  -- Range check
  TargetInMeleeRange = Target:IsInMeleeRange(5)

  -- Interrupts
  local ShouldReturn = Everyone.Interrupt(S.Pummel, 5, true); if ShouldReturn then return ShouldReturn; end
  local ShouldReturn = Everyone.InterruptWithStun(S.StormBolt, 5); if ShouldReturn then return ShouldReturn; end
  -- auto_attack
  -- charge
  if Settings.Commons.Enabled.Charge and S.Charge:IsCastable() then
    if Cast(S.Charge, not Target:IsSpellInRange(S.Charge)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('HCwspGNMaXbMVzoGtPobAnbFlkiaeBfurRNdtaZzupzVEQJBEeIAfhiY2hhcmdlIG1haW4gMg=='); end
  end
  -- Manually added: VR/IV
  if Player:HealthPercentage() < Settings.Commons.HP.VictoryRushHP then
    if S.VictoryRush:IsReady() then
      if Cast(S.VictoryRush, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('IEcRQlbofXBRHBlmihHDqrAsVxDmBwgxrXSTQUfJSmFDBAZMCXizTiFdmljdG9yeV9ydXNoIGhlYWw='); end
    end
    if S.ImpendingVictory:IsReady() then
      if Cast(S.ImpendingVictory, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('vgvXdGEHyigmVBXHwjBQIiHonLWwgTbgmZJonsRvTqdXcFMWbcSCQYraW1wZW5kaW5nX3ZpY3RvcnkgaGVhbA=='); end
    end
  end
  -- healthstone
  if Player:HealthPercentage() <= Settings.General.HP.Healthstone and I.Healthstone:IsReady() then
    if Cast(M.Healthstone, nil, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('ytyGGyBmufvsxpSKJnlSiTpORSGWXPeUiLDWxaGymUjbVmkJzBnMuNIaGVhbHRoc3RvbmUgZGVmZW5zaXZlIDM='); end
  end
  -- phial_of_serenity
  if Player:HealthPercentage() <= Settings.General.HP.PhialOfSerenity and I.PhialofSerenity:IsReady() then
    if Cast(M.PhialofSerenity, nil, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('ndJBVVRsGMihCqbDfGFtpWNBbPFxieAEZazKZlqGDZhRXzgsgLPsFuecGhpYWxfb2Zfc2VyZW5pdHkgZGVmZW5zaXZlIDQ='); end
  end
  -- variable,name=execute_phase,value=talent.massacre&target.health.pct<35|target.health.pct<20|target.health.pct>80&covenant.venthyr
  VarExecutePhase = (S.Massacre:IsAvailable() and Target:HealthPercentage() < 35 or Target:HealthPercentage() < 20 or Target:HealthPercentage() > 80 and CovenantID == 2)
  -- variable,name=unique_legendaries,value=runeforge.signet_of_tormented_kings|runeforge.sinful_surge|runeforge.elysian_might
  VarUniqueLegendaries = (SignetofTormentedKingsEquipped or SinfulSurgeEquipped or ElysianMightEquipped)
  -- run_action_list,name=movement,if=movement.distance>5
  if (not TargetInMeleeRange) then
    local ShouldReturn = Movement(); if ShouldReturn then return ShouldReturn; end
  end
  -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
  if Settings.Commons.Enabled.HeroicLeap and S.HeroicLeap:IsCastable() and (not Target:IsInRange(25)) and Mouseover and Mouseover:GUID() == Target:GUID() then
    if Cast(M.HeroicLeapCursor) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('FmIfmOlwledMUzVpTzRcQQQNbXAwBESLCvAGXbkbvgYkPvvfdSkrApXaGVyb2ljX2xlYXAgbWFpbiA0'); end
  end
  -- potion
  if Settings.General.Enabled.Potions and I.PotionofSpectralStrength:IsReady() and Player:BloodlustUp() then
    if Cast(M.PotionofSpectralStrength, nil, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('YrEgFKAtABakOvttATRMbKqveyxckbVbKhhvmbocmbiWGlskrlLHSZZcG90aW9uIG1haW4gNg=='); end
  end
  -- conquerors_banner,if=rage>70
  if S.ConquerorsBanner:IsCastable() and CDsON() and (Player:Rage() > 70) then
    if Cast(S.ConquerorsBanner) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('SsFaCnCtsWepuBdnaDHMhBzdEZXUoPiqamcdsUqCiuLwHyqGjRXYShBY29ucXVlcm9yc19iYW5uZXIgbWFpbiA4'); end
  end
  -- spear_of_bastion,if=buff.enrage.up&rage<70
  if CDsON() and S.SpearofBastion:IsCastable() and (EnrageUp and Player:Rage() < 70) then
    if Cast(M.SpearofBastionPlayer, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('PHXhwzTlMoSKfjuplETlfgpPOePBCFbukRzhUNaaDiKJfsZhYZCZIMCc3BlYXJfb2ZfYmFzdGlvbiBtYWluIDk='); end
  end
  -- rampage,if=cooldown.recklessness.remains<3&talent.reckless_abandon.enabled
  if S.Rampage:IsReady() and (CDsON() and S.Recklessness:CooldownRemains() < 3 and S.RecklessAbandon:IsAvailable()) then
    if Cast(S.Rampage, not TargetInMeleeRange) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('wFiUhkQXgpzLcUXlGbnegHVTecVtMHjulYuZPiJvospcxrvZnTKGacLcmFtcGFnZSBtYWluIDEw'); end
  end
  if CDsON() then
    -- recklessness,if=runeforge.sinful_surge&gcd.remains=0&(variable.execute_phase|(target.time_to_pct_35>40&talent.anger_management|target.time_to_pct_35>70&!talent.anger_management))&(spell_targets.whirlwind=1|buff.meat_cleaver.up)
    if S.Recklessness:IsCastable() and (SinfulSurgeEquipped and (VarExecutePhase or (Target:TimeToX(35) > 40 and S.AngerManagement:IsAvailable() or Target:TimeToX(35) > 70 and not S.AngerManagement:IsAvailable())) and (EnemiesCount8 == 1 or Player:BuffUp(S.MeatCleaverBuff))) then
      if Cast(S.Recklessness, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('dBNXPhmsYqclAaBAOosRgoGLhoRfzsxMcnzuRxRpLqZjrXZDLwQehjhcmVja2xlc3NuZXNzIG1haW4gMTE='); end
    end
    -- recklessness,if=runeforge.elysian_might&gcd.remains=0&(cooldown.spear_of_bastion.remains<5|cooldown.spear_of_bastion.remains>20)&((buff.bloodlust.up|talent.anger_management.enabled|raid_event.adds.in>10)|target.time_to_die>100|variable.execute_phase|target.time_to_die<15&raid_event.adds.in>10)&(spell_targets.whirlwind=1|buff.meat_cleaver.up)
    if S.Recklessness:IsCastable() and (ElysianMightEquipped and (Settings.Commons.Enabled.Covenant and S.SpearofBastion:CooldownRemains() < 5 or S.SpearofBastion:CooldownRemains() > 20) and ((Player:BloodlustUp() or S.AngerManagement:IsAvailable() or EnemiesCount8 == 1) or Target:TimeToDie() > 100 or VarExecutePhase or Target:TimeToDie() < 15) and (EnemiesCount8 == 1 or Player:BuffUp(S.MeatCleaverBuff))) then
      if Cast(S.Recklessness, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('ytzwzsLMnJMQLMPCftEmAvZOYEDwQtobddxZdfbQuvEMaycvmZcCEJVcmVja2xlc3NuZXNzIG1haW4gMTI='); end
    end
    -- recklessness,if=!variable.unique_legendaries&gcd.remains=0&((buff.bloodlust.up|talent.anger_management.enabled|raid_event.adds.in>10)|target.time_to_die>100|variable.execute_phase|target.time_to_die<15&raid_event.adds.in>10)&(spell_targets.whirlwind=1|buff.meat_cleaver.up)&(!covenant.necrolord|cooldown.conquerors_banner.remains>20)
    if S.Recklessness:IsCastable() and (not VarUniqueLegendaries and ((Player:BloodlustUp() or S.AngerManagement:IsAvailable() or EnemiesCount8 == 1) or Target:TimeToDie() > 100 or VarExecutePhase or Target:TimeToDie() < 15) and (EnemiesCount8 == 1 or Player:BuffUp(S.MeatCleaverBuff)) and (CovenantID ~= 4 or S.ConquerorsBanner:CooldownRemains() > 20)) then
      if Cast(S.Recklessness, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('MUhJhxjbRpwtvXWfuVZZKbtoxewmCXxBwSddIRmxrnQoaEQKvIaNcvScmVja2xlc3NuZXNzIG1haW4gMTM='); end
    end
    -- recklessness,use_off_gcd=1,if=runeforge.signet_of_tormented_kings.equipped&gcd.remains&prev_gcd.1.rampage&((buff.bloodlust.up|talent.anger_management.enabled|raid_event.adds.in>10)|target.time_to_die>100|variable.execute_phase|target.time_to_die<15&raid_event.adds.in>10)&(spell_targets.whirlwind=1|buff.meat_cleaver.up)
    if S.Recklessness:IsCastable() and (SignetofTormentedKingsEquipped and Player:PrevGCDP(1, S.Rampage) and ((Player:BloodlustUp() or S.AngerManagement:IsAvailable()) or Target:TimeToDie() > 100 or VarExecutePhase) and (EnemiesCount8 == 1 or Player:BuffUp(S.MeatCleaverBuff))) then
      if Cast(S.Recklessness, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('JarKpOoQLPgcBoOncshduWItrfcMmTjbzVrUmzNvFLowsQxHAHZgveMcmVja2xlc3NuZXNzIG1haW4gMTQ='); end
    end
  end
  -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up|raid_event.adds.in<gcd&!buff.meat_cleaver.up
  if S.Whirlwind:IsCastable() and (EnemiesCount8 > 1 and Player:BuffDown(S.MeatCleaverBuff)) then
    if Cast(S.Whirlwind, not Target:IsInMeleeRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('VYunjduXQZgDCorNYcDuNIGLGQoHXhPJrhnUogkXnodnjPuAZKBCvSrd2hpcmx3aW5kIG1haW4gMTY='); end
  end
  -- trinkets
  if CDsON() and Settings.General.Enabled.Trinkets and Player:BuffUp(S.RecklessnessBuff) then
    local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
    if TrinketToUse then
      if Utils.ValueIsInArray(TrinketToUse:SlotIDs(), 13) then
        if Cast(M.Trinket1, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('bgqcwufWQoBQmEpyYkhvgHMwaKFHtEWjjbiulYOAOwqnfHFpphloBMRdXNlX3RyaW5rZXQg') .. TrinketToUse:Name() .. dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('dfAEaLTrtXPFBMgLTWkxrHHzzISwhiCMNgfsqYOjDZXXUhOlHBZTRXzIGRhbWFnZSAx'); end
      elseif Utils.ValueIsInArray(TrinketToUse:SlotIDs(), 14) then
        if Cast(M.Trinket2, not TargetInMeleeRange, nil, true) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('uKPRhHMwMgOizOhCUcOPfiyhzjuQeasfqRxnxzAZdRoyCiILugOkCQodXNlX3RyaW5rZXQg') .. TrinketToUse:Name() .. dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('mJZWEmXKvejHgLzxafYAZkEzBKMxJKXhAYzHlismpeVqyJatmUxzRjxIGRhbWFnZSAy'); end
      end
    end
  end
  if CDsON() and Settings.General.Enabled.Racials then
    -- arcane_torrent,if=rage<40&!buff.recklessness.up
    if S.ArcaneTorrent:IsCastable() and (Player:Rage() < 40 and Player:BuffDown(S.RecklessnessBuff)) then
      if Cast(S.ArcaneTorrent, not Target:IsInRange(8)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('rrgTVMNQSnGfyzdTcrckAfVBMLBZYlFPSPmTQlxfxhYDWbuCBCBCATaYXJjYW5lX3RvcnJlbnQ='); end
    end
    -- lights_judgment,if=buff.recklessness.down&debuff.siegebreaker.down
    if S.LightsJudgment:IsCastable() and (Player:BuffDown(S.RecklessnessBuff) and Target:DebuffDown(S.SiegebreakerDebuff)) then
      if Cast(S.LightsJudgment, not Target:IsSpellInRange(S.LightsJudgment)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('OaHcVLHilsXfykLDbcAihDWjbBPDHSiDNFfaWDVFdQYDmHgsmwYHFOtbGlnaHRzX2p1ZGdtZW50'); end
    end
    -- bag_of_tricks,if=buff.recklessness.down&debuff.siegebreaker.down&buff.enrage.up
    if S.BagofTricks:IsCastable() and (Player:BuffDown(S.RecklessnessBuff) and Target:DebuffDown(S.SiegebreakerDebuff) and EnrageUp) then
      if Cast(S.BagofTricks, not Target:IsSpellInRange(S.BagofTricks)) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('bWuLGOJqDpHGROTOFKpEjyBPfzZWvbwAEykBFaArHlahzGEtIbTIqoHYmFnX29mX3RyaWNrcw=='); end
    end
    -- berserking,if=buff.recklessness.up
    if S.Berserking:IsCastable() and (Player:BuffUp(S.RecklessnessBuff)) then
      if Cast(S.Berserking) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('DfECHXiVfYqdJqjpRwYgcYPDTTVyEOFDmNwCnuaZxMpSrgoWMKCdfaPYmVyc2Vya2luZw=='); end
    end
    -- blood_fury
    if S.BloodFury:IsCastable() then
      if Cast(S.BloodFury) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('ouhUqqTWzCikhOtMYurOknILMUvAhbzKcpoLrBjLXfgLgyBwsTfdQgbYmxvb2RfZnVyeQ=='); end
    end
    -- fireblood
    if S.Fireblood:IsCastable() then
      if Cast(S.Fireblood) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('UJiBMHjbfuCjtqoPtJnlIMFmRNYCjDcXOqsqtMeHbZQOOlZtQSFltPqZmlyZWJsb29k'); end
    end
    -- ancestral_call
    if S.AncestralCall:IsCastable() then
      if Cast(S.AncestralCall) then return dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('DnaaSXaTcPjQqbfJRGKNVirhQrvXzRiGYYfJOUHcIGBVdKleJNdDyeEYW5jZXN0cmFsX2NhbGw='); end
    end
  end
  -- call_action_list,name=aoe
  local ShouldReturn = AOE(); if ShouldReturn then return ShouldReturn; end
  -- call_action_list,name=single_target
  local ShouldReturn = SingleTarget(); if ShouldReturn then return ShouldReturn; end
end

--- ======= ACTION LISTS =======
local function APL()
  if not Player:AffectingCombat() then
    -- call Precombat
    local ShouldReturn = OutOfCombat(); if ShouldReturn then return ShouldReturn; end
  else
    if Everyone.TargetIsValid() then
      -- In Combat
      local ShouldReturn = Combat(); if ShouldReturn then return ShouldReturn; end
    end
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
  WR.Bind(S.BattleShout)
  WR.Bind(S.Bladestorm)
  WR.Bind(S.Bloodbath)
  WR.Bind(S.Bloodthirst)
  WR.Bind(S.Charge)
  WR.Bind(S.CrushingBlow)
  WR.Bind(S.DragonRoar)
  WR.Bind(S.Execute)
  WR.Bind(S.HeroicLeap)
  WR.Bind(S.IntimidatingShout)
  WR.Bind(S.Pummel)
  WR.Bind(S.RagingBlow)
  WR.Bind(S.Rampage)
  WR.Bind(S.Recklessness)
  WR.Bind(S.Siegebreaker)
  WR.Bind(S.StormBolt)
  WR.Bind(S.VictoryRush)
  WR.Bind(S.Whirlwind)
  -- Bind Items
  WR.Bind(M.Trinket1)
  WR.Bind(M.Trinket2)
  WR.Bind(M.Healthstone)
  WR.Bind(M.PotionofSpectralStrength)
  WR.Bind(M.PhialofSerenity)
  -- Bind Macros
  WR.Bind(M.HeroicLeapCursor)
  WR.Bind(M.SpearofBastionPlayer)
  WR.Bind(M.CancelBladestorm)
end

local function Init()
  WR.Print(dafJZHZRMGqIjtLCdftIxMUaFfxwciNtEoWUDnojniRkZYrFKrqilAVoOxPrtyMJTHwcE('PEyBKHfoyCmQVQkXMiRobzALIYaHxpVteNGeCpwaZEOFZPBgqflcKLlRnVyeSBXYXJyaW9yIGJ5IFdvcmxkeQ=='))
  AutoBind()
end

WR.SetAPL(72, APL, Init)
    