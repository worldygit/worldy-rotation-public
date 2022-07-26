local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function yKDJthBhiIErrCyFghfyGoCW(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

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
local Pet        = Unit.Pet
local Spell      = HL.Spell
local Item       = HL.Item
-- WorldyRotation
local WR         = WorldyRotation
local Cast       = WR.Cast
local AoEON      = WR.AoEON
local CDsON      = WR.CDsON
local Macro      = WR.Macro
-- lua
local mathmin    = math.min
local mathfloor  = math.floor
local GetTime    = GetTime

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Define S/I/M for spell, item and macro arrays
local S = Spell.DeathKnight.Blood
local I = Item.DeathKnight.Blood
local M = Macro.DeathKnight.Blood

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
}

-- Rotation Var
local VarDeathStrikeDumpAmt
local VarDeathStrikeCost
local VarDeathsDueBuffCheck
local VarHeartStrikeRP
local VarHeartStrikeRPDRW
local VarTomestoneBoneCount
local IsTanking

local EnemiesMelee
local EnemiesMeleeCount
local Enemies10y
local EnemiesCount10y
local HeartStrikeCount
local UnitsWithoutBloodPlague
local UnitsWithoutShackleDebuff
local ghoul = HL.GhoulTable
local LastSpellCast
local LastBloodTapCast = GetTime()*1000

--Opener
local StartOfCombat

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, yKDJthBhiIErrCyFghfyGoCW('RvMlxhfJBnCKNiVhtivMAGvGVcELVLBkAtCJWdtNGhKKGiLzDolARUDQ09WRU5BTlRfQ0hPU0VO'))

-- Legendary
local CrimsonRuneWeaponEquipped = Player:HasLegendaryEquipped(35)

HL:RegisterForEvent(function()
  CrimsonRuneWeaponEquipped = Player:HasLegendaryEquipped(35)
end, yKDJthBhiIErrCyFghfyGoCW('ZvUkUHGIZWKJShdtVORsHmtSvDFaDoEHwNyLvEWhhiLgaqxbcaQDcIaUExBWUVSX0VRVUlQTUVOVF9DSEFOR0VE'))

-- GUI Settings
local Everyone = WR.Commons.Everyone
local Settings = {
  General = WR.GUISettings.General,
  Commons = WR.GUISettings.APL.DeathKnight.Commons,
  Blood = WR.GUISettings.APL.DeathKnight.Blood
}

-- Stun Interrupts List
local StunInterrupts = {
  {S.Asphyxiate, yKDJthBhiIErrCyFghfyGoCW('QWLuPRFkhFzxplzRwKcyVGYYgaVjauyeBBvVMxYNkpzphEmBTfsGmQPQ2FzdCBBc3BoeXhpYXRlIChJbnRlcnJ1cHQp'), function () return true; end},
  --Add Deathgrip?
}

--Functions
local EnemyRanges = {5, 8, 10, 30}
local TargetIsInRange = {}
local function ComputeTargetRange()
  for _, i in ipairs(EnemyRanges) do
    if i == 8 or 5 then TargetIsInRange[i] = Target:IsInMeleeRange(i) end
    TargetIsInRange[i] = Target:IsInRange(i)
  end
end

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local function UnitsWithoutBP(enemies)
  local WithoutBPCount = 0
  for _, CycleUnit in pairs(enemies) do
    if not CycleUnit:DebuffUp(S.BloodPlagueDebuff) then
      WithoutBPCount = WithoutBPCount + 1
    end
  end
  return WithoutBPCount
end

local function UnitsWithoutShackle(enemies)
  local WithoutShackleCount = 0
  for _, CycleUnit in pairs(enemies) do
    if not CycleUnit:DebuffUp(S.ShackleTheUnworthy) then
      WithoutShackleCount = WithoutShackleCount + 1
    end
  end
  return WithoutShackleCount
end

local function OutOfCombat()
  -- flask
  -- food
  -- augmentation
  -- snapshot_stats
  -- fleshcraftS
end

