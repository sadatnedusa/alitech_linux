## **PCI/PCIe Architecture and BDF Addressing**:
In a PCI (Peripheral Component Interconnect) or PCI Express (PCIe) system, the **BDF (Bus:Device.Function)** notation is a critical part of identifying and addressing components in the system's PCI/PCIe hierarchy. This notation provides a unique way of referring to each device and function within the PCI/PCIe topology.

### Breakdown of PCI/PCIe Structure:
Let's start by understanding how devices are connected in the PCI/PCIe architecture:

1. **PCI Bus**:
   - PCI buses are the primary pathways for data between the CPU, memory, and I/O devices in a system.
   - In PCI/PCIe, buses are the links that connect multiple devices, often forming a tree-like structure. Each PCI/PCIe bus can have multiple devices connected to it.

2. **PCI Devices**:
   - **PCI Device** refers to a piece of hardware (such as a network card, graphics card, or storage controller) connected to a PCI/PCIe bus. A device could also be a multi-function device, which can offer multiple independent functionalities (e.g., a network card with multiple Ethernet ports).
   - A PCI device is uniquely identified by its **Bus**, **Device**, and **Function**.

3. **Functions**:
   - A **function** refers to the individual features or roles a device performs. A device can support multiple functions. For example, a multi-port network adapter might have one device number but multiple functions (one for each Ethernet port).

### **Bus:Device.Function (BDF)** Notation:

- **Bus**: Identifies which PCI or PCIe bus the device is on. Systems typically have several buses, especially when there are multiple root complex or PCIe slots. The bus number starts at `0`.
  
- **Device**: Identifies the specific device within a bus. Each bus can support up to 32 devices, numbered from `0` to `31`.

- **Function**: Identifies the specific function of a device. Many devices support multiple functions, but a device can support up to 8 functions (numbered `0` through `7`).

In the **BDF notation**, we have:

```
Bus:Device.Function
```

Where:

- **Bus** is the bus number.
- **Device** is the device number on that bus.
- **Function** is the function number of the device.

### Example:

Consider this output from the `lspci` command on a Linux machine:

```
00:1f.2 SATA controller: Intel Corporation 100 Series/C230 Series Chipset Family SATA controller (rev 31)
01:00.0 VGA compatible controller: NVIDIA Corporation GP104 [GeForce GTX 1080] (rev a1)
00:02.0 VGA compatible controller: Intel Corporation Skylake Integrated Graphics (rev 07)
```

- **00:1f.2**:
  - **Bus**: `00` — This is the first PCI bus in the system.
  - **Device**: `1f` — The device number on bus `00`.
  - **Function**: `2` — The third function on device `1f`. This device might support multiple functions, for example, a combination of SATA controller and other functionality.

- **01:00.0**:
  - **Bus**: `01` — This device is located on PCI bus `1`.
  - **Device**: `00` — The device number on bus `01`.
  - **Function**: `0` — The first function of the device, in this case, a graphics card.

### PCI Configuration Space and BDF:

