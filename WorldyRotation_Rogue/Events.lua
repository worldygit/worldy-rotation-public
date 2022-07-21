local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
local Cache, Utils = HeroCache, HL.Utils
local Unit = HL.Unit
local Player, Pet, Target = Unit.Player, Unit.Pet, Unit.Target
local Focus, MouseOver = Unit.Focus, Unit.MouseOver
local Arena, Boss, Nameplate = Unit.Arena, Unit.Boss, Unit.Nameplate
local Party, Raid = Unit.Party, Unit.Raid
local Spell = HL.Spell
local Item = HL.Item
-- WorldyRotation
local WR = WorldyRotation
local Rogue = WR.Commons.Rogue
-- Lua
local C_Timer = C_Timer
local mathmax = math.max
local mathmin = math.min
local mathabs = math.abs
local pairs = pairs
local tableinsert = table.insert
local UnitAttackSpeed = UnitAttackSpeed
local GetTime = GetTime
-- File Locals



--- ============================ CONTENT ============================

--- Roll the Bones Tracking
--- As buff is mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('KWUzEKgRTnxbVSonFCGbalOCuVKyECgLdLkPTsLplqIjFJvusruPcutaGlkZGVu') from the client but we get apply/refresh events for it
do
  local RtBExpiryTime = GetTime()
  function Rogue.RtBRemains()
    local Remains = RtBExpiryTime - GetTime() - HL.RecoveryOffset()
    return Remains >= 0 and Remains or 0
  end

  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      if SpellID == 315508 then
        RtBExpiryTime = GetTime() + 30
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('VGrkfMMYcwQPLUqksWvPIINrZKFDLiJrgtEQckZPvmOAvaagwTUHsTCU1BFTExfQVVSQV9BUFBMSUVE')
  )
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      if SpellID == 315508 then
        RtBExpiryTime = GetTime() + mathmin(40, 30 + Rogue.RtBRemains())
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('CjOFrpJspgKQRLfbNIBGnUPAaDmxgLfbHnhIllvduRrLlPQuDJBikCxU1BFTExfQVVSQV9SRUZSRVNI')
  )
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      if SpellID == 315508 then
        RtBExpiryTime = GetTime()
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('dPbsELcShNVqilDmivMEPSDIIDWuXxomfLRUXPwPZumAJSBHbvBODRjU1BFTExfQVVSQV9SRU1PVkVE')
  )
end

