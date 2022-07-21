local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
  -- HeroLib
local HL = HeroLib
-- WorldyRotation
local WR = WorldyRotation
-- File Locals
local GUI = HL.GUI
local CreateChildPanel = GUI.CreateChildPanel
local CreatePanelOption = GUI.CreatePanelOption
local CreateARPanelOption = WR.GUI.CreateARPanelOption
local CreateARPanelOptions = WR.GUI.CreateARPanelOptions


--- ============================ CONTENT ============================
-- Default settings
WR.GUISettings.APL.Rogue = {
  Commons = {
    Enabled = {
      RangedMultiDoT = true, -- Suggest Multi-DoT at 10y Range
      UseTrinkets = true,
      ShowPooling = true,
      STMfDAsDPSCD = false, -- Single Target MfD as DPS CD
    },
    PoisonRefresh = 15,
    PoisonRefreshCombat = 3,
    UsePriorityRotation = FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('oDgsnOgBxiBivgxDzFPJNctRwwFdhbQyVaprjBqWmccuRaCFpCuldwdTmV2ZXI='), -- Only for Assassination / Subtlety
  },
  Commons2 = {
    HP = {
      CrimsonVialHP = 20,
      FeintHP = 10,
    },
    Enabled = {
      StealthOOC = true,
    },
  },
  Outlaw = {
    Enabled = {
      UseDPSVanish = false, -- Use Vanish in the rotation for DPS
      DumpSpikes = false, -- donFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('zlGPloSaeDiWspnoXHBDBjohPRJIqpymiBSIWoPmSeLCagvpXLGUeALdCBkdW1wIGJvbmUgc3Bpa2VzIGF0IGVuZCBvZiBib3NzLCB1c2VmdWwgaW4gTSsNCiAgICB9LA0KICAgIEhQID0gew0KICAgICAgUm9sbHRoZUJvbmVzTGVlY2hLZWVwSFAgPSA2MCwgLS0gJSBIUCB0aHJlc2hvbGQgdG8ga2VlcCBHcmFuZCBNZWxlZSB3aGlsZSBzb2xvLg0KICAgICAgUm9sbHRoZUJvbmVzTGVlY2hSZXJvbGxIUCA9IDQwLCAtLSAlIEhQIHRocmVzaG9sZCB0byByZXJvbGwgZm9yIEdyYW5kIE1lbGVlIHdoaWxlIHNvbG8uDQogICAgfSwNCiAgICAtLSBSb2xsIHRoZSBCb25lcyBMb2dpYywgYWNjZXB0cyA=')SimCFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('neRyIPsunGCWySBGZGrBJfhILMoAXcqrQNDYCVmouVKumajRFQfWwJFLCA=')1+ BuffFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('sMaDedpVlZiFtSAWQDOHTgqyrHUCWaTXqRlHSTrdHNhlZPPOTnwqAzkIGFuZCBldmVyeSA=')RtBNameFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('ueHzHtKoutEQLMhxlOingOyhDRDyJPObnRYhXeTynpvthzMzqBTXCrILg0KICAgIC0tIA==')SimCFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('UDNPMcizoNzcJGTpiPVwLGNkEaGjErWKVCcxDjcebLrCuhAwtYARBVDLCA=')1+ BuffFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('tJCLTPYkhrWRtlyuRPVlltSQNFqrahCrDRKhWtizFhTlYBfVWYPVtsOLCA=')BroadsideFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('yLRfmBKKbEYLbAhBHseYGVCzCYRwhXycBnnmRSsqzDidEJPsaHrFLkRLCA=')Buried TreasureFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('RmeDJpTWfnDkHNzrcjeteSQeUAtvGvElPcPkfRgQInfswQViFkmdDfrLCA=')Grand MeleeFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('cMwcjkBkmxVsstTJIyjJLCNyGCAaFyBQXNVOgrQsSRZGEyeHPKNLnkbLCA=')Skull and CrossbonesFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('BWsAbiqweewnGsMejfGFvGzQdcKZOZDADplbYZtndSPmLZbnqKIEMZTLCA=')Ruthless PrecisionFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('ORvJEOygzKlnYQgnWNGDNiugSbGbvZQxOhpiQaOYKLxXFKzKAnnMCTGLCA=')True BearingFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('TggUfxVxOrXmTjAUVQBqUzGMocsEZxhwApxVwnGGgrKUZvktuRWthAcDQogICAgUm9sbHRoZUJvbmVzTG9naWMgPSA=')SimCFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('JLFGMZkSPHbeWcjMdmyLiYEHhRRvKInBmSZFjaCvvVOSPjAUPlswpVyLA0KICB9LA0KfQ0KDQpXUi5HVUkuTG9hZFNldHRpbmdzUmVjdXJzaXZlbHkoV1IuR1VJU2V0dGluZ3MpDQoNCi0tIENoaWxkIFBhbmVscw0KbG9jYWwgQVJQYW5lbCA9IFdSLkdVSS5QYW5lbA0KbG9jYWwgQ1BfUm9ndWUgPSBDcmVhdGVDaGlsZFBhbmVsKEFSUGFuZWwsIA==')RogueFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('DClteyWqxancqaVGrzXtEVVElKCkoKzjqVoplZnFPNYsgrXHxqyluvKKQ0KbG9jYWwgQ1BfUm9ndWUyID0gQ3JlYXRlQ2hpbGRQYW5lbChBUlBhbmVsLCA=')Rogue 2FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('eHYFoetILtCsQFkMMTGiPAikEnfFrsTABHDnkOfkGCgfADEKXTYmjHBKQ0KbG9jYWwgQ1BfT3V0bGF3ID0gQ3JlYXRlQ2hpbGRQYW5lbChBUlBhbmVsLCA=')OutlawFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('pWhzLDfVdXJYwXslTQrLTkSWlkDpORSyTADgUspalUDjQXSfSIJmuqSKQ0KLS0gQ29udHJvbHMNCi0tIFJvZ3VlDQpDcmVhdGVQYW5lbE9wdGlvbig=')SliderFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('HOZvCKOJYPVHZftfwQpbdRluUOaLXwNDeyMafEGhPGwGfmybZlEoGBjLCBDUF9Sb2d1ZSwg')APL.Rogue.Commons.PoisonRefreshFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('sTpjFXPKWDgdHvxIvIyIOhlrltVIarPKoZuHwwFqnvtRIASItMeVmrnLCB7NSwgNTUsIDF9LCA=')OOC Poison RefreshFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('nRLBGfgyHRPWhlkQTwbNGOqooRLdcSsTGCOGfxTzlzxHyWqngBuiwgFLCA=')Set the timer for the Poison Refresh (OOC)FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('PesZiOaREQcXlxLKriqPBuddsaqXvRZQBFpmREWIQUCIwZpsmlonNGKKQ0KQ3JlYXRlUGFuZWxPcHRpb24o')SliderFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('YoEWEbjsltOkZFsKErlesdpwjGRxoxrgLsIiDHHibWyVKtUmYDVJPSnLCBDUF9Sb2d1ZSwg')APL.Rogue.Commons.PoisonRefreshCombatFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('iHGtHbOapyZwntwzmTbLxkiahMJDOkrFcVrZYkSgNUgQjvesufTbfpXLCB7MCwgNTUsIDF9LCA=')Combat Poison RefreshFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('rfqiXtIkeNSPBBLrswdffFOXLHMCjmKkhBrPvjOVnJPTtjRmTGwUrBGLCA=')Set the timer for the Poison Refresh (In Combat)FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('ymDlgphSfTSdAMwbdnpoFLPHgYnUmnKirhRCNbiSjGNAhsqSsXWNCIyKQ0KQ3JlYXRlUGFuZWxPcHRpb24o')DropdownFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('SIbzedsJiDilLYEZWOSBJYjRiokhidoQbvHzgNSZdKrxMsHPrHoGgnhLCBDUF9Sb2d1ZSwg')APL.Rogue.Commons.UsePriorityRotationFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('dODnzpKBBVnEAqVLdkUwdVNDVJUXvKCIrZxReGRiTQjFkLdbCSzqDjzLCB7')NeverFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('SzMHrTSAvrNIBXiVwYOqXMPkWZuhNpmigpuOWGoaKOJtaUbEaGbcPxmLCA=')On BossesFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('TndzoadFFWcqGRXJpYnHzzGHjgcJzHPewKTflqaeVwAwHPBEcxAhKlHLCA=')AlwaysFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('LWtbeRepGgJoLGHGJKEyxASoHMNBrzDOfxakIbAjnYFCIfyeyhMjPegLCA=')AutoFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('GLrwKtMytAaGoCoAmKRrzWqUHzjVzhrRZTTpFVkgFqxdqGDWHMmGkxJfSwg')Use Priority RotationFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('pHRzvTRUAyNmNqDOeZtCBcjjscdXqksypLZXZLqfmVHNIpHszrBqARyLCA=')Select when to show rotation for maximum priority damage (at the cost of overall AoE damage.)
Auto will function as Never except on specific encounters where AoE is not recommended.FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('ABXWhBxjkHzzEMExhbtvAYlTNCsjuIYyXhZGqdmoDTGniGxHwdeQUptKQ0KQ3JlYXRlQVJQYW5lbE9wdGlvbnMoQ1BfUm9ndWUsIA==')APL.Rogue.CommonsFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('cQiwcNHnntPQwSgaRHIXHVnIgqOwkeMgNnKQYXSoqxqwNYPDNxcawUeKQ0KLS0gUm9ndWUgMg0KQ3JlYXRlQVJQYW5lbE9wdGlvbnMoQ1BfUm9ndWUyLCA=')APL.Rogue.Commons2FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('CcMgqcKgTLSJWcpFQFWtcQtfIdOUzOIdYZEMkxNXQWvwGJAVVFZulOJKQ0KLS0gT3V0bGF3DQpDcmVhdGVQYW5lbE9wdGlvbig=')DropdownFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('HJwwrIHjcGfDrrFzYSOosfUrogvoNQDVbhnnlayrRPbeOvEKdIUFtXBLCBDUF9PdXRsYXcsIA==')APL.Rogue.Outlaw.RolltheBonesLogicFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('IxjWuMwziSOhhaKYUiCQCUtWhfkwWdhjzJaouGzfkvpUwVJvxRvZoTILCB7')SimCFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('AseZjouOLkYSXalRctLoDiUOQbXyrKwnHlwjMHxfLSelGumTOLcOeSxLCA=')1+ BuffFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('EDlSMrLwHmtsxexrVtaKxRjfDkPXdQxrGZbEJvVOCiAiWexXaXCWwZwLCA=')BroadsideFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('IaColPPryGnutNSOUISfbXNAVwUUuaNiZHNplXeoGmxxvJOsDTXPUtuLCA=')Buried TreasureFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('snBkmtqGnkwcHhuajxNDBRYnoOhKaCLVvYjbzHnqEmPWgfTiFpFiPHiLCA=')Grand MeleeFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('FwqKDWOMcalodsUyxFlnDRrlAdSwhXblnttrNCykAXsaRoDXPyumOxMLCA=')Skull and CrossbonesFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('WZddsAxIjgWdmnPsslmfZaVBYWdScABSMMrdlmYdpmDiXCKMavtZehJLCA=')Ruthless PrecisionFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('dGgasjcqSElvwGwUiAwWtgjmiVzlaHTVKnLBshIgGHVweHAtHXvKaTBLCA=')True BearingFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('VXghiRlvXdmJXIHobaTPawYVcJBjDRUEtTyXBTRvFHAdxMmbiAikJxxfSwg')Roll the Bones LogicFgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('jphBZTLXXUCyUeRqlYLcWEuWJbBXoMMNPqsqvyGpMtMWedEJdgzzvFdLCA=')Define the Roll the Bones logic to follow.
(SimC highly recommended!)FgTbfxJwDUAjbCMtJtKHdNCGTWGtawQGYRResT('USQPuOegTJNAoghOxYLWPbXuvPbKUTqRLETdchZqrVEtyPJMUCdrHRMKQ0KQ3JlYXRlQVJQYW5lbE9wdGlvbnMoQ1BfT3V0bGF3LCA=')APL.Rogue.Outlaw')
    