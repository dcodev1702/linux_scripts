#!/usr/bin/python3

import subprocess
from sys import exit
from socket import gethostname
from typing import Final


# This is a hard coded value for Azure native Linux VM's 
# Found this on Google somewhere, it's been very helpful!
AZURE_VM_CHASSIS_TAG = '7783-7084-3265-9085-8269-3286-77'
HOSTNAME: Final[str] = socket.gethostname()

def system_check():

    
    try:
        if(subprocess.run(['which', 'dmidecode'], check=True, stdout=subprocess.DEVNULL)):

            # This tag is used to identify Virtual Machines running in MSFT Azure

            VM_CHASSIS_TAG = subprocess.run(['sudo', 'dmidecode', '--string', 'chassis-asset-tag'], stdout=subprocess.PIPE, universal_newlines=True).stdout.strip()

            if VM_CHASSIS_TAG == AZURE_VM_CHASSIS_TAG:
                print(f"{HOSTNAME} is located in Azure! -> Chassis Tag: {VM_CHASSIS_TAG}")
                return True
            else:
                print(f"{HOSTNAME} NOT in Azure -> Chassis Tag: {VM_CHASSIS_TAG}")
                return False

    except subprocess.CalledProcessError:
        print("dmidecode not found!! Exiting...")
        exit(1)


def main():
    print(f"Checking if {HOSTNAME} is running on Azure.")
    system_check()


if __name__ == "__main__":
    main()