--- Exsanguinated Tracking
do
  -- Variables
  -- { [SpellName] = { [GUID] = boolean } }
  local ExsanguinatedByBleed = {
    CrimsonTempest = {},
    Garrote = {},
    Rupture = {},
  }
  
  local VendettaGUID = {}
  --local VendettaSpell = Spell.Rogue.Assassination.Vendetta

  local Tier284pcEquipped = Player:HasTier(28, 4)
  HL:RegisterForEvent(function()
    Tier284pcEquipped = Player:HasTier(28, 4)
  end, mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('DLehoXXhtcpxqHFzBaohLzbphhKNhqsmZfMTmUFAcYdHemwIPrpcdSQUExBWUVSX0VRVUlQTUVOVF9DSEFOR0VE'))

  -- Exsanguinated Expression
  function Rogue.Exsanguinated(ThisUnit, ThisSpell)
    local GUID = ThisUnit:GUID()
    if not GUID then return false end

    local SpellID = ThisSpell:ID()
    if SpellID == 121411 then
      -- Crimson Tempest
      return ExsanguinatedByBleed.CrimsonTempest[GUID] or false
    elseif SpellID == 703 then
      -- Garrote
      return ExsanguinatedByBleed.Garrote[GUID] or false
    elseif SpellID == 1943 then
      -- Rupture
      return ExsanguinatedByBleed.Rupture[GUID] or false
    end

    return false
  end

  function Rogue.WillLoseExsanguinate(ThisUnit, ThisSpell)
    if Rogue.Exsanguinated(ThisUnit, ThisSpell) then
      return true
    end

    return false
  end

  function Rogue.ExsanguinatedRate(ThisUnit, ThisSpell)
    -- TODO: Check rate comparison for Exsang + Vendetta
    if Rogue.Exsanguinated(ThisUnit, ThisSpell) then
      return 2.0
    end

    return 1.0
  end

  -- Exsanguinate OnCast Listener
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, DestGUID, _, _, _, SpellID)
      -- Exsanguinate
      if SpellID == 200806 then
        for _, ExsanguinatedByGUID in pairs(ExsanguinatedByBleed) do
          for GUID, _ in pairs(ExsanguinatedByGUID) do
            if GUID == DestGUID then
              ExsanguinatedByGUID[GUID] = true
            end
          end
        end
      -- Vendetta
      elseif Tier284pcEquipped and SpellID == 79140 then
        for _, ExsanguinatedByGUID in pairs(ExsanguinatedByBleed) do
          for GUID, _ in pairs(ExsanguinatedByGUID) do
            if GUID == DestGUID then
              ExsanguinatedByGUID[GUID] = true
            end
          end
        end
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('XmHdsOOcADIOdIPOUlAeYrnMadQkfCfuYLFrgpiEzbhHDUKZSxxpdxbU1BFTExfQ0FTVF9TVUNDRVNT')
  )
  -- Bleed OnApply/OnRefresh Listener
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, DestGUID, _, _, _, SpellID)
      if Tier284pcEquipped and SpellID == 79140 then
        -- Vendetta
        VendettaGUID[DestGUID] = true
        if ExsanguinatedByBleed.CrimsonTempest[DestGUID] == false then
          ExsanguinatedByBleed.CrimsonTempest[DestGUID] = true
        end
        if ExsanguinatedByBleed.Garrote[DestGUID] == false then
          ExsanguinatedByBleed.Garrote[DestGUID] = true
        end
        if ExsanguinatedByBleed.Rupture[DestGUID] == false then
            ExsanguinatedByBleed.Rupture[DestGUID] = true
        end
        return
      end

      -- Debuff are additionally Exsanguinated on cast when Vendetta is up 
      local Exsanguinated = Tier284pcEquipped and VendettaGUID[DestGUID] or false
      if SpellID == 121411 then
        -- Crimson Tempest
        ExsanguinatedByBleed.CrimsonTempest[DestGUID] = Exsanguinated
      elseif SpellID == 703 then
        -- Garrote
        ExsanguinatedByBleed.Garrote[DestGUID] = Exsanguinated
      elseif SpellID == 1943 then
        -- Rupture
        ExsanguinatedByBleed.Rupture[DestGUID] = Exsanguinated
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('XFgcAjRrygJCdqTubiMbopURuargQlOTQhNibqyuEDWfjYylciCYNelU1BFTExfQVVSQV9BUFBMSUVE'), mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('TXktffUDMJbUihkQBEVYWFADHwGgDUMMFxpAxAWrthWtDjVHNQIamlmU1BFTExfQVVSQV9SRUZSRVNI')
  )
  -- Bleed OnRemove Listener
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, DestGUID, _, _, _, SpellID)
      if Tier284pcEquipped and SpellID == 79140 then
        -- Vendetta
        if VendettaGUID[DestGUID] ~= nil then
          VendettaGUID[DestGUID] = nil
        end
      elseif SpellID == 121411 then
        -- Crimson Tempest
        if ExsanguinatedByBleed.CrimsonTempest[DestGUID] ~= nil then
          ExsanguinatedByBleed.CrimsonTempest[DestGUID] = nil
        end
      elseif SpellID == 703 then
        -- Garrote
        if ExsanguinatedByBleed.Garrote[DestGUID] ~= nil then
          ExsanguinatedByBleed.Garrote[DestGUID] = nil
        end
      elseif SpellID == 1943 then
        -- Rupture
        if ExsanguinatedByBleed.Rupture[DestGUID] ~= nil then
          ExsanguinatedByBleed.Rupture[DestGUID] = nil
        end
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('gKJpfeVKFvpUhiBKXlLxRxWONDlgeaOoQxOnAHcphzVWbgVTCJFdrruU1BFTExfQVVSQV9SRU1PVkVE')
  )
  -- Bleed OnUnitDeath Listener
  HL:RegisterForCombatEvent(
    function(_, _, _, _, _, _, _, DestGUID)
      -- Vendetta
      if VendettaGUID[DestGUID] ~= nil then
        VendettaGUID[DestGUID] = nil
      end
      -- Crimson Tempest
      if ExsanguinatedByBleed.CrimsonTempest[DestGUID] ~= nil then
        ExsanguinatedByBleed.CrimsonTempest[DestGUID] = nil
      end
      -- Garrote
      if ExsanguinatedByBleed.Garrote[DestGUID] ~= nil then
        ExsanguinatedByBleed.Garrote[DestGUID] = nil
      end
      -- Rupture
      if ExsanguinatedByBleed.Rupture[DestGUID] ~= nil then
        ExsanguinatedByBleed.Rupture[DestGUID] = nil
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('nEFOyYrixiZLFwuiTcFpQFqmWWyoVVLtMhSLUsOJqpPIDnEbaNfGBWGVU5JVF9ESUVE'), mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('aNJuborrLWsehmiLMSCgykpsAMlEKqboLMHZYSjkCSFGgzerDVPNdTAVU5JVF9ERVNUUk9ZRUQ=')
  )
