local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function pZsHFxzgbnrrrVQJSbrgFGFLOAHUcJABQhKwqgmKkTwgbtDZLbxGili(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
  -- Addon
  local addonName, WR = ...;
  -- HeroLib
  local HL = HeroLib;
  local Cache = HeroCache;
  local Unit = HL.Unit;
  local Player = Unit.Player;
  local Target = Unit.Target;
  local Spell = HL.Spell;
  local Item = HL.Item;
  -- Lua

  -- File Locals



--- ============================ CONTENT ============================
--- ======= NON-COMBATLOG =======
  -- OnSpecChange
  local SpecTimer = 0;
  HL:RegisterForEvent(
    function (Event)
      -- Prevent the first event firing (when login)
      if not HL.PulseInitialized then return; end
      -- Timer to prevent bug due to the double/triple event firing.
      -- Since it takes 5s to change spec, wepZsHFxzgbnrrrVQJSbrgFGFLOAHUcJABQhKwqgmKkTwgbtDZLbxGili('xBRatyDvVVGbvdJGnHkPIgfEbkuvuCYAXRyJurMHTdvwjeOpydyftLVbGwgdGFrZSAzc2Vjb25kcyBhcyB0aW1lci4NCiAgICAgIGlmIEdldFRpbWUoKSA+IFNwZWNUaW1lciB0aGVuDQogICAgICAgIC0tIFVwZGF0ZSB0aGUgdGltZXIgb25seSBvbiB2YWxpZCBzY2FuLg0KICAgICAgICBpZiBXUi5QdWxzZUluaXQoKSB+PSA=')Invalid SpecIDpZsHFxzgbnrrrVQJSbrgFGFLOAHUcJABQhKwqgmKkTwgbtDZLbxGili('LkpQxLyJldEnUQCyopHPhIjRmlYjHORzlFOwbMqNvntFQmCljSrUzsgIHRoZW4NCiAgICAgICAgICBTcGVjVGltZXIgPSBHZXRUaW1lKCkgKyAzOw0KICAgICAgICBlbmQNCiAgICAgIGVuZA0KICAgIGVuZA0KICAgICwg')PLAYER_SPECIALIZATION_CHANGED'
  );

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

    