local function RemoveCC()
end
local function AntiMagicShellHandler()
end
local function Defense()
end
local function Interrupts()
end
local function Stun()
end
local function Healing()
  -- Rune Tap Emergency
  if S.RuneTap:IsReady() and IsTanking and Player:HealthPercentage() <= Settings.Blood.HP.RuneTapThreshold and Player:Rune() >= 3 and S.RuneTap:Charges() >= 1 and Player:BuffDown(S.RuneTapBuff) then
    if Cast(S.RuneTap, nil, nil, true) then return yKDJthBhiIErrCyFghfyGoCW('XZfuCOhlgPbKdFALJxeIvXfvWshHtZrcdFahpWxzTxKLBwaBoIefcAkcnVuZV90YXAgZGVmZW5zaXZlcyAy'); end
  end
  -- Vampiric Blood
  if S.VampiricBlood:IsCastable() and IsTanking and Player:HealthPercentage() <= Settings.Blood.HP.VampiricBloodThreshold and Player:BuffDown(S.IceboundFortitudeBuff) then
    if Cast(S.VampiricBlood, nil, nil, true) then return yKDJthBhiIErrCyFghfyGoCW('aNFGVFjRcfJluoUEfmGddFEhcGIiXznrjiMJWsNFDFzoNzqTtsIxjQfdmFtcGlyaWNfYmxvb2QgZGVmZW5zaXZlcyAxNA=='); end
  end
  -- Icebound Fortitude
  if S.IceboundFortitude:IsCastable() and IsTanking and Player:HealthPercentage() <= Settings.Blood.HP.IceboundFortitudeThreshold and Player:BuffDown(S.VampiricBloodBuff) then
    if Cast(S.IceboundFortitude, nil, nil, true) then return yKDJthBhiIErrCyFghfyGoCW('iKanKBZPXSKlcvTmoQnnfEMwJvcFebPlWnrJyEfRWgPmdCsMJqmxoWdaWNlYm91bmRfZm9ydGl0dWRlIGRlZmVuc2l2ZXMgMTY='); end
  end
  -- Healing
  if S.DeathStrike:IsReady() and Player:HealthPercentage() <= 50 + (Player:RunicPower() > 90 and 20 or 0) and not Player:HealingAbsorbed() then
    if Cast(S.DeathStrike, nil, nil, true) then return yKDJthBhiIErrCyFghfyGoCW('glLSeDIjLAjWnCRQqPZfaDAEcdmNdkwMCrFoeRDekiwCKVezhLgWNQwZGVhdGhfc3RyaWtlIGRlZmVuc2l2ZXMgMTg='); end
  end
end
local function Cooldowns()
end
local function Mitigation()
end

local function AoE()
  if Player:BuffDown(S.DeathAndDecayBuff) and S.DeathAndDecay:IsReady() and not Player:IsMoving() and (Player:BuffUp(S.CrimsonScourgeBuff) or Player:Rune() == 6) then
    if Cast(M.DeathAndDecayPlayer) then return yKDJthBhiIErrCyFghfyGoCW('rLCzCugUIXhwGHelcRtMaNUOiRrcdZuDyVMdHDewoPWTfZwFFLIOJXXZGVhdGhhbmRlYWN5IGRyd191cF9zYW9lIDE='); end
  end
  if S.BloodBoil:IsCastable() and Target:IsInMeleeRange(8) and S.BloodBoil:ChargesFractional() >= 1.1 and UnitsWithoutBloodPlague > 0 then
    if Cast(S.BloodBoil) then return yKDJthBhiIErrCyFghfyGoCW('etwWmLwApyrCXcSxJleTtqqnrpgYlOuDwhadApVBwKeoRhgNyIvnaZOYmxvb2RfYm9pbCBkcndfdXAgNg=='); end
  end
  if Player:BuffDown(S.DeathAndDecayBuff) and not Player:IsMoving() and S.DeathAndDecay:IsReady() and Player:Rune() >= 2 then
    if Cast(M.DeathAndDecayPlayer) then return yKDJthBhiIErrCyFghfyGoCW('jcyriEkiZIKVCSpMaeFwKSnGZOJytdkQfVbHnxulqoguXIDblqWjCZqZGVhdGhhbmRlYWN5IGRyd191cF9zYW9lIDE='); end
  end
  if S.ShackleTheUnworthy:IsCastable() and Player:Rune() <= 1 then
    if Cast(S.ShackleTheUnworthy) then return yKDJthBhiIErrCyFghfyGoCW('BzlxxwkLyBNrSUrKBXvvrFOFuMTMQtzKKVswMhEqqAJqyQZVDwecYYnc2hhY2tsZV90aGVfdW53b3J0aHkgRFJXX1NpbmdsZSAx'); end
  end
  if S.BloodTap:IsCastable() and not(Target:DebuffUp(S.ShackleTheUnworthy) and UnitsWithoutShackleDebuff > 0) then
    if (Player:Rune() < 1 and S.BloodTap:ChargesFractional() >= 1.1) then
      if Cast(S.BloodTap, nil, nil, true) then return yKDJthBhiIErrCyFghfyGoCW('TNYXOYsfwdZwaviAUGkNtyyjutDJRdViAQZvAZSHIZPqosxmrALfCiwQmxvb2RUYXA='); end
    end
  end
  if Player:BuffUp(S.DeathAndDecayBuff) and Player:Rune() >= 1 then
    if not (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffStack(S.BoneShieldBuff) < 2 ) then
      if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('QQtkeHvUwsPnRzWfHqLzHzrDxKzOltfXxeETNAjbyTzDHcLOWaeokPdaGVhcnRfc3RyaWtlIGRyd191cCAxNA=='); end
    end
  end
  if Player:BuffUp(S.DancingRuneWeaponBuff) and Player:Rune() >= 1 then
    if not (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffStack(S.BoneShieldBuff) < 2 or Player:BuffDown(S.DeathAndDecayBuff) and S.DeathAndDecay:IsReady()) then
      if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('gIDrdEGSWGnOqnSHFkctPsJKgBLnEJVMemEkFYuIUiYHbDpORlaAhqSaGVhcnRfc3RyaWtlIGRyd191cCAxNA=='); end
    end
  end
  if S.BloodBoil:IsCastable() and Target:IsInMeleeRange(8) and S.BloodBoil:ChargesFractional() >= 0.8 then
    if Cast(S.BloodBoil) then return yKDJthBhiIErrCyFghfyGoCW('vxPtePIKbNYDxQWrTMGDkGckDjEhGYAEMEIayacPcZSYvhSrOeQMMzzYmxvb2RfYm9pbCBkcndfdXAgNg=='); end
  end  