end

--- Relentless Strikes Energy Prediction
do
  -- Variables
  local RelentlessStrikes = {
    Offset = 0,
    FinishDestGUID = nil,
    FinishCount = 0,
  }
  -- Return RS adjusted Energy Predicted
  function Rogue.EnergyPredictedWithRS()
      return Player:EnergyPredicted() + RelentlessStrikes.Offset
  end
  -- Return RS adjusted Energy Deficit Predicted
  function Rogue.EnergyDeficitPredictedWithRS()
      return Player:EnergyDeficitPredicted() - RelentlessStrikes.Offset
  end
  -- Zero RSOffset after receiving relentless strikes energize
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      -- Relentless Strikes
      if SpellID == 98440 then
        RelentlessStrikes.Offset = 0
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('tYwXvozfUsTCTreAjfEMpINOIYYNUQvZqkZDpNFFHpNFyndSCWNTFgDU1BFTExfRU5FUkdJWkU=')
  )
  -- Running Combo Point tally to access after casting finisher
  HL:RegisterForEvent(
    function(_, _, PowerType)
      if PowerType == mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('oCtoBIcQWwDOMYAQyaKCokNlJMmWrpZHMGtaVoxfSLsHmTXMqGvoEAfQ09NQk9fUE9JTlRT')and Player:ComboPoints() > 0 then
        RelentlessStrikes.Offsetvote = Player:ComboPoints() * 6
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('ouhRbXuGBDJWuCTfHFTOtCmUSWOUqETpXXQNWXeLvOLKkxGdjGzPyBMVU5JVF9QT1dFUl9VUERBVEU=')
  )
  -- Set RSOffset when casting a finisher
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, DestGUID, _, _, _, SpellID)
      -- Eviscerate & Rupture & Shadow Vault SpellIDs
      if SpellID == 196819 or SpellID == 1943 or SpellID == 319175 then
        RelentlessStrikes.FinishDestGUID = DestGUID
        RelentlessStrikes.FinishCount = RelentlessStrikes.FinishCount + 1
        RelentlessStrikes.Offset = RelentlessStrikes.Offsetvote
        -- Backup clear
        C_Timer.After(2, function ()
            if RelentlessStrikes.FinishCount == 1 then
              RelentlessStrikes.Offset = 0
            end
            RelentlessStrikes.FinishCount = RelentlessStrikes.FinishCount - 1
          end
        )
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('CVqvCDVwWayRdEBAEvbbJUvwfEnjNIXmUeensoVCwxrHzOGlQZQaIvoU1BFTExfQ0FTVF9TVUNDRVNT')
  )
  -- Prevent RSOffset getting stuck when target dies mid-finisher (mostly DfA)
  HL:RegisterForCombatEvent(
    function(_, _, _, _, _, _, _, DestGUID)
      if RelentlessStrikes.FinishDestGUID == DestGUID then
        RelentlessStrikes.Offset = 0
      end
    end,
    mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('nHlHMuyeGfhCgQSEOfmoiSEpqtiCEsiKBLQCsYUgirGZZrzkxIMuUycVU5JVF9ESUVE'), mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('LrANtzYlJXxqhRwkZKTSAfbZcsbwMeHDSFRVopprFYhwjOhNYqWHPFOVU5JVF9ERVNUUk9ZRUQ=')
  )
end

