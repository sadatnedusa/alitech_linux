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

Would you like to explore subnetting in CIDR, or how CIDR is used with specific routing protocols?
