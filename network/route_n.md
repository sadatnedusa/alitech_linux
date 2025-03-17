## route -n
- The `route -n` command is used to display the routing table on a Linux or Unix-based system, but it also works on other systems with similar CLI interfaces (e.g., some network devices).
- The `-n` option prevents the command from attempting to resolve IP addresses into hostnames, displaying raw IP addresses instead for faster output.

### Example Output of `route -n`
When you run the `route -n` command, you might see output like this:

```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 eth0
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
```

### Explanation of the Columns:
1. **Destination**: The destination network or host.
2. **Gateway**: The gateway (next hop) to reach the destination.
3. **Genmask**: The subnet mask for the destination.
4. **Flags**: Various flags that indicate the route's status:
   - `U`: Route is up (active).
   - `G`: Gateway route.
   - `H`: Host route (route to a specific IP).
5. **Metric**: The "cost" of using the route (lower values indicate preferred routes).
6. **Ref**: The reference count (typically not used on Linux).
7. **Use**: Number of times the route has been used.
8. **Iface**: The network interface associated with the route (e.g., `eth0`, `eth1`, etc.).

### Common Use Cases:
- **View current routes**: Checking the current routing table to understand how traffic is being routed through the network.
- **Diagnosing routing issues**: If you're having network issues, this command can help determine if routes are correctly configured.

---
## Examples

- Here are some **common routing problems**, their **explanations**, and the **troubleshooting steps** to help resolve them.


### **Example 1: Missing Default Route**
**Problem:**
When you run `route -n`, there is no default route (`0.0.0.0`) in the routing table. This could prevent the device from accessing networks outside of its local subnet.

**Example Output:**
```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
```

**Explanation:**
- The routing table lacks an entry for the default route (`0.0.0.0`), meaning the device does not know how to reach external networks.
- The `0.0.0.0` route is essential for routing packets to destinations outside of the local network.

**Troubleshooting Steps:**
1. **Check your gateway**: Ensure that the device has a valid gateway address configured.
   - If the device is connected to a router, the gateway should be the router's IP address.
2. **Add a default route manually**: You can add the default route with the following command:
   ```bash
   sudo route add default gw <gateway-ip> eth0
   ```
   Example:
   ```bash
   sudo route add default gw 192.168.1.1 eth0
   ```
3. **Verify the new route**: After adding the default route, check the routing table again with:
   ```bash
   route -n
   ```

4. **Test connectivity**: Try pinging an external IP (e.g., Google's DNS server):
   ```bash
   ping 8.8.8.8
   ```


### **Example 2: Incorrect Network Mask**
**Problem:**
The network mask in the routing table is incorrect, which could lead to network isolation (e.g., the device cannot communicate with other devices in the same subnet).

**Example Output:**
```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     0.0.0.0         255.255.0.0     U     0      0        0 eth0
```

**Explanation:**
- The `Genmask` for `192.168.1.0` is incorrectly set to `255.255.0.0` instead of the correct `255.255.255.0` for a standard Class C subnet.
- This misconfiguration can lead to issues in communication with other devices on the same subnet, as the subnet mask tells the device which IP addresses are local and which require a gateway.

**Troubleshooting Steps:**
1. **Verify the correct subnet mask** for your network. For `192.168.1.0`, the correct subnet mask is typically `255.255.255.0` unless you have a different network design.
2. **Modify the network mask** using the following command:
   ```bash
   sudo route change 192.168.1.0/24 gw 192.168.1.1
   ```
3. **Verify the configuration**:
   ```bash
   route -n
   ```

4. **Test connectivity** to devices in the same subnet:
   ```bash
   ping 192.168.1.100
   ```


### **Example 3: Incorrect or Missing Gateway**
**Problem:**
You may have a route for a network, but the gateway address might be incorrect or unreachable, which can cause traffic to fail.

**Example Output:**
```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.0     192.168.1.1     255.255.255.0   UG    0      0        0 eth0
```

**Explanation:**
- In this example, traffic to `192.168.2.0` network should be routed through `192.168.1.1` (gateway).
- If `192.168.1.1` is down or unreachable, packets destined for `192.168.2.0` will not be able to reach their destination.

**Troubleshooting Steps:**
1. **Check if the gateway is reachable**:
   - Use `ping` to test the gateway:
     ```bash
     ping 192.168.1.1
     ```
   - If the gateway is unreachable, it may be down, or there could be a network connectivity issue.
2. **Verify gateway configuration**: Ensure the gateway IP is correctly configured. If necessary, replace it with a valid gateway IP.
3. **Check for routing loops or conflicts**: Run `traceroute` to see if the packet is being misrouted:
   ```bash
   traceroute 192.168.2.100
   ```

4. **If needed, delete and re-add the route**:
   ```bash
   sudo route del 192.168.2.0
   sudo route add 192.168.2.0 gw <correct-gateway-ip>
   ```


### **Example 4: Route to a Specific Host Not Found**
**Problem:**
If you're trying to ping a specific host and it's not reachable, it's possible that there isn't a specific route in the routing table for that host.

**Example Output:**
```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
```

**Explanation:**
- If the destination IP is outside the `192.168.1.0/24` subnet, there might be no direct route for that host.
- In this example, there is no route for `10.1.1.1` (a different network).

**Troubleshooting Steps:**
1. **Check if a route exists for the destination network**: 
   - For example, to access `10.1.1.0/24`, the device needs a route to that network.
   - Verify the routing table and see if the network exists.
2. **Add the appropriate route**:
   - If necessary, add a static route to the desired destination.
     ```bash
     sudo route add -net 10.1.1.0/24 gw 192.168.1.1
     ```

3. **Verify the route**:
   ```bash
   route -n
   ```

4. **Test connectivity**:
   ```bash
   ping 10.1.1.1
   ```


### **Example 5: Subnet Overlap**
**Problem:**
You might have two or more routes with overlapping subnets, which can cause conflicts in routing decisions.

**Example Output:**
```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.1.0     192.168.1.1     255.255.255.0   UG    0      0        0 eth0
```

**Explanation:**
- You have two routes for the same network `192.168.1.0/24`. One is a direct connection (`0.0.0.0` gateway), and the other has a gateway (`192.168.1.1`).
- This can create ambiguity about how traffic for `192.168.1.0/24` should be routed.

**Troubleshooting Steps:**
1. **Identify and remove conflicting routes**:
   - If one route is unnecessary, remove it:
     ```bash
     sudo route del 192.168.1.0
     ```

2. **Verify routing table**:
   ```bash
   route -n
   ```

3. **Test traffic** to ensure routing works as expected:
   ```bash
   ping 192.168.1.100
   ```


### Conclusion
By understanding and following these troubleshooting steps, you can resolve common routing issues like missing default routes, incorrect subnet masks, unreachable gateways, and more. 
If you have a specific output from `route -n` or need help with another routing issue, feel free to share it, and I can assist further!