--- Shuriken Tornado Tracking
do
  local LastEnergizeTime, LastCastTime = 0, 0
  local ShurikenTornadoBuff = Spell(277925)
  function Rogue.TimeToNextTornado()
    if not Player:BuffUp(ShurikenTornadoBuff, nil, true) then
      return 0
    end
    local TimeToNextTick = Player:BuffRemains(ShurikenTornadoBuff, nil, true) % 1
    -- Tick happened in the same tick, we may not have the CP gain yet
    if GetTime() == LastEnergizeTime then
      return 0
    -- Tick happened very recently, slightly before the predicted buff tick
    elseif (GetTime() - LastEnergizeTime) < 0.1 and TimeToNextTick < 0.25 then
      return 1
    -- Tick hasnmOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('IfADXCOpvrtcjryNTUVwuBOOsCfWqemegdcPYwKhNYjCkKwmHjwYZwFdCBoYXBwZW5lZCB5ZXQgYnV0IHRoZSBwcmVkaWN0ZWQgYnVmZiB0aWNrIGhhcyBwYXNzZWQNCiAgICBlbHNlaWYgKFRpbWVUb05leHRUaWNrID4gMC45IG9yIFRpbWVUb05leHRUaWNrID09IDApIGFuZCAoR2V0VGltZSgpIC0gTGFzdEVuZXJnaXplVGltZSkgPiAwLjc1IHRoZW4NCiAgICAgIHJldHVybiAwLjENCiAgICBlbmQNCiAgICByZXR1cm4gVGltZVRvTmV4dFRpY2sNCiAgZW5kDQoNCiAgSEw6UmVnaXN0ZXJGb3JTZWxmQ29tYmF0RXZlbnQoDQogICAgZnVuY3Rpb24oXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgU3BlbGxJRCkNCiAgICAgIC0tIFNodXJpa2VuIFN0b3JtIEVuZXJnaXplDQogICAgICBpZiBTcGVsbElEID09IDIxMjc0MyB0aGVuDQogICAgICAgIExhc3RFbmVyZ2l6ZVRpbWUgPSBHZXRUaW1lKCkNCiAgICAgIC0tIEFjdHVhbCBTaHVyaWtlbiBTdG9ybSBDYXN0DQogICAgICBlbHNlaWYgU3BlbGxJRCA9PSAxOTc4MzUgdGhlbg0KICAgICAgICBMYXN0Q2FzdFRpbWUgPSBHZXRUaW1lKCkNCiAgICAgIGVuZA0KICAgICAgLS0gSWYgdGhlIHBsYXllciBjYXN0cyBhbiBhY3R1YWwgU2h1cmlrZW4gU3Rvcm0sIHRoaXMgdmFsdWUgaXMgbm8gbG9uZ2VyIHJlbGlhYmxlDQogICAgICBpZiBMYXN0Q2FzdFRpbWUgPT0gTGFzdEVuZXJnaXplVGltZSB0aGVuDQogICAgICAgIExhc3RFbmVyZ2l6ZVRpbWUgPSAwDQogICAgICBlbmQNCiAgICBlbmQsDQogICAg')SPELL_CAST_SUCCESSmOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('ohNPDyodNdHPohUpkvpEmfYqfnHjLcpbIPkYCrcFigCaPGiWgYQrQnZDQogICkNCmVuZA0KDQoNCi0tLSBTaGFkb3cgVGVjaG5pcXVlcyBUcmFja2luZw0KZG8NCiAgLS0gVmFyaWFibGVzDQogIGxvY2FsIFNoYWRvd1RlY2huaXF1ZXMgPSB7DQogICAgQ291bnRlciA9IDAsDQogICAgTGFzdE1IID0gMCwNCiAgICBMYXN0T0ggPSAwLA0KICB9DQogIC0tIFJldHVybiBUaW1lIHRvIHgtdGggYXV0byBhdHRhY2sgc2luY2UgbGFzdCBwcm9jDQogIGZ1bmN0aW9uIFJvZ3VlLlRpbWVUb1NodChIaXQpDQogICAgaWYgU2hhZG93VGVjaG5pcXVlcy5Db3VudGVyID49IEhpdCB0aGVuDQogICAgICByZXR1cm4gMA0KICAgIGVuZA0KDQogICAgbG9jYWwgTUhTcGVlZCwgT0hTcGVlZCA9IFVuaXRBdHRhY2tTcGVlZCg=')playermOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('BGpoHOmNjuufWRoDAvjMCCwmuiEqfwfsyqIaGlXqSDMjmlMsFyfrrIZKQ0KICAgIC0tIEdlbmVyYXRlIHRoZSBiYXNlIHRpbWUgdG8gdXNlLCBpZiB3ZSBhcmUgb3V0IG9mIHJhbmdlIHRoaXMgaXMgc2V0IHRvIHRoZSBjdXJyZW50IHRpbWUNCiAgICBsb2NhbCBMYXN0TUggPSBtYXRobWF4KFNoYWRvd1RlY2huaXF1ZXMuTGFzdE1IICsgTUhTcGVlZCwgR2V0VGltZSgpKQ0KICAgIGxvY2FsIExhc3RPSCA9IG1hdGhtYXgoU2hhZG93VGVjaG5pcXVlcy5MYXN0T0ggKyBPSFNwZWVkLCBHZXRUaW1lKCkpDQoNCiAgICBsb2NhbCBBQVRhYmxlID0ge30NCiAgICBmb3IgaSA9IDAsIDIgZG8NCiAgICAgIHRhYmxlaW5zZXJ0KEFBVGFibGUsIExhc3RNSCArIGkgKiBNSFNwZWVkKQ0KICAgICAgdGFibGVpbnNlcnQoQUFUYWJsZSwgTGFzdE9IICsgaSAqIE9IU3BlZWQpDQogICAgZW5kDQogICAgdGFibGUuc29ydChBQVRhYmxlKQ0KDQogICAgbG9jYWwgSGl0SW5UYWJsZSA9IG1hdGhtaW4oNSwgbWF0aG1heCgxLCBIaXQgLSBTaGFkb3dUZWNobmlxdWVzLkNvdW50ZXIpKQ0KDQogICAgcmV0dXJuIEFBVGFibGVbSGl0SW5UYWJsZV0gLSBHZXRUaW1lKCkNCiAgZW5kDQogIC0tIFJlc2V0IG9uIGVudGVyaW5nIHdvcmxkDQogIEhMOlJlZ2lzdGVyRm9yU2VsZkNvbWJhdEV2ZW50KA0KICAgIGZ1bmN0aW9uICgpDQogICAgICBTaGFkb3dUZWNobmlxdWVzLkNvdW50ZXIgPSAwDQogICAgICBTaGFkb3dUZWNobmlxdWVzLkxhc3RNSCA9IEdldFRpbWUoKQ0KICAgICAgU2hhZG93VGVjaG5pcXVlcy5MYXN0T0ggPSBHZXRUaW1lKCkNCiAgICBlbmQsDQogICAg')PLAYER_ENTERING_WORLDmOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('GsxCrAKvAkwbsMzMtfpDCNZqFjkmFUSbKcLjNIiTJEULMVoBpVPSRvcDQogICkNCiAgLS0gUmVzZXQgY291bnRlciBvbiBlbmVyZ2l6ZQ0KICBITDpSZWdpc3RlckZvclNlbGZDb21iYXRFdmVudCgNCiAgICBmdW5jdGlvbihfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBTcGVsbElEKQ0KICAgICAgLS0gU2hhZG93IFRlY2huaXF1ZXMNCiAgICAgIGlmIFNwZWxsSUQgPT0gMTk2OTExIHRoZW4NCiAgICAgICAgU2hhZG93VGVjaG5pcXVlcy5Db3VudGVyID0gMA0KICAgICAgZW5kDQogICAgZW5kLA0KICAgIA==')SPELL_ENERGIZEmOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('tgcueiIKgOfILgjEjVAkSPnVIhflrxLkNIUzYhhNtNRJMeQaFRuvTnFDQogICkNCiAgLS0gSW5jcmVtZW50IGNvdW50ZXIgb24gc3VjY2Vzc2Z1bCBzd2luZ3MNCiAgSEw6UmVnaXN0ZXJGb3JTZWxmQ29tYmF0RXZlbnQoDQogICAgZnVuY3Rpb24oXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgXywgSXNPZmZIYW5kKQ0KICAgICAgU2hhZG93VGVjaG5pcXVlcy5Db3VudGVyID0gU2hhZG93VGVjaG5pcXVlcy5Db3VudGVyICsgMQ0KICAgICAgaWYgSXNPZmZIYW5kIHRoZW4NCiAgICAgICAgU2hhZG93VGVjaG5pcXVlcy5MYXN0T0ggPSBHZXRUaW1lKCkNCiAgICAgIGVsc2UNCiAgICAgICAgU2hhZG93VGVjaG5pcXVlcy5MYXN0TUggPSBHZXRUaW1lKCkNCiAgICAgIGVuZA0KICAgIGVuZCwNCiAgICA=')SWING_DAMAGEmOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('NcqzAwqBhjVfpOOEvEzTsqocbdNKjPAnHSelqCTMfaSyWkPPgaGHvSYDQogICkNCiAgLS0gUmVtZW1iZXIgdGltZXJzIG9uIHN3aW5nIG1pc3Nlcw0KICBITDpSZWdpc3RlckZvclNlbGZDb21iYXRFdmVudCgNCiAgICBmdW5jdGlvbihfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBJc09mZkhhbmQpDQogICAgICBpZiBJc09mZkhhbmQgdGhlbg0KICAgICAgICBTaGFkb3dUZWNobmlxdWVzLkxhc3RPSCA9IEdldFRpbWUoKQ0KICAgICAgZWxzZQ0KICAgICAgICBTaGFkb3dUZWNobmlxdWVzLkxhc3RNSCA9IEdldFRpbWUoKQ0KICAgICAgZW5kDQogICAgZW5kLA0KICAgIA==')SWING_MISSEDmOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('RYiNpACIXwvobUFSwujiBCnxTwtAIFnazfrKAqaUZTuSyoapOQGpnOEDQogICkNCmVuZA0KDQotLSBCYXNlIENyaXQgVHJhY2tlciAobWFpbmx5IGZvciBPdXRsYXcpDQpkbw0KICBsb2NhbCBCYXNlQ3JpdENoYW5jZSA9IFBsYXllcjpDcml0Q2hhbmNlUGN0KCkNCiAgbG9jYWwgQmFzZUNyaXRDaGVja3NQZW5kaW5nID0gMA0KICBsb2NhbCBmdW5jdGlvbiBVcGRhdGVCYXNlQ3JpdCgpDQogICAgaWYgbm90IFBsYXllcjpBZmZlY3RpbmdDb21iYXQoKSB0aGVuDQogICAgICBCYXNlQ3JpdENoYW5jZSA9IFBsYXllcjpDcml0Q2hhbmNlUGN0KCkNCiAgICAgIEhMLkRlYnVnKA==')Base Crit Set to: mOirvselGGSUomrprMZXsmywHOyvlnVQzFMuSdpjEqtpZrNroHlzVYo('HsYupEuijpmVlfxUdodyeFEByzWUdQNfWiaAunHhdZTilJSOOzydBNsIC4uIEJhc2VDcml0Q2hhbmNlKQ0KICAgIGVuZA0KICAgIGlmIEJhc2VDcml0Q2hlY2tzUGVuZGluZyA9PSBuaWwgb3IgQmFzZUNyaXRDaGVja3NQZW5kaW5nIDwgMCB0aGVuDQogICAgICBCYXNlQ3JpdENoZWNrc1BlbmRpbmcgPSAwDQogICAgZWxzZQ0KICAgICAgQmFzZUNyaXRDaGVja3NQZW5kaW5nID0gQmFzZUNyaXRDaGVja3NQZW5kaW5nIC0gMQ0KICAgIGVuZA0KICAgIGlmIEJhc2VDcml0Q2hlY2tzUGVuZGluZyA+IDAgdGhlbg0KICAgICAgQ19UaW1lci5BZnRlcigzLCBVcGRhdGVCYXNlQ3JpdCkNCiAgICBlbmQNCiAgZW5kDQogIEhMOlJlZ2lzdGVyRm9yRXZlbnQoDQogICAgZnVuY3Rpb24gKCkNCiAgICAgIGlmIEJhc2VDcml0Q2hlY2tzUGVuZGluZyA9PSAwIHRoZW4NCiAgICAgICAgQ19UaW1lci5BZnRlcigzLCBVcGRhdGVCYXNlQ3JpdCkNCiAgICAgICAgQmFzZUNyaXRDaGVja3NQZW5kaW5nID0gMg0KICAgICAgZW5kDQogICAgZW5kLA0KICAgIA==')PLAYER_EQUIPMENT_CHANGED'
  )

  function Rogue.BaseAttackCrit()
    return BaseCritChance
  end
end
    