import network, time
import urequests
from machine import Pin

from configmgr import *
myconfigfile = ConfigFile('config.conf')
myconfigfile.read()
myconfig = myconfigfile.config
print(myconfig)

ports=myconfig['ports']

print(type(ports))
for portname in ports:
    print(portname)


# This maps the GPIO pins to the GROUP IDs in Uptime Kuma. You can change the IDs to match your own Uptime Kuma setup. The IDs correspond to the monitors or groups you want to check the status of. Make sure to replace the Wi-Fi credentials and the base URL with your actual values.

portLookup = ports
portSetup = {}
lastStatus = {}
for portName in portLookup.keys():
    ledPort = Pin(portName, Pin.OUT)
    portSetup[portName] = ledPort
    lastStatus[portName] = False
    
powerLed = Pin("GP0", Pin.OUT)
powerLed.on()

def buildUrl(id=2):
    baseUrl=myconfig['kuma']['base_url']+"/api/badge/" # replace with your actual Uptime Kuma server URL, if memory serves me correctly, this is the url of a "GROUP" badge, which will show the status of all monitors in that group. If you want to check a specific monitor, you can use the monitor's ID instead of the group ID.
    endUrl="/status"
    return baseUrl+str(id)+endUrl
#    return myconfig['kuma']['base_url']+'/dashboard/'+str(id)


def getStatus(id=2):
    fullUrl=buildUrl(id)
    print("URL="+fullUrl)
    response = urequests.get(fullUrl)
    #print(response.text)
    if "Up</span>" in response.text:
        response.close()
        print('ID '+str(id)+' is UP')
        return True
    else:
        if "Up" in response.text:
            print(response.text)
            response.close()
            print('ID '+str(id)+' is UP kind of')
            return True
        else:
            response.close()
            return False
    
    

def start_network():
    print("Starting network...")
    print("Connecting to Wi-Fi...")
    
    ssid = myconfig['wifi']['ssid'] # replace with your actual Wi-Fi credentials
    password = myconfig['wifi']['password'] # replace with your actual Wi-Fi credentials
    print("SSID:"+ssid)
    print("SSID: {}".format(ssid))
    print("Password: {}".format(password))

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
    print('Done waiting for connection')
    if wlan.status() != 3:
        print('Wlan.status'.format(wlan.status()))
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
powerLedStatus=False
while True:
    for portName, statusId in portLookup.items():
        print(portName+":"+str(statusId))
        if(lastStatus[portName]):
            portSetup[portName].off()
        else:
            portSetup[portName].on()
        time.sleep(0.1)
        if(lastStatus[portName]):
            portSetup[portName].on()
        else:
            portSetup[portName].off()
        
        status=getStatus(statusId)
        lastStatus[portName]=status
        if(lastStatus[portName]):
            portSetup[portName].on()
        else:
            portSetup[portName].off()
        
    for counter in range(20):
        time.sleep(0.2)
        powerLedStatus= not powerLedStatus
        if powerLedStatus:
            powerLed.on()
        else:
            powerLed.off()