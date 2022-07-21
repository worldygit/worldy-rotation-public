local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function JOnEHjArYINEAncWijbzkqlyZlDhtuWd(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

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
local MergeTableByKey = HL.Utils.MergeTableByKey
-- WorldyRotation
local WR         = WorldyRotation
local Macro      = WR.Macro

--- ============================ CONTENT ============================

-- Spells
if not Spell.Priest then Spell.Priest = {} end
Spell.Priest.Commons = {
  -- Racials
  AncestralCall                         = Spell(274738),
  ArcanePulse                           = Spell(260364),
  ArcaneTorrent                         = Spell(232633),
  BagofTricks                           = Spell(312411),
  Berserking                            = Spell(26297),
  BerserkingBuff                        = Spell(26297),
  BloodFury                             = Spell(20572),
  BloodFuryBuff                         = Spell(20572),
  Fireblood                             = Spell(265221),
  LightsJudgment                        = Spell(255647),
  -- Abilities
  DesperatePrayer                       = Spell(19236),
  DispelMagic                           = Spell(528),
  Fade                                  = Spell(586),
  PowerInfusion                         = Spell(10060),
  PowerInfusionBuff                     = Spell(10060),
  PowerWordFortitude                    = Spell(21562),
  PowerWordFortitudeBuff                = Spell(21562),
  PowerWordShield                       = Spell(17),
  PowerWordShieldBuff                   = Spell(17),
  PowerWordShieldDebuff                 = Spell(6788),
  ShadowWordDeath                       = Spell(32379),
  ShadowWordPain                        = Spell(589),
  ShadowWordPainDebuff                  = Spell(589),
  Smite                                 = Spell(585),
  -- Covenant Abilities
  AscendedBlast                         = Spell(325283),
  AscendedNova                          = Spell(325020), -- Melee, 8
  BoonoftheAscended                     = Spell(325013),
  BoonoftheAscendedBuff                 = Spell(325013),
  FaeGuardians                          = Spell(327661),
  FaeGuardiansBuff                      = Spell(327661),
  Fleshcraft                            = Spell(324631),
  Mindgames                             = Spell(323673),
  UnholyNova                            = Spell(324724), -- Melee, 15
  WrathfulFaerieDebuff                  = Spell(342132),
  -- Other
  Pool                                  = Spell(999910)
}

Spell.Priest.Holy = MergeTableByKey(Spell.Priest.Commons, {
  -- Base Spells
  BodyandSoul                           = Spell(64129),
  CircleofHealing                       = Spell(204883),
  DivineHymn                            = Spell(64843),
  FlashHeal                             = Spell(2061),
  GuardianSpirit                        = Spell(47788),
  Heal                                  = Spell(2060),
  HolyFire                              = Spell(14914),
  HolyFireDebuff                        = Spell(14914),
  HolyNova                              = Spell(132157), -- Melee, 12
  HolyWordChastise                      = Spell(88625),
  HolyWordSanctify                      = Spell(34861),
  HolyWordSerenity                      = Spell(2050),
  MassResurrection                      = Spell(212036),
  PrayerofHealing                       = Spell(596),
  PrayerofMending                       = Spell(33076),
  PrayerofMendingBuff                   = Spell(41635),
  Purify                                = Spell(527),
  Renew                                 = Spell(139),
  RenewBuff                             = Spell(139),
  Resurrection                          = Spell(2006),
  SurgeofLightBuff                      = Spell(114255),
  -- Talents
  AngelicFeather                        = Spell(121536),
  AngelicFeatherBuff                    = Spell(121557),
  Apotheosis                            = Spell(200183),
  DivineStar                            = Spell(110744),
  Halo                                  = Spell(120517),
  HolyWordSalvation                     = Spell(265202),
  -- Legendary
  FlashConcentrationBuff                = Spell(336267),
})

-- Items
if not Item.Priest then Item.Priest = {} end
Item.Priest.Commons = {
  -- Potion
  Healthstone                      = Item(5512),
  PotionofSpectralIntellect        = Item(171352),
  -- Covenant
  PhialofSerenity                  = Item(177278),
  -- Trinkets
  ArchitectsIngenuityCore          = Item(188268, {13, 14}),
  DarkmoonDeckPutrescence          = Item(173069, {13, 14}),
  DreadfireVessel                  = Item(184030, {13, 14}),
  EmpyrealOrdinance                = Item(180117, {13, 14}),
  GlyphofAssimilation              = Item(184021, {13, 14}),
  InscrutableQuantumDevice         = Item(179350, {13, 14}),
  MacabreSheetMusic                = Item(184024, {13, 14}),
  ScarsofFraternalStrife           = Item(188253, {13, 14}),
  ShadowedOrbofTorment             = Item(186428, {13, 14}),
  SinfulGladiatorsBadgeofFerocity  = Item(175921, {13, 14}),
  SoullettingRuby                  = Item(178809, {13, 14}),
  SunbloodAmethyst                 = Item(178826, {13, 14}),
  TheFirstSigil                    = Item(188271, {13, 14}),
}

Item.Priest.Holy = MergeTableByKey(Item.Priest.Commons, {
})

-- Macros
if not Macro.Priest then Macro.Priest = {} end
Macro.Priest.Commons = {
  -- Base Spells
  PowerInfusionPlayer              = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ylCbNePENJzGxlarbBUKLRaitKtRloIPDZTOaTcTjcsPkqkWAuVwOXhUG93ZXJJbmZ1c2lvblBsYXllcg=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('vwCKNQoJNjamdYQNAsxiyLyWHBFsOQDvFBAIRhkyLsRMpyQzrDTwcmUL2Nhc3QgW0BwbGF5ZXJdIA==') .. Spell.Priest.Commons.PowerInfusion:Name()),
  PowerWordFortitudePlayer         = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('mYPyBwAfdWDMKkznyaJZGGwYQCVJJuPxONIQRHfnJzkYoDHIAcSvjJtUG93ZXJXb3JkRm9ydGl0dWRlUGxheWVy'), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('QLNsHHgBXYGcdksFYFhUToTUZYWdfMaBYHAmomxLXLoITrLBmDPfFSVL2Nhc3QgW0BwbGF5ZXJdIA==') .. Spell.Priest.Commons.PowerWordFortitude:Name()),
  PowerWordShieldPlayer            = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('mXZrLeeVCMgCIFLmwHWlrlsFOENPwpNcMcHUJUaXNAnasbwgCDVtaQrUG93ZXJXb3JkU2hpZWxkUGxheWVy'), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('fDUMQejuqBntieNfYPSqdhVjculVvhsPNSxFbjYOVWZQehOVNFWawzYL2Nhc3QgW0BwbGF5ZXJdIA==') .. Spell.Priest.Commons.PowerWordShield:Name()),
  ShadowWordDeathMouseover         = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('wuBJXOLnDHXucrchYzfYiASUcGtTFbONpiMHohbzwhIWXjFzOcDXnkkU2hhZG93V29yZERlYXRoTW91c2VvdmVy'), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('unlqarCXfCDnxCSzTflOXwgsOqYyWzytDUrQwTnNcyGKgLulBgTSLHSL2Nhc3QgW0Btb3VzZW92ZXJdIA==') .. Spell.Priest.Commons.ShadowWordDeath:Name()),
  ShadowWordPainMouseover          = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ENCgmykAjSQVSCBjBWzpztQSurMPXLYgCRujCpbQXqSZoLSOCtsXhKUU2hhZG93V29yZFBhaW5Nb3VzZW92ZXI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('komCNvmfkUkwmYqfziHzdILHsfFNerqDhtzawxhAzvVMBJXwgpoljPHL2Nhc3QgW0Btb3VzZW92ZXJdIA==') .. Spell.Priest.Commons.ShadowWordPain:Name()),
}

