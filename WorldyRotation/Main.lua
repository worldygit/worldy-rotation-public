local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local WR = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Spell = HL.Spell;
local GUI = HL.GUI;
local CreatePanelOption = GUI.CreatePanelOption;

-- Lua
local mathmax = math.max;
local mathmin = math.min;
local tonumber = tonumber;
local tostring = tostring;
local type = type;
-- File Locals
local PrevResult, CurrResult;

--- ============================ CONTENT ============================
--- ======= BINDINGS =======
BINDING_HEADER_WORLDYROTATION = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('HglXYQmjuKZcmIzEjcyiLBZvtDRVcwsPXJFoNvHdokFpScytPpzRnOcV29ybGR5Um90YXRpb24=');
BINDING_NAME_WORLDYROTATION_TOGGLE = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('AzfaAskbngyvErCSvNcgBQhzbpXJUpnfzkVwQQAWSPKAlMvLIifxJcnVG9nZ2xlIE9uL09mZg==');
BINDING_NAME_WORLDYROTATION_CDS = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('oXrMaNkPyPkPXQgSMIsOVgIgtbksBQjLrKIfMVMsLHsrHIQqKGxSUfZVG9nZ2xlIENEcw==');
BINDING_NAME_WORLDYROTATION_AOE = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('eNlboLorLdSdwiAvKofFqnydZupxzeEuDwnAWWNCOwNuvWXviOInhZxVG9nZ2xlIEFvRQ==');

--- ======= MAIN FRAME =======
WR.MainFrame = CreateFrame(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('UuvhCRjbdZuhRRvPSdScUWjiTiPkIFserzMKOPUAQrXAQRJADjNrOmKRnJhbWU='), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('GpptLDsnWtCdTmsHSuyOXvMhewrBUWGATxxizBFJSdmfuzAjPtMJTxUV29ybGR5Um90YXRpb25fTWFpbkZyYW1l'), UIParent);
WR.MainFrame:SetFrameStrata(WR.GUISettings.General.MainFrameStrata);
WR.MainFrame:SetFrameLevel(10);
WR.MainFrame:SetSize(5, 1); -- 1 Validation | 2 Toggle | 3 Cds | 4 AoE | 5 Keybind
WR.MainFrame:SetPoint(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('tiPpynAlyfTLsoYsTbIETVzVjlTIPTiLoMTvlWfzXoGmGiTBVvchWdDVE9QTEVGVA=='), 0, 0);
WR.MainFrame:SetIgnoreParentAlpha(true);
WR.MainFrame:SetIgnoreParentScale(true);
WR.MainFrame:SetClampedToScreen(true);
WR.MainFrame.Textures = {};
WR.MainFrame.Macros = {};

function WR.MainFrame:Resize ()
  local _, screenHeight = GetPhysicalScreenSize()
  local scaleFactor = 768 / screenHeight
  if self:GetScale() ~= scaleFactor then
    self:SetScale(scaleFactor)
  end
end

function WR.MainFrame:CreatePixelTexture (pixel)
  WR.MainFrame.Textures[pixel] = WR.MainFrame:CreateTexture();
  WR.MainFrame.Textures[pixel]:SetColorTexture(0,0,0,1);
  WR.MainFrame.Textures[pixel]:SetPoint(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('talpDLQflrYlvGvLNzDscPMeLjobuiWEQHStEAAWrNVraNcnhgkkHtsVE9QTEVGVA=='), WR.MainFrame, pixel, 0);
end

function WR.MainFrame:ChangePixel (pixel, data)
  local number;
  if data == nil then
    number = 0;
  elseif type(data) == CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('YuhtKzlzYSyeJBEvBsDQZtoLSNEyCaTFJgAkopWsjpsyDUVyPykaZqtYm9vbGVhbg==') then
    number = data and 1 or 0;
  else
    number = tonumber(data);
  end
  local c = mathmin(mathmax(number, 0), 16777216);
  local b = c%256;
  local g = ((c-b)/256)%256;
  local r = ((c-b)/65536)-(g/256);
  self.Textures[pixel]:SetColorTexture(r/255, g/255, b/255, 1);
end

function WR.MainFrame:ChangeBind (Bind)
  local BindEx = WR.GetBindInfo(Bind);
  self:ChangePixel(2, BindEx.Key);
  self:ChangePixel(3, BindEx.Mod1);
  self:ChangePixel(4, BindEx.Mod2);
end

function WR.MainFrame:AddMacroFrame (Object)
  self.Macros[Object.MacroID] = CreateFrame(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('JkJGhORcGVdjejUqWKLDIuRvGmAgCfHfaaNhtPthKQlIhklzFyyxLLoQnV0dG9u'), Object.MacroID, self, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('gQWxFSKJpHXqbCydFkvWCPNDwYQbVKEbGeYEaHlAiVFTdEcgNfDyAPIU2VjdXJlQWN0aW9uQnV0dG9uVGVtcGxhdGU='));
  self.Macros[Object.MacroID]:SetAttribute(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('bWGCfzYGnRuEbMtXKfCtKNDzZulkSNcyvMncfhOhCINsewuanHPdXXwdHlwZQ=='), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('agPutPQZjEoyBBajHuPkHjNBDvTiCewZnXtGGojsPCmUJmkYbsBIyXXbWFjcm8='));
  self.Macros[Object.MacroID]:SetAttribute(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('pBxCVrqnXeOzBDwpVjVENviPEZAmkvcHksliwFxDhHRKblKfyZHmmcDbWFjcm90ZXh0'), Object.MacroText);