end
if S.DeathStrike:IsReady() and Player:RunicPower() >= 45 then
  if Cast(S.DeathStrike) then return yKDJthBhiIErrCyFghfyGoCW('kAEEMLjhYyuzIcfSszaUctXQhWAmJfEnaHAliBTfppqdmRzIztrtVUBZGVhdGhfc3RyaWtlIGRyd191cCA4'); end
end

local function StandardAoE()
  --actions.standard+=/blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
  if S.BloodBoil:IsCastable() and Target:IsInMeleeRange(10) and S.BloodBoil:TimeSinceLastCast() > 2.5 then
    if (EnemiesCount10y >= 5 and S.BloodBoil:ChargesFractional() >= 1.1)  then
      if Cast(S.BloodBoil) then return yKDJthBhiIErrCyFghfyGoCW('pUtdcFXmvVZDqoVhWtfpHGGCRRxeLIgJGfLcONqANnfNGxyggVLuesYYmxvb2RfYm9pbCBkcndfdXAgNg=='); end
    end  
  end
  if S.DeathAndDecay:IsReady() and not Player:IsMoving() and ((EnemiesMeleeCount == 3 and Player:BuffUp(S.CrimsonScourgeBuff)) or EnemiesMeleeCount >= 4) then
    if Cast(M.DeathAndDecayPlayer) then return yKDJthBhiIErrCyFghfyGoCW('qgCqKGiQYQoUpMPVskTLJeDnCLTKAAvdNOgoPDiTbRAAnKODTQaGAwBZGVhdGhhbmRlYWN5IGRyd191cF9zYW9lIDE='); end
  end
  VarHeartStrikeRPDRW = 25 + (HeartStrikeCount * 2)
  if S.HeartStrike:IsReady() and (Player:RuneTimeToX(2) < Player:GCD() or Player:Rune() > 2 or Player:RunicPowerDeficit() >= VarHeartStrikeRPDRW) then
    if not (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffStack(S.BoneShieldBuff) < 2 ) then
      if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('fWarKljdJuQOxHQikajwkENXPXwxQXlHzYxXDliJqynpnxYIoqUytXsaGVhcnRfc3RyaWtlIGRyd191cCAxNA=='); end
    end
  end
  if S.DeathAndDecay:IsReady() and not Player:IsMoving() and EnemiesMeleeCount >= 3 then
    if Cast(M.DeathAndDecayPlayer) then return yKDJthBhiIErrCyFghfyGoCW('zLBrSRgZHugzmBRrltAWJBgMxusAobvJVJjFOVPrzPydQHGHkWLCjghZGVhdGhhbmRlYWN5IGRyd191cF9zYW9lIDE='); end
  end
  --actions.standard+=/heart_strike,if=rune.time_to_4<gcd

  if S.DeathAndDecay:IsReady() and not Player:IsMoving() and Player:BuffUp(S.CrimsonScourgeBuff) then
    if Cast(M.DeathAndDecayPlayer) then return yKDJthBhiIErrCyFghfyGoCW('ZmxZHpEtqPbkJytOZWIufllthzByWPDIxQhJjCSfoJxcLfFRdOijtwuZGVhdGhhbmRlYWN5IGRyd191cF9zYW9lIDE='); end
  end
  if S.BloodBoil:IsCastable() and Player:BuffRemains(S.DancingRuneWeaponBuff) > 3 and Target:IsInMeleeRange(10) and S.BloodBoil:TimeSinceLastCast() > 2.5 and S.BloodBoil:ChargesFractional() >= 1.1  then
    if Cast(S.BloodBoil) then return yKDJthBhiIErrCyFghfyGoCW('CmmlemfpMuSVJWTxWyEbiHkLsrYvNEWzNPFymxGvCcwHLIhkJpSbiWOYmxvb2RfYm9pbCBkcndfdXAgNg=='); end
  end  
  if S.HeartStrike:IsReady() and (Player:Rune() > 1 and (Player:RuneTimeToX(3) < Player:GCD() or Player:BuffStack(S.BoneShieldBuff) > 7)) then
    if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('ItyPeZkBVsHcgBvcKCYurooboqyyqCYVkrNirmiJFmTdGyyxmISCxJSaGVhcnRfc3RyaWtlIHN0YW5kYXJkIDI4'); end
  end
  if S.DeathStrike:IsReady() and Player:RunicPower() >= 45 then
    if Cast(S.DeathStrike) then return yKDJthBhiIErrCyFghfyGoCW('jJBSHbdUXDXhaJbRtNJoGoxfwqnIWVuXXCSQqUnqXTGrnommZLYlqYPZGVhdGhfc3RyaWtlIGRyd191cCA4'); end
  end
  return yKDJthBhiIErrCyFghfyGoCW('qpdSvUpqiOSEZyKUgJwqiUqIwcogaqOQOshxvtZmiGvokigTDHLUnhKRW5kIG9mIFN0YW5kYXJkIEFPRQ==') 
