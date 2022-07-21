local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

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
local MultiSpell = HL.MultiSpell
local Item       = HL.Item
local MergeTableByKey = HL.Utils.MergeTableByKey
-- WorldyRotation
local WR         = WorldyRotation
local Macro      = WR.Macro

--- ============================ CONTENT ============================

-- Spell
if not Spell.Warrior then Spell.Warrior = {} end
Spell.Warrior.Commons = {
  -- Racials
  AncestralCall                         = Spell(274738),
  ArcaneTorrent                         = Spell(50613),
  BagofTricks                           = Spell(312411),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(20572),
  Fireblood                             = Spell(265221),
  LightsJudgment                        = Spell(255647),
  -- Abilities
  BattleShout                           = Spell(6673),
  BattleShoutBuff                       = Spell(6673),
  Charge                                = Spell(100),
  IntimidatingShout                     = Spell(5246),
  HeroicLeap                            = Spell(6544),
  Pummel                                = Spell(6552),
  VictoryRush                           = Spell(34428),
  -- Talents
  AngerManagement                       = Spell(152278),
  Avatar                                = Spell(107574),
  AvatarBuff                            = Spell(107574),
  DragonRoar                            = Spell(118000),
  ImpendingVictory                      = Spell(202168),
  StormBolt                             = Spell(107570),
  -- Covenant Abilities (Shadowlands)
  AncientAftershock                     = Spell(325886),
  Condemn                               = Spell(330325),
  CondemnDebuff                         = Spell(317491),
  ConquerorsBanner                      = Spell(324143),
  ConquerorsFrenzyBuff                  = Spell(343672),
  Fleshcraft                            = Spell(324631),
  SpearofBastion                        = Spell(307865),
  SpearofBastionBuff                    = Spell(307871),
  -- Conduits (Shadowlands)
  MercilessBonegrinder                  = Spell(335260),
  MercilessBonegrinderBuff              = Spell(346574),
  -- Pool
  Pool                                  = Spell(999910),
}

Spell.Warrior.Fury = MergeTableByKey(Spell.Warrior.Commons, {
  -- Abilities
  Bloodbath                             = Spell(335096),
  Bloodthirst                           = Spell(23881),
  CrushingBlow                          = Spell(335097),
  EnrageBuff                            = Spell(184362),
  Execute                               = MultiSpell(5308, 280735),
  MeatCleaverBuff                       = Spell(85739),
  RagingBlow                            = Spell(85288),
  Rampage                               = Spell(184367),
  Recklessness                          = Spell(1719),
  RecklessnessBuff                      = Spell(1719),
  Whirlwind                             = Spell(190411),
  -- Talents
  Bladestorm                            = Spell(46924),
  BladestormBuff                        = Spell(46924),
  Cruelty                               = Spell(335070),
  Frenzy                                = Spell(335077),
  FrenzyBuff                            = Spell(335077),
  FrothingBerserker                     = Spell(215571),
  Massacre                              = Spell(206315),
  Onslaught                             = Spell(315720),
  RecklessAbandon                       = Spell(202751),
  Siegebreaker                          = Spell(280772),
  SiegebreakerDebuff                    = Spell(280773),
  SuddenDeath                           = Spell(280721),
  SuddenDeathBuff                       = Spell(280776),
  -- Conduits (Shadowlands)
  ViciousContempt                       = Spell(337302),
  -- Legendary Effects (Shadowlands)
  WilloftheBerserkerBuff                = Spell(335594),
})

Spell.Warrior.Arms = MergeTableByKey(Spell.Warrior.Commons, {
  -- Abilities
  Bladestorm                            = Spell(227847),
  ColossusSmash                         = Spell(167105),
  ColossusSmashDebuff                   = Spell(208086),
  DeepWoundsDebuff                      = Spell(262115),
  Execute                               = MultiSpell(163201, 281000),
  MortalStrike                          = Spell(12294),
  Overpower                             = Spell(7384),
  OverpowerBuff                         = Spell(7384),
  Slam                                  = Spell(1464),
  SweepingStrikes                       = Spell(260708),
  SweepingStrikesBuff                   = Spell(260708),
  Whirlwind                             = Spell(1680),
  -- Talents
  Cleave                                = Spell(845),
  CollateralDamage                      = Spell(334779),
  DeadlyCalm                            = Spell(262228),
  DeadlyCalmBuff                        = Spell(262228),
  Doubletime                            = Spell(103827),
  Dreadnaught                           = Spell(262150),
  FervorofBattle                        = Spell(202316),
  InfortheKill                          = Spell(248621),
  Massacre                              = Spell(281001),
  Ravager                               = Spell(152277),
  Rend                                  = Spell(772),
  RendDebuff                            = Spell(772),
  Skullsplitter                         = Spell(260643),
  SuddenDeathBuff                       = Spell(52437),
  Warbreaker                            = Spell(262161),
  WarMachineBuff                        = Spell(262231),
  -- Conduits (Shadowlands)
  AshenJuggernaut                       = Spell(335232),
  AshenJuggernautBuff                   = Spell(335234),
  BattlelordBuff                        = Spell(346369),
  ExploiterDebuff                       = Spell(335452),
})

