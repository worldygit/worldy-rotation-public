local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function mMLTzBTfkopJCpJOnKmAPsMuwIGMvLukVTTTFLSzLlLslqxhKnURbDdJgvd(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Spell = HL.Spell
local Item = HL.Item
-- Lua
-- WoW API
local GetTime = GetTime
-- File Locals



--- ============================ CONTENT ============================
--- Ghoul Tracking
HL:RegisterForSelfCombatEvent(function(_, _, _, _, _, _, _, destGUID, _, _, _, spellId)
  if spellId ~= 46585 then return end
  HL.GhoulTable.SummonedGhoul = destGUID
  -- Unsure if theremMLTzBTfkopJCpJOnKmAPsMuwIGMvLukVTTTFLSzLlLslqxhKnURbDdJgvd('hxCakvFIARqleLtORvVVteHgLDkeIqhdbpTMzIAlxvvZzffrJxWLBPlcyBhbnkgaXRlbXMgdGhhdCBjb3VsZCBleHRlbmQgdGhlIGdob3VscyB0aW1lIHBhc3QgNjAgc2Vjb25kcw0KICBITC5HaG91bFRhYmxlLlN1bW1vbkV4cGlyYXRpb24gPSBHZXRUaW1lKCkgKyA2MA0KZW5kLCA=')SPELL_SUMMONmMLTzBTfkopJCpJOnKmAPsMuwIGMvLukVTTTFLSzLlLslqxhKnURbDdJgvd('ZFJJPBIdYHkCsvFgPLfAxxrjQPkCFOHmgupoSeeohXMylZnaoUzxCzKKQ0KDQpITDpSZWdpc3RlckZvclNlbGZDb21iYXRFdmVudChmdW5jdGlvbihfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBfLCBzcGVsbElkKQ0KICBpZiBzcGVsbElkIH49IDMyNzU3NCB0aGVuIHJldHVybiBlbmQNCiAgSEwuR2hvdWxUYWJsZS5TdW1tb25lZEdob3VsID0gbmlsDQogIEhMLkdob3VsVGFibGUuU3VtbW9uRXhwaXJhdGlvbiA9IG5pbA0KZW5kLCA=')SPELL_CAST_SUCCESSmMLTzBTfkopJCpJOnKmAPsMuwIGMvLukVTTTFLSzLlLslqxhKnURbDdJgvd('uJvetCDaAVICCIjBChyIgPDlhbJgoOkeGyFoGtCxdnhZnPJMdHgSzCyKQ0KDQpITDpSZWdpc3RlckZvckNvbWJhdEV2ZW50KGZ1bmN0aW9uKF8sIF8sIF8sIF8sIF8sIF8sIF8sIGRlc3RHVUlEKQ0KICBpZiBkZXN0R1VJRCB+PSBITC5HaG91bFRhYmxlLlN1bW1vbmVkR2hvdWwgdGhlbiByZXR1cm4gZW5kDQogIEhMLkdob3VsVGFibGUuU3VtbW9uZWRHaG91bCA9IG5pbA0KICBITC5HaG91bFRhYmxlLlN1bW1vbkV4cGlyYXRpb24gPSBuaWwNCmVuZCwg')UNIT_DESTROYED')
--- ======= NON-COMBATLOG =======


--- ======= COMBATLOG =======
  --- Combat Log Arguments
    ------- Base -------
      --     1        2         3           4           5           6              7             8         9        10           11
      -- TimeStamp, Event, HideCaster, SourceGUID, SourceName, SourceFlags, SourceRaidFlags, DestGUID, DestName, DestFlags, DestRaidFlags

    ------- Prefixes -------
      --- SWING
      -- N/A

      --- SPELL & SPELL_PACIODIC
      --    12        13          14
      -- SpellID, SpellName, SpellSchool

    ------- Suffixes -------
      --- _CAST_START & _CAST_SUCCESS & _SUMMON & _RESURRECT
      -- N/A

      --- _CAST_FAILED
      --     15
      -- FailedType

      --- _AURA_APPLIED & _AURA_REMOVED & _AURA_REFRESH
      --    15
      -- AuraType

      --- _AURA_APPLIED_DOSE
      --    15       16
      -- AuraType, Charges

      --- _INTERRUPT
      --      15            16             17
      -- ExtraSpellID, ExtraSpellName, ExtraSchool

      --- _HEAL
      --   15         16         17        18
      -- Amount, Overhealing, Absorbed, Critical

      --- _DAMAGE
      --   15       16       17       18        19       20        21        22        23
      -- Amount, Overkill, School, Resisted, Blocked, Absorbed, Critical, Glancing, Crushing

      --- _MISSED
      --    15        16           17
      -- MissType, IsOffHand, AmountMissed

    ------- Special -------
      --- UNIT_DIED, UNIT_DESTROYED
      -- N/A

  --- End Combat Log Arguments

  -- Arguments Variables
  -- I referenced the warlock events file, not sure if this is correct
  HL.GhoulTable = {
    SummonedGhoul = nil,
    SummonExpiration = nil
  }

  function HL.GhoulTable:remains()
    if HL.GhoulTable.SummonExpiration == nil then return 0 end
    return HL.GhoulTable.SummonExpiration - GetTime()
  end

  function HL.GhoulTable:active()
    return HL.GhoulTable.SummonedGhoul ~= nil and HL.GhoulTable:remains() > 0
  end
    