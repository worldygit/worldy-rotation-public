local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function VsvkuHvIQhoznKoLaJFSvXRWiaYuzNOZMBcxILwIErzgbbNvpvFjhoynJduKVWQmpqFteSntynJNRrTeARbFtucDtXLjZ(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

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
local SpellDisc    = Spell.Priest.Discipline
-- Lua
-- WoW API
local UnitPower         = UnitPower

--- ============================ CONTENT ============================
-- Discipline, ID: 256
local OldDiscIsCastable
OldDiscIsCastable = HL.AddCoreOverride(VsvkuHvIQhoznKoLaJFSvXRWiaYuzNOZMBcxILwIErzgbbNvpvFjhoynJduKVWQmpqFteSntynJNRrTeARbFtucDtXLjZ('NdDXlEEleqwQTCJTcuZIZaCiBpYDYgkgKlGqHtpKuNQFrGVLRrkvpSaU3BlbGwuSXNDYXN0YWJsZQ=='),
  function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    local BaseCheck = OldDiscIsCastable(self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    if self == SpellDisc.MindBlast or self == SpellDisc.Schism then
      return BaseCheck and (not Player:IsCasting(self))
    elseif self == SpellDisc.Smite or self == SpellDisc.DivineStar or self == SpellDisc.Halo or self == SpellDisc.Penance or self == SpellDisc.PowerWordSolace then
      return BaseCheck and (not Player:BuffUp(SpellDisc.ShadowCovenantBuff))
    else
      return BaseCheck
    end
  end
, 256)

-- Holy, ID: 257

-- Shadow, ID: 258

-- Example (Arcane Mage)
-- HL.AddCoreOverride (VsvkuHvIQhoznKoLaJFSvXRWiaYuzNOZMBcxILwIErzgbbNvpvFjhoynJduKVWQmpqFteSntynJNRrTeARbFtucDtXLjZ('AmQPZqEVKrIkncjzTmFbgMTmvWcZQypCCXUbkRAROtPTBYQhkTcVtARU3BlbGwuSXNDYXN0YWJsZVA='), 
-- function (self, Range, AoESpell, ThisUnit, BypassRecovery, Offset)
--   if Range then
--     local RangeUnit = ThisUnit or Target
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or VsvkuHvIQhoznKoLaJFSvXRWiaYuzNOZMBcxILwIErzgbbNvpvFjhoynJduKVWQmpqFteSntynJNRrTeARbFtucDtXLjZ('IfwbJMyfjMHOaxYgHnshswfIqvGFZuorpLbjTsqiRbFruGqyTgettdxQXV0bw==')) == 0 and RangeUnit:IsInRange( Range, AoESpell )
--   elseif self == SpellArcane.MarkofAluneth then
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or VsvkuHvIQhoznKoLaJFSvXRWiaYuzNOZMBcxILwIErzgbbNvpvFjhoynJduKVWQmpqFteSntynJNRrTeARbFtucDtXLjZ('ClSPoancGpqxIEVtuRgYfspfkxeMLusgWhjXhEGgSmqqojyCcGicwhJQXV0bw==')) == 0 and not Player:IsCasting(self)
--   else
--     return self:IsLearned() and self:CooldownRemainsP( BypassRecovery, Offset or VsvkuHvIQhoznKoLaJFSvXRWiaYuzNOZMBcxILwIErzgbbNvpvFjhoynJduKVWQmpqFteSntynJNRrTeARbFtucDtXLjZ('xwTPmArZZygkiHSTlZuQTUEddWEtxewpHxvteBgZMRuRPYNyQqYbUJrQXV0bw==')) == 0
--   end
-- end
-- , 62)
    