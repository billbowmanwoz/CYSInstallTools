import os
import subprocess
import tkinter as tk
from tkinter import filedialog

# Get the Program Files directory for a 64-bit system
program_files = os.environ.get("ProgramFiles", "Not Found")

# print(f"Program Files directory: {program_files}")

# Create the full path to the VirtualBox directory
virtualbox_path = os.path.join(program_files, "Oracle", "VirtualBox")

print(f"The full path to VirtualBox: {virtualbox_path}")

# Append the directory to PATH
os.environ["PATH"] += os.pathsep + virtualbox_path

# # Verify the updated PATH
# print(os.environ["PATH"])

def get_vbox_vm_directory():
    try:
        output = subprocess.check_output(['VBoxManage', 'list', 'systemproperties'], universal_newlines=True)
        for line in output.splitlines():
            if "machine folder" in line:
                return line.split(":",1)[1].strip()
    except subprocess.CalledProcessError as e:
        print("Error occurred:", e)
        return None

# vm_directory = get_vbox_vm_directory()

# if vm_directory:
#     print(f"Default VirtualBox VM Directory: {vm_directory}")
# else:
#     print("Couldn't retrieve the VM directory.")

# VM Configuration
VBOXMachineDir = get_vbox_vm_directory()
VM_NAME = input("What is the name of the Ubuntu Linux VM you want to create? ")
OS_TYPE_MENU = """
1. Linux
2. Windows
What one are we installing today? """
selection = False
OS_TYPE = int(input(OS_TYPE_MENU))

# OS_TYPE = "Ubuntu_64"
RAM_SIZE = int(input("How Much RAM do you want to allocate? "))  # in MB
CPU_COUNT = "2"
VRAM_SIZE = "128"  # in MB
DISK_PATH = os.path.join(VBOXMachineDir, VM_NAME, f"{VM_NAME}.vdi")
# print(DISK_PATH)
# DISK_SIZE = "20000"  # in MB
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
# ISO_PATH = "C:/Users/wcart/Downloads/ubuntu.iso"
# 
# def run_command(command):
#     """Helper function to execute shell commands."""
#     subprocess.run(command, shell=True, check=True)

# Ensure directory exists
#os.makedirs(os.path.dirname(DISK_PATH), exist_ok=True)

# Step 1: Create VM
#run_command(f'VBoxManage createvm --name "{VM_NAME}" --ostype "{OS_TYPE}" --register')

# Step 2: Set Memory and CPU
#run_command(f'VBoxManage modifyvm "{VM_NAME}" --memory {RAM_SIZE} --cpus {CPU_COUNT} --vram {VRAM_SIZE}')

# Step 3: Create and Attach Storage
#run_command(f'VBoxManage createhd --filename "{DISK_PATH}" --size {DISK_SIZE} --format VDI')
#run_command(f'VBoxManage storagectl "{VM_NAME}" --name "SATA Controller" --add sata --controller IntelAhci')
#run_command(f'VBoxManage storageattach "{VM_NAME}" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "{DISK_PATH}"')

# Step 4: Attach ISO (for OS installation)
#run_command(f'VBoxManage storagectl "{VM_NAME}" --name "IDE Controller" --add ide')
#run_command(f'VBoxManage storageattach "{VM_NAME}" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "{ISO_PATH}"')

# Step 5: Set Boot Order
#run_command(f'VBoxManage modifyvm "{VM_NAME}" --boot1 dvd --boot2 disk --boot3 none --boot4 none')

# Step 6: Configure Network (NAT or Bridged)
#run_command(f'VBoxManage modifyvm "{VM_NAME}" --nic1 nat')

# Step 7: Start the VM
# run_command(f'VBoxManage startvm "{VM_NAME}" --type headless')

#print(f"Virtual Machine '{VM_NAME}' has been successfully created and started.")