end

local function DRWUpSingle()
  if S.DancingRuneWeapon:CooldownRemains() > Player:BuffRemains(S.DancingRuneWeaponBuff) and Player:BuffRemains(S.DancingRuneWeaponBuff) < 3 and not (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffStack(S.BoneShieldBuff) < 2 ) then
    if (S.BloodTap:IsCastable() or S.ShackleTheUnworthy:IsCastable()) and Player:Rune() >= 1 then
      if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('ExXLfhnEHwYFdHwSZQzoiypVJvVSRxzulnoPMSOPkkJkLVCExXGkwERaGVhcnRfc3RyaWtlIGRyd191cCAxNA=='); end
    end
    if S.ShackleTheUnworthy:IsCastable() and Player:Rune() <= 2 then
      if Cast(S.ShackleTheUnworthy) then return yKDJthBhiIErrCyFghfyGoCW('QnMPgAWDqnZPoyzLPAvXCEPulAlflwHRkCGtXfKaqTMnoUQFYrDQppac2hhY2tsZV90aGVfdW53b3J0aHkgRFJXX1NpbmdsZSAx'); end
    end
  end 
  if S.BloodBoil:IsCastable() and Player:BuffRemains(S.DancingRuneWeaponBuff) > 3 and Target:IsInMeleeRange(10) and S.BloodBoil:TimeSinceLastCast() > 2.5 and ((S.BloodBoil:Charges() >= 2 and Player:Rune() <= 1) or (Target:DebuffRemains(S.BloodPlagueDebuff) <= 2 and S.BloodBoil:Charges() >= 1) or (EnemiesCount10y > 5 and S.BloodBoil:ChargesFractional() >= 1.1))  then
    if Cast(S.BloodBoil) then 
      LastSpellCast =  S.BloodBoil:Name()
      return yKDJthBhiIErrCyFghfyGoCW('YFjMXyfUElGgsJMHLoTLzKHGnWDLMQeYcqSCBKugbKrRHIXsrhAIvwPYmxvb2RfYm9pbCBkcndfdXAgNg==')
    end
  end    
  VarHeartStrikeRPDRW = 25 + (HeartStrikeCount * 2)
  if S.HeartStrike:IsReady() and Player:RuneTimeToX(3) < Player:GCD() or Player:RunicPowerDeficit() >= VarHeartStrikeRPDRW then
    if Cast(S.HeartStrike) then 
      LastSpellCast =  S.HeartStrike:Name() 
      return yKDJthBhiIErrCyFghfyGoCW('PdCptEJPkvPHrVmyPSJfLHFzBrPqJgkPcCqwXcZrvjIDynfQnrOcWnEaGVhcnRfc3RyaWtlIGRyd191cCAxNA==')
    end
  end
  if S.DeathStrike:IsReady() and Player:RunicPowerDeficit() <= VarHeartStrikeRPDRW then
    if Cast(S.DeathStrike) then
      LastSpellCast =  S.DeathStrike:Name() 
      return yKDJthBhiIErrCyFghfyGoCW('iDkYSfrzElkCPxRgsAJmhIdjIDVLmMQceCVKVsFjEKFubxYkoSKLZMOZGVhdGhfc3RyaWtlIGRyd191cCA4')
    end
  end
  --actions.drw_up+=/heart_strike,if=rune.time_to_2<gcd|runic_power.deficit>=variable.heart_strike_rp_drw
  if S.HeartStrike:IsReady() and Player:RuneTimeToX(2) < Player:GCD() or Player:RunicPowerDeficit() >= VarHeartStrikeRPDRW then
    if Cast(S.HeartStrike) then 
      LastSpellCast =  S.HeartStrike:Name() 
      return yKDJthBhiIErrCyFghfyGoCW('RedOoCezEQzPQQJavwOFuysccXySnoiIMLDsIGBScsoTcEwcDDqeWwPaGVhcnRfc3RyaWtlIGRyd191cCAxNA==')
    end
  end
  return yKDJthBhiIErrCyFghfyGoCW('OIyfCqQhxYzkppqkRIkMMcvhOgvfvRdFLXzHkpmEBSoEaBKQcwnQVAIZW5kIG9mIFNpbmdsZQ==')