end

-- AddonLoaded
WR.MainFrame:RegisterEvent(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('RhGvkEoQNNHMZEEiWYHBzzzJgGPelSHGaIAtlAXTDsAxTGLVQyqAhYIQURET05fTE9BREVE'));
WR.MainFrame:RegisterEvent(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('nrDkvxMkbgpNsmGcKjoctaIQIEttdtHWDXSHbjfahGvqtoiNyWpRmnHVkFSSUFCTEVTX0xPQURFRA=='));
WR.MainFrame:RegisterEvent(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('EVebcGoyghQCuetPSSFEpTKJfdKQfqqxhfqfWAolmQqpOTSyTihnRuIVUlfU0NBTEVfQ0hBTkdFRA=='));
WR.MainFrame:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('twGgIWAofjeXHmPhMkpJrbMjLlHtnlgpcnCdilwKCQwTKxsvyPbkgkeT25FdmVudA=='), function (self, Event, Arg1)
  if Event == CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('JsIMAxBpJtkjoiMPgkMVkvwWTahMvAPufsikIwENcXaplmPIuYAalCQQURET05fTE9BREVE') then
    if Arg1 == CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('iPJkwrKCjxDRetmNDsLQpAUoKcskzjmfCRuaskDWhSIYLJhhCAazceEV29ybGR5Um90YXRpb24=') then
      -- Panels
      if type(WorldyRotationDB) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('BZPCvtDKOkPWnZhQRGngheHnKpxicmUVSmMeGNyVwGAMCPTrLKVPxnbdGFibGU=') then
        WorldyRotationDB = {};
      end
      if type(WorldyRotationCharDB) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('TQVPzVvsktOBFSXfkwXKoxbSwaYbVciejoHOcplpJLgmRLWBAqtQaSPdGFibGU=') then
        WorldyRotationCharDB = {};
      end
      if type(WorldyRotationDB.GUISettings) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('fdbNmAJqCzFbZDppaHxhqJRpAhWDNRXuSRRvLcxuguXyPjraRnzeLoqdGFibGU=') then
        WorldyRotationDB.GUISettings = {};
      end
      if type(WorldyRotationCharDB.GUISettings) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('nCOUzGkHSicyPFweJUVNAkbJOfXwXUAfgwbSuuZpAoorMvXbvvKSRgRdGFibGU=') then
        WorldyRotationCharDB.GUISettings = {};
      end
      if type(WorldyRotationCharDB.Toggles) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('nUbXkwezjbwhlEpPSDzbpsrIGUTuxWImxdbyMmLMOqHLnDbDgcQZUpLdGFibGU=') then
        WorldyRotationCharDB.Toggles = {};
      end
      WR.GUI.LoadSettingsRecursively(WR.GUISettings);
      WR.GUI.CorePanelSettingsInit();
      -- UI
      WR.MainFrame:SetFrameStrata(WR.GUISettings.General.MainFrameStrata);
      WR.MainFrame:Show();
      -- Pixel
      for i=0, 4 do
        WR.MainFrame:CreatePixelTexture(i);
        if type(WorldyRotationCharDB.Toggles[i]) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('RFKgpbeCwGnAlSgadiQKdgmImmlRXGYfqmwmWaMWVcBJCKmRuOHMOdOYm9vbGVhbg==') then
          WorldyRotationCharDB.Toggles[i] = true;
        end
      end
      WR.MainFrame:ChangePixel(0, 424242);
      WR.MainFrame:ChangePixel(1, WR.ON());

      WR.ToggleFrame:Init();

      -- Load additionnal settings
      local CP_General = GUI.GetPanelByName(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('vOLSdSWoFbqzELsStIkeMTBMziXcRyXfvjfkTBtvgldREYaBHTlxsdZR2VuZXJhbA=='))
      if CP_General then
        CreatePanelOption(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('XULSHkuHFzXyumOSCGidtZvzFMXJzAFFvMitaVdqZZBEIKAIJkpehGoQnV0dG9u'), CP_General, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('QMOdXlSbHdynYzmdasFdKFmanGgnZkutIFCduwrkbBpemtmyArmDdzQQnV0dG9uTW92ZQ=='), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('QOMdaNzpoMAnqgTcdHNpZUVsYZdMKOSEFwzSBGENymivrUkgQvqRfZaTG9jay9VbmxvY2s='), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('DsqkpNuMSbnoEjmmIdNkACASsYWOxEQmZKMJESGApPjCCZZIaNMTnLHRW5hYmxlIHRoZSBtb3Zpbmcgb2YgdGhlIGZyYW1lcy4='), function() WR.ToggleFrame:ToggleLock(); end);
      end

      -- Modules
      C_Timer.After(2, function ()
        WR.MainFrame:UnregisterEvent(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('xMuXbojFZUlcBRgxQliQWLIzYTVXyjKvORyBCcxuIdWkgbKkNLyMSmuQURET05fTE9BREVE'));
        WR.PulseInit();
      end
      );
    end
  elseif Event == CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('WdrMQVmjaWPcEkpXbsgJHgshqwOKMhsrhUhquOSbBFJxvSQUBEkdtsNVkFSSUFCTEVTX0xPQURFRA==') or Event == CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('RukIbNimExBplQJGLSOtAbIrVwoaJuXSZSCziNgrHJipsWqCYPHfRDAVUlfU0NBTEVfQ0hBTkdFRA==') then
    WR.MainFrame:Resize()
  end
