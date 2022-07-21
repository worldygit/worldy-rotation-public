local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- WorldyRotation
local WR = WorldyRotation
-- HeroLib
local HL = HeroLib
-- File Locals
local GUI = HL.GUI
local CreateChildPanel = GUI.CreateChildPanel
local CreatePanelOption = GUI.CreatePanelOption
local CreateARPanelOption = WR.GUI.CreateARPanelOption
local CreateARPanelOptions = WR.GUI.CreateARPanelOptions

--- ============================ CONTENT ============================
-- All settings here should be moved into the GUI someday.
WR.GUISettings.APL.Priest = {
  Commons = {
    Enabled = {
    },
  },
  Holy = {
    General = {
      Enabled = {
        AngelicFeather = true,
        BodyAndSoul = true,
        Dispel = true,
        FlashConcentration = true,
        OutOfCombatHealing = true,
        PowerWordFortitude = true,
      },
    },
    Cooldown = {
      Enabled = {
        PowerInfusionSolo = true,
      },
      HP = {
        Apotheosis = 60,
        DivineHymn = 50,
        GuardianSpirit = 20,
        HolyWordSalvation = 50,
      },
      AoEGroup = {
        Apotheosis = 3,
        DivineHymn = 3,
        HolyWordSalvation = 4,
      },
      AoERaid = {
        Apotheosis = 6,
        DivineHymn = 6,
        HolyWordSalvation = 8,
      },
    },
    Defensive = {
      Enabled = {
        Fade = true,
      },
      HP = {
        DesperatePrayer = 40,
      },
    },
    Damage = {
      Enabled = {
        Apotheosis = true,
        BoonOfTheAscended = true,
        DivineStar = true,
      },
      AoE = {
        DivineStar = 1,
        HolyNova = 3,
      },
    },
    Healing = {
      HP = {
        CircleOfHealing = 85,
        DivineStar = 85,
        FlashHeal = 65,
        Halo = 85,
        Heal = 80,
        HolyWordSanctify = 85,
        HolyWordSerenity = 70,
        PrayerOfHealing = 0,
        PrayerOfMending = 99,
        Renew = 0,
      },
      AoEGroup = {
        CircleOfHealing = 3,
        Halo = 3,
        HolyWordSanctify = 3,
        PrayerOfHealing = 3,
      },
      AoERaid = {
        CircleOfHealing = 4,
        Halo = 5,
        HolyWordSanctify = 4,
        PrayerOfHealing = 4,
      },
    },
  },
}

WR.GUI.LoadSettingsRecursively(WR.GUISettings)

-- Child Panels
local ARPanel = WR.GUI.Panel
local CP_Priest = CreateChildPanel(ARPanel, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('ywKLrfmyMogQXqvLXzyRtTZthpxDWaXchthdgBqUNZwRuyqWMHCjhXUUHJpZXN0'))
local CP_Holy = CreateChildPanel(CP_Priest, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('jPkMOMUdEzOIOSmzXwaDinSHhHgoXKRgjesrNVyJvyWMArCxeiYXyRqSG9seQ=='))
local CP_Holy_General = CreateChildPanel(CP_Holy, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('JuIImUBdaTrZNTCYAdGtUXJTaEgufifsZnYMTASqXuBOkMHvrKfuecAR2VuZXJhbA=='))
local CP_Holy_Cooldown = CreateChildPanel(CP_Holy, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('aaYNMiBxcBpZQtwlYMRnqDKBFGbpdmCykrNdMBCLtFoMIhvzCXEVwmFQ29vbGRvd24='))
local CP_Holy_Defensive = CreateChildPanel(CP_Holy, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('QKRWCrTTSpzyMGZrRVHAFslURWHuDMIhrjxdPQKriwgYFRnSmsGpHobRGVmZW5zaXZl'))
local CP_Holy_Damage = CreateChildPanel(CP_Holy, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('VGUgfPZeGWuSmHbeRrMsupnUraqiiUgebykTmDHhtNeqVSZdFIunBKeRGFtYWdl'))
local CP_Holy_Healing = CreateChildPanel(CP_Holy, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('PUNrUkkDkBSvdmzdhtVdiRYDBANMyQhQvEhRCITqAtypKwLCQBpgVYaSGVhbGluZw=='))

CreateARPanelOptions(CP_Priest, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('DZUtEdLTgEVfeCrCfksqnCcaBgJgbDLMmEApWbhKiUSOoEGzcqTzICvQVBMLlByaWVzdC5Db21tb25z'))

--Holy
CreateARPanelOptions(CP_Holy_General, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('SKtUbrJHSdpnEeivzqrGaAjdEIZJUjFdDRCQprnNPtsWkPzBHVpBfPxQVBMLlByaWVzdC5Ib2x5LkdlbmVyYWw='))
CreateARPanelOptions(CP_Holy_Cooldown, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('zYrGDyprzqrsGfyKIKuTlrvmqnJbrgNaNgPsfxdlFlWCblnBaCsKuerQVBMLlByaWVzdC5Ib2x5LkNvb2xkb3du'))
CreateARPanelOptions(CP_Holy_Defensive, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('DQuPYrGhsmkTZZflRseSbsHezgQVcioxhRTFMPiKlpUbztMAuPURgqbQVBMLlByaWVzdC5Ib2x5LkRlZmVuc2l2ZQ=='))
CreateARPanelOptions(CP_Holy_Damage, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('niKkinhtSGtGuyeXpekjKXfloALmkVUUmvDOCfkhdVfNOaBDGJDrNfYQVBMLlByaWVzdC5Ib2x5LkRhbWFnZQ=='))
CreateARPanelOptions(CP_Holy_Healing, dktnkDJWbWatBXjZEvIkDdgysEMEtEOKDFdIdWNAv('lcYRFiLPydhyybhxqzeyubdRHJqRXuaDGZYAUBxLRIJoBRZzUfeJfusQVBMLlByaWVzdC5Ib2x5LkhlYWxpbmc='))
    