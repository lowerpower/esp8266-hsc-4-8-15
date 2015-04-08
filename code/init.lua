-- Tell the chip to connect to the access point
-- wifi.setmode(wifi.STATION)

cfg={}
cfg.ssid="hacksonoma"
cfg.pwd="hacksonoma"
wifi.ap.config(cfg)

wifi.setmode(wifi.SOFTAP)
print('set mode=STATION (mode='..wifi.getmode()..')')
print('MAC: ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())
-- wifi.sta.config("GL-iNet-6c4","goodlife")

-- Compile server code and remove original .lua files.
-- This only happens the first time afer the .lua files are uploaded.

local compileAndRemoveIfNeeded = function(f)
   if file.open(f) then
      file.close()
      node.compile(f)
      file.remove(f)
   end
end

local serverFiles = {'httpserver.lua', 'httpserver-static.lua', 'httpserver-error.lua'}
for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil

-- Connect to the WiFi access point. Once the device is connected,
-- you may start the HTTP server.
dofile("httpserver.lc")(80)

