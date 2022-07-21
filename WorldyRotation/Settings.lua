local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
  -- Addon
  local WR = ...;
  -- HeroLib
  local HL = HeroLib;
  -- File Locals
  local GUI = HL.GUI;
  local CreatePanel = GUI.CreatePanel;
  local CreateChildPanel = GUI.CreateChildPanel;
  local CreatePanelOption = GUI.CreatePanelOption;
  local CreateARPanelOptions = WR.GUI.CreateARPanelOptions


--- ============================ CONTENT ============================
  -- Default settings
  WR.GUISettings = {
    General = {
      -- Main Frame Strata
      MainFrameStrata = JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('MOkfYjsVKgoEPuirPlrzHFQgXfZqETOlsMdghyRMjXlaIYVjxVsCldTQkFDS0dST1VORA=='),
      Enabled = {
        -- Pause
        ShiftKeyPause = false,
        -- Interrupt
        Interrupt = false,
        InterruptWithStun = false, -- EXPERIMENTAL
        InterruptOnlyWhitelist = false,
        -- CrowdControl
        CrowdControl = false,
        -- Dispel
        DispelBuffs = false,
        DispelDebuffs = false,
        -- Misc
        Racials = false,
        Potions = false,
        Trinkets = false,
        -- Debug
        RotationDebugOutput = false,
      },
      Threshold = {
        -- Interrupt
        Interrupt = 60,
      },
      HP = {
        Healthstone = 40,
        PhialOfSerenity = 40,
      },
    },
    APL = {}
  };

  function WR.GUI.CorePanelSettingsInit ()
    -- GUI
    local WRPanel = CreatePanel(WR.GUI, JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('licDvpAHapnDHLCxVpePTXjCjVvXduXMifOCZHXReOqoykWwjjFyjKwV29ybGR5Um90YXRpb24='), JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('UYgiNqtafnBijvZMulyEhzRkqRcirCkwbKXvFagjNKpgVPmjTrUmTXXUGFuZWxGcmFtZQ=='), WR.GUISettings, WorldyRotationDB.GUISettings);
    -- Child Panel
    local CP_General = CreateChildPanel(WRPanel, JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('zJnbvpKhZFfjSOeOssYPsVHmlrpKUXcFNaCouoLLOjhxFwHwYllSZNtR2VuZXJhbA=='));
    -- Controls
    CreatePanelOption(JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('coaaJPuHPmxPCZVckNoATIwxdYsykrKqDtVDrZprmOKFvXywUcCwBCLRHJvcGRvd24='), CP_General, JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('zkvtFPvvfaagIiTyjaFPggGzeoXlVLThuvgAeKStoVzyjFfAPFMkxStR2VuZXJhbC5NYWluRnJhbWVTdHJhdGE='), {JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('LFxgYjPCNToxDCzCZUTgNhHoxGIbQneDFDJKYJurfyRhzDvUZbJxdHvSElHSA=='), JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('aErFJqgLEngzhZFGPvgTdRVcPVTnTfhnMdxVZfzrIEVHNKsGFPvCGfpTUVESVVN'), JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('nkTewtohSFndFBPwMHtxBZclslnaDdqKdPNenpZRmncEMKGpOZSeMctTE9X'), JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('QBAchrcLMVnCLeOEZnGSjMZEOzZwOPjNyEyuGuHuKBTWkLOdVWUmlWlQkFDS0dST1VORA==')}, JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('FxYcHobIQNiziahMbLSQENMkcCkXWUyfjzVjgSCIbapNJCkTcMKZXxNTWFpbiBGcmFtZSBTdHJhdGE='), JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('BFJRWLgVVnnEzkQXKHCCvnxFWfcHCEUQbcwibZNthSMzDUPWqolAXDuQ2hvb3NlIHRoZSBmcmFtZSBzdHJhdGEgdG8gdXNlIGZvciBpY29ucy4='), {ReloadRequired = true});
    CreateARPanelOptions(CP_General, JQMIGDkklzXkdunldpkysJcZCUsythbpoSRWWIAByRhJCVtTBBBLvBVKSkNLJBvWZjinVtb('SFvdldFOzjFwuZBDjLJAAxFjdqvAmxhCJloMCQLwdGLbWGMwJJYeAuYR2VuZXJhbA=='))
  end
    