#!/usr/bin/python3

'''
Author: DCO Dev 1702
Date: 2 March 2023

Purpose:
--------
This logic is used in a larger script for Azure Monitor Agent to determine if the resource (VM)
is running in Azure.  If true, do NOT use tcpdump as the binary is not permitted on Azure.
Otherise, call tcpdump to sniff traffic for CEF messages.  This logic is used in the 
AMA_Troubleshooting.py script when screening for CEF messages to send to Log Analytics.

'''
import subprocess
from sys import exit
from socket import gethostname
from typing import Final


# Found this on Google somewhere, it's been very helpful!
# This tag is used to identify Virtual Machines running in MSFT Azure
AZURE_VM_CHASSIS_TAG = '7783-7084-3265-9085-8269-3286-77'
HOSTNAME: Final[str] = gethostname()

def system_check():

    try:
        if(subprocess.run(['which', 'dmidecode'], check=True, stdout=subprocess.DEVNULL)):

            VM_CHASSIS_TAG = subprocess.run(['sudo', 'dmidecode', '--string', 'chassis-asset-tag'], \
                             stdout=subprocess.PIPE, universal_newlines=True).stdout.strip()

            if VM_CHASSIS_TAG == AZURE_VM_CHASSIS_TAG:
                print(f"Host:[{HOSTNAME}] is located in Azure! -> Chassis Tag: {VM_CHASSIS_TAG}")
                return True
            else:
                print(f"Host:[{HOSTNAME}] is NOT an Azure resource (VM) -> Chassis Tag: {VM_CHASSIS_TAG}")
                return False

    except subprocess.CalledProcessError:
        print("dmidecode not found!! Exiting...")
        exit(1)


def main():
    print(f"Checking if Host:[{HOSTNAME}] is an Azure resource (VM).")
    system_check()


if __name__ == "__main__":
   main()
