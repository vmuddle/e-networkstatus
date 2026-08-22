import network, time
import urequests
from machine import Pin

# This maps the GPIO pins to the GROUP IDs in Uptime Kuma. You can change the IDs to match your own Uptime Kuma setup. The IDs correspond to the monitors or groups you want to check the status of. Make sure to replace the Wi-Fi credentials and the base URL with your actual values.

portLookup = { "GP1": 2 ,  # Internet
               "GP2": 4 ,  # Garage
               "GP3": 8,   # Google Router
               "GP4": 29,   # switch A
               "GP5": 30,   # switch B
               "GP6": 17,   # apple_tv_a_wifi
               "GP7": 16,   # apple_tv_a_lan
               "GP8": 12,   # bike_tv_a_wifi
               "GP9": 15,   # bike_tv_a_lan
               "GP10": 18,  # trainer_a_wifi
               "GP11": 19,  # trainer_a_lan
               "GP12": 24,  # apple_tv_b_wifi
               "GP13": 21,  # apple_tv_b_lan
               "GP14": 11,  # bike_tv_b_wifi
               "GP15": 20,  # bike_tv_b_lan
               "GP16": 23,  # trainer_b_wifi
               "GP17": 22,  # trainer_b_lan
               }
portSetup = {}
for portName in portLookup.keys():
    ledPort = Pin(portName, Pin.OUT)
    portSetup[portName] = ledPort
    
powerLed = Pin("GP0", Pin.OUT)
powerLed.on()

def buildUrl(id=2):
    baseUrl="http://192.168.87.239:3001/api/badge/" # replace with your actual Uptime Kuma server URL, if memory serves me correctly, this is the url of a "GROUP" badge, which will show the status of all monitors in that group. If you want to check a specific monitor, you can use the monitor's ID instead of the group ID.
    endUrl="/status"
    return baseUrl+str(id)+endUrl

def getStatus(id=2):
    fullUrl=buildUrl(id)
    print("URL="+fullUrl)
    response = urequests.get(fullUrl)
    #print(response.text)
    if "Up" in response.text:
        response.close()
        return True
    else:
        response.close()
        return False
    
    

def start_network():
    ssid = 'wifi_ssid' # replace with your actual Wi-Fi credentials
    password = 'wifi_password' # replace with your actual Wi-Fi credentials

    wlan = network.WLAN(network.STA_IF)
    print(wlan.config("mac"))
    wlan.ipconfig(dhcp4=True)
    wlan.active(True)
    wlan.connect(ssid, password)
    max_wait = 10
    while max_wait > 0:
        if wlan.status() < 0 or wlan.status() >= 3:
            break
        max_wait -= 1
        print('waiting for connection...')
        time.sleep(1)

    if wlan.status() != 3:
        raise RuntimeError('network connection failed')
    else:
        print('connected')
        status = wlan.ifconfig()
        print( 'ip = ' + status[0] )

def checksum(data):
    if len(data) & 0x1: # Odd number of bytes
        data += b'\0'
    cs = 0
    for pos in range(0, len(data), 2):
        b1 = data[pos]
        b2 = data[pos + 1]
        cs += (b1 << 8) + b2
    while cs >= 0x10000:
        cs = (cs & 0xffff) + (cs >> 16)
    cs = ~cs & 0xffff
    return cs

start_network()
#_thread.start_new_thread(core2, ())
while True:
    for portName, statusId in portLookup.items():
        print(portName+":"+str(statusId))
        powerLed.off()
        status=getStatus(statusId)
        if status:
            portSetup[portName].on()
        else:
            portSetup[portName].off()
        powerLed.on()
    time.sleep(10)