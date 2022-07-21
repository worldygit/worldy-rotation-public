local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function sOWCvIbUTovUEqPcAFb(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
  -- Addon
  local addonName, WR = ...;
  -- HeroLib
  local HL = HeroLib;
  local Cache, Utils = HeroCache, HL.Utils;
  local Unit = HL.Unit;
  local Player = Unit.Player;
  local Target = Unit.Target;
  local Spell = HL.Spell;
  local Item = HL.Item;
  -- Lua
  local error = error
  local tableinsert = table.insert;
  local tableremove = table.remove;
  local mathmin = math.min;
  local pairs = pairs;
  local print = print;
  local select = select;
  local setmetatable = setmetatable
  local stringlower = string.lower;
  local strsplit = strsplit;
  local strsplittable = strsplittable;
  local tostring = tostring;
  local type = type
  -- File Locals


--- ======= GLOBALIZE =======
  -- Addon
  WorldyRotation = WR;

--- ============================ CONTENT ============================
--- ======= CORE =======
  -- Print with WR Prefix
  function WR.Print (...)
    print(sOWCvIbUTovUEqPcAFb('GxWMFtFeLKYCmwOKWaigkkkRwqjtxIUpZFPlnTXsfMHyFRuwraVbynPW3xjRkZGRjY2MDBXb3JsZHkgUm90YXRpb258cl0='), ...);
  end

  -- Defines the APL
  WR.APLs = {};
  WR.APLInits = {};
  function WR.SetAPL (Spec, APL, APLInit)
    WR.APLs[Spec] = APL;
    WR.APLInits[Spec] = APLInit;
  end

  -- Define Macro
  local function Class()
    local Class = {}
    Class.__index = Class
    setmetatable(Class, {
      __call =
      function(self, ...)
        local Object = {}
        setmetatable(Object, self)
        Object:New(...)
        return Object
      end
    })
    return Class
  end

  local Macro = Class()
  WR.Macro = Macro
  
  function Macro:New(MacroID, MacroText)
    if type(MacroID) ~= sOWCvIbUTovUEqPcAFb('mHAqElnquloowhCvMXOWyoMarQQZPSEEyPSfuniduWWVdxxSXIOcikec3RyaW5n') then error(sOWCvIbUTovUEqPcAFb('EGFSxroPFwOOcWODeNtBnZAmCccAZMttNJTxoBMldMGlFUPUsSZHJgrSW52YWxpZCBNYWNyb0lELg==')) end
    if type(MacroText) ~= sOWCvIbUTovUEqPcAFb('xCSkjIaQMQOmVaePPTBXlpwrqlQMSwMYnBGHXNQuReigQKWzqJObonSc3RyaW5n') then error(sOWCvIbUTovUEqPcAFb('FCKEZeSmiltDbdKCjLphPbWjOTUuUkiwjIHMhDAxBQvkRiLNyVgAcVhSW52YWxpZCBNYWNyb1RleHQu')) end
  
    -- Attributes
    self.MacroID = MacroID
    self.MacroText = MacroText
  end

--- ======= CASTS =======
  -- Main Cast
do
  local QuakingDebuffId = Spell(240447);
  local PoolResource = 999910;
  function WR.Cast (Object, OutofRange, Immovable, OffGCD)
    local SpellID = Object.SpellID;
    local ItemID = Object.ItemID;
    local MacroID = Object.MacroID;
    local Usable = MacroID or Object:IsUsable();
    local ShowPooling = Object.SpellID == PoolResource;
    if ShowPooling or not Usable or OutofRange or (Immovable and (Player:IsMoving() or Player:DebuffUp(QuakingDebuffId, true))) or (not OffGCD and (Player:CastEnd() - HL.Latency() > 0 or Player:GCDRemains() - HL.Latency() > 0)) then
      WR.MainFrame:ChangeBind(nil);
      Object.LastDisplayTime = GetTime();
      return false;
    end

    local Bind;
    if SpellID then
      Bind = WR.SpellBinds[SpellID];
      if not Bind then
        WR.Print(tostring(SpellID) .. sOWCvIbUTovUEqPcAFb('jCcPvPcGAeMPgWcgtvihBnQEOKgzWyfThiFzrgtYzHoJLZzNHasOwvEIGlzIG5vdCBib3VuZC4='));
      end
    elseif ItemID then
      Bind = WR.ItemBinds[ItemID];
      if not Bind then
        WR.Print(tostring(ItemID) .. sOWCvIbUTovUEqPcAFb('eNYrzvysTbxLrBYUUiEJdqXvQqlaXMrBBnAHKajoejIWHnDFozdkEQRIGlzIG5vdCBib3VuZC4='));
      end
    elseif MacroID then
      Bind = WR.MacroBinds[MacroID];
      if not Bind then
        WR.Print(tostring(MacroID) .. sOWCvIbUTovUEqPcAFb('NvysbCxEaLEkArxbQfIMtNBGvEslYzuEgtDeiDyORjzKnYPxxDNsOxZIGlzIG5vdCBib3VuZC4='));
      end
    end

    WR.MainFrame:ChangeBind(Bind);
    Object.LastDisplayTime = GetTime();
    return true;
  end
end

--- ======= BINDS =======
  -- Main Bind
  do
    local CommonKeys = {
      sOWCvIbUTovUEqPcAFb('VOKXRSVsjWlyEbwAJdgqsgNWoGQARCMxvgbmdxnxqPsWvuKOLRKRIijMQ=='), sOWCvIbUTovUEqPcAFb('tiRBNvXXYbOnqZpSKyVDddHnufogPajbavZqGjDMaXWqAGzQmswKINFMg=='), sOWCvIbUTovUEqPcAFb('MyDHzudbtkumuXAlRiLStTouQKSsrgHaDSOEewnKVRViuXsRmuzZtGiMw=='), sOWCvIbUTovUEqPcAFb('btfUhWJAGYkGYKYYakwFNtKpdGGNdptWkcFxFGcVaVRRQgMhTmlkoZINA=='), sOWCvIbUTovUEqPcAFb('EpabodVsudvowJcYDzPxRsvebXPFfSdXLICWnqZzCmHjQpdSoVxqjINNQ=='), sOWCvIbUTovUEqPcAFb('pEIQFDxYdPFkAwKcULrVByUlRIStFZYtMhKPNHpkixUawkwlMOyaAIvNg=='), sOWCvIbUTovUEqPcAFb('aJGVBLujVPclQcExdiognQgbSBgFbaKYhBQjSdlQNwwmEkrxDhbNIXbSg=='), sOWCvIbUTovUEqPcAFb('JudkkDffwZVlYxwiImxvLTXNKBlSKLFiLDRtUMycGIewfBnFCYeAWRASw=='), sOWCvIbUTovUEqPcAFb('OVcdYovPNtOziJhBtNqgwyvAkgYlRUgpFRdfiVRfVxWUueuADlAllFQTA==')
    };
    local UncommonKeys = {
      sOWCvIbUTovUEqPcAFb('teMxMgdxlxjrDlRUsavTxeevasyzWbxhYPFXlSzuqzQpeZIkUdHlFBdRjE='), sOWCvIbUTovUEqPcAFb('LMGOYxcuGOCWFTvmcezzcMnilpSkNYnFtFLdUiHuXFALXKUZpiqnfPURjI='), sOWCvIbUTovUEqPcAFb('cyRAqhxTxcmhjeGUZwjLeoumDueUwfoaiuosbuxkoxdlFoeBZjBSaOARjM='), sOWCvIbUTovUEqPcAFb('bAvQvzCZwHRHEVoHNfPEwhChHxqINFShWGGCKjGBNAwaUIiLHkLJEGHRjQ='), sOWCvIbUTovUEqPcAFb('AzhbxJCngAJyrJLrHcREdgRTAcdpSgFlNLWPVuHbJDQBrPmVeXfROFWRjU='), sOWCvIbUTovUEqPcAFb('dWlkcurnOhXstxuwCLRzHYsNBqOHHpdAsUeMkeRyqGBwSOoNxQoGgWdRjY='),
      sOWCvIbUTovUEqPcAFb('xoVnTqNeqIJRLDBUlnKIFigcQOBFNPUHIvFArAtAmkKgYrrSnFuWhtITnVtcGFkIDA='), sOWCvIbUTovUEqPcAFb('OpAHtwgSVXGaIaOrDVGqYUczyTbpShgaQTPdKFPILFkrSRdAryevsbETnVtcGFkIDE='), sOWCvIbUTovUEqPcAFb('ybSqzlARxyOuusYUDGjZwfbeWXBjYylTpTWqPSexRswYUyEQbgRrGhmTnVtcGFkIDI='), sOWCvIbUTovUEqPcAFb('OGEAAMdOpIBiifYPJRUUEICXNufmSdgvmihWvCFUYUOUWvHoZTBzKQtTnVtcGFkIDM='), sOWCvIbUTovUEqPcAFb('CFQDqjISGDumdxdxbOenrOFQYIGKamFWiMgkAgedUEiVKWsEGZBAjcoTnVtcGFkIDQ='), sOWCvIbUTovUEqPcAFb('RHcdhJbAFPLzMYICWnLFeSzPIQBNgedtJvHIfwhcLyUClGwBNYRbPGUTnVtcGFkIDU='), sOWCvIbUTovUEqPcAFb('wSuLBgzvzrKYvaNvfRNuKqTdqacBmidfOxxCfhMibXeOrJUPOdAtACXTnVtcGFkIDY='), sOWCvIbUTovUEqPcAFb('hfGhytbLimmNtYUPsdgEzhCTnSBolQuijgyPRFFXcrKKjBxvxtFQyWrTnVtcGFkIDc='), sOWCvIbUTovUEqPcAFb('VJaELZzbCwHjTQNAsUZLdzNbPQyYQglUCMsbGYACqjvMTqVTYwFnEteTnVtcGFkIDg='), sOWCvIbUTovUEqPcAFb('EarUOVwvvXNJsPxHTYFwrsmtVGndPnezDbpEEWDrDAlmDdFFgOwzbiSTnVtcGFkIDk='), sOWCvIbUTovUEqPcAFb('zqLuIKvglwMDRZJjdQgdHqXzawBjOSMiosoTlAGKKNIJOwNejBTiikDTnVtcGFkICs='), sOWCvIbUTovUEqPcAFb('WMZCvbctIjrfGDVpHFKvjPbWmUZXouAlAnrqpqsCznqlZqQfKcBrpSfTnVtcGFkIC0='),
      sOWCvIbUTovUEqPcAFb('QLjjuebLimfLQLIGWNSrkLLpsNQDXLvaTJPrZzKbSxoosZULFmnprLCWw=='), sOWCvIbUTovUEqPcAFb('elDwYEHctgSfUtfKBsJuKIpzlZvWeGFqheLtfCasyxoHHXLlVsdVPGoXQ=='), sOWCvIbUTovUEqPcAFb('lSGrxntcZPCJZwBynUGBGvPoKIcWTRYNIxarqSdBFQDUxMkjHiObrIPXA=='), sOWCvIbUTovUEqPcAFb('pIuRAGrTotacyzciyPnmbtnwWgEzhWCugvpcDPxPDUrUaKeLFOwXlLhOw=='), sOWCvIbUTovUEqPcAFb('GFVncPyKebfZETDLopwkMynXlQRxJIytXNHvGPWcFVJGwrqLWGyDrfY')sOWCvIbUTovUEqPcAFb('VpsMOqftrdWpmFvGzSCVfIkPYsjQgWUIiYMHvuLoZJKPgaBNwwKXHxgLCA=')`sOWCvIbUTovUEqPcAFb('oXjPchxAMvsasxXXKisSAHRdrkNKdnibqZfApgTdIJJmXtgzgIcLDYZLCA='),sOWCvIbUTovUEqPcAFb('lnAvaaDJWxGIaPzQUgIYcbiAJQWCCYQddJnWMHHOopGhuzTAmrYhdMILCA=').sOWCvIbUTovUEqPcAFb('xIQNYEqxCdhPWrxFBOHZlgWdKtbGEQLLSuMssDNUbIyseuzjaLMarErLCA=')/sOWCvIbUTovUEqPcAFb('UQwwboWgNxJSjDnIaUeZcZGxdeKWHJsIeLuDQvLpImVDHRDRQDelBMkDQogICAgfTsNCiAgICBsb2NhbCBSYXJlS2V5cyA9IHsNCiAgICAgIA==')7sOWCvIbUTovUEqPcAFb('SQUXctEhwcxdPqzVfDdWAYRCBZqfPXOpjoqkLkZghaBOoGtPOphFIinLCA=')8sOWCvIbUTovUEqPcAFb('IVIgMbaHgzBhElEfEiONLaxVkhEnDeyPTguoZgxQlnpkdIdQbiDNskHLCA=')9sOWCvIbUTovUEqPcAFb('fsLPWRAjFeKYMYqYraccHOztGSOOiIHFoYMFYokWmOeCfZxNbGAoMraLCA=')0sOWCvIbUTovUEqPcAFb('rbUqVwbnZHPsDDKpRrZVUxKfcHdFiOfDLGkxCVsaeeiuaDDUGnTqGIOLCA=')-sOWCvIbUTovUEqPcAFb('fsghCVcfylEVAduWmSENCiISmdJTpgepUTOtanTpFfIxWBMxcIRTyItLCA=')=sOWCvIbUTovUEqPcAFb('JvCczGlDKQrTREQpxeIYpEZDUNZahPUfgkFxrNRkTbvElzvrxOasivtLA0KICAgICAg')F7sOWCvIbUTovUEqPcAFb('SYHiFlOayyMfVrkPfLwsvTgabgCFkAGgYkkMHhgeNqRqECAxizSkNptLCA=')F8sOWCvIbUTovUEqPcAFb('ZwLohaBPfiEZHUZiAMtzsHshNHXkrHXjBJlikvmFSEpvcVyCvssrkdRLCA=')F9sOWCvIbUTovUEqPcAFb('RwKSHySEpeGxTyYLnhNwHljsHBIYvahRLZcgvWSpMoYYivcKwIteyRpLCA=')F10sOWCvIbUTovUEqPcAFb('pAPOUHeXAIBQJHdzrPAHHsZQUsIqYLKRkEMjTMJXWwPMDjNOBExhgMGLCA=')F11sOWCvIbUTovUEqPcAFb('YGkNmttvSYdULmyNgUybDPBlJzUBxaOTxqirnVYJrgZmXLaQXtXHMrwLCA=')F12sOWCvIbUTovUEqPcAFb('VswLGYvuafSPJHHvJSQksmomqnEDLhvuYBHnGAOUnSOrfNnsHztZulUDQogICAgfTsNCiAgICBsb2NhbCBNb2RpZmllcktleXMgPSB7DQogICAgICA=')SHIFT:sOWCvIbUTovUEqPcAFb('rJEBlMrBYQbOUnrVwDSlelztRjBAmZSxssEncCHYhMXwtKwSpwQSSTrLCA=')CTRL:sOWCvIbUTovUEqPcAFb('TbdCFUPCIxCAizTJhOaAjVKETimZIgljMbGQJQtsffVBLkpjEKXQzKlLCA=')ALT:sOWCvIbUTovUEqPcAFb('snFncsnrVcojEnJYWlxTNqWcwTGntsxfqmpcMApKvHRFcenopqPVgIVDQogICAgfTsNCiAgICBsb2NhbCBNb2RpZmllcktleUNvbWJzID0gew0KICAgICAg')CTRL:SHIFT:sOWCvIbUTovUEqPcAFb('gAfTWucaXJPksGTqIATNRYECSjlZCgnIOPluCZWaHhprUUhRKQYeKUiLCA=')ALT:SHIFT:sOWCvIbUTovUEqPcAFb('FeQRKpbdaXMOJZbphlDnDsovWCoLrsJFAmaKLLXSYAaiNfDuOWKoIvDDQogICAgfTsNCiAgICBXUi5TcGVsbEJpbmRzID0ge307DQogICAgV1IuSXRlbUJpbmRzID0ge307DQogICAgV1IuTWFjcm9CaW5kcyA9IHt9Ow0KICAgIFdSLlNwZWxsT2JqZWN0cyA9IHt9Ow0KICAgIFdSLkl0ZW1PYmplY3RzID0ge307DQogICAgV1IuTWFjcm9PYmplY3RzID0ge307DQogICAgV1IuRnJlZUJpbmRzID0ge307DQogICAgV1IuU2V0dXBGcmVlQmluZHMgPSB0cnVlOw0KICAgIEhMOlJlZ2lzdGVyRm9yRXZlbnQoZnVuY3Rpb24oKQ0KICAgICAgV1IuUmViaW5kKCk7DQogICAgZW5kLCA=')PLAYER_TALENT_UPDATEsOWCvIbUTovUEqPcAFb('KzToslZGvaHQnyOePQcuGlENRVlwHlntuIahRJiRlAgnmHrVVRiinvPKQ0KICAgIGZ1bmN0aW9uIFdSLkJpbmQgKE9iamVjdCkNCiAgICAgIGlmIFdSLlNldHVwRnJlZUJpbmRzIHRoZW4NCiAgICAgICAgV1IuQWRkRnJlZUJpbmRzKENvbW1vbktleXMpOw0KICAgICAgICBXUi5BZGRGcmVlQmluZHMoVW5jb21tb25LZXlzKTsNCiAgICAgICAgV1IuQWRkRnJlZUJpbmRzKFJhcmVLZXlzKTsNCiAgICAgICAgV1IuU2V0dXBGcmVlQmluZHMgPSBmYWxzZTsNCiAgICAgIGVuZA0KICAgICAgbG9jYWwgQmluZCA9IFdSLkZyZWVCaW5kc1sjV1IuRnJlZUJpbmRzXTsNCiAgICAgIHRhYmxlcmVtb3ZlKFdSLkZyZWVCaW5kcywgI1dSLkZyZWVCaW5kcyk7DQogICAgICBXUi5VbmJpbmQoQmluZCk7DQogICAgICBsb2NhbCBTcGVsbElEID0gT2JqZWN0LlNwZWxsSUQ7DQogICAgICBsb2NhbCBJdGVtSUQgPSBPYmplY3QuSXRlbUlEOw0KICAgICAgbG9jYWwgTWFjcm9JRCA9IE9iamVjdC5NYWNyb0lEOw0KICAgICAgaWYgU3BlbGxJRCB0aGVuDQogICAgICAgIFNldEJpbmRpbmdTcGVsbChCaW5kOmdzdWIo'):sOWCvIbUTovUEqPcAFb('JyRcyvqmXNNpjPjCdcUiAccBYgUtSgHWZLSEpaKWJizIqFVFWlIiilKLCA=')-sOWCvIbUTovUEqPcAFb('wBybwCMeSlCrOMlkLiTbuSgVhFBLKrIRoBGAcBKGxUtxKQFeveKqmEhKSwgT2JqZWN0Ok5hbWUoKSk7DQogICAgICAgIFdSLlNwZWxsQmluZHNbU3BlbGxJRF0gPSBCaW5kOw0KICAgICAgICBXUi5TcGVsbE9iamVjdHNbU3BlbGxJRF0gPSBPYmplY3Q7DQogICAgICBlbHNlaWYgSXRlbUlEIHRoZW4NCiAgICAgICAgU2V0QmluZGluZ0l0ZW0oQmluZDpnc3ViKA=='):sOWCvIbUTovUEqPcAFb('RpFtehqehNbIyNckFPKUHojwAGQnMGOtGKvLFWSIXToyQWwgulfpeTQLCA=')-sOWCvIbUTovUEqPcAFb('GjeZjURuXwBGOJnmIyVsKRKJdsIJFsXuZcLMypyyFIFzkBsSGKjbTxBKSwgT2JqZWN0Ok5hbWUoKSk7DQogICAgICAgIFdSLkl0ZW1CaW5kc1tJdGVtSURdID0gQmluZDsNCiAgICAgICAgV1IuSXRlbU9iamVjdHNbSXRlbUlEXSA9IE9iamVjdDsNCiAgICAgIGVsc2VpZiBNYWNyb0lEIHRoZW4NCiAgICAgICAgV1IuTWFpbkZyYW1lOkFkZE1hY3JvRnJhbWUoT2JqZWN0KTsNCiAgICAgICAgU2V0QmluZGluZ0NsaWNrKEJpbmQ6Z3N1Yig='):sOWCvIbUTovUEqPcAFb('eyWeYrtxoEoZfQkdglDmtVjTMcTKQIqbsSvvClftTKGALjxRqGcMEwhLCA=')-sOWCvIbUTovUEqPcAFb('dbJJIMrLwwgUCGlhKpYQkxbhKrljHqOPaFrlcxagyiQJWLRnGFWKqhXKSwgTWFjcm9JRCk7DQogICAgICAgIFdSLk1hY3JvQmluZHNbTWFjcm9JRF0gPSBCaW5kOw0KICAgICAgICBXUi5NYWNyb09iamVjdHNbTWFjcm9JRF0gPSBPYmplY3Q7DQogICAgICBlbmQNCiAgICBlbmQNCiAgICBmdW5jdGlvbiBXUi5VbmJpbmQgKEtleSkNCiAgICAgIGxvY2FsIE51bUJpbmRpbmdzID0gR2V0TnVtQmluZGluZ3MoKTsNCiAgICAgIGZvciBpID0gMSwgTnVtQmluZGluZ3MgZG8NCiAgICAgICAgbG9jYWwgS2V5MSwgS2V5MiA9IEdldEJpbmRpbmdLZXkoR2V0QmluZGluZyhpKSk7DQogICAgICAgIGlmIEtleTEgPT0gS2V5IG9yIEtleTIgPT0gS2V5IHRoZW4NCiAgICAgICAgICBTZXRCaW5kaW5nKEtleSk7DQogICAgICAgIGVuZA0KICAgICAgZW5kDQogICAgZW5kDQogICAgZnVuY3Rpb24gV1IuQWRkRnJlZUJpbmRzIChLZXlzKQ0KICAgICAgZm9yIGkgPSAxLCAjS2V5cyBkbw0KICAgICAgICB0YWJsZWluc2VydChXUi5GcmVlQmluZHMsIEtleXNbaV0pOw0KICAgICAgICBmb3IgaiA9IDEsICNNb2RpZmllcktleXMgZG8NCiAgICAgICAgICB0YWJsZWluc2VydChXUi5GcmVlQmluZHMsIE1vZGlmaWVyS2V5c1tqXSAuLiBLZXlzW2ldKTsNCiAgICAgICAgZW5kDQogICAgICAgIGZvciBqID0gMSwgI01vZGlmaWVyS2V5Q29tYnMgZG8NCiAgICAgICAgICB0YWJsZWluc2VydChXUi5GcmVlQmluZHMsIE1vZGlmaWVyS2V5Q29tYnNbal0gLi4gS2V5c1tpXSk7DQogICAgICAgIGVuZA0KICAgICAgZW5kDQogICAgZW5kDQogICAgZnVuY3Rpb24gV1IuUmViaW5kICgpDQogICAgICBXUi5GcmVlQmluZHMgPSB7fTsNCiAgICAgIFdSLlNldHVwRnJlZUJpbmRzID0gdHJ1ZTsNCiAgICAgIGZvciBJZCwgXyBpbiBwYWlycyhXUi5TcGVsbEJpbmRzKSBkbw0KICAgICAgICBXUi5CaW5kKFdSLlNwZWxsT2JqZWN0c1tJZF0pOw0KICAgICAgZW5kDQogICAgICBmb3IgSWQsIF8gaW4gcGFpcnMoV1IuSXRlbUJpbmRzKSBkbw0KICAgICAgICBXUi5CaW5kKFdSLkl0ZW1PYmplY3RzW0lkXSk7DQogICAgICBlbmQNCiAgICAgIGZvciBJZCwgXyBpbiBwYWlycyhXUi5NYWNyb0JpbmRzKSBkbw0KICAgICAgICBXUi5CaW5kKFdSLk1hY3JvT2JqZWN0c1tJZF0pOw0KICAgICAgZW5kDQogICAgZW5kDQogIGVuZA0KDQotLS0gPT09PT09PSBDT01NQU5EUyA9PT09PT09DQogIC0tIENvbW1hbmQgSGFuZGxlcg0KICBmdW5jdGlvbiBXUi5DbWRIYW5kbGVyIChNZXNzYWdlKQ0KICAgIGxvY2FsIEFyZ3VtZW50ID0gc3Ryc3BsaXQo') sOWCvIbUTovUEqPcAFb('HHyFWDZcmIeOgrHhgUxQyiXkPyyTcpuJpusRNVNBBRenGFbxCJKuqtxLCBzdHJpbmdsb3dlcihNZXNzYWdlKSk7DQogICAgaWYgQXJndW1lbnQgPT0g')togglesOWCvIbUTovUEqPcAFb('luHrmLFCdPkPcXCdOAvoXDnxRJooXokttmrEOUzgqkKlTBpZLheJLJYIHRoZW4NCiAgICAgIFdvcmxkeVJvdGF0aW9uQ2hhckRCLlRvZ2dsZXNbMV0gPSBub3QgV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1sxXTsNCiAgICAgIFdSLlByaW50KA==')WorldyRotation is now sOWCvIbUTovUEqPcAFb('nPdRHEYpkfVDgjgKKizIXRiJmluRUrbGRyFbOXHjrSuKnwChvmACGnrLi4oV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1sxXSBhbmQg')|cff00ff00enabled|r.sOWCvIbUTovUEqPcAFb('hzzttsEkohhwEEvcNatFshPBHwLxrdyTKugRaYPPjHHKXdWmufQBaEYIG9yIA==')|cffff0000disabled|r.sOWCvIbUTovUEqPcAFb('CbWYdGwbIFcxKKyOkaBqgwXXIIXfTNaSmxIMNDhPYzkswkYIlnmzcQuKSk7DQogICAgICBXUi5NYWluRnJhbWU6Q2hhbmdlUGl4ZWwoMSwgV1IuT04oKSk7DQogICAgICBXUi5Ub2dnbGVGcmFtZTpVcGRhdGVCdXR0b25UZXh0KDEpOw0KICAgIGVsc2VpZiBBcmd1bWVudCA9PSA=')cdssOWCvIbUTovUEqPcAFb('yiuPORcHlZuwiUZKnkUJOZGRHNLYbUWjWlVuKMpGuBqSXlEfSQDBDczIHRoZW4NCiAgICAgIFdvcmxkeVJvdGF0aW9uQ2hhckRCLlRvZ2dsZXNbMl0gPSBub3QgV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1syXTsNCiAgICAgIFdSLlByaW50KA==')CDs are now sOWCvIbUTovUEqPcAFb('RbjlwADRaBMwWVyGsAnPCqjyetnFobpgSMDliiTZfkmHrFKvLcUyOHqLi4oV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1syXSBhbmQg')|cff00ff00enabled|r.sOWCvIbUTovUEqPcAFb('sJkNpMrYuMDzakzzInqoqfezstbMsPyhsRdPjnihzyYWTIZgLthAeLKIG9yIA==')|cffff0000disabled|r.sOWCvIbUTovUEqPcAFb('rDacYhngooBmMNTYXJiSWKpVWoTUMGLtmiMcrsoacPMYrWdoDNqhNUfKSk7DQogICAgICBXUi5Ub2dnbGVGcmFtZTpVcGRhdGVCdXR0b25UZXh0KDIpOw0KICAgIGVsc2VpZiBBcmd1bWVudCA9PSA=')aoesOWCvIbUTovUEqPcAFb('HwVHnvWAPlauPiwqgquIvNEYSyZuyfykXpAeESFCMUfgIdknGGuBmEeIHRoZW4NCiAgICAgIFdvcmxkeVJvdGF0aW9uQ2hhckRCLlRvZ2dsZXNbM10gPSBub3QgV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1szXTsNCiAgICAgIFdSLlByaW50KA==')AoE is now sOWCvIbUTovUEqPcAFb('NsSCFvIWMBpGJzbYLNjkVFgfbbsLpiNMJACvZZIdVKCvBTrPQrlxCRtLi4oV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1szXSBhbmQg')|cff00ff00enabled|r.sOWCvIbUTovUEqPcAFb('UJsCQjXgfmpsaIuflmpKSReVdzsNocxVXkiBRdAYcOCoDDMaPsdixblIG9yIA==')|cffff0000disabled|r.sOWCvIbUTovUEqPcAFb('GDdERvyPWAuAkrwzIkAljQMpcUfqoFCBLmQYqTUCjuSbVmxwTzNCniiKSk7DQogICAgICBXUi5Ub2dnbGVGcmFtZTpVcGRhdGVCdXR0b25UZXh0KDMpOw0KICAgIGVsc2VpZiBBcmd1bWVudCA9PSA=')locksOWCvIbUTovUEqPcAFb('gVMTUZsbWSHGrEqqBXzbVYprJYKnoPNfJQYkTqYdPvCuzTQwEBfVdoAIHRoZW4NCiAgICAgIFdSLlRvZ2dsZUZyYW1lOlRvZ2dsZUxvY2soKTsNCiAgICBlbHNlaWYgQXJndW1lbnQgPT0g')breaksOWCvIbUTovUEqPcAFb('URedVuOnHkNXavjBVzloZacZuzaaSgHTLdBUzVINBoXdzzNyxTsEdaEIHRoZW4NCiAgICAgIFdSLkJyZWFrKCk7DQogICAgZWxzZWlmIEFyZ3VtZW50ID09IA==')helpsOWCvIbUTovUEqPcAFb('rgvLcDYffTCdifCCNHJaAooFpTznQZzAeNzlMQrtLEWcZtrNKJugbkrIHRoZW4NCiAgICAgIFdSLlByaW50KA==')|cffffff00--[Toggles]--|rsOWCvIbUTovUEqPcAFb('CPIDgWdKnbdGjEhByqcffEbvmUukegQltXMyKAOkrbfjKEeJQGycdnlKTsNCiAgICAgIFdSLlByaW50KA==')  On/Off: |cff8888ff/wr toggle|rsOWCvIbUTovUEqPcAFb('ULDugBlMxXrIEJxeOkCnKDMMMExNhxOrsRzJINQTKhjOVkfYBSSxjsiKTsNCiAgICAgIFdSLlByaW50KA==')  CDs: |cff8888ff/wr cds|rsOWCvIbUTovUEqPcAFb('rbevnfJupnIqJNSYfhgzvoIYXDYPDCyUjipSxvIJpzInFRqgNFGJgEdKTsNCiAgICAgIFdSLlByaW50KA==')  AoE: |cff8888ff/wr aoe|rsOWCvIbUTovUEqPcAFb('ylLFrlqgOzgkAucriSEbguHKXXdXyjbFVjcnGMFPrwcSCjOIrvbjFERKTsNCiAgICAgIFdSLlByaW50KA==')  Un-/Lock: |cff8888ff/wr lock|rsOWCvIbUTovUEqPcAFb('uebxXfXMdruYhvRfTmDeHljGQNdBqMqFpYCXBMEvhynkMFkGVsWDfYrKTsNCiAgICAgIFdSLlByaW50KA==')  Break: |cff8888ff/wr break|rsOWCvIbUTovUEqPcAFb('MEhQqLHtUYQCnnekuvENyLqOxWQMJgXqxOyVSNstkZcmxHXLbHNdrWsKTsNCiAgICBlbHNlDQogICAgICBXUi5QcmludCg=')Invalid arguments.sOWCvIbUTovUEqPcAFb('LzNBjGVGjpsdBtuHqtEAziskTzlOqEjBTVjffrzVGkNjRGZVSXXLwMjKTsNCiAgICAgIFdSLlByaW50KA==')Type |cff8888ff/wr help|r for more infos.sOWCvIbUTovUEqPcAFb('xxmXUObWjnJMLAhWjWsrWEIGnEXvemzByxjLJbYOmYcPIkBSrZszVhXKTsNCiAgICBlbmQNCiAgZW5kDQogIFNMQVNIX1dPUkxEWVJPVEFUSU9OMSA9IA==')/wrsOWCvIbUTovUEqPcAFb('fRHcGOCDbqSJsifZLXsBzSQnlHejixqqhthmRemiUpDMKXsmlBncwMqDQogIFNsYXNoQ21kTGlzdFs=')WORLDYROTATIONsOWCvIbUTovUEqPcAFb('CoHERWiStRiIHUvKZSqSlSarkuXpdWeGZPpEAzpFUcKdPVCyubXkfhkXSA9IFdSLkNtZEhhbmRsZXI7DQoNCiAgLS0gR2V0IGlmIHRoZSBtYWluIHRvZ2dsZSBpcyBvbi4NCiAgZnVuY3Rpb24gV1IuT04gKCkNCiAgICByZXR1cm4gV29ybGR5Um90YXRpb25DaGFyREIuVG9nZ2xlc1sxXTsNCiAgZW5kDQoNCiAgLS0gR2V0IGlmIHRoZSBDRHMgYXJlIGVuYWJsZWQuDQogIGZ1bmN0aW9uIFdSLkNEc09OICgpDQogICAgcmV0dXJuIFdvcmxkeVJvdGF0aW9uQ2hhckRCLlRvZ2dsZXNbMl07DQogIGVuZA0KDQogIC0tIEdldCBpZiB0aGUgQW9FIGlzIGVuYWJsZWQuDQogIGRvDQogICAgbG9jYWwgQW9FSW1tdW5lTlBDSUQgPSB7DQogICAgICAtLS0gTGVnaW9uDQogICAgICAgIC0tLS0tIER1bmdlb25zICg3LjAgUGF0Y2gpIC0tLS0tDQogICAgICAgIC0tLSBNeXRoaWMrIEFmZml4ZXMNCiAgICAgICAgICAtLSBGZWwgRXhwbG9zaXZlcyAoNy4yIFBhdGNoKQ0KICAgICAgICAgIFsxMjA2NTFdID0gdHJ1ZQ0KICAgIH0NCiAgICAtLSBEaXNhYmxlIHRoZSBBb0UgaWYgd2UgdGFyZ2V0IGFuIHVuaXQgdGhhdCBpcyBpbW11bmUgdG8gQW9FIHNwZWxscy4NCiAgICBmdW5jdGlvbiBXUi5Bb0VPTiAoKQ0KICAgICAgcmV0dXJuIFdvcmxkeVJvdGF0aW9uQ2hhckRCLlRvZ2dsZXNbM10gYW5kIG5vdCBBb0VJbW11bmVOUENJRFtUYXJnZXQ6TlBDSUQoKV07DQogICAgZW5kDQogIGVuZA0KDQogIC0tIEdldCBiaW5kIGluZm8uDQogIGRvDQogICAgbG9jYWwgS2V5Q29kZSA9IHsNCiAgICAgIFs=')1sOWCvIbUTovUEqPcAFb('YmNxwGALzIkiIcxKCcZKzMRsLXUAOcKOIRPLkLpLqwnjEAVDNAXfzptXSA9IDIsDQogICAgICBb')2sOWCvIbUTovUEqPcAFb('IkINXupDrWnHrPRlvcnoOmduTjSPBIPDjJUkjPcJilloSlowGXZdLSqXSA9IDMsDQogICAgICBb')3sOWCvIbUTovUEqPcAFb('jUeLmhWfAofQNpsYThCApqdJgQgMZExmdZkAzOAJRQzAItRqDPwvwgBXSA9IDQsDQogICAgICBb')4sOWCvIbUTovUEqPcAFb('dSjfjFUmDmibOJLtLqLQvmeRGCMMbeeUFqrRuXoUAKMKCEHmDPRqsOfXSA9IDUsDQogICAgICBb')5sOWCvIbUTovUEqPcAFb('RzPcauLrIAhcBNZWxqPmdBGUNqQQHOrJZjXlOaRZJVrSMYzbikFjgERXSA9IDYsDQogICAgICBb')6sOWCvIbUTovUEqPcAFb('QsjojaBWFOkdUbnTyrCzswuYwLUsppWqjWZSxXnCwMqjIjqfAAVKmhYXSA9IDcsDQogICAgICBb')7sOWCvIbUTovUEqPcAFb('LPEJxYaAPuwNyjFADijOiYTRwKiAlLFEUQIRYLMXJNRtERSkcTiWCCvXSA9IDgsDQogICAgICBb')8sOWCvIbUTovUEqPcAFb('CUIIPyDPncEvddhFWnaVmmgEVrcZkbScDRkRHoCKGTBGTsJKjkeHgGoXSA9IDksDQogICAgICBb')9sOWCvIbUTovUEqPcAFb('mrQhwAccrwXqtQBWxQcrAcSdgbjhIdkREBrxvQVPVKLcoVrJWETDFXEXSA9IDEwLA0KICAgICAgWw==')0sOWCvIbUTovUEqPcAFb('ApleChqkbYcsKgCMoDkezJVYYnhLfjdpdQAmixNbMsXatVdOobYgYpyXSA9IDExLA0KICAgICAgWw==')-sOWCvIbUTovUEqPcAFb('XmtYOyRqbNfniJbsjLVUHtAWVAcnkronnSnsNfiTvbPDppqVUAVDuRwXSA9IDEyLA0KICAgICAgWw==')=sOWCvIbUTovUEqPcAFb('TbufaKkfHTAiqPmrbUCQHUlbDgSZFYbXbqTsXtiWUseIyYWzzcHtMLXXSA9IDEzLA0KICAgICAgWw==')QsOWCvIbUTovUEqPcAFb('lgVIHnKeUCseQepteiFrvgnlfCOdiMEPmpUVAcrGFVoPowqjVsqDHBBXSA9IDE2LA0KICAgICAgWw==')WsOWCvIbUTovUEqPcAFb('lXskGJwRVFgaNXZrtyGkkWDkAcWOeoNWTBBNAJaFZjaebssKVxGJoLwXSA9IDE3LA0KICAgICAgWw==')EsOWCvIbUTovUEqPcAFb('xCEKnDHxaBrTHqQGrqPslFhOKJwBDzHZJPYiWNANlzDJsMciKGdAIFPXSA9IDE4LA0KICAgICAgWw==')RsOWCvIbUTovUEqPcAFb('DoIzWeEJSPFAQxSFymglfBHyWibGzPQZXWdorjMykhrnDcMzLXyPZpHXSA9IDE5LA0KICAgICAgWw==')TsOWCvIbUTovUEqPcAFb('NzXphDJsUOQqMdHfFDMqjiSfWJfxGAldFVTYxNCCbmloTOXhQwzMcVOXSA9IDIwLA0KICAgICAgWw==')YsOWCvIbUTovUEqPcAFb('bUykpiTqDcBzTXSZmiPKBTTnTkQBWZXeRUldMytZPwanRRjRYlDefXIXSA9IDIxLA0KICAgICAgWw==')UsOWCvIbUTovUEqPcAFb('uHzquSvvsxymtmoDTwtoYMMBnioGPpskZtXPAFAsqxtjLrfERrfUDJfXSA9IDIyLA0KICAgICAgWw==')IsOWCvIbUTovUEqPcAFb('lOTTcvBTHUvuRknZKiaqYmmgucMKErSXqyrJZHmNWRUTOXvfiJbZyOpXSA9IDIzLA0KICAgICAgWw==')OsOWCvIbUTovUEqPcAFb('XXuwPVxQAOkOWTDEMIzSHiHUvuFdBVJvGQJVlGlymtJXnLWwWrzIemCXSA9IDI0LA0KICAgICAgWw==')PsOWCvIbUTovUEqPcAFb('zFCiSgQjefWXAWpibVXmQkvqqdRrvtVMXsbUfcqspffjmRWZRPskfDwXSA9IDI1LA0KICAgICAgWw==')[sOWCvIbUTovUEqPcAFb('YjyGSnLkfptUjqBEkxbNnooNWOQZTMwBSNOwbuKuQmcYUOYZJwaLyrGXSA9IDI2LA0KICAgICAgWw==')]sOWCvIbUTovUEqPcAFb('JCkEEfRIjGONyTedyQzjsbERlsjLKbGzBdRRJwfliTHFwgURKRqTblSXSA9IDI3LA0KICAgICAgWw==')CTRLsOWCvIbUTovUEqPcAFb('ZVVonFgcJqyOfDvKNYzxBlMlttPTyRxTFSTVkhuFxCbRGtpLXgCdfMSXSA9IDI5LA0KICAgICAgWw==')AsOWCvIbUTovUEqPcAFb('dHovySSgaNMUPwhCnKGCadTlQrybODqchpWAofBWgcWhAErDDkrnYmRXSA9IDMwLA0KICAgICAgWw==')SsOWCvIbUTovUEqPcAFb('EOsojuHVpGdumKgVlTvrnxhwTWnOWGEIOJGQAjhJtAbfOBhKMaZaDuPXSA9IDMxLA0KICAgICAgWw==')DsOWCvIbUTovUEqPcAFb('OCKLPsbLEoezREeYdQHfOorOFzFhRvKlCrTsCPTylvJVUUwypEYRNmUXSA9IDMyLA0KICAgICAgWw==')FsOWCvIbUTovUEqPcAFb('NgEqnHEuFEGufeegsslurPUyjOlTwbWATWQnHSbSZqKULtMCTaROGqVXSA9IDMzLA0KICAgICAgWw==')GsOWCvIbUTovUEqPcAFb('vNDAQgLVHhrnNVoRRedISKgzgqhtLaUhZHwusVoONJCEfoLzloWRHhjXSA9IDM0LA0KICAgICAgWw==')HsOWCvIbUTovUEqPcAFb('TZDICbCHVxHwrOTnqyzGynTVaFeYcBKSGpoNsTtdePUbEYcrsWYvbhNXSA9IDM1LA0KICAgICAgWw==')JsOWCvIbUTovUEqPcAFb('fGghlxoHyxfXrBRFIbLaWXfclYMqvonDshwhYMeFvqEFwYTeSJSfYgwXSA9IDM2LA0KICAgICAgWw==')KsOWCvIbUTovUEqPcAFb('CnTqbGVuEFZAtZSHqnMRibFySUieuUNbAgPlOqluWEAmrMLRVcHmYpjXSA9IDM3LA0KICAgICAgWw==')LsOWCvIbUTovUEqPcAFb('zeVFcIhtOJUUtcwdhTsJeLqccRSjsTkOZLwCHGywZARzeXCxTjGBVEEXSA9IDM4LA0KICAgICAgWw==');sOWCvIbUTovUEqPcAFb('DgWqyLrjwgBuprDbJHrQcrudnOkXyukoazfLnnwXOvIqFFhidgeZguqXSA9IDM5LA0KICAgICAgWw==')sOWCvIbUTovUEqPcAFb('BPslwPTJncFmboeOXZtdohkpjYkeWlPXyDmLxEpbEupcuBYlBbUgcts')] = 40,
      [sOWCvIbUTovUEqPcAFb('fUomHDtzaRPHuGyhQwiavYQhheinFIwZuklvjCZAefMqDTbjlRghuzlYA==')] = 41,
      [sOWCvIbUTovUEqPcAFb('GjpeuEkzyGNDpeaguSqkZLtAeumZZIYmtEKAADuwSEMYseaVsMHQXfxU0hJRlQ=')] = 42,
      [sOWCvIbUTovUEqPcAFb('OVfLkWIOzebJQdXFdZbEctomielrOuWivmZbUJnxrxSbxWWupivJTsNXA==')] = 43,
      [sOWCvIbUTovUEqPcAFb('eQdXIoEsNdXFcmXyLFZZZTklvxywdePEZSedmTZWQDrikFvPZpmWkgVWg==')] = 44,
      [sOWCvIbUTovUEqPcAFb('QPabwJggzhaUheoLHLBVVYOotBHXxNjGwQAvyxJZVflAKSXOtvfeHyaWA==')] = 45,
      [sOWCvIbUTovUEqPcAFb('QQROEkpNxQsogxmDOBiWnEjHaDwgWNegNunJdsTpzAszJvnEFjvcrcGQw==')] = 46,
      [sOWCvIbUTovUEqPcAFb('MeFeUzLZSDDXgtEiQFGpRonRoLWuAqkkgLvfEtpQeiVDyAlsMJzkMskVg==')] = 47,
      [sOWCvIbUTovUEqPcAFb('tSJyARHhcYUPxsvshOGzcOKNAGlnEJMMzgwuPOizgzbbGttOvzgkTIMQg==')] = 48,
      [sOWCvIbUTovUEqPcAFb('cjtgCzYKzJGjEJdZiuCWCpfsgKgHGkflcdjXsbmBDnhJjuTeGLeDIWTTg==')] = 49,
      [sOWCvIbUTovUEqPcAFb('wlrsipXMzUjzUegGzBkPMafrBpeRwHGKHSVtuTauPmJNAuaxXxwptGbTQ==')] = 50,
      [sOWCvIbUTovUEqPcAFb('rgvSXnNConhrfxYbLSmhrhEzominrYiVZKeKvSNxJRFyzZWToFfmSMQLA==')] = 51,
      [sOWCvIbUTovUEqPcAFb('SyfxBfRmLrsvHMHZpdNHurHQPyDFWujjcwjOGbTmcWyUJGXCKtcYYncLg==')] = 52,
      [sOWCvIbUTovUEqPcAFb('ZpuAZxixOKsULCQbBQrWhWnWcRzvkcYeUJgbZTahRvhCUmyVRHVfiTWLw==')] = 53,
      [sOWCvIbUTovUEqPcAFb('RxbiBVIdTQHZIiGWEfgnIftAhkIhOhYZBdSsCQNHQHhZElilgsFBWtxTnVtcGFkIC8=')] = 53,
      [sOWCvIbUTovUEqPcAFb('pNcUGqKTumUgWHKSLstGFlDSfPUbmBAKYZPZSmfOPwSkrTKBaAQKeRTTnVtcGFkICo=')] = 55,
      [sOWCvIbUTovUEqPcAFb('rwLbKlixCjfejCPTwVDWoAMqjhAUxiWMjWqXGAxpGsaZVmYAJfbDeHwQUxU')] = 56,
      [sOWCvIbUTovUEqPcAFb('UbXlZkBVamaTrbpQSRaaHKBVedKsckyJaIbSQQrYyMGwzeKESvIKOWWIA==')] = 57,
      [sOWCvIbUTovUEqPcAFb('OpvKSAqMSooNVYSOnlgddaoYiuJFCkiRvvUIoGEYEneyqRcfACCLsGuRjE=')] = 59,
      [sOWCvIbUTovUEqPcAFb('mdaxDesgqTowShBVysWJtQZawIFPHFwBKiScEDUYaYeBWdBvsdkQQfRRjI=')] = 60,
      [sOWCvIbUTovUEqPcAFb('trmPjWQkAWuWJFTPSqIAkNWrIRuTEcPdjezmEqYPESGyfVRHdJiUPUdRjM=')] = 61,
      [sOWCvIbUTovUEqPcAFb('oAQvYERNWPPwuLMKSuLENXCZypqmzpiTdCnPWjgdqVndEKBoidaHytURjQ=')] = 62,
      [sOWCvIbUTovUEqPcAFb('SNOFZnJZcJaMwqjSCuOoDLsaPzYeMHAAmgXawJkbrRVgfWbERfWeDCIRjU=')] = 63,
      [sOWCvIbUTovUEqPcAFb('sAgrLZuesXjbkvJNvYjjImunjeGPpaYwVXDCnlWGOrMKFbzmSejKFMrRjY=')] = 64,
      [sOWCvIbUTovUEqPcAFb('TWpWlffHpNBXdcYGyQDrtptjKpBglacBRrXNcxiakoglkrOKCWSfBApRjc=')] = 65,
      [sOWCvIbUTovUEqPcAFb('lISYKYlKlWMCZjSasvCmUxVVWFfIzCEgWJanPRqzLwiDBFJxdgjvaOBRjg=')] = 66,
      [sOWCvIbUTovUEqPcAFb('DDFUMEuWakyueBhXrqaYgJhoDCSauNUjFEoNZIbgdrkAniLAdMeIIElRjk=')] = 67,
      [sOWCvIbUTovUEqPcAFb('UWYgHMJxonVYoldyviiAZjDMNzQAbkoFxdOGRzllmhvWAFqnEdKGYMKRjEw')] = 68,
      [sOWCvIbUTovUEqPcAFb('MWpsaPCwqdmngqxnGZxOGHkRoPqJHtVsCvhEAODNBVBomzzblTeoVnZTnVtcGFkIDc=')] = 71,
      [sOWCvIbUTovUEqPcAFb('gAKoFATxAmEIaxBwEEYSGBeqshVFieeKPztflTgndrZuddXrjZMbwKrTnVtcGFkIDg=')] = 72,
      [sOWCvIbUTovUEqPcAFb('tUQqpgllxVdPqdYolJNyhacXtWlOxihMFhcFkOkGtubQsvNVcoOVMjmTnVtcGFkIDk=')] = 73,
      [sOWCvIbUTovUEqPcAFb('ngtTZgduefuOOSgJMDsiDiYaIRQNtsqYWkIIffQsAlhlzaPWfRtwBskTnVtcGFkIDk=')] = 73,
      [sOWCvIbUTovUEqPcAFb('rajOMnWhECxfaMWNvcUfgoNvLcSpsgKwnbaAkPfNAIOOvZNElHJCxXUTnVtcGFkIC0=')] = 74,
      [sOWCvIbUTovUEqPcAFb('WWIxYXOQsFFnCuoDpEaYlRUFoBrDGJDsBQuTHoMzJWrOYaKKdtlaOouTnVtcGFkIDQ=')] = 75,
      [sOWCvIbUTovUEqPcAFb('utQnqwbMEjRQDJIDPdVxgzKjNibVcdjFtEGwWhelnbueRrneBuLNEEGTnVtcGFkIDU=')] = 76,
      [sOWCvIbUTovUEqPcAFb('CbpTNfiFFOxKgcBfQDxJhEYgRfuqltGbgSPZSAqpoQqrulXnXLPZcKqTnVtcGFkIDY=')] = 77,
      [sOWCvIbUTovUEqPcAFb('yBdZauMWeumvQXzlVkEMBfXyBWIFFSUTXxNCndkXqALlEDwJPVpswjzTnVtcGFkICs=')] = 78,
      [sOWCvIbUTovUEqPcAFb('LErbaAkKErGTOrKeOAuJXfPbRraAXrwRLSPMkrXzEYtLTeesWKmyLJETnVtcGFkIDE=')] = 79,
      [sOWCvIbUTovUEqPcAFb('qoJVUbgKtusutPWvPEfMmjQUIMyERBPcfigFwDGFboUXZqkmgyJlLqFTnVtcGFkIDI=')] = 80,
      [sOWCvIbUTovUEqPcAFb('ReHahAXOWKCEDekDGdmBHDRbajQLiFWDdfifJsUjUlSjqfAyxdAldlKTnVtcGFkIDM=')] = 81,
      [sOWCvIbUTovUEqPcAFb('zjEVtXHjHdPVxXVGxoOrKcVhKBnMlmmdHoGklKSJNReSboMtYFGWpBbTnVtcGFkIDA=')] = 82,
      [sOWCvIbUTovUEqPcAFb('UKwjiTuAXqpAFzBjSnVLTspLiWJMiwiGmMIJCoaKmYEkyzNRQKrWpCwRjEx')] = 87,
      [sOWCvIbUTovUEqPcAFb('EwEkeCdaWfAGiGnyubrOdhoDnRPTMqAGZaKoOWpFqQPnHvfwVdIDVPyRjEy')] = 88,
    }
    function WR.GetBindInfo(Bind)
      local Key, Mod1, Mod2;
      if Bind ~= nil then
        local BindParts = strsplittable(sOWCvIbUTovUEqPcAFb('YoKaqTZnGWSSoaEkHpaWxEBoCfxvYgwMNrllHRbwNPAPLfgVGALfreUOg=='), Bind);
        if #BindParts == 1 then
          Key = BindParts[1];
        elseif #BindParts == 2 then
          Mod1 = BindParts[1];
          Key = BindParts[2];
        elseif #BindParts == 3 then
          Mod1 = BindParts[1];
          Mod2 = BindParts[2];
          Key = BindParts[3];
        end
      end
      local BindEx = {};
      if Key then
        BindEx.Key = KeyCode[tostring(Key)];
      end
      if Mod1 then
        BindEx.Mod1 = KeyCode[tostring(Mod1)];
      end
      if Mod2 then
        BindEx.Mod2 = KeyCode[tostring(Mod2)];
      end
      return BindEx;
    end
  end
    