end

local function StandardSingle()
  if S.DeathStrike:IsReady() and Player:RunicPowerDeficit() <= VarDeathStrikeDumpAmt  then
    if Cast(S.DeathStrike) then return yKDJthBhiIErrCyFghfyGoCW('xOVmVzClrkQLgUgmRpHtDtpymmlIkNHgLCoPmMGzToLjiEWCeslwyHZZGVhdGhfc3RyaWtlIGRyd191cCA4'); end
  end
  if (CovenantID == 3 and Player:BuffUp(S.DeathAndDecayBuff)) then
    VarHeartStrikeRP = (15 + EnemiesMeleeCount * num(S.Heartbreaker:IsAvailable()) * 2)
  else
    VarHeartStrikeRP = (15 + EnemiesMeleeCount * num(S.Heartbreaker:IsAvailable()) * 2) * 1.2
  end
  --Todo: Should dump RP if we are below 4 runes and DRW cooldown remains less then 2-3 GCDs
  if S.DeathStrike:IsReady() and ((Player:RunicPowerDeficit() <= VarHeartStrikeRP) or Target:TimeToDie() < 10) then
    if Cast(S.DeathStrike) then return yKDJthBhiIErrCyFghfyGoCW('QaSjquGLDSGijYmkwXVWKyscNClgYgrdrDHyIJImAxgzBVfYPUCFVyCZGVhdGhfc3RyaWtlIHN0YW5kYXJkIDE2'); end
  end
  if S.HeartStrike:IsReady() and (Player:RuneTimeToX(4) < Player:GCD()) then
    if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('UUCIRWvzKsIazLULoHDPHAvPptPeYMWqohOEmcoIrSOkAxsxbkaeLLcaGVhcnRfc3RyaWtlIHN0YW5kYXJkIDIw'); end
  end
  if S.DeathAndDecay:IsReady() and not Player:IsMoving() and Player:BuffUp(S.CrimsonScourgeBuff) and EnemiesMeleeCount > 0 then
    if Cast(M.DeathAndDecayPlayer) then return yKDJthBhiIErrCyFghfyGoCW('jGRKxHvCBHZoMAadRykBBnSLKFeocMgqPhPmIalkaPqqBSlZHyDpOgUZGVhdGhfYW5kX2RlY2F5IHN0YW5kYXJkIDIy'); end
  end
  -- blood_boil,if=charges_fractional>=1.1
  if S.BloodBoil:IsCastable() and Target:IsInMeleeRange(10) and (S.BloodBoil:ChargesFractional() >= 1.1) then
    if Cast(S.BloodBoil) then return yKDJthBhiIErrCyFghfyGoCW('HoRfgNiBSssCzlMOhjPOdUjkTBquyUVzDaVynqZTyQPgMXJacbPSUUPYmxvb2RfYm9pbCBzdGFuZGFyZCAyNg=='); end
  end
  -- heart_strike,if=(rune>1&(rune.time_to_3<gcd|buff.bone_shield.stack>7))
  if S.HeartStrike:IsReady() and (Player:Rune() > 1 and (Player:RuneTimeToX(3) < Player:GCD() or Player:BuffStack(S.BoneShieldBuff) > 7)) then
    if Cast(S.HeartStrike) then return yKDJthBhiIErrCyFghfyGoCW('MvWYKgXnTshJgAzPwZZxqfFdtOodHlZtjwJkBCLeHFzHEITOREwAZtuaGVhcnRfc3RyaWtlIHN0YW5kYXJkIDI4'); end
  end 
