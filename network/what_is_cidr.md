## What is CIDR?

- https://datatracker.ietf.org/doc/html/rfc1519
- 
**CIDR (Classless Inter-Domain Routing)** is a method for allocating and managing IP addresses more efficiently than the older system based on classful networking. 
It helps optimize the use of IP address space and improves routing by reducing the size of routing tables.

### Key Points About CIDR:
1. **Background**:
   - Before CIDR, IP addresses were managed using classes (Class A, B, C), which were often inefficient due to rigid boundaries. For example, a Class A network had up to **16 million** IP addresses, while a Class C network had only **256** IP addresses. This led to waste when organizations didn’t need the full address range provided by these classes.
   - CIDR was introduced in **1993** as a way to solve this problem and is described in [RFC 1519](https://datatracker.ietf.org/doc/html/rfc1519).

2. **CIDR Notation**:
   - CIDR uses a combination of an **IP address** and a **suffix** that indicates the network size, written as `IP/prefix length`.
   - **Example**: `192.168.1.0/24` means:
     - The IP address block starts at `192.168.1.0`.
     - The `/24` indicates that the first 24 bits are the network portion, and the remaining bits are for host addresses.
   - The prefix length (`/24`) corresponds to the subnet mask `255.255.255.0`.

3. **How CIDR Works**:
   - CIDR breaks IP address space into more flexible subnet sizes. Instead of assigning fixed block sizes (e.g., Class A, B, or C), it allows for the creation of subnets with variable lengths based on need.
   - **Example**: An organization can use a block like `192.168.1.0/26` (which provides 64 IP addresses) if they only need 64 addresses, rather than wasting a larger block like `192.168.1.0/24`.

4. **Benefits of CIDR**:
   - **Efficient Use of IP Address Space**: CIDR reduces IP address waste by allowing network administrators to allocate addresses in increments that fit their needs.
   - **Reduced Routing Table Size**: CIDR enables route aggregation (or **supernetting**), where multiple IP addresses are represented by a single routing table entry. This simplifies routing and improves performance.
     - **Example**: Instead of routing four separate Class C networks (`192.168.1.0/24`, `192.168.2.0/24`, `192.168.3.0/24`, `192.168.4.0/24`), CIDR can represent them as `192.168.0.0/22`, encompassing all four subnets.

5. **CIDR in IPv4 and IPv6**:
   - **IPv4**: CIDR is commonly used in IPv4 to manage the limited address space more effectively.
   - **IPv6**: CIDR is inherently used in IPv6 addressing to handle its vast address space, simplifying allocation and routing.

### Example of CIDR in Use:
- **Subnet Calculation**:
  - **CIDR Block**: `10.0.0.0/16`
  - **Subnet**: This block includes `10.0.0.0` to `10.0.255.255`, giving **65,536** IP addresses (2^16).
  - A smaller network, `10.0.0.0/24`, would cover `10.0.0.0` to `10.0.0.255`, offering **256** IP addresses (2^8).

### CIDR Aggregation Example:
If an ISP has multiple customers with networks `192.168.1.0/24`, `192.168.2.0/24`, `192.168.3.0/24`, `192.168.4.0/24`, CIDR allows these to be advertised as `192.168.0.0/22` in a single routing entry, simplifying routing tables.

### Practical Implications:
- **Network administrators** use CIDR to create subnets that precisely fit their needs.
- **ISPs** use CIDR to allocate IP address blocks to customers, making IP address distribution more efficient.
- **Routers** can handle fewer, more aggregated routes, optimizing routing and improving performance on the internet.

---

### Subnetting in CIDR

**Subnetting** with CIDR (Classless Inter-Domain Routing) allows network administrators to divide a large IP network into smaller, more manageable subnets. This flexibility optimizes the use of IP addresses and improves network management. Let’s break down how subnetting works with CIDR, followed by an explanation of its integration with routing protocols.

#### Subnetting Example with CIDR:
Imagine you have an IP block of `192.168.1.0/24`, which includes **256 addresses** (0–255). You can subnet this block into smaller networks using different prefix lengths.

- **Original CIDR Block**: `192.168.1.0/24` (256 IPs)
- **Subnetting into /26**:
  - **New CIDR Blocks**:
    - `192.168.1.0/26` (includes `192.168.1.0` to `192.168.1.63` – 64 IPs)
    - `192.168.1.64/26` (includes `192.168.1.64` to `192.168.1.127` – 64 IPs)
    - `192.168.1.128/26` (includes `192.168.1.128` to `192.168.1.191` – 64 IPs)
    - `192.168.1.192/26` (includes `192.168.1.192` to `192.168.1.255` – 64 IPs)

- **How It Works**:
  - **/26** means the first 26 bits of the IP address are used for the network portion, leaving 6 bits for the host portion (`2^6 = 64` addresses per subnet).
  - This allows you to create **four subnets** from the original /24 block, each capable of hosting up to 62 usable addresses (subtracting 2 for the network and broadcast addresses).

#### Step-by-Step Subnetting Process:
1. **Determine the required subnet size**: Based on the number of hosts needed per subnet, choose an appropriate prefix length.
2. **Calculate the number of subnets**: The number of subnets increases as you extend the prefix length (e.g., /25 doubles the number of subnets compared to /24).
3. **Assign subnets**: Allocate the subnets according to organizational needs, such as different departments or services.

### CIDR with Routing Protocols:
CIDR plays a vital role in routing by allowing **route aggregation**, which helps reduce the size of routing tables in routers. This makes routing more efficient, particularly for large-scale networks like the internet.

#### How CIDR Works with Routing Protocols:
1. **Route Aggregation (Supernetting)**:
   - **Example**: An ISP has multiple customers with IP subnets `203.0.113.0/24`, `203.0.114.0/24`, `203.0.115.0/24`, and `203.0.116.0/24`.
   - Instead of advertising four separate routes, the ISP can use **CIDR aggregation** to advertise a single route: `203.0.112.0/22`.
   - This combined route covers all four subnets and simplifies the routing table entries.

2. **Routing Protocols and CIDR**:
   - **BGP (Border Gateway Protocol)**: BGP, the main routing protocol used on the internet, supports CIDR to help route advertisements be as aggregated as possible. This keeps internet routing tables manageable, enabling more scalable growth.
   - **OSPF (Open Shortest Path First)** and **EIGRP (Enhanced Interior Gateway Routing Protocol)**: These protocols can also leverage CIDR to optimize routing within internal networks by summarizing routes.

3. **CIDR Notation in Routing Tables**:
   - **Example Entry**: A routing table entry might show `10.10.0.0/16` indicating that traffic destined for any address between `10.10.0.0` and `10.10.255.255` should follow a specific route.
   - CIDR helps routers handle fewer entries, enhancing lookup speed and reducing processing overhead.

### Real-World Scenario:
Consider a company with three branches, each needing its subnet:
- The company is assigned `172.16.0.0/16` (65,536 IPs). They can split this into:
  - `172.16.0.0/18` for Branch A (16,384 IPs)
  - `172.16.64.0/18` for Branch B (16,384 IPs)
  - `172.16.128.0/18` for Branch C (16,384 IPs)

Each branch's router can advertise its subnet to the main office using summarized CIDR notation, making the network efficient and scalable.

### Summary:
- **Subnetting with CIDR** provides network administrators with control over IP allocation, making networks more efficient.
- **Routing protocols** use CIDR to aggregate routes and reduce the size of routing tables, optimizing network performance.
- CIDR notation is fundamental to managing both IPv4 and IPv6 networks, enabling the internet to handle growing connectivity demands.

---


### Summary of CIDR in Subnetting and Routing:

**CIDR** enhances network design and routing through its ability to flexibly allocate IP address space and support route aggregation. This adaptability optimizes resource usage and simplifies routing management, particularly in large-scale networks.

#### Key Benefits of CIDR:
- **Efficient IP Allocation**: CIDR helps prevent wasted IP addresses by allowing administrators to allocate addresses based on specific needs, rather than adhering to fixed class boundaries (Class A, B, C).
- **Scalable Network Design**: CIDR allows networks to be divided into appropriately sized subnets, which can be customized for different branches, departments, or services.
- **Route Aggregation (Supernetting)**: Reduces the size of routing tables by summarizing multiple networks into a single route, which in turn lowers the processing burden on routers and speeds up routing decisions.

### Detailed Example of CIDR in Action:
**Scenario**: An ISP managing IP allocations for several customers.

- **ISP's CIDR Block**: `198.51.0.0/20` (contains 4,096 IP addresses).
- **Subnetting by the ISP**:
  - Customer A receives `198.51.0.0/22` (1,024 IPs).
  - Customer B receives `198.51.4.0/22` (1,024 IPs).
  - Customer C receives `198.51.8.0/22` (1,024 IPs).
  - Customer D receives `198.51.12.0/22` (1,024 IPs).

**Route Aggregation**:
- Instead of advertising separate entries for each customer (`198.51.0.0/22`, `198.51.4.0/22`, etc.), the ISP can advertise a single route `198.51.0.0/20`, summarizing all the subnets. This keeps the global routing table concise and manageable.

### Integration with Routing Protocols:
- **BGP (Border Gateway Protocol)**: CIDR allows BGP to manage and advertise aggregated routes effectively, reducing the number of individual routes exchanged between autonomous systems (AS). This results in a more efficient and scalable internet infrastructure.
- **OSPF (Open Shortest Path First)**: CIDR enables OSPF to summarize routes between different areas within an organization, decreasing the number of entries in routing tables and improving convergence time.
- **EIGRP (Enhanced Interior Gateway Routing Protocol)**: EIGRP uses CIDR to support variable-length subnet masks (VLSMs) within a network, allowing for optimal address space usage.

### Real-World Application:
Suppose a multinational company with offices in New York, London, and Tokyo receives the block `10.0.0.0/8`. They can segment this block for different branches:

- **New York Office**: `10.1.0.0/16` (65,536 IPs)
- **London Office**: `10.2.0.0/16` (65,536 IPs)
- **Tokyo Office**: `10.3.0.0/16` (65,536 IPs)

Each office advertises its subnet to the main router using **CIDR notation**. The main router can aggregate these as `10.0.0.0/14`, simplifying external route advertisements and maintaining efficient routing.

---

### CIDR Configuration Examples and Tools

Let’s delve into practical examples of how to configure CIDR for subnets in networking devices, along with some subnet calculators and tools that can help with CIDR subnetting.

### Example Configuration: Cisco Router

Here’s an example of how you might configure a Cisco router with CIDR subnets:

#### Scenario:
- An organization has the CIDR block `192.168.0.0/24`.
- The organization wants to create three subnets:
  - **Subnet 1**: `192.168.0.0/26` for the Sales department (64 addresses)
  - **Subnet 2**: `192.168.0.64/26` for the HR department (64 addresses)
  - **Subnet 3**: `192.168.0.128/26` for the IT department (64 addresses)

#### Cisco Router Configuration Steps:

1. **Access the Router**: 
   Connect to your Cisco router via console or SSH.

2. **Enter Global Configuration Mode**:
   ```bash
   enable
   configure terminal
   ```

3. **Configure Subnet Interfaces**:
   - **For the Sales Department**:
     ```bash
     interface GigabitEthernet0/0.1
     encapsulation dot1Q 1
     ip address 192.168.0.1 255.255.255.192  # /26 Subnet
     ```
   - **For the HR Department**:
     ```bash
     interface GigabitEthernet0/0.2
     encapsulation dot1Q 2
     ip address 192.168.0.65 255.255.255.192  # /26 Subnet
     ```
   - **For the IT Department**:
     ```bash
     interface GigabitEthernet0/0.3
     encapsulation dot1Q 3
     ip address 192.168.0.129 255.255.255.192  # /26 Subnet
     ```

4. **Exit and Save Configuration**:
   ```bash
   exit
   write memory
   ```

### Verifying the Configuration:
You can verify your configuration with the following commands:
```bash
show ip interface brief
```
This command will display the status and IP address of each interface, confirming that your subnets are correctly configured.

### Subnet Calculators and Tools

Several tools can assist in calculating CIDR notations and subnetting:

1. **Online Subnet Calculators**:
   - **Subnet-Calculator.com**: Enter your IP address and subnet mask to see CIDR notation, network address, and broadcast address.
   - **IPcalc**: A simple command-line tool (Linux) to calculate subnets, CIDR, and usable hosts.

2. **Subnetting Software**:
   - **SolarWinds IP Address Manager**: Provides features for managing and planning IP address allocation, including CIDR support.
   - **ManageEngine OpUtils**: Offers IP address management and subnetting tools that support CIDR.

3. **CIDR Notation Cheat Sheet**:
   Here's a quick reference for common subnet sizes and CIDR notation:

   | CIDR Notation | Subnet Mask       | Total IPs | Usable IPs |
   |---------------|-------------------|-----------|------------|
   | /24           | 255.255.255.0     | 256       | 254        |
   | /25           | 255.255.255.128   | 128       | 126        |
   | /26           | 255.255.255.192   | 64        | 62         |
   | /27           | 255.255.255.224   | 32        | 30         |
   | /28           | 255.255.255.240   | 16        | 14         |
   | /29           | 255.255.255.248   | 8         | 6          |
   | /30           | 255.255.255.252   | 4         | 2          |

### Summary:
- **Configuration**: The example illustrates how to configure CIDR-based subnets on a Cisco router. This configuration allows efficient management of IP addresses in a network.
- **Tools**: Using online subnet calculators and software can greatly simplify the process of calculating and managing CIDR subnets.

---

## What is broadcast?

### Broadcast Address Explained

A **broadcast address** is a special type of address used in computer networking to send data packets to all devices on a specific subnet or network segment simultaneously. It allows a sender to communicate with all devices in that subnet without needing to send individual messages to each device.

#### Key Characteristics of Broadcast Address:

1. **Address Format**: 
   - The broadcast address for a given subnet is derived from the subnet's network address by setting all the host bits to 1. 
   - For example, in a `/24` subnet (e.g., `192.168.1.0/24`), the broadcast address would be `192.168.1.255`, where `255` represents all host bits set to 1.

2. **Purpose**:
   - Broadcast addresses are used for various purposes, including network discovery, service announcements, and sending control messages to multiple devices at once.

3. **How It Works**:
   - When a device sends a packet to the broadcast address, all devices within the same subnet receive that packet. Devices outside the subnet do not receive it, which helps manage network traffic.

4. **Examples**:
   - **For the subnet `192.168.1.0/24`**:
     - Network Address: `192.168.1.0`
     - Broadcast Address: `192.168.1.255`
   - **For the subnet `10.0.0.0/8`**:
     - Network Address: `10.0.0.0`
     - Broadcast Address: `10.255.255.255`

#### Calculating Broadcast Address:

To calculate the broadcast address for any given subnet:

1. **Identify the Network Address and Subnet Mask**: 
   - For example, let's say we have the network `192.168.1.0/26`. The subnet mask for `/26` is `255.255.255.192`.

2. **Convert to Binary**:
   - Network Address: `192.168.1.0` -> `11000000.10101000.00000001.00000000`
   - Subnet Mask: `255.255.255.192` -> `11111111.11111111.11111111.11000000`

3. **Determine Host Bits**:
   - The `/26` subnet means there are 6 bits for host addresses (32 - 26 = 6).
   - Setting all host bits to `1` gives us the broadcast address.

4. **Calculate Broadcast Address**:
   - Binary: `11000000.10101000.00000001.00111111`
   - Decimal: `192.168.1.63`

Thus, the broadcast address for the subnet `192.168.1.0/26` is `192.168.1.63`.

#### Use Cases for Broadcast Address:

- **DHCP**: When a device needs an IP address, it sends a DHCP Discover message to the broadcast address. This allows all DHCP servers on the network to respond.
- **ARP (Address Resolution Protocol)**: ARP requests are sent to the broadcast address so that the device can determine the MAC address of another device with a specific IP address.

### Summary:
The broadcast address is a vital networking concept that facilitates efficient communication across all devices within a subnet. By allowing a single message to reach multiple devices, it simplifies various network functions, such as discovery and configuration. If you have further questions or need examples related to a specific scenario, feel free to ask!

---

## Question : Divide 192.168.0./24 into four subnets?

To divide the network `192.168.1.0/24` into 4 subnets, you can use a subnetting method that increases the subnet prefix length. Here’s how to do it step-by-step:

### Step 1: Determine the New Subnet Mask

1. **Original Subnet**: `192.168.1.0/24`
   - The `/24` means that the first 24 bits are for the network part, leaving 8 bits for the host part.
   - In decimal, the subnet mask is `255.255.255.0`.

2. **Calculate Required Subnets**:
   - You want to create **4 subnets**. To find the number of bits needed to create 4 subnets, use the formula \(2^n \geq \text{Number of Subnets}\), where \(n\) is the number of bits.
   - \(2^2 = 4\), so you need 2 bits.

3. **New Subnet Mask**:
   - Add 2 bits to the original `/24` to get the new subnet mask:
   - New subnet mask: `/26` (which is `255.255.255.192` in decimal).

### Step 2: Calculate the Subnets

With a `/26` subnet mask, each subnet will have \(2^{(32-26)} = 2^6 = 64\) addresses, with 62 usable for hosts (2 addresses are reserved for network and broadcast).

#### Subnet Breakdown:

1. **Subnet 1**:
   - **Network Address**: `192.168.1.0/26`
   - **Usable IP Range**: `192.168.1.1` to `192.168.1.62`
   - **Broadcast Address**: `192.168.1.63`

2. **Subnet 2**:
   - **Network Address**: `192.168.1.64/26`
   - **Usable IP Range**: `192.168.1.65` to `192.168.1.126`
   - **Broadcast Address**: `192.168.1.127`

3. **Subnet 3**:
   - **Network Address**: `192.168.1.128/26`
   - **Usable IP Range**: `192.168.1.129` to `192.168.1.190`
   - **Broadcast Address**: `192.168.1.191`

4. **Subnet 4**:
   - **Network Address**: `192.168.1.192/26`
   - **Usable IP Range**: `192.168.1.193` to `192.168.1.254`
   - **Broadcast Address**: `192.168.1.255`

### Summary of Subnets:

| Subnet      | Network Address    | Usable IP Range                | Broadcast Address  |
|-------------|--------------------|--------------------------------|---------------------|
| Subnet 1    | 192.168.1.0/26     | 192.168.1.1 - 192.168.1.62     | 192.168.1.63        |
| Subnet 2    | 192.168.1.64/26    | 192.168.1.65 - 192.168.1.126   | 192.168.1.127       |
| Subnet 3    | 192.168.1.128/26   | 192.168.1.129 - 192.168.1.190  | 192.168.1.191       |
| Subnet 4    | 192.168.1.192/26   | 192.168.1.193 - 192.168.1.254  | 192.168.1.255       |

### Points to ponder

By increasing the subnet prefix from `/24` to `/26`, we effectively divided the original network `192.168.1.0/24` into 4 smaller subnets, each capable of supporting up to 62 hosts.