end
);

--- ======= TOGGLE FRAME =======
WR.ToggleFrame = CreateFrame(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('wIBKTXiIuVOCaSlYRxaWlEmIkOuGBSepgaTNokQmavnMBoSPBCGIUrCRnJhbWU='), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('hrmCaKYAeGNHmuOnbGYPwMJfPLYuQvCKTFfBxXQiTgfyEAldjZmmjmyV29ybGR5Um90YXRpb25fVG9nZ2xlRnJhbWU='), UIParent);
WR.ToggleFrame:SetFrameStrata(WR.MainFrame:GetFrameStrata());
WR.ToggleFrame:SetFrameLevel(WR.MainFrame:GetFrameLevel() - 1);
WR.ToggleFrame:SetSize(64, 20);
WR.ToggleFrame:SetPoint(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('TiHctRJCUDFOeVOJfAdWHfwdfoUZgvByQtjaJdNAZuLbKTDAXhtWgEAQ0VOVEVS'), 0, 0);
WR.ToggleFrame:SetClampedToScreen(true);

function WR.ToggleFrame:Unlock ()
  -- Unlock the UI
  self:EnableMouse(true);
  self:SetMovable(true);
  WorldyRotationDB.Locked = false;
end
function WR.ToggleFrame:Lock ()
  self:EnableMouse(false);
  self:SetMovable(false);
  WorldyRotationDB.Locked = true;
end
function WR.ToggleFrame:ToggleLock ()
  if WorldyRotationDB.Locked then
    self:Unlock();
    WR.Print(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('AvuaoBoZzQLujxtpaHDSkrzewAdpiZkmwnNDgUSJOsGsgiYvWAsqhoHVUkgaXMgbm93IHxjZmYwMGZmMDB1bmxvY2tlZHxyLg=='));
  else
    self:Lock ();
    WR.Print(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('VJsSiHJKpxkTTDcPYBBKdWqEZIWGnBINURMQzgXOBvsXLSLsIIkBnEBVUkgaXMgbm93IHxjZmZmZjAwMDBsb2NrZWR8ci4='));
  end
end

