from pathlib import Path
import os
import subprocess
import re
import tkinter as tk
from tkinter import filedialog, messagebox, ttk

def get_vbox_vm_directory():
    try:
        output = subprocess.check_output(['VBoxManage', 'list', 'systemproperties'], universal_newlines=True)
        for line in output.splitlines():
            if "machine folder" in line:
                return Path(line.split(":", 1)[1].strip())
    except subprocess.CalledProcessError as e:
        print("Error occurred:", e)
        return None

def set_path():
    program_files = Path(os.environ.get("ProgramFiles", "Not Found"))
    virtualbox_path = program_files / "Oracle" / "VirtualBox"
    os.environ["PATH"] += os.pathsep + str(virtualbox_path)

def get_vm_list():
    result = subprocess.run(['vboxmanage', 'list', 'vms'], capture_output=True, text=True)
    output = result.stdout
    vm_list = re.findall(r'"(.+?)"\s+\{[a-f0-9\-]+\}', output)
    return vm_list

def run_command(command):
    subprocess.run(command, shell=True, check=True)

def create_vm():
    vm_name = vm_name_var.get()
    os_choice = os_type_var.get()
    ram = ram_var.get()
    cpus = cpu_var.get()
    disk_size = disk_var.get()
    iso_file = iso_path_var.get()

    if not vm_name or not os_choice or not iso_file:
        messagebox.showerror("Error", "Please fill out all required fields.")
        return

    if vm_name.lower() in (name.lower() for name in vm_list):
        messagebox.showerror("Duplicate VM Name", f"A VM named '{vm_name}' already exists.")
        return

    os_type_map = {
        "Linux": "Linux26_64",
        "Windows": "WindowsNT_64"
    }
    os_type = os_type_map.get(os_choice, "Linux26_64")
    disk_path = vbox_machine_dir / vm_name / f"{vm_name}.vdi"

    try:
        disk_path.parent.mkdir(parents=True, exist_ok=True)

        run_command(f'VBoxManage createvm --name "{vm_name}" --ostype "{os_type}" --register')
        run_command(f'VBoxManage modifyvm "{vm_name}" --memory {ram} --cpus {cpus} --vram 128')
        run_command(f'VBoxManage createhd --filename "{disk_path}" --size {disk_size} --format VDI')
        run_command(f'VBoxManage storagectl "{vm_name}" --name "SATA Controller" --add sata --controller IntelAhci')
        run_command(f'VBoxManage storageattach "{vm_name}" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "{disk_path}"')
        run_command(f'VBoxManage storagectl "{vm_name}" --name "IDE Controller" --add ide')
        run_command(f'VBoxManage storageattach "{vm_name}" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "{iso_file}"')
        run_command(f'VBoxManage modifyvm "{vm_name}" --nic1 nat')
        run_command(f'VBoxManage startvm "{vm_name}"')

        messagebox.showinfo("Success", f"VM '{vm_name}' created and started successfully!")
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Error", f"Failed to create VM:\n{e}")

def browse_iso():
    path = filedialog.askopenfilename(title="Select an ISO File", filetypes=[("ISO files", "*.iso")])
    if path:
        iso_path_var.set(path)

# ------------------ Initialize ------------------

set_path()
vm_list = get_vm_list()
vbox_machine_dir = get_vbox_vm_directory()

root = tk.Tk()
root.title("VirtualBox VM Creator")
root.geometry("400x450")

# ------------------ UI Elements ------------------

vm_name_var = tk.StringVar()
os_type_var = tk.StringVar(value="Linux")
ram_var = tk.IntVar(value=2048)
cpu_var = tk.IntVar(value=2)
disk_var = tk.IntVar(value=51200)
iso_path_var = tk.StringVar()

padding = {'padx': 10, 'pady': 5}

tk.Label(root, text="VM Name:").pack(**padding)
tk.Entry(root, textvariable=vm_name_var).pack(fill='x', **padding)

tk.Label(root, text="Operating System:").pack(**padding)
ttk.Combobox(root, textvariable=os_type_var, values=["Linux", "Windows"]).pack(fill='x', **padding)

tk.Label(root, text="RAM (MB):").pack(**padding)
tk.Entry(root, textvariable=ram_var).pack(fill='x', **padding)

tk.Label(root, text="CPU Cores:").pack(**padding)
tk.Entry(root, textvariable=cpu_var).pack(fill='x', **padding)

tk.Label(root, text="Disk Size (MB):").pack(**padding)
tk.Entry(root, textvariable=disk_var).pack(fill='x', **padding)

tk.Label(root, text="ISO File:").pack(**padding)
tk.Entry(root, textvariable=iso_path_var).pack(fill='x', **padding)
tk.Button(root, text="Browse...", command=browse_iso).pack(**padding)

tk.Button(root, text="Create VM", command=create_vm, bg="#4CAF50", fg="white").pack(pady=20)

# ------------------ Start GUI ------------------

root.mainloop()