Spell.Warrior.Protection = MergeTableByKey(Spell.Warrior.Commons, {
  -- Abilities
  DemoralizingShout                     = Spell(1160),
  Devastate                             = Spell(20243),
  Execute                               = Spell(163201),
  IgnorePain                            = Spell(190456),
  Intervene                             = Spell(3411),
  LastStand                             = Spell(12975),
  LastStandBuff                         = Spell(12975),
  Revenge                               = Spell(6572),
  RevengeBuff                           = Spell(5302),
  ShieldBlock                           = Spell(2565),
  ShieldBlockBuff                       = Spell(132404),
  ShieldSlam                            = Spell(23922),
  ThunderClap                           = Spell(6343),
  -- Talents
  BoomingVoice                          = Spell(202743),
  Ravager                               = Spell(228920),
  UnstoppableForce                      = Spell(275336),
  -- Tier Effects
  OutburstBuff                          = Spell(364010),
  SeeingRedBuff                         = Spell(364006),
})

-- Items
if not Item.Warrior then Item.Warrior = {} end
Item.Warrior.Commons = {
  -- Potions
  Healthstone                           = Item(5512),
  PotionofPhantomFire                   = Item(171349),
  PotionofSpectralStrength              = Item(171275),
  -- Covenant
  PhialofSerenity                       = Item(177278),
  -- Trinkets
  DDVoracity                            = Item(173087, {13, 14}),
  FlameofBattle                         = Item(181501, {13, 14}),
  GrimCodex                             = Item(178811, {13, 14}),
  InscrutableQuantumDevice              = Item(179350, {13, 14}),
  InstructorsDivineBell                 = Item(184842, {13, 14}),
  MacabreSheetMusic                     = Item(184024, {13, 14}),
  OverwhelmingPowerCrystal              = Item(179342, {13, 14}),
  WakenersFrond                         = Item(181457, {13, 14}),
  -- GladiatorzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('OEpMvyFXKYKcNCwvmQIVqPTLrDlGZmwGBazDBqNkREbTYchfPhYyHmqcyBCYWRnZXMNCiAgU2luZnVsR2xhZGlhdG9yc0JhZGdlICAgICAgICAgICAgICAgICA9IEl0ZW0oMTc1OTIxLCB7MTMsIDE0fSksDQogIFVuY2hhaW5lZEdsYWRpYXRvcnNCYWRnZSAgICAgICAgICAgICAgPSBJdGVtKDE4NTE5NywgezEzLCAxNH0pLA0KfQ0KDQpJdGVtLldhcnJpb3IuRnVyeSA9IE1lcmdlVGFibGVCeUtleShJdGVtLldhcnJpb3IuQ29tbW9ucywgew0KfSkNCg0KSXRlbS5XYXJyaW9yLkFybXMgPSBNZXJnZVRhYmxlQnlLZXkoSXRlbS5XYXJyaW9yLkNvbW1vbnMsIHsNCn0pDQoNCkl0ZW0uV2Fycmlvci5Qcm90ZWN0aW9uID0gTWVyZ2VUYWJsZUJ5S2V5KEl0ZW0uV2Fycmlvci5Db21tb25zLCB7DQp9KQ0KDQotLSBNYWNyb3MNCmlmIG5vdCBNYWNyby5XYXJyaW9yIHRoZW4gTWFjcm8uV2FycmlvciA9IHt9IGVuZA0KTWFjcm8uV2Fycmlvci5Db21tb25zID0gew0KICAtLSBCYXNpYyBTcGVsbHMNCiAgSGVyb2ljTGVhcEN1cnNvciAgICAgICAgICAgICAgICAgPSBNYWNybyg=')HeroicLeapCursorzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('HlknJrTBzHepgDVOcCLZIiJhwaDjVooNmZjmQPyRRDQpPXwecYOGUyZLCA=')/cast [@cursor] zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('nqjZAHXJgANnObrtLjxNczruapbQGRFGySVqZAPKUXtIecAQGACIycPIC4uIFNwZWxsLldhcnJpb3IuQ29tbW9ucy5IZXJvaWNMZWFwOk5hbWUoKSksDQogIC0tIENvdmVuYW50DQogIFNwZWFyb2ZCYXN0aW9uUGxheWVyICAgICAgICAgICAgID0gTWFjcm8o')SpearofBastionPlayerzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('VPHokrwHxFAttPHpGCwqeCAHwcbDVUkXChAAJPwDQUYlbTvfBxEOHVrLCA=')/cast [@player] zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('QeseHJIicyowEBcZZMmInAAuNUSMfrCKhkcIbfEniOvQhTyBGWpCxphIC4uIFNwZWxsLldhcnJpb3IuQ29tbW9ucy5TcGVhcm9mQmFzdGlvbjpOYW1lKCkpLA0KICAtLSBJdGVtcw0KICBUcmlua2V0MSAgICAgICAgICAgICAgICAgICAgICAgICA9IE1hY3JvKA==')Trinket1zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('UDRJGtwjoExowwhOuuryrJXSIzrzocMJCrlXmBrlDLUcgSJritKeVkQLCA=')/use 13zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('QUAexlFsZvDdxKdFXIctqtQTUJfwFoNReWuWqyTYjaQCeOydJVGbMcRKSwNCiAgVHJpbmtldDIgICAgICAgICAgICAgICAgICAgICAgICAgPSBNYWNybyg=')Trinket2zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('CMkejjvTdMcucsmwTFOOffMiiDzcLiTgDKvpbeeLgoGjKSLpVgVCVBnLCA=')/use 14zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('KhSqaZnNtYhfnyGMituBNFgmDVvRddwofZPXIDRscnYEpSkCACAAlGZKSwNCiAgSGVhbHRoc3RvbmUgICAgICAgICAgICAgICAgICAgICAgPSBNYWNybyg=')HealthstonezEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('dUlRVYGhfFWBjiAabBkItSlnHezGzTTbyqiiQHFzKmhVdxpqEglmySQLCA=')/use zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('xWxkTymmgpSczzMuMmArMgnvdpEBZyzwxtsJhaHCoHtodfoZRlwhYWtIC4uIEl0ZW0uV2Fycmlvci5Db21tb25zLkhlYWx0aHN0b25lOk5hbWUoKSksDQogIFBvdGlvbm9mU3BlY3RyYWxTdHJlbmd0aCAgICAgICAgID0gTWFjcm8o')PotionofSpectralStrengthzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('zOkyVXjgSYtaQrdpnXTNLgpugDLbCikKIdwObkfzOlYmYwzYctdqUIoLCA=')/use zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('wdPFmNpbNhRMvxvXpgQQTxyNBIeoofsJiouJiEESImhsFXfJZRnqAolIC4uIEl0ZW0uV2Fycmlvci5Db21tb25zLlBvdGlvbm9mU3BlY3RyYWxTdHJlbmd0aDpOYW1lKCkpLA0KICBQaGlhbG9mU2VyZW5pdHkgICAgICAgICAgICAgICAgICA9IE1hY3JvKA==')PhialofSerenityzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('uqVUXPdCSBoHiBsZCieTJQlvKBHORXVHbEMxzWnWwjsSIkRjNHurlZqLCA=')/use zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('myoeANiTSWgCgBtuhpQSdISSekFZkQetrbzYAgTisHdDknaNHkjvRmhIC4uIEl0ZW0uV2Fycmlvci5Db21tb25zLlBoaWFsb2ZTZXJlbml0eTpOYW1lKCkpLA0KfQ0KDQpNYWNyby5XYXJyaW9yLkZ1cnkgPSBNZXJnZVRhYmxlQnlLZXkoTWFjcm8uV2Fycmlvci5Db21tb25zLCB7DQogIENhbmNlbEJsYWRlc3Rvcm0gICAgICAgICAgICAgICAgID0gTWFjcm8o')CancelBladestormzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('hJRzZAGDxfEYOGdXdmASBFVdmIdoRehcMcHiQCqbORrVYZcZUxvNdvuLCA=')/cancelaura zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('UdKMCVwEyrNkCWSxEYEXbSYSZTgMpfbNwhJZdlmuqiLZsjxCCPNqZHJIC4uIFNwZWxsLldhcnJpb3IuRnVyeS5CbGFkZXN0b3JtOk5hbWUoKSksDQp9KQ0KDQpNYWNyby5XYXJyaW9yLkFybXMgPSBNZXJnZVRhYmxlQnlLZXkoTWFjcm8uV2Fycmlvci5Db21tb25zLCB7DQogIFJhdmFnZXJQbGF5ZXIgICAgICAgICAgICAgICAgICAgID0gTWFjcm8o')RavagerPlayerzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('wsFgxOopDAyxdpXNEQGdMwRYVoGjAUldOSJxmEqYVUByWstroARcSpJLCA=')/cast [@player] zEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('EzbKGHbwoLGInqHVgUVKpAAvsQodDvsVZSAoSURRvGWwaaVvXGZdZNWIC4uIFNwZWxsLldhcnJpb3IuUHJvdGVjdGlvbi5SYXZhZ2VyOk5hbWUoKSksDQp9KQ0KDQpNYWNyby5XYXJyaW9yLlByb3RlY3Rpb24gPSBNZXJnZVRhYmxlQnlLZXkoTWFjcm8uV2Fycmlvci5Db21tb25zLCB7DQogIFJhdmFnZXJQbGF5ZXIgICAgICAgICAgICAgICAgICAgID0gTWFjcm8o')RavagerPlayerzEXaQjUJcdgrKHnQysgVUuCmWTtTTHPTsvlOwDmh('KXEesqWAwneoQYRbXHXpHKAeQeTqbYnGIslakbIvaszkxSfQyczXwooLCA=')/cast [@player] ' .. Spell.Warrior.Protection.Ravager:Name()),
})
    