local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function ldXiXfNKXcGRbkFdDekcvyGYaeydmBLlnjKhRiUaHfUnAROuDRCOMEjcpKrqUiHJPoBkWACekGvhbjPtGBELVpANQtisKwoK(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- WorldyRotation
local WR = WorldyRotation
-- HeroLib
local HL = HeroLib
--File Locals
local GUI = HL.GUI
local CreateChildPanel = GUI.CreateChildPanel
local CreatePanelOption = GUI.CreatePanelOption
local CreateARPanelOption = WR.GUI.CreateARPanelOption
local CreateARPanelOptions = WR.GUI.CreateARPanelOptions

--- ============================ CONTENT ============================
-- All settings here should be moved into the GUI someday.
WR.GUISettings.APL.DeathKnight = {
  Commons = {
    Enabled = {
      Potions = true,
      Trinkets = true,
    },
    HP = {
      UseDeathStrikeHP = 60, -- % HP threshold to try to heal with Death Strike
      UseDarkSuccorHP = 80, -- % HP threshold to use Dark SuccorldXiXfNKXcGRbkFdDekcvyGYaeydmBLlnjKhRiUaHfUnAROuDRCOMEjcpKrqUiHJPoBkWACekGvhbjPtGBELVpANQtisKwoK('kIyRVgcVSufpLXROQRxFjROxMmaXnEzXdfTsJmmAqmqTwddKrgBeWTEcyBmcmVlIERlYXRoIFN0cmlrZQ0KICAgIH0sDQogIH0sDQogIEJsb29kID0gew0KICAgIEVuYWJsZWQgPSB7DQogICAgICBQb29sRHVyaW5nQmxvb2Rkcmlua2VyID0gZmFsc2UsDQogICAgfSwNCiAgICBIUCA9IHsNCiAgICAgIFJ1bmVUYXBUaHJlc2hvbGQgPSA0MCwNCiAgICAgIEljZWJvdW5kRm9ydGl0dWRlVGhyZXNob2xkID0gNTAsDQogICAgICBWYW1waXJpY0Jsb29kVGhyZXNob2xkID0gNjUsDQogICAgfSwNCiAgfSwNCn0NCg0KV1IuR1VJLkxvYWRTZXR0aW5nc1JlY3Vyc2l2ZWx5KFdSLkdVSVNldHRpbmdzKQ0KLS0gUGFuZWxzDQpsb2NhbCBBUlBhbmVsID0gV1IuR1VJLlBhbmVsDQpsb2NhbCBDUF9EZWF0aGtuaWdodCA9IENyZWF0ZUNoaWxkUGFuZWwoQVJQYW5lbCwg')DeathKnightldXiXfNKXcGRbkFdDekcvyGYaeydmBLlnjKhRiUaHfUnAROuDRCOMEjcpKrqUiHJPoBkWACekGvhbjPtGBELVpANQtisKwoK('zoEpohlxnPXWvEPtrfOkzfDlVjqKhpFYKjhFajySVxHMUacZeYkXTDKKQ0KbG9jYWwgQ1BfQmxvb2QgPSBDcmVhdGVDaGlsZFBhbmVsKENQX0RlYXRoa25pZ2h0LCA=')BloodldXiXfNKXcGRbkFdDekcvyGYaeydmBLlnjKhRiUaHfUnAROuDRCOMEjcpKrqUiHJPoBkWACekGvhbjPtGBELVpANQtisKwoK('SHUUOWYfBkVaZhBspowpyGOzedZorSgWMvInefWjmBNOMQaMlXRTPIkKQ0KDQotLURlYXRoS25pZ2h0IFBhbmVscw0KQ3JlYXRlQVJQYW5lbE9wdGlvbnMoQ1BfRGVhdGhrbmlnaHQsIA==')APL.DeathKnight.CommonsldXiXfNKXcGRbkFdDekcvyGYaeydmBLlnjKhRiUaHfUnAROuDRCOMEjcpKrqUiHJPoBkWACekGvhbjPtGBELVpANQtisKwoK('WGPazOAeEUmiXWgqKtEGWENxScHwtetOcaSfBKdmtScSVBHyxpPYeASKQ0KDQotLUJsb29kIFBhbmVscw0KQ3JlYXRlQVJQYW5lbE9wdGlvbnMoQ1BfQmxvb2QsIA==')APL.DeathKnight.Blood')
    