wifiwidget = widget({type = "textbox", name = "wifiwidget", align = "right" })

function wifiInfo()
     spacer = " "
     local w = assert(io.popen("awk 'NR==3 {print substr(\$3,0,2) \"%\"}' /proc/net/wireless ",'r'))
     local wifiStrength = (w:read('*a'))
     w:close()
     wifiwidget.text = " Wifi:"..spacer..wifiStrength..spacer
end

wifiInfo()

awful.hooks.timer.register(15, function()
    wifiInfo()
end)
