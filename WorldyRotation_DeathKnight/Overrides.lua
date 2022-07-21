local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function FcbXkJkQITLllrcXnTQEvzKjMDaToaDGtjmAkQEfSaArYmJrwxZyaQmBgqYqytNrHLqFysxOrmPfVUjXFmZZaUSed(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

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
local SpellBlood   = Spell.DeathKnight.Blood
-- Lua

--- ============================ CONTENT ============================
-- Generic

-- Blood, ID: 250
local OldBloodIsCastable
OldBloodIsCastable = HL.AddCoreOverride(FcbXkJkQITLllrcXnTQEvzKjMDaToaDGtjmAkQEfSaArYmJrwxZyaQmBgqYqytNrHLqFysxOrmPfVUjXFmZZaUSed('woOlUkbQUSgRqQEsIdYdGyXHzEsWtcZQamNhpdgKuVaDEmzYTOPrgAwU3BlbGwuSXNDYXN0YWJsZQ=='),
  function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
  local BaseCheck = OldBloodIsCastable(self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    if self == SpellBlood.RaiseDead then
      return (not Pet:IsActive()) and BaseCheck
    else
      return BaseCheck
    end
  end
, 250)

-- Example (Arcane Mage)
-- HL.AddCoreOverride (FcbXkJkQITLllrcXnTQEvzKjMDaToaDGtjmAkQEfSaArYmJrwxZyaQmBgqYqytNrHLqFysxOrmPfVUjXFmZZaUSed('qmjGHuZtFOYtsQLQWjAJPvZvAPRMfEwQmQiHXFBojPStdnsXKrlPddDU3BlbGwuSXNDYXN0YWJsZVA='),
-- function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
--   if Range then
--     local RangeUnit = ThisUnit or Target;
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or FcbXkJkQITLllrcXnTQEvzKjMDaToaDGtjmAkQEfSaArYmJrwxZyaQmBgqYqytNrHLqFysxOrmPfVUjXFmZZaUSed('yXgEImGkqFVkmYStqGXxGixhzPtltiUzPejAjBuEgxZCrgHvFQMVorIQXV0bw==')) == 0 and RangeUnit:IsInRange( Range, AoESpell );
--   elseif self == SpellArcane.MarkofAluneth then
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or FcbXkJkQITLllrcXnTQEvzKjMDaToaDGtjmAkQEfSaArYmJrwxZyaQmBgqYqytNrHLqFysxOrmPfVUjXFmZZaUSed('dDKNaLnjavunLMdZFWBKBhrMkiqvnthlXyjOxkPOqzXliJiIWyszAzxQXV0bw==')) == 0 and not Player:IsCasting(self);
--   else
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or FcbXkJkQITLllrcXnTQEvzKjMDaToaDGtjmAkQEfSaArYmJrwxZyaQmBgqYqytNrHLqFysxOrmPfVUjXFmZZaUSed('qjptvdYkoIALgOuNnWCxYqbVnrWCaqjXAmPFYqVybzfxJrDJxRUEjNwQXV0bw==')) == 0;
--   end;
-- end
-- , 62);
    