local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function jzTnsjHeQCOEWRAhBsxDThGOze(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
-- HeroLib
local HL      = HeroLib
local Cache   = HeroCache
local Unit    = HL.Unit
local Player  = Unit.Player
local Pet     = Unit.Pet
local Target  = Unit.Target
local Spell   = HL.Spell
local Item    = HL.Item
-- WorldyRotation
local WR      = WorldyRotation
-- Spells
local SpellFury             = Spell.Warrior.Fury
local SpellArms             = Spell.Warrior.Arms
local SpellProt             = Spell.Warrior.Protection
-- Lua

--- ============================ CONTENT ============================
-- Arms, ID: 71
local ArmsOldSpellIsCastable
ArmsOldSpellIsCastable = HL.AddCoreOverride (jzTnsjHeQCOEWRAhBsxDThGOze('pzxZmJNZSWiQnGcevFRQevnDbPXYqpvPQhnWpdyRUdEvosyLgunsaOHU3BlbGwuSXNDYXN0YWJsZQ=='),
  function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    local BaseCheck = ArmsOldSpellIsCastable(self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    if self == SpellArms.Charge then
      return BaseCheck and self:Charges() >= 1 and (not Target:IsInRange(8) and Target:IsInRange(25))
    else
      return BaseCheck
    end
  end
, 71)

-- Fury, ID: 72
local FuryOldSpellIsCastable
FuryOldSpellIsCastable = HL.AddCoreOverride (jzTnsjHeQCOEWRAhBsxDThGOze('urfdsHDWxzOrgAsXXKrYppxBwtLHiFUXKKsFAlYCGgLEMbVEloefGbrU3BlbGwuSXNDYXN0YWJsZQ=='),
  function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    local BaseCheck = FuryOldSpellIsCastable(self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    if self == SpellFury.Charge then
      return BaseCheck and (self:Charges() >= 1 and (not Target:IsInRange(8)) and Target:IsInRange(25))
    else
      return BaseCheck
    end
  end
, 72)

local FuryOldSpellIsReady
FuryOldSpellIsReady = HL.AddCoreOverride (jzTnsjHeQCOEWRAhBsxDThGOze('ixLzbzrKaEcntiyooUFeNtQTlSjwfyRDDKnJZiYBnvAOSGqmZYpCdUwU3BlbGwuSXNSZWFkeQ=='),
  function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    local BaseCheck = FuryOldSpellIsReady(self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    if self == SpellFury.Rampage then
      if Player:PrevGCDP(1, SpellFury.Bladestorm) then
        return self:IsCastable() and Player:Rage() >= self:Cost()
      else
        return BaseCheck
      end
    else
      return BaseCheck
    end
  end
, 72)

-- Protection, ID: 73
local ProtOldSpellIsCastable
ProtOldSpellIsCastable = HL.AddCoreOverride (jzTnsjHeQCOEWRAhBsxDThGOze('UVbcDZfIIaSwsFYaCUSYQutwnnWMczxJQmOpQLIVpTbBDYwKatqEcxYU3BlbGwuSXNDYXN0YWJsZQ=='),
  function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    local BaseCheck = ProtOldSpellIsCastable(self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    --if self == SpellProt.Charge then
      --return BaseCheck and (self:Charges() >= 1 and (not Target:IsInRange(8)) and Target:IsInRange(25))
    if self == SpellProt.Avatar then
      return BaseCheck and (Player:BuffDown(SpellProt.AvatarBuff))
    elseif self == SpellProt.Intervene then
      return BaseCheck and (Player:IsInParty() or Player:IsInRaid())
    else
      return BaseCheck
    end
  end
, 73)

-- Example (Arcane Mage)
-- HL.AddCoreOverride (jzTnsjHeQCOEWRAhBsxDThGOze('hVhenAVSDGMvNTsPuqfstyMvKpqCSARjXLZTtXmBJiyKzSYavbEjFhoU3BlbGwuSXNDYXN0YWJsZVA='),
-- function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
--   if Range then
--     local RangeUnit = ThisUnit or Target
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or jzTnsjHeQCOEWRAhBsxDThGOze('xhCOPfsvPbWwbFSVGePNUdSBPDjYWreOjBizzmDhEmwLsahnbJWhtIhQXV0bw==')) == 0 and RangeUnit:IsInRange( Range, AoESpell )
--   elseif self == SpellArcane.MarkofAluneth then
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or jzTnsjHeQCOEWRAhBsxDThGOze('wuOJvhfUlMmKAVKqOuLIMetgVwcddwNMDkoMCesHBhAaHNcWwlegkeGQXV0bw==')) == 0 and not Player:IsCasting(self)
--   else
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or jzTnsjHeQCOEWRAhBsxDThGOze('lfPhXKQnsMDtvnieEsoQpTmQVjZteyfTPwMbYSTbNOrtXCFLLvRdszaQXV0bw==')) == 0
--   end
-- end
-- , 62)    