Macro.Priest.Holy = MergeTableByKey(Macro.Priest.Commons, {
  -- Base Spells
  CircleofHealingFocus             = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('PPIXwgRtaLucBVeIUUZpBlheoOlspUjvGRXZGqQMDutGRrmMsIfPNXrQ2lyY2xlb2ZIZWFsaW5nRm9jdXM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('uoRXrsLXttynBCiXkadInkWyKWqeTSHEkNwuhwVyAFhePNCBQhESBcbL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.CircleofHealing:Name()),
  GuardianSpiritFocus              = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('JOeFbLevbthdfNjeiUUUXeCTNeVOaeCDTPJyRpyKryupVUpbDGBAORhR3VhcmRpYW5TcGlyaXRGb2N1cw=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('qDGAWcDzarEmrxOjugomkFlHOWwubzNXhxJzcGdqfcNkdsRemZkgJqVL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.GuardianSpirit:Name()),
  FlashHealFocus                   = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('juXHtivPfNRPNEsmzlVXMpBDPNRFbzblOcIgNbKLmxtJZKborSQnwAjRmxhc2hIZWFsRm9jdXM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('JYobaWZCOUFJpWheCVgoJsIOzXVdoQfekmtmAmIhvBWdPMeKodUXCOLL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.FlashHeal:Name()),
  HealFocus                        = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('DZcynSctoYiROlCixlFTXgBfSTEQUYklqykkSfqGdWDbrpWAHjYNAwTSGVhbEZvY3Vz'), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('enxnNDZshjXsTCITNtpAITvdJufOXZyyzVTTVnwSligTuknEwkXhFdzL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.Heal:Name()),
  HolyWordSanctifyCursor           = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('YecEzKbyMiKxqmXDhPrNZbuHPAmsOyHJjBGdbkJEpjhRQzXmJuaSOGtSG9seVdvcmRTYW5jdGlmeUN1cnNvcg=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('lVqvplalpLYUzXoJPtYqswWVZunVvoMhWGGmPyoVgRkCfrnqEAZKaZwL2Nhc3QgW0BjdXJzb3JdIA==') .. Spell.Priest.Holy.HolyWordSanctify:Name()),
  HolyWordSerenityFocus            = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('TnDBGYnsdyornWqMspyAoYRVjMtnHAVBswTHgYWoDtnCEwqRMmnUyyoSG9seVdvcmRTZXJlbml0eUZvY3Vz'), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('GKktFGsnAjwhXwkzaQhPlJdSDGSFxosyOGCqRcaIIfffqqJaOAOtfCxL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.HolyWordSerenity:Name()),
  PrayerofHealingFocus             = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('JipHAlRvJehFEttGHQzLCeoSrFFxWaCcGnjQlpaThOoMNyzlBwLUpOuUHJheWVyb2ZIZWFsaW5nRm9jdXM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('RXkDOQedFfXKEUAbeSoIolxfkDmPnzbdvXTkzwItmxPGgPowHAEDkVTL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.PrayerofHealing:Name()),
  PrayerofMendingFocus             = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('svzFAmkKHEJQJGrAYDcXHUaSxjMpImqerEcryrYVReIsiNliPFOTZBwUHJheWVyb2ZNZW5kaW5nRm9jdXM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('wiSfjSHdNXXieDGCQqiqQdjKkxFMbaZLOqtPoNMcojUozWwQCbgZAncL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.PrayerofMending:Name()),
  PurifyFocus                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('FxhqMzWwjbENUmMEndIQNMSeBvMsbGyFxmQqYzHqBOpLPhANJKQhcYwUHVyaWZ5Rm9jdXM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ytSZFXxLSzQNwNEQvxrQelYAZXclsSfjbATkDPTQsZtLrTkIpeiYHbaL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.Purify:Name()),
  RenewFocus                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('XnXTqqthFsmMKzCErHMrFhXpgYPcsDGQyfZFpFwPdZmujcqVSHDhUngUmVuZXdGb2N1cw=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('NJAyOLqreqBKfJZTMlxwAdjossLodzPUzEPQsLILbnbFuiCvWUgzfmoL2Nhc3QgW0Bmb2N1c10g') .. Spell.Priest.Holy.Renew:Name()),
  -- Talents
  AngelicFeatherPlayer             = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('pJaupFyEQjrGnQwvIPKmyHPzwMEsdpolxAusRNrzwhogaEGLNCCrxNpQW5nZWxpY0ZlYXRoZXJQbGF5ZXI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('GiWFurtKiKvUDvbnqUkEEqcUUCFalwvqMSoSvOZFGGKADFeuBMUABTML2Nhc3QgW0BwbGF5ZXJdIA==') .. Spell.Priest.Holy.AngelicFeather:Name()),
  -- Items
  Trinket1                         = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ZbQZDhhmDKvpcrNwcmPanBzIzdVXDtRAKAucQbHVgHKTzwbyNTesceqVHJpbmtldDE='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('PBthfRluGEjoVtyvzzNdDiCCIxhSaeELzRwPsLeYBBSboQhdHEclyqlL3VzZSAxMw==')),
  Trinket2                         = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('idEiDDdDqBaDbAfKZwYEKMpoTJGRQqXQpedXJusubqREqKsAJUqHVShVHJpbmtldDI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('BTMRpPZoUOQGHchrJUOUXhHIdcisidiCZAjQWTJtoZhlhoRYuChtYvRL3VzZSAxNA==')),
  Healthstone                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ZOWAEnGDIvmjNsdFYsssNRcQLMKboNRKyCzBtEzbAkylgGiTIenWcJySGVhbHRoc3RvbmU='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('xQefdGPUtadVdbHyOwMMyNOGeVuvrBzXTruEsvIZUlALvtFpkbTixKmL3VzZSA=') .. Item.Priest.Commons.Healthstone:Name()),
  PotionofSpectralIntellect        = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('HoVWLuTIBhCmaIiiuGbbrXxjwnqbtvXNynYEoVGKDtqNvLqWTxBDbyPUG90aW9ub2ZTcGVjdHJhbEludGVsbGVjdA=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('OBzzYJiOVMPEKDwmeyNumAxItdKpFufAbTAKVWAcHHPsLHvWnsPWpPUL3VzZSA=') .. Item.Priest.Commons.PotionofSpectralIntellect:Name()),
  PhialofSerenity                  = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('MdNiBQMQLPXmoMNtaPNbGusEyfSObOajLFFpSGgficosYyVLFQDkwYmUGhpYWxvZlNlcmVuaXR5'), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('VbKXWIauHAbMJfJZSevTNagcgrWDLiVmGyUcntcZlKFFQlONzSwhrDML3VzZSA=') .. Item.Priest.Commons.PhialofSerenity:Name()),
  -- Focus
  FocusTarget                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('fkaENXFkuvBDeSwOVmAbGdyEEunODmScRutMdckbiYMLbrXcSSWSnCfRm9jdXNUYXJnZXQ='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('fFymywelCsKuOIGADQhYKFqSTDlKmRFfrnJRhbDtmbxzLmCfTszzWLFL2ZvY3VzIHRhcmdldA==')),
  FocusPlayer                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ZBmvuhwRZrlpPyAoLOBahhnZVtzEyqfrHDgeldkCojmNwaCJSQHpUGoRm9jdXNQbGF5ZXI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('dHtRLgMhzEqgkLcDeZVlASFJsalMZbFjKwxGlZEZxivLALDSgfryOMPL2ZvY3VzIHBsYXllcg==')),
  FocusParty1                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('UMNvRGshwiWVKbvcbVBLpLhewOUpRxrzJcqYVIaCFMguAFrCywYXLkRRm9jdXNQYXJ0eTE='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('fseJCCqoqAekZBhJfEXJdnckMLmQXQrbjFVdzUfgZMpVkIIwJAnhOIgL2ZvY3VzIHBhcnR5MQ==')),
  FocusParty2                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('xsxKZfKxiyLuKjklEUTIvUYwrRzWKZFbJZHDPMUeccKbzsfCWNkkZSRRm9jdXNQYXJ0eTI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('uItiEmKPNwZtigEIQFiMdQzGpWXczVIjUOrFhZdMrWHLYllNwUtQPXmL2ZvY3VzIHBhcnR5Mg==')),
  FocusParty3                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('inXeXkVqqDsKwPTgvzFjgrCIKhqtuAXUbwaIsMNKMvlGMAYJzTnBWMhRm9jdXNQYXJ0eTM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('doRQZFrSfswGRSUVzTnlptIANGZzfuKFRTqYoovUkbinJiqxdkweRftL2ZvY3VzIHBhcnR5Mw==')),
  FocusParty4                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('SHtBYuNgEHAgotGzRtFibVXJsKjVXNaMOsgeftaDROubJjlWwzAOJVgRm9jdXNQYXJ0eTQ='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('BbEoOGBUtWBQJahNabxihuSOawIMzwsaHkTzHxTSnsfSwXqTXWuORdvL2ZvY3VzIHBhcnR5NA==')),
  FocusRaid1                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('SyryzZGzGLAFnFDKpUCDwEAJPDWZgwYvtMaGaobmFQkynHBxmAbkGaLRm9jdXNSYWlkMQ=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('xXxyYQVAaGmdeVjijdZTclrVdUtkjNvZljnIBZxzWMOQPkezFnQehrHL2ZvY3VzIHJhaWQx')),
  FocusRaid2                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('CdjLOXVFKuOugAqfTVrHjzRnQyUtwFFAcNLMYSaZDIeMJPAEtWoXINxRm9jdXNSYWlkMg=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('BkSjQifROXAYVMcWElvJdsnDmsZLzXHCdRcxNDywyvsYajYiDlEKDWuL2ZvY3VzIHJhaWQy')),
  FocusRaid3                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('jvtAWtoOyDFNfsYdhSXHUwwkYQrMIWFcOBTwBnTbrYjzrZYBmxRnQEtRm9jdXNSYWlkMw=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('aKjzqTeQVoJIrEtckDONRhIByJFLKHNsHYSsodPbjavVUSxPgkOQTTfL2ZvY3VzIHJhaWQz')),
  FocusRaid4                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('aeVhmznTBcedrEMTWBgdGZhYJlJEhnqxyqLHMRIaTOYchwXyMSkJPJwRm9jdXNSYWlkNA=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('VycwMLILKHrOxGKoBAVvuHZkDeJlBsjBwyDcgWVcKnFjStyNSgAzQctL2ZvY3VzIHJhaWQ0')),
  FocusRaid5                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('GiXjpyvKpRwKGrFiDLJuyaPQBpUYbEOFPgaboqtZsTHeUgrMFdAopysRm9jdXNSYWlkNQ=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('cilWmQSXnbzNFfxVglHBJGQaLezvqdvpsGHQhftJKLFOLUGPLIgYzVcL2ZvY3VzIHJhaWQ1')),
  FocusRaid6                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('fIAbmStkxiUxLMCNHTdSZDHgeHDWTcBCAOHkybIOqloZmxfWmcGSBzvRm9jdXNSYWlkNg=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('qVUSCVhXpYUyvssvlBJmobrjBJWstnKSukdiupAfYGOIKBZjztfYuIlL2ZvY3VzIHJhaWQ2')),
  FocusRaid7                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('FiAIuWanDdOPzfBCSBsxekXpbrOigZHmhkbdkDoIvNrhGfNesWilTsRRm9jdXNSYWlkNw=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('vImKWroyklvUoHiDLbanvEnkWVesKyhEbCVFZPOxIWQFcPRueiOldBTL2ZvY3VzIHJhaWQ3')),
  FocusRaid8                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('xWIACuDjpwXUnBetxgxMjcHFpfzOOZpKmRpoadbRIxiEXnmGYpHGnHuRm9jdXNSYWlkOA=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('bKycpwNwPAniZfNvoJfFZwaUerXPzjuRXjqwVGdRKuOKxTgrJjsAYNdL2ZvY3VzIHJhaWQ4')),
  FocusRaid9                       = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('WExKPIXqYjFXYquDSMIWQzYMlyQBDNNnIvjWTXbeNnDdEIRSezYwNUKRm9jdXNSYWlkOQ=='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('tPLxMlBfyaYmQogwosgnaGtmBmxTpqjiJfCVbPacXRAiHoJMEzYqRBbL2ZvY3VzIHJhaWQ5')),
  FocusRaid10                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('UrQadhitkNzcvsoodrVTQQTNxTmUKkFHCGQYSeURmXalHTHzAbwhORkRm9jdXNSYWlkMTA='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('VzyAkhGwJPuNpbxETBEhfPJGXoOHKuCCyaLHAJIuTbGSqPPHjGsbdIJL2ZvY3VzIHJhaWQxMA==')),
  FocusRaid11                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('JAtTFeErFQEDwXLvzYCOsxjHibSoaSLbWIPXUxmpGqNbKKkRgLBFhMpRm9jdXNSYWlkMTE='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('pzJlWdsUFwayYXmnAcLylElfmmexZTeYJYFkXuEjhLdRtkeLhUrktMUL2ZvY3VzIHJhaWQxMQ==')),
  FocusRaid12                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('RytEjkWYKZazhGEwGBQPgcOyRddNJKiMBOPjMELXBdVgShUCUyOuDEiRm9jdXNSYWlkMTI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('PoFOVOrEMuqxAUoHMlIOiVelebYFMDTljkqjaWhbYBWFivHoLCvPTDeL2ZvY3VzIHJhaWQxMg==')),
  FocusRaid13                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('kbzABLVyNZCncXpgiETvowhXzoTAuYXhAoAkmeHaQqINWTintuDJZhsRm9jdXNSYWlkMTM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('xZdXEWyKGFPEjRwwCOvbspbKmOfHpnAivHGdXYHiWHbIEafygrETlTvL2ZvY3VzIHJhaWQxMw==')),
  FocusRaid14                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('PcVszKiQqEexsnSQFITzBbuJWlZYXPbagzvOEmcBQcwQjZuVQMcBLClRm9jdXNSYWlkMTQ='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('UtHoNOBXeflRGhRloPGVXzzFkLNVCveyFQEJlNbUdlOhUJepitwMZoDL2ZvY3VzIHJhaWQxNA==')),
  FocusRaid15                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('zHgHLEjsgSZXYrxpQUYzTAuhDwGKyFfiRJWhLdmiEIFXdeQtdDeLUXNRm9jdXNSYWlkMTU='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('kaybyCsWSPTpdzEXsVLRaNxinTPtYCWeayxhdOGqpPWYcHsFBqQFYIfL2ZvY3VzIHJhaWQxNQ==')),
  FocusRaid16                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('kUXpIXVPQTCxwRRRvNFmszAUoCcFdIqJfrwgHkxmUsnoYvnoQyUYbaPRm9jdXNSYWlkMTY='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('XauPZgJrBbKeZtwmtSRnxQGTXXnQrADfyKrFneSypIUGujioTmtWcdeL2ZvY3VzIHJhaWQxNg==')),
  FocusRaid17                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('SWtRKgGpzhjjEvBJaFIrDvpLcfjwGgGRDnLpmBqKZdCYfwsqSfWFQMPRm9jdXNSYWlkMTc='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('gvkJEVGLnIpRIlHIvRMkFUDiHVQIsyYopJDLiUQghCioXGGYPdbkdpNL2ZvY3VzIHJhaWQxNw==')),
  FocusRaid18                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('kDEoTUYWmjipiVtFGeEHqNnUCDFtaMvdXLPNgHNIzfhBvigUYNxRQVqRm9jdXNSYWlkMTg='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('WPBXrWyTcRAcHTcyCFuhhWVFJKoRehvpMDoTNZSSznPJTEkZDdsLtiAL2ZvY3VzIHJhaWQxOA==')),
  FocusRaid19                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('rdSNocXVyBNyGpnIjAOrENSxeTdUfkCBSQVDJNGMzitbNPCOUbIObyyRm9jdXNSYWlkMTk='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('qJhSxgFEfNZQYqtxUFtbCGLXEmToRIqqqfTEmOvezwqopGHuIwNQCPsL2ZvY3VzIHJhaWQxOQ==')),
  FocusRaid20                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('kvgaZnFCEzaWswqzDIutwgBQwlshhMFHjyizGqjdHycnZQmdErDHYlCRm9jdXNSYWlkMjA='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('JiZanWGanVwkFaUuVQpMgzEqgkvkrcSiddrwrouUuyxsEdyHzBcQAApL2ZvY3VzIHJhaWQyMA==')),
  FocusRaid21                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('lLezkzJGZYWOGDHhSFMcPCMYhezrOIIogMhVLbiARbtINfQgcHePmuvRm9jdXNSYWlkMjE='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('bIkuKZCNcapAJMZutUVKwEhWdielSGFutPCdHkMyNwcRwBTUxvxbtIWL2ZvY3VzIHJhaWQyMQ==')),
  FocusRaid22                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('YSyTdbcsNDHNtaqNpYoizmmSQXozcynbyfOccWmmCLBLwSyRqkdxvvWRm9jdXNSYWlkMjI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('HuPjmCPhunlYcZXDdJNDBEMqoalaxhSyOxSDhEgVkJBUYsJUEVkhAMGL2ZvY3VzIHJhaWQyMg==')),
  FocusRaid23                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('EPwynpxcvYesOBRAlLCpntcOLsrZcQtRCvteSfosKqvTQVKpZEhsNGCRm9jdXNSYWlkMjM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('fcXfPFSIYccOrKbFPnxpVQcecRqOvuSWpKIOOHHEOXDBpQEuiFPCebbL2ZvY3VzIHJhaWQyMw==')),
  FocusRaid24                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('mKbYTXPjzHnEcZRCbBozTAnAFlRSVxvZXzwWjCshGFWzrPaMvHmAyLERm9jdXNSYWlkMjQ='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('aSzGrkZGCNlKHWheEiQLCQkuyxSTdmZAiuPIbydAaJIUdFoeWOAcAPtL2ZvY3VzIHJhaWQyNA==')),
  FocusRaid25                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('yDIWGuLDkuSFhdCPXcCaPcVaXLqVACdEsjZwxIfUlEmvatuhmjaNXAoRm9jdXNSYWlkMjU='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('LLnBmXlyqlZOvjPsUoGiDPJSbfwAJpRVEubCVNVwwixCIGVDMfkFUeFL2ZvY3VzIHJhaWQyNQ==')),
  FocusRaid26                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('DlbQgNtEMwdKdtXcNvTkLponTwsyeRngVGEijPVvCBnGGfPYofOwSHbRm9jdXNSYWlkMjY='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('MPiGmNJEoOKcirKBZyQuWaKsGpUDtmgiLedCtkJulKISRtMUwFMJBRkL2ZvY3VzIHJhaWQyNg==')),
  FocusRaid27                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('TqlttMIAiIbfPySyDLwgElLWuTbRvDQWBkiibSzwoyncpWbrTNtpUSARm9jdXNSYWlkMjc='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('InvNpMQrIsWvkURtZwAnwhMCSJTTyBHCxtGQorFszYMddPPVTlbIOvfL2ZvY3VzIHJhaWQyNw==')),
  FocusRaid28                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('EOqbPKUuqobSxaxMcErGHYuUQDtaEyDZXaJvPsMuZRSdMgqJNlPZEPMRm9jdXNSYWlkMjg='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('XrkNNnYhMGpqHcUZmemtvBJBJtOsqXlyQuzZBXTemzAOThELxxUsEFqL2ZvY3VzIHJhaWQyOA==')),
  FocusRaid29                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('ObawSZMeStPDsHcQBKvwmyZuEhVniuJMbDLPNXrVEDljgZVqRPHraXVRm9jdXNSYWlkMjk='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('FeUANvdwCgcxUhBlukUPaihXeKvYmgCcJFKwErUyUIQpDOSaovmynEfL2ZvY3VzIHJhaWQyOQ==')),
  FocusRaid30                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('tlwYVDGYbJrlskCXGsDYUFiAnRSfMmGRaecxqyZFehBjwWDPGjEJtPVRm9jdXNSYWlkMzA='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('TjACacjRTQommOVXmBZhAKdRceDNMVJnunwXAhRTTaCWFXvsLJNvCMqL2ZvY3VzIHJhaWQzMA==')),
  FocusRaid31                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('qUDGSXMUcmEpdWcVjBDhTARWZWzuBhyJRlMaizYSMchNMcyTrYkMZdxRm9jdXNSYWlkMzE='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('GZlXysIviaWCmOKQeZeygDQmERmdeMQOZxpnPLPSoskIvIdoILfqXnUL2ZvY3VzIHJhaWQzMQ==')),
  FocusRaid32                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('UcpOyQWrDOcpJUNFjDTsUFEyuGvRTtNwRkSCGrFLQVoZTdNAuPiXUwHRm9jdXNSYWlkMzI='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('dIuXEzCvNFQtyriJxGHaAfoqgwRJmVjzevKcEgprxMSgArdvDXFHDyrL2ZvY3VzIHJhaWQzMg==')),
  FocusRaid33                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('BRoxJajiGWVhtmRgTvnAvLJjypUNLNxXcICZRFnlJcuheejyRfqWTETRm9jdXNSYWlkMzM='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('SCWtnmaVdQWbMSGkDsRPKdyBjeehmQtLLervPGnUDHyYNRrorTNdSDdL2ZvY3VzIHJhaWQzMw==')),
  FocusRaid34                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('aHvqrLpSIssGurkTUUWnQlfoqlbYzLqtJjmRjCTeqAmqSDwQECWnABpRm9jdXNSYWlkMzQ='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('xUvOtcjqkrQpKRkkwNleXPBlJnTwXNaPcHQLexvUNDVgFOgpJURwzdxL2ZvY3VzIHJhaWQzNA==')),
  FocusRaid35                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('NdnuWfPLDTYsHxLRDNRMUmLKpTfCIPcPOfFLYadyVNInrJNahGGmXRaRm9jdXNSYWlkMzU='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('iLomkwTMnABYBiiyMNdBGOmSApJSjWqxmTntDHnGnslfVWqKzuWEQmbL2ZvY3VzIHJhaWQzNQ==')),
  FocusRaid36                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('BKfDYDPyiwPBVKzWvgkCSitkMxXiMZMpbqoNxpzcfWepRWdekzzDDQNRm9jdXNSYWlkMzY='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('yXBoOmnzYmRPFuAbDlopEBZdMcWaBwcDfVJeOoGXsuHBJrNlvIubitfL2ZvY3VzIHJhaWQzNg==')),
  FocusRaid37                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('hXUComGwCqgxYYqgSNRfryICMJsYNtlJldhYNqfbAsnEEmLhzJPOmnmRm9jdXNSYWlkMzc='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('izTwnQneSFQlHUPZSpkebxKXKkptiKpfFoGYssfcvoZoNrhYlBOPDuEL2ZvY3VzIHJhaWQzNw==')),
  FocusRaid38                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('MlVjiltcNdleBWErjZWeJapMzrUeqAJKYkwzracNpGmhdpguZECXXTIRm9jdXNSYWlkMzg='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('YvtbOIzNBZRBLCNZbrCWWVeWzVeNbeKQBKMYaTLZkqfpWklPlWhmZQeL2ZvY3VzIHJhaWQzOA==')),
  FocusRaid39                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('hbaWpXceubRocvsGrWYNPpOmdnXESjOnAizDwGyCIuBVLkhYYzgaTgrRm9jdXNSYWlkMzk='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('RWGTHDVjfzKdyhDOHpmErIssWvcpbkdryCMORrMkSIOspdHpzDXAihjL2ZvY3VzIHJhaWQzOQ==')),
  FocusRaid40                      = Macro(JOnEHjArYINEAncWijbzkqlyZlDhtuWd('HfkZaspalXSpqensoWZbGhrgRYTgnSorkArZsLjxVfYKaTnXKHWlhDARm9jdXNSYWlkNDA='), JOnEHjArYINEAncWijbzkqlyZlDhtuWd('LknTUArzFuIilFRzsavYOuDtMGtjUSDQNczcinmIcOVJDdGUalQNKmgL2ZvY3VzIHJhaWQ0MA==')),
})
    