local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
  -- Addon
  local addonName, WR = ...;
  -- HeroLib
  local HL = HeroLib;
  local Utils = HL.Utils;
  -- Lua
  local stringformat = string.format;
  local stringgmatch = string.gmatch;
  local strsplit = strsplit;
  local tableconcat = table.concat;
  -- File Locals
  local CreatePanelOption = HL.GUI.CreatePanelOption;
  local StringToNumberIfPossible = Utils.StringToNumberIfPossible;


--- ============================ CONTENT ============================
  WR.GUI = {};

  function WR.GUI.LoadSettingsRecursively (Table, KeyChain)
    local KeyChain = KeyChain or SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('WZEQQzLEJsPvITnxXFhZhQXrUfekIGyrRaUKKSiITaLeKdHsivpFLso');
    for Key, Value in pairs(Table) do
      -- Generate the NewKeyChain
      local NewKeyChain;
      if KeyChain ~= SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('fjjmZAxPAJkhjzjDZYJEvuaJSkJGLcmZeDvXURerNGxAgLyuqsgedZo') then
        NewKeyChain = KeyChain .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('wiESEHxkBNqntktcsuvTgXOFEndOBysWJEpXHiVkfdeOIFKxcXTZcRALg==') .. Key;
      else
        NewKeyChain = Key;
      end
      -- Continue the table browsing
      if type(Value) == SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('HVCIqmYbSdDRibuLxqJmXZbVOlEcfMHxxowNTOnUvdUzsnalaYIClJTdGFibGU=') then
        WR.GUI.LoadSettingsRecursively(Value, NewKeyChain);
      -- Update the value
      else
        -- Check if the final key is a string or a number (the case for table values with numeric index)
        local ParsedKey = StringToNumberIfPossible(Key);
        -- Load the saved value
        local DBSetting = WorldyRotationDB.GUISettings[NewKeyChain];
        -- If the saved value exists, take it
        if DBSetting ~= nil then
          Table[ParsedKey] = DBSetting;
        -- Else, save the default value
        else
          WorldyRotationDB.GUISettings[NewKeyChain] = Value;
        end
      end
    end
  end

  do
    local CreateARPanelOption = {
      Enabled = function (Panel, Setting, Name)
        CreatePanelOption(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('VeHiShmfDTgkOIuKVBvBNBZQhuykUuTWXiRxHlBThQlfTCFPGkBczVQQ2hlY2tCdXR0b24='), Panel, Setting, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('nDYfrkgSKpgpIyQVJNEVSQjZWURbKWKvoEKZauTYmzepizpQNVzkxAKVXNlOiA=') .. Name, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('FakMpiqjEYJprUHyIbtNHlfzcaLaRINiKDZvTckWqNNFxzgiiiTcBxnRW5hYmxlIGlmIHlvdSB3YW50IHRvIHVzZSA=') .. Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('jfRhmNiaksOkuHNvdawNBcOxgQFTgkfazlXajJukwvOgNVOKfuTCvAsLg=='));
      end,
      Threshold = function(Panel, Setting, Name)
        CreatePanelOption(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('hDyFuMgRWBkoRTCYWyUiCTqHXBLriUxsmkYGioeBbdLcPZWMDhEEOLWU2xpZGVy'), Panel, Setting, {0, 100, 1}, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('GXrpFRBoZqnRELWYDFPDtgazNAXOxuEQdNbLodzYbYQalkvMyrArggrVGhyZXNob2xkOiA=') .. Name, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('WiAHniJVmAVuSzazqsIsZtAaReJqmMxXsjDxVlUTiIbLxsBvPozqlLIU2V0IHRoZSB0aHJlc2hvbGQgb2Yg') .. Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('nULrYoDdfkoFrSRNGPQOhWRjAlDJJmYPdqkvMjIJfkInYtjtteUEKCGLiBTZXQgdG8gMCB0byBkaXNhYmxlLg=='));
      end,
      HP = function(Panel, Setting, Name)
        CreatePanelOption(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('KBVwahTrbUqoJzGViFHgOvzPpQBYdAQqOJWudOPnJrZlFxRBkvpsPEoU2xpZGVy'), Panel, Setting, {0, 100, 1}, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('HotBoOFjiJCuvXQGRwLcAMpSoplcCUWDlCeNDhhpjPFsKrxWAlwqBzQSFA6IA==') .. Name, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('pSnIiSVwlxHAtufTTWzbpNEeRCjnngtwDyEslhzXtLRqxcSGBlmAxDzU2V0IHRoZSBIUCB0aHJlc2hvbGQgb2Yg') .. Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('ACdpubyCSApJqswieEZMqlSKuitAraFknOgsiChdkLaLwpTGDnaUcSRLiBTZXQgdG8gMCB0byBkaXNhYmxlLg=='));
      end,
      AoE = function(Panel, Setting, Name)
        CreatePanelOption(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('nPRArCSCOZZbtbPBFuKqmtOeYeNnFBhCgleTOExaHlLThEPjNuHBCRvU2xpZGVy'), Panel, Setting, {0, 5, 1}, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('taqYZDcCNTelirNISCMGWLAucbFPrzzpdMmFHFzmPgAIFOuYXtPLRwJQW9FOiA=') .. Name, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('KfCIYHBdrfcJafEpkxIFsofuJuSdHZsLPcshkQaVOaVHAYgALFUIyyPU2V0IHRoZSBBb0UgY291bnQgb2Yg') .. Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('zxupRUeHHXCOlEPQxaTVXPZzDrvqMzYSdaTRsWJYazTkwdXptBEAtxULiBTZXQgdG8gMCB0byBkaXNhYmxlLg=='));
      end,
      AoEGroup = function(Panel, Setting, Name)
        CreatePanelOption(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('NYynwNdadEEgXzUSulBZiIrgzrTusDWYGqHqpfOgulCxBASoDkxIBZCU2xpZGVy'), Panel, Setting, {1, 5, 1}, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('fatniBIjVqHbRMCnTkmwOlfiUrSGwUZlHaMWHmrFZpudtHZGKgJZeJLR3JvdXA6IA==') .. Name, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('wnIgymVcMhyQLwauGkUizUlvrRxJCMrWfuySFNoEUNasrOpivyxFmEfU2V0IHRoZSBBb0UgZ3JvdXAgY291bnQgb2Yg') .. Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('MjBDVhIcpCQAzBtozRJkDiBwzHrlUevBGbRPWbSUzwavJUZtxsSzlNYLg=='));
      end,
      AoERaid = function(Panel, Setting, Name)
        CreatePanelOption(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('vnHlXfJxkNwCvvGqGGiUvOOxNcxaZHPLSkDvEBBMBmqXifUHDHvwUxfU2xpZGVy'), Panel, Setting, {1, 5, 1}, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('YZvYUApIBAKWTJVnvNaVumjwtpGzfKefnPrISonyEEFcQzrXetXyUvKUmFpZDog') .. Name, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('iBfHxacxptsUATUEGCfRPcWREKfbceZbOSbpfnpEENMktEQVdaLUVVfU2V0IHRoZSBBb0UgcmFpZCBjb3VudCBvZiA=') .. Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('rUbqgGkaqSOmjRvvkvMUiMVkSuLptcbXotwzxiQYeecowPqkuNxgRttLg=='));
      end,
    };
    function WR.GUI.CreateARPanelOption (Type, Panel, Setting, ...)
      CreateARPanelOption[Type](Panel, Setting, ...);
    end

    function WR.GUI.CreateARPanelOptions (Panel, Settings)
      -- Find the corresponding setting table
      local SettingsSplit = {strsplit(SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('ubgPsIaxaXUdHZqpMZwwfZjBDvyxopQJCnZlNpBPfntLiwERaFwzMurLg=='), Settings)};
      local SettingsTable = WR.GUISettings;
      for i = 1, #SettingsSplit do
        SettingsTable = SettingsTable[SettingsSplit[i]];
      end
      -- Iterate over all options available
      for Type, _ in pairs(CreateARPanelOption) do
        SettingsType = SettingsTable[Type];
        if SettingsType then
          for SettingName, _ in pairs(SettingsType) do
            -- Split the key on uppercase matches
            local Name = SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('EByphejDscAaSzuvucVUnXcEdUUngreRlIXQulfZHZbUdiXFPkdSlvQ');
            for Word in stringgmatch(SettingName, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('cylOVHucRtltZkHmkyLAYRKwUhMirdBaICdQQzminoWUOOOJeemPDEAW0EtWl1bYS16XSs=')) do
              if Name == SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('gsEyHHalBSHbRjVHQLuJmwqxNxChEPHKIUDJlsryPycJQZUYndwGHwJ') then
                Name = Word;
              else
                Name = Name .. SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('JgSBHlQkiDiGNaNDclarIprvquouFtRfTJXrXLAJwxNOQrdmlEusvHVIA==') .. Word;
              end
            end
            -- Rewrite the setting string
            local Setting = tableconcat({Settings, Type, SettingName}, SfVgRkmdwudscEEQRSeRlvESSabHGpyvZwMaapCpypVZPJvLEpcBfQrimjQECKvReuwkuYikhWQKsPAOWZaG('RaxANYtXCikPsIfYfzYvWeFmmTdpQQKuWTqTaBNsQxObSmBEjLHomtyLg=='));
            -- Construct the option
            WR.GUI.CreateARPanelOption(Type, Panel, Setting, Name);
          end
        end
      end
    end
  end
    