function WR.ToggleFrame:Init ()
  -- Frame Init
  self:SetFrameStrata(WR.MainFrame:GetFrameStrata());
  self:SetFrameLevel(WR.MainFrame:GetFrameLevel() - 1);
  self:SetWidth(64);
  self:SetHeight(20);

  -- Anchor based on Settings
  if WorldyRotationDB and WorldyRotationDB.ToggleFramePos then
    self:SetPoint(WorldyRotationDB.ToggleFramePos[1], WorldyRotationDB.ToggleFramePos[2], WorldyRotationDB.ToggleFramePos[3], WorldyRotationDB.ToggleFramePos[4], WorldyRotationDB.ToggleFramePos[5]);
  else
    self:SetPoint(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('KkOEPJyHgQvAGKodbHniJGvCVrbZMhlYLlvdvuMipwOdeznADUHxZmJQ0VOVEVS'), 0, 0);
  end

  -- Start Move
  local function StartMove (self)
    if self:IsMovable() then
      self:StartMoving();
    end
  end
  self:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('BtPfWZffiWBVezptyWuAcdWdebPTzyYXtQQgQPFXLIRXUzAMqmyEQbWT25Nb3VzZURvd24='), StartMove);
  -- Stop Move
  local function StopMove (self)
    self:StopMovingOrSizing();
    if not WorldyRotationDB then WorldyRotationDB = {}; end
    local point, relativeTo, relativePoint, xOffset, yOffset, relativeToName;
    point, relativeTo, relativePoint, xOffset, yOffset = self:GetPoint();
    if not relativeTo then
      relativeToName = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('VZHWGutGjCTEkfPhnCScKejZJHAGzksagGdgCouPGWPaUAoWPLWJcQKVUlQYXJlbnQ=');
    else
      relativeToName = relativeTo:GetName();
    end
    WorldyRotationDB.ToggleFramePos = {
      point,
      relativeToName,
      relativePoint,
      xOffset,
      yOffset
    };
  end
  self:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('NmMKxJCptVRdNCTrskpIaEvdCMNJTcebOHhJqQcdvGMpjQZDkhVvbpQT25Nb3VzZVVw'), StopMove);
  self:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('uwEJiClVFEqEDIbLmgecnDPqRQefjeBFAOBgPMOJiTAaOrJsMdBpERIT25IaWRl'), StopMove);
  self:Lock();
  self:Show();

  -- Button Creation
  self.Button = {};
  self:AddButton(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('IojjKavPbSjpEpFJHGCcxORWcyKulEBTApnqXRTksZaveGNkAwAzRkrTw=='), 1, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('TegVDfXUTRmWOfPXvsoAsDSuDmudCdqtPrvVLYcKUHSSZYDrdJdTzADT24vT2Zm'), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('yZbCoZxGZbsGiVFIIKnGVRMPSGVCDxmQwqJqkctdVgiYekQnkYYgNnadG9nZ2xl'));
  self:AddButton(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('pArkeImRlHVMGGONZLfCdoaSjEDqZaBdGvmJEfAagkgxoVytRIxFaCmQw=='), 2, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('YPJPSdFacgsoWjDWBAinUdxnNTuEqMkblQqeLrQuLOcYNAZYuwsFwiFQ0Rz'), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('JgEbpUapYtafxdgWsRrzozJIiGsmkPoXLUWapRWSpuMoqFuVYGPBCVlY2Rz'));
  self:AddButton(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('TaysZIUDmCdlsSZpzXPpuBnzniCWIXDspiSGUTwIEkhKiuNtkjHVlIjQQ=='), 3, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('JqozcEwIeFZcihoHXSoCiLznlKcvVONsOOlAyWIPkUzWOZqfWdKFrceQW9F'), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('mDtAaUaSgxHKnZOIjuGXxkLdVgakkEQElleLioqFmMnDjYXXRqAcPvEYW9l'));
end
-- Add a button
function WR.ToggleFrame:AddButton (Text, i, Tooltip, CmdArg)
  local ButtonFrame = CreateFrame(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('FBSzGtQbaLhfymfmHwxQzwYqeQtPxsGbVjYipkftkuUjvlxUUXoFsWHQnV0dG9u'), CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('kjthDcSQxGAkIEmFeyggCdHCITafaiBMgWDSNDFwJGHbRHoArxLNNkzJHBhcmVudEJ1dHRvbg==')..tostring(i), self);
  ButtonFrame:SetFrameStrata(self:GetFrameStrata());
  ButtonFrame:SetFrameLevel(self:GetFrameLevel() - 1);
  ButtonFrame:SetWidth(20);
  ButtonFrame:SetHeight(20);
  ButtonFrame:SetPoint(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('KlXIXGMbCHVuYHuEvdUoqctOPYpUWIOCeUZSLKLYJghCrVicNelawNcTEVGVA=='), self, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('gSTaPYpSfJPMFiYjeOtXAomMCVAHhpDyNsjSQzYEoDnRCmGVLIFjpepTEVGVA=='), 20*(i-1)+i, 0);

  -- Button Tooltip (Optional)
  if Tooltip then
    ButtonFrame:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('loEZyZVWHHnNbiDkhVlrIhDNCoNYgdvbyVSHWveVBTqmmscNmZXBSbRT25FbnRlcg=='),
        function ()
          Mixin(GameTooltip, BackdropTemplateMixin);
          GameTooltip:SetOwner(WR.ToggleFrame, CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('QFQEGvtqDcaralHPICNFhcnwTmyXirbNeIWZNMCckQlXbvBRmHReqpzQU5DSE9SX0JPVFRPTQ=='), 0, 0);
          GameTooltip:ClearLines();
          GameTooltip:SetBackdropColor(0, 0, 0, 1);
          GameTooltip:SetText(Tooltip, nil, nil, nil, 1, true);
          GameTooltip:Show();
        end
    );
    ButtonFrame:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('DNdXZtreQDxUiiLQMxOHNkRyoogLXRIOUEXUpMuPBINTSFzBlVQSuuWT25MZWF2ZQ=='),
        function ()
          GameTooltip:Hide();
        end
    );
  end

  -- Button Text
  ButtonFrame:SetNormalFontObject(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('YDslJcjXngDTDlRCMErSXSCEbDKhMTufcSXsHKlorxNZLfgzwWJRexcR2FtZUZvbnROb3JtYWxTbWFsbA=='));
  ButtonFrame.text = Text;

  -- Button Texture
  local NormalTexture = ButtonFrame:CreateTexture();
  NormalTexture:SetTexture(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('ismEHDOTSZYmOzDdBsXXwdTGMpvzemaFabdRSnDgaEfYdBRjuNFbhdkSW50ZXJmYWNlL0J1dHRvbnMvVUktU2lsdmVyLUJ1dHRvbi1VcA=='));
  NormalTexture:SetTexCoord(0, 0.625, 0, 0.7875);
  NormalTexture:SetAllPoints();
  ButtonFrame:SetNormalTexture(NormalTexture);
  local HighlightTexture = ButtonFrame:CreateTexture();
  HighlightTexture:SetTexture(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('jdzcJcUgJRSJnnOTmQQnnEPCGRdqOeLwfblmNTodKQZRQCvJTvkYleNSW50ZXJmYWNlL0J1dHRvbnMvVUktU2lsdmVyLUJ1dHRvbi1IaWdobGlnaHQ='));
  HighlightTexture:SetTexCoord(0, 0.625, 0, 0.7875);
  HighlightTexture:SetAllPoints();
  ButtonFrame:SetHighlightTexture(HighlightTexture);
  local PushedTexture = ButtonFrame:CreateTexture();
  PushedTexture:SetTexture(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('ePojHAnnZcVfKpipkOLlljegGUXdThAXLRtZYeefiSVLxExYOLiKkSiSW50ZXJmYWNlL0J1dHRvbnMvVUktU2lsdmVyLUJ1dHRvbi1Eb3du'));
  PushedTexture:SetTexCoord(0, 0.625, 0, 0.7875);
  PushedTexture:SetAllPoints();
  ButtonFrame:SetPushedTexture(PushedTexture);

  -- Button Setting
  if type(WorldyRotationCharDB) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('hSWPDhBSbrocLLuWTzzyhoUlJakrsSPteMYwhWnByKctiZyXGZlgfqGdGFibGU=') then
    WorldyRotationCharDB = {};
  end
  if type(WorldyRotationCharDB.Toggles) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('IaXklkuvBuwYotlEdeSDeUUuhdLlVXAROVBdKnZczzEehJSUSXBATTsdGFibGU=') then
    WorldyRotationCharDB.Toggles = {};
  end
  if type(WorldyRotationCharDB.Toggles[i]) ~= CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('TLSpVXfvhEpCZQcnNsLNBNfiEKyjZkegCzAvgYJXAFXmvIsydhKJAtPYm9vbGVhbg==') then
    WorldyRotationCharDB.Toggles[i] = true;
  end

  -- OnClick Callback
  ButtonFrame:SetScript(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('mXngXVsaDTiKiaOuYevnqznviYEYjUbJrsRoSDyCXPzZNzhJGGbFhhnT25Nb3VzZURvd24='),
      function (self, Button)
        if Button == CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('kyRTdJUyXwLIKxWJIxrbkXuVjlAtzySffMSAykojsJxPZhQVTGTWmhtTGVmdEJ1dHRvbg==') then
          WR.CmdHandler(CmdArg);
        end
      end
  );

  self.Button[i] = ButtonFrame;

  WR.ToggleFrame:UpdateButtonText(i);

  ButtonFrame:Show();