Each device on the PCI/PCIe bus has a **configuration space** that contains information about the device (such as vendor ID, device ID, capabilities, and the device's functions). The **BDF** addressing is used to access this configuration space, where various device parameters can be read or written.

- The **PCI Configuration Space** for each device is mapped into the system's addressable memory.
- The **BDF** address is used to access specific configuration registers of a device or function.

For example:
- To configure or read data from **Bus 00, Device 1f, Function 2**, the system will use the BDF address to directly access the device's configuration space.

### Multi-Function Devices:
Some PCI/PCIe devices, like **network adapters**, **graphics cards**, or **storage controllers**, can have multiple functions under a single device. For example:
- A **network adapter** might have a primary function (`function 0`) for managing Ethernet traffic, and additional functions (`function 1`, `function 2`, etc.) for other ports or features.

In this case, the device will still have the same **Bus** and **Device** numbers but different **Function** numbers.

For example, a network card might have:
```
Bus:Device.Function
00:1d.0  (Primary function)
00:1d.1  (Secondary function)
00:1d.2  (Tertiary function)
```

### Accessing Devices Using BDF:
- **BIOS/UEFI** and the **Operating System** (OS) use the **BDF** addressing scheme to detect, configure, and load drivers for PCI/PCIe devices.
- **Linux** and other operating systems provide tools like `lspci` to show devices along with their **BDF** addresses.
- **Kernel** and drivers use the **BDF** to locate and configure devices.

### PCIe Topology Example:

Consider a simplified system with two PCIe root complexes, connected to several devices:

```
Root Complex 0:
   Bus 0: Device 0 -> Function 0 (GPU)
   Bus 0: Device 1 -> Function 0 (SATA Controller)
   
Root Complex 1:
   Bus 1: Device 0 -> Function 0 (Network Card - Ethernet Port 1)
   Bus 1: Device 0 -> Function 1 (Network Card - Ethernet Port 2)
```

This topology would have **Bus:Device.Function** addresses like:
- **00:00.0** (GPU on Bus 0)
- **00:01.0** (SATA controller on Bus 0)
- **01:00.0** (Ethernet Port 1 on Bus 1)
- **01:00.1** (Ethernet Port 2 on Bus 1)

### Conclusion:

- The **Bus:Device.Function (BDF)** notation is a key component in the **PCI** and **PCIe** systems for identifying devices, accessing their configuration spaces, and managing multi-function devices.
- Understanding BDF is essential when configuring devices, troubleshooting hardware, or developing low-level system software and drivers.
- In systems with multiple PCIe slots or root complexes, BDF ensures that each device is uniquely addressable and manageable.


---


## To identify the **Bus:Device.Function (BDF)** addresses for PCI devices on a Red Hat Linux (RHEL) system, you can use a variety of commands and tools. Here are the most commonly used commands to get this information:

### 1. **Using `lspci`**

The `lspci` command is the most straightforward and commonly used method to list all PCI devices and their BDF (Bus:Device.Function) addresses.

#### Basic Command:
```bash
lspci
```

This will list all PCI devices along with their **BDF** addresses (Bus:Device.Function), but it won’t display detailed information about each device.

#### Sample Output:
```bash
00:00.0 Host bridge: Intel Corporation Skylake Host Bridge/DRAM Registers (rev 08)
00:02.0 VGA compatible controller: Intel Corporation Skylake Integrated Graphics (rev 07)
00:1f.2 SATA controller: Intel Corporation 100 Series/C230 Series Chipset Family SATA controller (rev 31)
```

- In this output:
  - **00:00.0** means **Bus 00, Device 00, Function 0**
  - **00:02.0** means **Bus 00, Device 02, Function 0**
  - **00:1f.2** means **Bus 00, Device 1f, Function 2**

#### Detailed Output with Device Info:
If you want more detailed information about the devices (such as vendor, device ID, etc.), you can use the `-vv` option for verbose output:

```bash
lspci -vv
```

This will show additional information such as vendor IDs, device IDs, and the capabilities of each PCI device, along with their BDF addresses.

#### Example Output:
```bash
00:00.0 Host bridge: Intel Corporation Skylake Host Bridge/DRAM Registers (rev 08)
    Subsystem: Intel Corporation Skylake Host Bridge/DRAM Registers
    Flags: bus master, fast devsel, latency 0
    Capabilities: <access to more registers>

00:02.0 VGA compatible controller: Intel Corporation Skylake Integrated Graphics (rev 07)
    Subsystem: Intel Corporation Skylake Integrated Graphics
    Flags: bus master, fast devsel, latency 0
    Capabilities: <more capabilities>
```

### 2. **Using `lspci -nn`** (with Vendor and Device IDs)

If you want to see the PCI vendor and device IDs along with the BDF address, you can use the `-nn` option:

```bash
lspci -nn
```

#### Sample Output:
```bash
00:00.0 Host bridge [0600]: Intel Corporation Skylake Host Bridge/DRAM Registers [8086:1900] (rev 08)
00:02.0 VGA compatible controller [0300]: Intel Corporation Skylake Integrated Graphics [8086:1912] (rev 07)
00:1f.2 SATA controller [0106]: Intel Corporation 100 Series/C230 Series Chipset Family SATA controller [8086:9d03] (rev 31)
```

Here:
- **8086** is the vendor ID (Intel).
- **1900**, **1912**, **9d03** are the device IDs for the specific devices.

This command still shows the **BDF** as part of the output, along with the vendor and device information.

### 3. **Using `cat /sys/bus/pci/devices/`**

The **/sys** filesystem in Linux contains a hierarchical representation of various kernel objects, including PCI devices. You can use this path to query information about PCI devices.

To find the **BDF** addresses, you can list the contents of the directory:

```bash
ls /sys/bus/pci/devices/
```

#### Sample Output:
```bash
0000:00:00.0  0000:00:02.0  0000:00:1f.2  0000:01:00.0
```

Here, the directories represent the **BDF** addresses. Each directory corresponds to a PCI device in the format of **Bus:Device.Function**.

You can get more details about a specific device by looking at the contents of these directories. For example, to get the vendor ID for a device at **0000:00:00.0**:

```bash
cat /sys/bus/pci/devices/0000:00:00.0/vendor
```

This will return the vendor ID (for example, `0x8086` for Intel).

To get the device ID for the same device:

```bash
cat /sys/bus/pci/devices/0000:00:00.0/device
```

This will return the device ID (e.g., `0x1900`).

### 4. **Using `dmesg` for PCI Device Initialization Information**

You can also check the **dmesg** logs, especially after boot, for PCI device enumeration. The **dmesg** command shows kernel messages, including PCI device detection and initialization, and it will include **BDF** addresses.

```bash
dmesg | grep -i pci
```

#### Sample Output:
```bash
[    0.514890] pci 0000:00:00.0: [8086:1900] type 00 class 0x060000
[    0.514894] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
[    0.514897] pci 0000:00:1f.2: [8086:9d03] type 00 class 0x010600
```

This will give you PCI device information with **BDF** addresses, as well as device and vendor IDs.

### 5. **Using `pciutils` (Advanced PCI Info)**

`pciutils` is a collection of utilities to query and configure PCI devices. The `lspci` tool mentioned earlier is part of this package, but there are other utilities in the package like **`setpci`** for more advanced manipulation.

#### For Example:

```bash
setpci -s 00:02.0
```

This command would allow you to query or modify settings for the device at **00:02.0**.


### Summary:

To identify **Bus:Device.Function (BDF)** addresses in Red Hat Linux (RHEL), you can use the following commands:

1. **`lspci`** — List all PCI devices with BDF addresses.
2. **`lspci -nn`** — List all devices with BDF addresses along with vendor and device IDs.
3. **`ls /sys/bus/pci/devices/`** — Explore the **/sys** directory to see PCI device directories by BDF.
4. **`dmesg | grep -i pci`** — Check the kernel logs for PCI device initialization and BDF addresses.
5. **`setpci`** — Advanced manipulation and querying of PCI devices by BDF.

