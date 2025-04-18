import os
import subprocess
import re
import tkinter as tk
from tkinter import filedialog

def get_vbox_vm_directory():
    try:
        output = subprocess.check_output(['VBoxManage', 'list', 'systemproperties'], universal_newlines=True)
        for line in output.splitlines():
            if "machine folder" in line:
                return line.split(":",1)[1].strip()
    except subprocess.CalledProcessError as e:
        print("Error occurred:", e)
        return None

def set_path():
    # Get the Program Files directory for a 64-bit system
    program_files = os.environ.get("ProgramFiles", "Not Found")
    # Create the full path to the VirtualBox directory
    virtualbox_path = os.path.join(program_files, "Oracle", "VirtualBox")
    # print(f"The full path to VirtualBox: {virtualbox_path}")
    # Append the directory to PATH
    os.environ["PATH"] += os.pathsep + virtualbox_path

def get_vm_list():
    # Run the application and capture the output
    # Replace 'your_app_command' with your actual command, e.g., './myapp' or 'somecommand'
    result = subprocess.run(['vboxmanage', 'list', 'vms'], capture_output=True, text=True)

    # Access the standard output
    output = result.stdout

    # Create list of dictionaries
    vm_list = re.findall(r'"(.+?)"\s+\{[a-f0-9\-]+\}', output)
    # vm_list = [{"VMName": name, "UUID": uuid} for name, uuid in re.findall(pattern, output)]

    # Now vm_list holds your parsed data
    return(vm_list)

# System Configuration
set_path()
list_of_vms = get_vm_list()
# print(list_of_vms)

# VM Configuration
VBOXMachineDir = get_vbox_vm_directory()
non_unique_vm = True
while non_unique_vm:
    VM_NAME = input("What is the name of the VM you want to create? ")
    if VM_NAME.lower() in (name.lower() for name in list_of_vms):
        print('VM Exists, you cannot use this name.')
    else: 
        non_unique_vm = False

OS_TYPE_MENU = """
    Operating System Types:
    1. Linux
    2. Windows
    What one are we installing today? """
OS_CHOICE = True
while OS_CHOICE:
    OS_TYPE_CHOICE = int(input(OS_TYPE_MENU))
    if OS_TYPE_CHOICE == 1:
        OS_TYPE = "Linux26_64"
        OS_CHOICE = False
    elif OS_TYPE_CHOICE == 2:
        OS_TYPE = "WindowsNT_64"
        OS_CHOICE = False
    else:
        print('Please select a valid option')

RAM_SIZE = int(input("How Much RAM do you want to allocate? "))  # in MB
CPU_COUNT = int(input("How Many CPU Cores do you want to allocate? "))
VRAM_SIZE = "128"  # in MB
DISK_PATH = os.path.join(VBOXMachineDir, VM_NAME, f"{VM_NAME}.vdi")
DISK_SIZE = int(input("How disk space do you want to allocate? (in MB) - ex. for 50GB, type 51200 "))  # in MB

# Initialize the Tkinter root window (it will not show)
root = tk.Tk()
root.withdraw()  # Hide the root window

# Open a file dialog with a filter for ISO files
ISO_PATH = filedialog.askopenfilename(
    title="Select an ISO file",
    filetypes=[("ISO files", "*.iso")]  # This will filter to only show .iso files
)
if ISO_PATH:
    print(f"Selected ISO file: {ISO_PATH}")
else:
    print("No file selected.")
# 
def run_command(command):
    """Helper function to execute shell commands."""
    subprocess.run(command, shell=True, check=True)

# Ensure directory exists
os.makedirs(os.path.dirname(DISK_PATH), exist_ok=True)

# Step 1: Create VM
run_command(f'VBoxManage.exe createvm --name "{VM_NAME}" --ostype "{OS_TYPE}" --register')

# Step 2: Set Memory and CPU
run_command(f'VBoxManage.exe modifyvm "{VM_NAME}" --memory {RAM_SIZE} --cpus {CPU_COUNT} --vram {VRAM_SIZE}')

# Step 3: Create and Attach Storage
run_command(f'VBoxManage.exe createhd --filename "{DISK_PATH}" --size {DISK_SIZE} --format VDI')
run_command(f'VBoxManage.exe storagectl "{VM_NAME}" --name "SATA Controller" --add sata --controller IntelAhci')
run_command(f'VBoxManage.exe storageattach "{VM_NAME}" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "{DISK_PATH}"')

# Step 4: Attach ISO (for OS installation)
run_command(f'VBoxManage.exe storagectl "{VM_NAME}" --name "IDE Controller" --add ide')
run_command(f'VBoxManage.exe storageattach "{VM_NAME}" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "{ISO_PATH}"')

# Step 5: Configure Network (NAT or Bridged)
run_command(f'VBoxManage modifyvm "{VM_NAME}" --nic1 nat')

# Step 6: Start the VM
run_command(f'VBoxManage startvm "{VM_NAME}"')


