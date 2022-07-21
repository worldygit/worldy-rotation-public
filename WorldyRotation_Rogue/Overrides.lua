local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function bBVaJsGkBnhMgljNVraZdLseHSyjCxCRSvvOaVJeaIHVJmTVCgBybqzHNbpOhJd(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

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
  local SpellAssa     = Spell.Rogue.Assassination
  local SpellOutlaw   = Spell.Rogue.Outlaw
  local SpellSubtlety = Spell.Rogue.Subtlety
-- Lua

--- ============================ CONTENT ============================
-- Assassination, ID: 259

-- Outlaw, ID: 260

-- Subtlety, ID: 261

-- Example (Arcane Mage)
-- HL.AddCoreOverride (bBVaJsGkBnhMgljNVraZdLseHSyjCxCRSvvOaVJeaIHVJmTVCgBybqzHNbpOhJd('kwaLXcnotokyKTEAJTkFYBGTuTBIqsEiQDdbrGQJJkaKnAhaMTErjrNU3BlbGwuSXNDYXN0YWJsZVA='),
-- function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
--   if Range then
--     local RangeUnit = ThisUnit or Target
--     return self:IsLearned() and self:CooldownRemains( BypassRecovery, Offset or bBVaJsGkBnhMgljNVraZdLseHSyjCxCRSvvOaVJeaIHVJmTVCgBybqzHNbpOhJd('ckrWgpxwvnGQVXJYTguRoDMFZErNhHCVXaJPxsnOECRaMJhnQoyiuOsQXV0bw==')) == 0 and RangeUnit:IsInRange( Range, AoESpell )
--   elseif self == SpellArcane.MarkofAluneth then
--     return self:IsLearned() and self:CooldownRemains( BypassRecovery, Offset or bBVaJsGkBnhMgljNVraZdLseHSyjCxCRSvvOaVJeaIHVJmTVCgBybqzHNbpOhJd('lkZWoEszEzeghsHRDmlrpMNLXTlDcGwSfwoczwnvpNlhJNRyiuwCwyvQXV0bw==')) == 0 and not Player:IsCasting(self)
--   else
--     return self:IsLearned() and self:CooldownRemains( BypassRecovery, Offset or bBVaJsGkBnhMgljNVraZdLseHSyjCxCRSvvOaVJeaIHVJmTVCgBybqzHNbpOhJd('sAyYhoetEtBoTVVPrpQGWlETYfFLbJFUWAewAyUFhganWmZGNZJfRhlQXV0bw==')) == 0
--   end
-- end
-- , 62)
    