end


--- ======= ACTION LISTS =======
local function APL()
  -- Get Enemies Count
  Enemies10y          = Player:GetEnemiesInRange(10)
  if AoEON() then
    EnemiesMelee      = Player:GetEnemiesInMeleeRange(8)
    EnemiesMeleeCount = #EnemiesMelee
    EnemiesCount10y   = #Enemies10y
  else
    EnemiesMeleeCount = 1
    EnemiesCount10y   = 1
  end

  -- HeartStrike is limited to 5 targets maximum
  HeartStrikeCount = mathmin(EnemiesMeleeCount, Player:BuffUp(S.DeathAndDecayBuff) and 5 or 2)
  
  -- Check Units without Blood Plague
  UnitsWithoutBloodPlague = UnitsWithoutBP(Enemies10y)
  UnitsWithoutShackleDebuff =  UnitsWithoutShackle(Enemies10y)

  -- Are we actively tanking?
  IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)
  --if nf then 
  VarDeathStrikeDumpAmt = (CovenantID == 3) and 55 or 70
  --VarDeathStrikeCost    = (Player:BuffUp(Ossuary)) and 40 or 45

  if Player:AffectingCombat() then
    if Target:IsInMeleeRange(8) then
      if S.BloodBoil:IsCastable() and S.BloodBoil:TimeSinceLastCast() > 2.5 and not Player:BuffUp(S.DancingRuneWeaponBuff) and not Player:BuffUp(S.DeathAndDecayBuff) then
        if (EnemiesCount10y >= 5 and S.BloodBoil:ChargesFractional() >= 1.8)  then
          if Cast(S.BloodBoil) then return yKDJthBhiIErrCyFghfyGoCW('tGmbzTtBTCckkGtPzsQxBEKbXgaILnrKEAXlyhxctMzruxfOenQrXjWYmxvb2RfYm9pbCBkcndfdXAgNg=='); end
        end  
      end
      if S.RaiseDead:IsCastable() then
        if Cast(S.RaiseDead) then
          LastSpellCast =  S.RaiseDead:Name()
          return yKDJthBhiIErrCyFghfyGoCW('lJDzxVPvZNIpCzIdJQNAeVyeOyMLrNTYIUPBnTJUyEbRiSnxKnFkidhcmFpc2VfZGVhZCBvcGVuZXIgMQ=='); 
        end
      end
      if S.SacrificialPact:IsReady() and ghoul.active() and Player:BuffRemains(S.DancingRuneWeaponBuff) > 4 and ghoul.remains() < 2 then
        if Cast(S.SacrificialPact) then 
          LastSpellCast =  S.SacrificialPact:Name()
          return yKDJthBhiIErrCyFghfyGoCW('kLdmrYpvZFmuXNcYruMOQwgsShTHsUMhaKBmBxajntFLnZNllWeaOyvc2FjcmlmaWNpYWxfcGFjdCBvcGVuZXIgMQ=='); 
        end
      end
      if CDsON() and S.DancingRuneWeapon:IsCastable() and Player:BuffDown(S.DancingRuneWeaponBuff) and S.DancingRuneWeapon:CooldownUp() then
        if Cast(S.DancingRuneWeapon, nil, nil, true) then 
          LastSpellCast =  S.DancingRuneWeapon:Name()
          return yKDJthBhiIErrCyFghfyGoCW('JtdVLPjQhRYkhiVcLPdmLWXqcnbVyBenzchlmWJiNRvnPsyoJDLuMDfZGFuY2luZ19ydW5lX3dlYXBvbiBvcGVuZXIgMg==')
        end
      end
      if S.DancingRuneWeapon:CooldownRemains() > 15 and S.Tombstone:IsReady() and Player:BuffStack(S.BoneShieldBuff) >= 5 then
        if Cast(S.Tombstone) then return yKDJthBhiIErrCyFghfyGoCW('eFHheaTtIOusDiGJUMcrIdVedHBrXjWUVgBXzrwmlLpeQUpnoKAlPrEdG9tYnN0b25lIERSVyBVcCAx'); end
      end
      if S.Marrowrend:IsReady() and (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffStack(S.BoneShieldBuff) < 2 ) then
        if Cast(S.Marrowrend) then return yKDJthBhiIErrCyFghfyGoCW('RCrMxtMkRfZRsutCVGvevsugqKeJKrSuuBbDIWtvnKZynxaWzGGCyxpbWFycm93cmVuZCBvcGVuZXIgNA=='); end
      end
      
      --actions+=/blood_tap,if=(rune<=2&rune.time_to_4>gcd&charges_fractional>=1.8)|rune.time_to_3>gcd
      -- Todo: We should not cast BloodTap if we have Shackle off CD or if target has debuff and there are units without debuff around.
      if S.BloodTap:IsCastable() and not S.ShackleTheUnworthy:IsCastable() and not (Target:DebuffUp(S.ShackleTheUnworthy) and UnitsWithoutShackleDebuff > 0) then
        if (Player:Rune() < 1 and S.BloodTap:ChargesFractional() >= 1.8) or Player:RuneTimeToX(2) > Player:GCD() then
          if Cast(S.BloodTap, nil, nil, true) then 
            return yKDJthBhiIErrCyFghfyGoCW('lnNFTIzPcvZsIACgWrnCuoRhHmRCEtRacoVfTlirvpuqikfKWfWUALDQmxvb2RUYXA=')
          end
        end
      end
      --local ShouldReturn = RemoveCC(); if ShouldReturn then return ShouldReturn; end
      --local ShouldReturn = AntiMagicShellHandler(); if ShouldReturn then return ShouldReturn; end
      --local ShouldReturn = Mitigation(); if ShouldReturn then return ShouldReturn; end
      --local ShouldReturn = Interrupts(); if ShouldReturn then return ShouldReturn; end
      -- Interrupt
      --local ShouldReturn = Everyone.Interrupt(S.MindFreeze, 5, true); if ShouldReturn then return ShouldReturn; end
      --local ShouldReturn = Everyone.InterruptWithStun(S.Asphyxiate, 5); if ShouldReturn then return ShouldReturn; end
      --local ShouldReturn = Stun(); if ShouldReturn then return ShouldReturn; end
      local ShouldReturn = Healing(); if ShouldReturn then return ShouldReturn; end
      if Player:BuffUp(S.DancingRuneWeaponBuff) then
        if S.Marrowrend:IsReady() and (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffStack(S.BoneShieldBuff) < 2 ) then
          if Cast(S.Marrowrend) then 
            LastSpellCast =  S.Marrowrend:Name()
            return yKDJthBhiIErrCyFghfyGoCW('ZvmiHseDDOrwGNVHHefBHVacWoQtNEXbDJQJgmKlHxrjpnFIkzNKTPwbWFycm93cmVuZCBEUlcgVXAgMg=='); 
          end
        end
         
        if EnemiesCount10y <= 2 then
          --actions.covenants+=/shackle_the_unworthy,if=rune<3&runic_power<100
          if CDsON() and S.ShackleTheUnworthy:IsCastable() and Player:RuneTimeToX(3) > Player:GCD() and Player:RunicPower() < 100 then
            if Cast(S.ShackleTheUnworthy) then return yKDJthBhiIErrCyFghfyGoCW('acNYcSIwiRutRRCfiTbtACXaliXafcYbLHsSYlrvnVVyoJXsNFWzBTec2hhY2tsZV90aGVfdW53b3J0aHkgRFJXX1NpbmdsZSAx'); end
          end
          return DRWUpSingle()
        end
        if EnemiesCount10y >= 3 then
          return AoE()
        end    
      end
      --Standard DRW down
      if S.Marrowrend:IsReady() and (Player:BuffRemains(S.BoneShieldBuff) <= Player:RuneTimeToX(3) or Player:BuffRemains(S.BoneShieldBuff) <= Player:GCD()) or Player:BuffStack(S.BoneShieldBuff) < 6 or (Player:BuffStack(S.BoneShieldBuff) < 7 and Player:RunicPowerDeficit() > 20 and not (S.DancingRuneWeapon:CooldownRemains() < Player:BuffRemains(S.BoneShieldBuff))) then
        if Cast(S.Marrowrend) then return yKDJthBhiIErrCyFghfyGoCW('CobWXtUiavsGHWYGnfZJksyZWKyUjjaVaghqfUAGZiCFYJZkSVhEhXwbWFycm93cmVuZCBEUlcgVXAgMg=='); end
      end
      if EnemiesCount10y <= 2 then
        if CDsON() and S.ShackleTheUnworthy:IsCastable() and Player:RuneTimeToX(3) > Player:GCD() and Player:RunicPower() < 100 then
          if Cast(S.ShackleTheUnworthy) then return yKDJthBhiIErrCyFghfyGoCW('cOUsFyocEmQPRDNsatQOHqSUHpSDUxHInVqZRXBdbBbfNMcfJRUmawqc2hhY2tsZV90aGVfdW53b3J0aHkgRFJXX1NpbmdsZSAx'); end
        end
        return StandardSingle()
      end
      if EnemiesCount10y >= 3 then  
        return AoE()
      end
    end
  end
  -- OutOfCombat
  if not Player:AffectingCombat() then    
    local ShouldReturn = OutOfCombat(); if ShouldReturn then return ShouldReturn; end
  end