end
-- Update a button text
function WR.ToggleFrame:UpdateButtonText (i)
  if WorldyRotationCharDB.Toggles[i] then
    self.Button[i]:SetFormattedText(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('paBnLBKvFKbhQKzSFkGPkimHmxejMpZxLnITVSWRkltLebsAXomKCYLfGNmZjAwZmYwMCVzfHI='), self.Button[i].text);
  else
    self.Button[i]:SetFormattedText(CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('GnpEnMAtQMPfitcVmIoYmDcXWGZkQsTswsTNCjpAxaTEnEWMlfQfAzwfGNmZmZmMDAwMCVzfHI='), self.Button[i].text);
  end
end

--- ======= MAIN =======
local EnabledRotation = {
  ---- Death Knight
  [250]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('IFSQqNUNXDiCTuPEkjuzKeJxHUXfpsoFMJOnQXZsCpQgfUAkZGJptQhV29ybGR5Um90YXRpb25fRGVhdGhLbmlnaHQ='),   -- Blood
  --  [251]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('SfofEnygReLhwDQFphBsRUEJNPSQaSQkXCuWcgiUreoOEgukUOsgzxCV29ybGR5Um90YXRpb25fRGVhdGhLbmlnaHQ='),   -- Frost
  --  [252]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('kwPHgmIQdnXqtLUiaubgCXAAgzkbnBmIXjlzsPWYaJFxuLYmUKnBLmDV29ybGR5Um90YXRpb25fRGVhdGhLbmlnaHQ='),   -- Unholy
  ---- Demon Hunter
  --  [577]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('IWFEiZtHMbemSEanjzpGIrJMtkXCFfTfbLhSrJkBalVeKReaLhEyECJV29ybGR5Um90YXRpb25fRGVtb25IdW50ZXI='),   -- Havoc
  --  [581]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('FauELRtZgBqFsCyTOvATyLuWgblIPWizMBHyjOINrhUfrodkGlSDVJhV29ybGR5Um90YXRpb25fRGVtb25IdW50ZXI='),   -- Vengeance
  ---- Druid
  --  [102]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('QHhmurUKMqOxCKpEXyAovAoEaLtIrundXuLcYmxOpXiYSTUOiXMlWYSV29ybGR5Um90YXRpb25fRHJ1aWQ='),         -- Balance
  --  [103]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('FOMmnxBlGytTuIRExFAHWUajRbzWcVYHDiQcAMRreqOxroYeCbISgLKV29ybGR5Um90YXRpb25fRHJ1aWQ='),         -- Feral
  --  [104]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('ajLHEzkRmRhWpMqaaHzmaYQZnzPXEfBnhqPqpYJwZUmwbQotqzgqVDOV29ybGR5Um90YXRpb25fRHJ1aWQ='),         -- Guardian
  --  [105]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('MVYeEYSXmmeSjvBtCFNsAavwZvTblYlDTvrXBPdMhmuxlmHOlxaWukXV29ybGR5Um90YXRpb25fRHJ1aWQ='),         -- Restoration
  ---- Hunter
  --  [253]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('vGrHdLJpUbPjuMHlFbiKzoepitJQuzMxlZCmEgpQYEjPExcKGFszKRPV29ybGR5Um90YXRpb25fSHVudGVy'),        -- Beast Mastery
  --  [254]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('yiBkwnbqCEfJzhdGPNSfYnwTJoLwtyYATNGkfjfizxXFXJrJEtAiuuTV29ybGR5Um90YXRpb25fSHVudGVy'),        -- Marksmanship
  --  [255]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('FNIVTRmLZyVJCWIgxEYOAVWTjLBmxehStXDNOHUYjQTnJEtTXnCJnnpV29ybGR5Um90YXRpb25fSHVudGVy'),        -- Survival
  ---- Mage
  --  [62]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('BaCdVdnNqpkztdjaBWmqwOnZRfCLHvDsywSTGhkOKjFGTcWyxYzjPQEV29ybGR5Um90YXRpb25fTWFnZQ=='),          -- Arcane
  --  [63]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('qMElYKHRzCsSEmzTIiENMIKxgHsOucgHLkPpAdObUOHWkbCjNAZpPhkV29ybGR5Um90YXRpb25fTWFnZQ=='),          -- Fire
  --  [64]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('FZTrkFrWIRgwtWPabfumYVmGCwfCGKAQnVzIIxjYDMVUtpXUWalZScHV29ybGR5Um90YXRpb25fTWFnZQ=='),          -- Frost
  ---- Monk
  --  [268]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('RyASSXsivGoxCMnFgSxmZLvkgxVmRGHexYwmHXAliMzqnedRGFaAdzCV29ybGR5Um90YXRpb25fTW9uaw=='),          -- Brewmaster
  --  [269]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('vIYvUmaRBIUPdAvOeERTqlKynnqvWRRdxsdsKneuBtbsLjiVPxYSnWCV29ybGR5Um90YXRpb25fTW9uaw=='),          -- Windwalker
  --  [270]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('fEeqOirQqENBrbJRmKijHfHtBlUWRhiinPPkBeJtHrpbFDJAgXVBvKYV29ybGR5Um90YXRpb25fTW9uaw=='),          -- Mistweaver
  ---- Paladin
  --  [65]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('VkeTyxeavntPhBaAESXdXjJxozrbexNGieyyxVePuGKGuZBofAHgUpqV29ybGR5Um90YXRpb25fUGFsYWRpbg=='),       -- Holy
  --  [66]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('NsCteSTQQhIzgSTGgSYzaIYLvwNkTTJBFUtegTlonXKAPmfOxIgtySBV29ybGR5Um90YXRpb25fUGFsYWRpbg=='),       -- Protection
  --  [70]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('nhcIFfmrBoYHawdnVMBUJjoSRRbHRkySCaVucMBpgMjCxfsbgfGEQKnV29ybGR5Um90YXRpb25fUGFsYWRpbg=='),       -- Retribution
  -- Priest
  --  [256]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('uYbQDpPvGCvSjOMYsAfgrhlExFpDIBfCOFEPMlABzdkTCHnecsYKopoV29ybGR5Um90YXRpb25fUHJpZXN0'),        -- Discipline
  [257]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('usLnIppTBKaTgPWtmvMChkanBBANnGCPlPaCRavVHfeoyBnmfPmbimVV29ybGR5Um90YXRpb25fUHJpZXN0'),        -- Holy
  --  [258]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('uJtUXQHczfLGSIycePYrRYmyfdbtuBYUFDxJsXigKTbKLunOQaHijJGV29ybGR5Um90YXRpb25fUHJpZXN0'),        -- Shadow
  ---- Rogue
  --  [259]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('naOExgLMeImWJudDWndKUQaHLamlvXwNJxAnuzyWbZLgFQacWqaiUSvV29ybGR5Um90YXRpb25fUm9ndWU='),         -- Assassination
  --  [261]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('igQKFGRXSNGIDDEXIhrmcCiYFzNfMmWDOPuYPZxDRJGhDyZhWhsqmIuV29ybGR5Um90YXRpb25fUm9ndWU='),         -- Subtlety
  [260]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('dLXKwAWiQKcfbADFIODwKFxpglbYEFsfUipPQUkUjiVMEpyuMJdRgwpV29ybGR5Um90YXRpb25fUm9ndWU='),         -- Outlaw
  ---- Shaman
  --  [262]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('JvjTezytqzaaOUXVVrkzzDJknOivwLbNNEeOUwnCnqXzXOHPLWITjInV29ybGR5Um90YXRpb25fU2hhbWFu'),        -- Elemental
  --  [263]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('jQmjYmjHEiBXTrkPWLoiDcbJNpHINBRuVrtzhQZjElJnzWDqNJcZmJfV29ybGR5Um90YXRpb25fU2hhbWFu'),        -- Enhancement
  --  [264]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('fplxNWZFuykJMbkfPIBaHCoYqzfIFgrFooNLruqaaEiyGfqcZPtXGQzV29ybGR5Um90YXRpb25fU2hhbWFu'),        -- Restoration
  ---- Warlock
  --  [265]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('oogxDfbdgWRaFUeJAAWFgUMBsmWVxeSocjQBwVdHXnozEZBAkRwrSnGV29ybGR5Um90YXRpb25fV2FybG9jaw=='),       -- Affliction
  --  [266]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('LvIgxZvgBucVaaUwTKGbLyDnEvssjgXNfJWxMeabBJXectOtBmiSJnfV29ybGR5Um90YXRpb25fV2FybG9jaw=='),       -- Demonology
  --  [267]   = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('LQDtCpUJdlaZgOJagwuWWunFJcQQdYJIPtiuNEOgyymTnWwpZTiPfeOV29ybGR5Um90YXRpb25fV2FybG9jaw=='),       -- Destruction
  ---- Warrior
  [71]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('PUHLpKjmNNKzdbkdEFzfWrAFFhKAzxLWdmcGguUqyCRHQlbBMRQnUJlV29ybGR5Um90YXRpb25fV2Fycmlvcg=='),       -- Arms
  [72]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('FVhneBIpkgAPKYWAspiWKNhGLQTePiEvLhScbhLgeFQtoNXbwNmandyV29ybGR5Um90YXRpb25fV2Fycmlvcg=='),       -- Fury
  [73]    = CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('KiHTcnIRXneSyiohkTFvsayVuifRVkEcMqFYdFPyefawgTqXZzzFrGLV29ybGR5Um90YXRpb25fV2Fycmlvcg==')        -- Protection
};
local LatestSpecIDChecked = 0;
function WR.PulseInit ()
  local Spec = GetSpecialization();
  -- Delay by 1 second until the WoW API returns a valid value.
  if Spec == nil then
    HL.PulseInitialized = false;
    C_Timer.After(1, function ()
      WR.PulseInit();
    end
    );
  else
    -- Force a refresh from the Core
    Cache.Persistent.Player.Spec = {GetSpecializationInfo(Spec)};
    local SpecID = Cache.Persistent.Player.Spec[1];

    -- Delay by 1 second until the WoW API returns a valid value.
    if SpecID == nil then
      HL.PulseInitialized = false;
      C_Timer.After(1, function ()
        WR.PulseInit();
      end
      );
    else
      -- Load the Class Module if itCHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('YkvWWKTpZBAPfiaJBkTRvBtvSoBgvihPlHyTtRoSSSkhJHGAyXsHktGcyBwb3NzaWJsZSBhbmQgbm90IGFscmVhZHkgbG9hZGVkDQogICAgICBpZiBFbmFibGVkUm90YXRpb25bU3BlY0lEXSBhbmQgbm90IElzQWRkT25Mb2FkZWQoRW5hYmxlZFJvdGF0aW9uW1NwZWNJRF0pIHRoZW4NCiAgICAgICAgTG9hZEFkZE9uKEVuYWJsZWRSb3RhdGlvbltTcGVjSURdKTsNCiAgICAgICAgSEwuTG9hZE92ZXJyaWRlcyhTcGVjSUQpDQogICAgICBlbmQNCg0KICAgICAgLS0gQ2hlY2sgaWYgdGhlcmUgaXMgYSBSb3RhdGlvbiBmb3IgdGhpcyBTcGVjDQogICAgICBpZiBMYXRlc3RTcGVjSURDaGVja2VkIH49IFNwZWNJRCB0aGVuDQogICAgICAgIGlmIEVuYWJsZWRSb3RhdGlvbltTcGVjSURdIGFuZCBXUi5BUExzW1NwZWNJRF0gdGhlbg0KICAgICAgICAgIFdSLk1haW5GcmFtZTpTaG93KCk7DQogICAgICAgICAgV1IuTWFpbkZyYW1lOlNldFNjcmlwdCg=')OnUpdateCHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('odMgOuxVFlrgKMUapkEIdlVDKeibiUsCEQXcFFLiuDxcFqEmtVWmRroLCBXUi5QdWxzZSk7DQogICAgICAgICAgLS0gU3BlYyBSZWdpc3RlcnMNCiAgICAgICAgICAtLSBTcGVsbHMNCiAgICAgICAgICBQbGF5ZXI6UmVnaXN0ZXJMaXN0ZW5lZFNwZWxscyhTcGVjSUQpOw0KICAgICAgICAgIEhMLlVucmVnaXN0ZXJBdXJhVHJhY2tpbmcoKTsNCiAgICAgICAgICAtLSBFbnVtcyBGaWx0ZXJzDQogICAgICAgICAgUGxheWVyOkZpbHRlclRyaWdnZXJHQ0QoU3BlY0lEKTsNCiAgICAgICAgICBTcGVsbDpGaWx0ZXJQcm9qZWN0aWxlU3BlZWQoU3BlY0lEKTsNCiAgICAgICAgICAtLSBNb2R1bGUgSW5pdCBGdW5jdGlvbg0KICAgICAgICAgIGlmIFdSLkFQTEluaXRzW1NwZWNJRF0gdGhlbg0KICAgICAgICAgICAgV1IuQVBMSW5pdHNbU3BlY0lEXSgpOw0KICAgICAgICAgIGVuZA0KICAgICAgICAgIC0tIFNwZWNpYWwgQ2hlY2tzDQogICAgICAgICAgaWYgR2V0Q1Zhcig=')nameplateShowEnemiesCHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('sTflgwQregmAnveBaDZlkrRvVTzTPjjfmfUTRQSifzBPfQNRUdvroxvKSB+PSA=')1CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('adBHdYTKPxQvhKYqqzTUqCcOyjmoMgncnklDctADAiUMZsfOoWFYCSBIHRoZW4NCiAgICAgICAgICAgIFdSLlByaW50KA==')It looks like enemy nameplates are disabled, you should enable them in order to get proper AoE rotation.CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('TNLSvkyoKKEVZbaPlZAyHqyaIdUdVNavBCYfSriFMaAJHWzFSiwXaMaKTsNCiAgICAgICAgICBlbmQNCiAgICAgICAgZWxzZQ0KICAgICAgICAgIFdSLlByaW50KA==')No Rotation found for this class/spec (SpecID: CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('MxURStnEVQdmvzvgoindcoGDxEJDKiHHqlsVCpHgVIrfzLsnCDYRzWZLi4gU3BlY0lEIC4uIA==')), addon disabled. This is likely due to the rotation being unsupported at this time. Please check supported rotations.CHOHyzHKONZuLSkJgyfDyxeGKyUIVudQnxagsnBiNWKQakTrGPzLXUmFUQkXufjsUowYAUVZikwjTQIrVzHofgx('OtYANHOsveGvisjsbZdFOrYVbSMLooWEKAfOWzuTECbGFgDpLHsNNYIKTsNCiAgICAgICAgICBXUi5NYWluRnJhbWU6SGlkZSgpOw0KICAgICAgICAgIFdSLk1haW5GcmFtZTpTZXRTY3JpcHQo')OnUpdate', nil);
        end
        LatestSpecIDChecked = SpecID;
      end
      if not HL.PulseInitialized then HL.PulseInitialized = true; end
    end
  end
