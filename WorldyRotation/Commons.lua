local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function RtVjBnbqDftybPt(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
  -- Addon
  local addonName, WR = ...;
  -- HeroLib
  local HL = HeroLib;
  local Cache, Utils = HeroCache, HL.Utils;
  local Unit = HL.Unit;
  local Player = Unit.Player;
  local Target = Unit.Target;
  local Mouseover = Unit.MouseOver;
  local Party = Unit.Party;
  local Raid = Unit.Raid;
  local Spell = HL.Spell;
  local Item = HL.Item;
  -- Lua
  local pairs = pairs;
  local stringformat = string.format
  local tableinsert = table.insert;
  -- File Locals
  WR.Commons = {};
  local Commons = {};
  WR.Commons.Everyone = Commons;
  local Settings = WR.GUISettings.General;
  local AbilitySettings = WR.GUISettings.Abilities;

--- ============================ CONTENT ============================
-- Is the current target valid?
function Commons.TargetIsValid()
  return Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost();
end

-- Is the current target a valid npc healable unit?
do
  local HealableNpcIDs = {
    182822,
    184493,
  };
  function Commons.TargetIsValidHealableNpc()
    return Target:Exists() and not Player:CanAttack(Target) and not Target:IsDeadOrGhost() and Utils.ValueIsInArray(HealableNpcIDs, Target:NPCID());
  end
end

-- Is the current unit valid during cycle?
function Commons.UnitIsCycleValid(Unit, BestUnitTTD, TimeToDieOffset)
  return not Unit:IsFacingBlacklisted() and not Unit:IsUserCycleBlacklisted() and (not BestUnitTTD or Unit:FilteredTimeToDie(RtVjBnbqDftybPt('xCDGiggOGnxNZOFgPgfZVHcdfgOwYquPLcBwCDSyFmoKaXdZnZBRYwrPg=='), BestUnitTTD, TimeToDieOffset));
end

-- Is it worth to DoT the unit?
function Commons.CanDoTUnit(Unit, HealthThreshold)
  return Unit:Health() >= HealthThreshold or Unit:IsDummy();
end

-- Interrupt
do
  local InterruptWhitelistIDs = { 332329, 332671, 331927, 340026, 332666, 332706, 332612, 332084, 321764, 320008, 332608, 328729, 323064, 332605,
                                  325523, 325700, 325701, 323552, 323538, 326021, 322486, 322938, 324914, 324776, 326046, 340544, 337235, 337251,
                                  337253, 322450, 322527, 321828, 335143, 334748, 320462, 324293, 320170, 338353, 323190, 327130, 322493, 328400,
                                  318949, 330403, 336451, 328429, 319070, 328180, 321999, 328094, 328016, 328338, 324609, 335305, 319654, 322433,
                                  321038, 334653, 335305, 336277, 326952, 326836, 327413, 317936, 317963, 328295, 328137, 328331, 341902, 341969,
                                  342139, 330562, 330810, 330868, 341771, 330532, 330875, 319669, 324589, 342675, 330586, 358967, 337220, 337235,
                                  337253, 337255, 337251, 337249, 355225, 352347, 356843, 357284, 357260, 351119, 355934, 356031, 356407, 353835,
                                  350922, 350922, 347775, 225573, 196870, 195046, 196027, 200631, 202658, 202181, 360259, 364030 };
  local StunWhitelistIDs = { 326450, 328177, 321935, 336451, 328651, 328400, 322169, 333540, 330586, 357260,
                             332181, 325701, 325700, 324609, 338022, 334747, 320822, 321807, 322569, 331743,
                             324987, 325021, 320512, 328429, 355934, 356031, 356407, 355640, 347775, 353835,
                             350922, 350922, 355132, 357284, 196064, 201139, 200105, 200291, 212784, 225562,
                             183526, 193803, 202658, 200105, 218532, 196799, 365008 };
  function Commons.Interrupt(Spell, Range, OffGCD, Unit, Macro)
    if not Unit then
      Unit = Target;
    end
    if Settings.Enabled.Interrupt and Unit:IsInterruptible() and (Unit:CastPercentage() >= Settings.Threshold.Interrupt or Unit:IsChanneling()) and (not Settings.Enabled.InterruptOnlyWhitelist or Utils.ValueIsInArray(InterruptWhitelistIDs, Unit:CastSpellID()) or Utils.ValueIsInArray(InterruptWhitelistIDs, Unit:ChannelSpellID())) then
      if Spell:IsCastable() then
        if Macro then
          if WR.Cast(Macro, not Unit:IsInRange(Range), nil, OffGCD) then return RtVjBnbqDftybPt('ecCHSbwLDPsESnLtIuOSAykmNCNCLGqfGbtbHPpJxcUgBNXNUnzWKGUQ2FzdCA=') .. Spell:Name() .. RtVjBnbqDftybPt('KGriiTwqhIGCEoQRvCFrsEtFFMtgsUOjQPzxNhVeSNmuydAqXTgrGcNIChJbnRlcnJ1cHQp'); end
        else
          if WR.Cast(Spell, not Unit:IsInRange(Range), nil, OffGCD) then return RtVjBnbqDftybPt('RjwYPtZvBECnbXqPIPAEPrhkZQfUyRKxSOfmEIgbJTSJPpVvwhnicyHQ2FzdCA=') .. Spell:Name() .. RtVjBnbqDftybPt('lMFFwTMNcshYoLFjaVfGBUBKrvOMOaMflFUoUfNUHcClHSyaGjzoBdCIChJbnRlcnJ1cHQp'); end
        end
      end
    end
  end
  function Commons.InterruptWithStun(Spell, Range, OffGCD, Unit, Macro)
    if not Unit then
      Unit = Target;
    end
    if Settings.Enabled.InterruptWithStun and (Unit:CastPercentage() >= Settings.Threshold.Interrupt or Unit:IsChanneling()) then
      if (Settings.Enabled.InterruptOnlyWhitelist and (Utils.ValueIsInArray(StunWhitelistIDs, Unit:CastSpellID()) or Utils.ValueIsInArray(StunWhitelistIDs, Unit:ChannelSpellID()))) or (not Settings.Enabled.InterruptOnlyWhitelist and Unit:CanBeStunned()) then
        if Spell:IsCastable() then
          if Macro then
            if WR.Cast(Macro, not Unit:IsInRange(Range), nil, OffGCD) then return RtVjBnbqDftybPt('EWPprxweYQUZeuSyadhfxmpRZsOTVJzyqHeMIKCTXeYIRQVMWQvlPwPQ2FzdCA=') .. Spell:Name() .. RtVjBnbqDftybPt('ogixelauhaTLQricPWLmHPZpLlstKAMpSoyAeoqBIeIqAyVVyVsKANUIChJbnRlcnJ1cHQgV2l0aCBTdHVuKQ=='); end
          else
            if WR.Cast(Spell, not Unit:IsInRange(Range), nil, OffGCD) then return RtVjBnbqDftybPt('ilPNlDwKULRVkjicmDGwnUeOlBQZzPpBRnnSXneZAACZixuHvIqlQhJQ2FzdCA=') .. Spell:Name() .. RtVjBnbqDftybPt('pPSjxQCOFXstATRSGiFkRNrHqJwGCJDRwIofXWMhdaJGmvTVvEutZGcIChJbnRlcnJ1cHQgV2l0aCBTdHVuKQ=='); end
          end
        end
      end
    end
  end
end

-- CC
do
  local CrowdControlUnitIDs = { 171887 };
  function Commons.CrowdControl(Spell, Range, OffGCD, Unit, Macro)
    if not Unit then
      Unit = Target;
    end
    if Settings.Enabled.CrowdControl and Utils.ValueIsInArray(CrowdControlUnitIDs, Unit:NPCID()) and Unit:IsMoving() then
      if Spell:IsCastable() then
        if Macro then
          if WR.Cast(Macro, not Unit:IsInRange(Range), nil, OffGCD) then return RtVjBnbqDftybPt('eGdikOirZEknWsZpDnLLvHpBofZLaSJqgOPlImPvuhBHBNbxPIQBgoPQ2FzdCA=') .. Spell:Name() .. RtVjBnbqDftybPt('ATPdnDizWRcMMHILknrZxYEmLBYDYvjwMbkRrSpvetFaNZcvKTayEXUIChDcm93ZCBDb250cm9sKQ=='); end
        else
          if WR.Cast(Spell, not Unit:IsInRange(Range), nil, OffGCD) then return RtVjBnbqDftybPt('MOARTsNZjOPKhDfjgfEftrbakdAOVLajtwDZoEaclUrJNpWIEHGSRjlQ2FzdCA=') .. Spell:Name() .. RtVjBnbqDftybPt('RGTsXIezLBaXFNkoIXyyUzRJMrPOULxQIJlKmiqdPEYnRjAidGcpIciIChDcm93ZCBDb250cm9sKQ=='); end
        end
      end
    end
  end
end

-- Mitigate
do
  local MitigateIDs = { 320655, 324394, 338456, 320696, 334488, 338636, 320771, 322557, 340289, 340208,
                        340300, 317943, 320966, 323744, 324608, 322736, 320144, 332239, 332181, 336005,
                        330713, 329774, 325382, 334929, 341623, 341625, 350828, 350422, 352650, 353969,
                        353603, 352663, 352649, 352651, 352652, 340016, 327646, 327882, 324527, 325552,
                        321178, 319650, 322429, 334326, 335308, 321249, 325254, 326718, 337178, 320069,
                        330565, 331316, 331288, 333845, 320644, 330697, 332836, 323515, 324079, 342425,
                        332619, 328857, 346681, 346762, 346705, 346685, 353605, 348953, 356923, 351603,
                        350916, 355477, 348128, 352796, 355889, 355048, 346116, 357281, 351591, 351589,
                        197418, 197429, 198245, 214003, 198635, 209036, 194611, 16856,  198496, 204611,
                        360414, 360284, 359960, 359976, 359981, 362801, 364447, 355429, 321141, 350916,
                        366297, 225732, 196587, 195172, 204611, 193607, 191941, 191524, 188169, 200732,
                        359975, 365272, 361689, 363681, 363018, 368027, 362801, 365681, 338357, 359720,
                        362405, 362771, 361312, 359868, 363893 };
  function Commons.ShouldMitigate()
    return Utils.ValueIsInArray(MitigateIDs, Target:CastSpellID()) or Utils.ValueIsInArray(MitigateIDs, Target:ChannelSpellID());
  end
end

-- Dispel Buffs
do
  Commons.DispellableEnrageBuffIDs = {};
  function Commons.UnitHasEnrageBuff(U)
    for i = 1, #Commons.DispellableEnrageBuffIDs do
      if U:BuffUp(Commons.DispellableEnrageBuffIDs[i], true) then
        return true;
      end
    end
    return false;
  end

  Commons.DispellableMagicBuffIDs = {};
  function Commons.UnitHasMagicBuff(U)
    for i = 1, #Commons.DispellableMagicBuffIDs do
      if U:BuffUp(Commons.DispellableMagicBuffIDs[i], true) then
        return true;
      end
    end
    return false;
  end
end

-- Dispel Debuffs
do
  Commons.DispellableMagicDebuffIDs = {};
  function Commons.UnitHasMagicDebuff(U)
    for i = 1, #Commons.DispellableMagicDebuffIDs do
      if U:DebuffUp(Commons.DispellableMagicDebuffIDs[i], true) then
        return true;
      end
    end
    return false;
  end

  Commons.DispellableDiseaseDebuffIDs = {};
  function Commons.UnitHasDiseaseDebuff(U)
    for i = 1, #Commons.DispellableDiseaseDebuffIDs do
      if U:DebuffUp(Commons.DispellableDiseaseDebuffIDs[i], true) then
        return true;
      end
    end
    return false;
  end

  Commons.DispellableCurseDebuffIDs = {};
  function Commons.UnitHasCurseDebuff(U)
    for i = 1, #Commons.DispellableCurseDebuffIDs do
      if U:DebuffUp(Commons.DispellableCurseDebuffIDs[i], true) then
        return true;
      end
    end
    return false;
  end
end

-- Is in Solo Mode?
function Commons.IsSoloMode()
  return not Player:IsInRaid() and not Player:IsInParty();
end

-- Get friendly units.
do
  local PartyUnits = {};
  local RaidUnits = {};
  function Commons.FriendlyUnits()
    if #PartyUnits == 0 then
      tableinsert(PartyUnits, Player);
      for i = 1, 4 do
        local PartyUnitKey = stringformat(RtVjBnbqDftybPt('fpjMKUpQeWvUxEUCfoMagbipHXlAKHocsIkOEUFfteUswoTIvXEKGdFcGFydHklZA=='), i);
        tableinsert(PartyUnits, Party[PartyUnitKey]);
      end
    end
    if #RaidUnits == 0 then
      for i = 1, 40 do
        local RaidUnitKey = stringformat(RtVjBnbqDftybPt('vzolLdFsNNNmUpdSnPFPTMDNPQGhFWIppPFAGxxYfVjKtSkVwokRkuAcmFpZCVk'), i);
        tableinsert(RaidUnits, Raid[RaidUnitKey]);
      end
    end
    if Commons.IsSoloMode() then
      return {Player};
    elseif Player:IsInParty() and not Player:IsInRaid() then
      return PartyUnits;
    elseif Player:IsInRaid() then
      return RaidUnits;
    end
    return {};
  end
end

-- Get dispellable friendly units.
function Commons.DispellableFriendlyUnits(DispellableDebuffs)
  local FriendlyUnits = Commons.FriendlyUnits();
  local DispellableUnits = {};
  for i = 1, #FriendlyUnits do
    local DispellableUnit = FriendlyUnits[i];
    for j = 1, #DispellableDebuffs do
      if DispellableUnit:DebuffUp(DispellableDebuffs[j], true) then
        tableinsert(DispellableUnits, DispellableUnit);
      end
    end
  end
  return DispellableUnits;
end
function Commons.DispellableFriendlyUnit(DispellableDebuffs)
  local DispellableFriendlyUnits = Commons.DispellableFriendlyUnits(DispellableDebuffs);
  local DispellableFriendlyUnitsCount = #DispellableFriendlyUnits;
  if DispellableFriendlyUnitsCount > 0 then
    for i = 1, DispellableFriendlyUnitsCount do
      local DispellableFriendlyUnit = DispellableFriendlyUnits[i];
      if not Commons.UnitGroupRole(DispellableFriendlyUnit) == RtVjBnbqDftybPt('HuBKwyQBhbSXpQZEbPRjoFCJSycWhsLRivuZXBMyIdXbnLyhfdmCnFpVEFOSw==') then
        return DispellableFriendlyUnit;
      end
    end
    return DispellableFriendlyUnits[1];
  end
end

-- Get assigned unit role.
function Commons.UnitGroupRole(GroupUnit)
  if GroupUnit:IsAPlayer() then
    return UnitGroupRolesAssigned(GroupUnit:ID());
  end
end

-- Mind Control Blacklist
do
  local MindControllSpells = {
    Spell(362075)
  };
  function Commons.IsMindControlled(FriendlyUnit)
    if FriendlyUnit and FriendlyUnit:Exists() and not FriendlyUnit:IsDeadOrGhost() then
      for i = 1, #MindControllSpells do
        if FriendlyUnit:DebuffUp(MindControllSpells[i], true) then
          return true;
        end
      end
    end
    return false;
  end
end


-- Get lowest friendly unit.
function Commons.LowestFriendlyUnit()
  local LowestUnit;
  local FriendlyUnits = Commons.FriendlyUnits();
  for i = 1, #FriendlyUnits do
    local FriendlyUnit = FriendlyUnits[i];
    if FriendlyUnit and FriendlyUnit:Exists() and not FriendlyUnit:IsDeadOrGhost() and FriendlyUnit:IsInRange(40) and not Commons.IsMindControlled(FriendlyUnit) then
      if not LowestUnit or FriendlyUnit:HealthPercentage() < LowestUnit:HealthPercentage() then
        LowestUnit = FriendlyUnit;
      end
    end
  end
  return LowestUnit;
end

-- Get friendly units count below health percentage.
function Commons.FriendlyUnitsBelowHealthPercentageCount(HealthPercentage)
  local Count = 0;
  local FriendlyUnits = Commons.FriendlyUnits();
  for i = 1, #FriendlyUnits do
    local FriendlyUnit = FriendlyUnits[i];
    if FriendlyUnit:Exists() and not FriendlyUnit:IsDeadOrGhost() and FriendlyUnit:IsInRange(40) then
      if FriendlyUnit:HealthPercentage() <= HealthPercentage then
        Count = Count + 1;
      end
    end
  end
  return Count;
end

-- Get dead friendly units count.
function Commons.DeadFriendlyUnitsCount()
  local Count = 0;
  local FriendlyUnits = Commons.FriendlyUnits();
  for i = 1, #FriendlyUnits do
    local FriendlyUnit = FriendlyUnits[i];
    if FriendlyUnit:IsDeadOrGhost() then
      Count = Count + 1;
    end
  end
  return Count;
end
    