end

local function AutoBind()
  -- Bind Spells
  WR.Bind(S.Asphyxiate)
  WR.Bind(S.BloodBoil)
  WR.Bind(S.DancingRuneWeapon)
  WR.Bind(S.DeathsCaress)
  WR.Bind(S.HeartStrike)
  WR.Bind(S.IceboundFortitude)
  WR.Bind(S.Marrowrend)
  WR.Bind(S.RuneTap)
  WR.Bind(S.VampiricBlood)
  WR.Bind(S.DeathAndDecay)
  WR.Bind(S.DeathStrike)
  WR.Bind(S.RaiseDead)
  WR.Bind(S.SacrificialPact)
  -- Covenant Abilities
  WR.Bind(S.AbominationLimb)
  WR.Bind(S.DeathsDue)
  WR.Bind(S.Fleshcraft)
  WR.Bind(S.ShackleTheUnworthy)
  WR.Bind(S.SwarmingMist)
  
  -- Talents
  WR.Bind(S.Blooddrinker)
  WR.Bind(S.BloodTap)
  WR.Bind(S.Bonestorm)
  WR.Bind(S.Consumption)
  WR.Bind(S.Tombstone)
  
  
  
  -- Bind Items
  WR.Bind(M.Trinket1)
  WR.Bind(M.Trinket2)
  WR.Bind(M.Healthstone)
  WR.Bind(M.PhialofSerenity)
  WR.Bind(M.PotionofSpectralStrength)
  
  -- Bind Macros
  WR.Bind(M.DeathAndDecayPlayer)
end

local function Init()
  WR.Print(yKDJthBhiIErrCyFghfyGoCW('kGergqDOqOlXVntEkjazgMJJOHKmmwAibhfpKwSyVzFnGZBObgPULaLQmxvb2QgRGVhdGhLbmlnaHQgYnkgR2FiYno='))
  AutoBind()
end

WR.SetAPL(250, APL, Init)
    