end

WR.Timer = {
  Pulse = 0
};
function WR.Pulse ()
  if GetTime() > WR.Timer.Pulse then
    WR.Timer.Pulse = GetTime() + HL.Timer.PulseOffset;

    -- Check if the current spec is available (might not always be the case)
    -- Especially when switching from area (open world -> instance)
    local SpecID = Cache.Persistent.Player.Spec[1];
    if SpecID then
      -- Check if we are ready to cast something to save FPS.
      if WR.ON() and WR.Ready() and not WR.Pause() then
        HL.CacheHasBeenReset = false;
        Cache.Reset();
        -- Rotational Debug Output
        if WR.GUISettings.General.Enabled.RotationDebugOutput then
          CurrResult = WR.APLs[SpecID]();
          if CurrResult and CurrResult ~= PrevResult then
            WR.Print(CurrResult);
            PrevResult = CurrResult;
          elseif CurrResult == nil then
            WR.MainFrame:ChangeBind(nil);
            PrevResult = nil;
          end
        else
          if WR.APLs[SpecID]() == nil then
            WR.MainFrame:ChangeBind(nil);
          end
        end
      else
        WR.MainFrame:ChangeBind(nil);
        PrevResult = nil;
      end
    end
  end
end

function WR.Ready ()
  return not Player:IsDeadOrGhost() and not Player:IsMounted() and not Player:IsInVehicle() and not C_PetBattles.IsInBattle() and not ACTIVE_CHAT_EDIT_BOX;
end

function WR.Pause()
  return WR.GUISettings.General.Enabled.ShiftKeyPause and IsShiftKeyDown();
end

function WR.Break()
  WR.ChangePulseTimer(Player:GCD() + 0.05);
end

-- Used to force a short/long pulse wait, it also resets the icons.
function WR.ChangePulseTimer (Offset)
  WR.MainFrame:ChangeBind(nil);
  WR.Timer.Pulse = GetTime() + Offset;
end
    