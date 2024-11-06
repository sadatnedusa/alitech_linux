
# Examples of **iptables** 
## That demonstrate how to **allow**, **drop**, and **block** various types of network traffic.
## These examples will help you understand how to create effective firewall rules for different scenarios.

### **1. Allow All Incoming Traffic on Port 22 (SSH)**

If you want to allow incoming SSH connections on port 22 (typically used for remote server management), use the following command:

```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

This will allow incoming **TCP traffic** destined for **port 22** (SSH).

---

### **2. Block All Incoming Traffic from a Specific IP Address**

To block traffic from a specific IP address (for example, **192.168.1.100**), use this command:

```bash
sudo iptables -A INPUT -s 192.168.1.100 -j DROP
```

This rule will **drop all packets** from the IP address **192.168.1.100**.

---

### **3. Allow All Outgoing Traffic (Default for OUTPUT Chain)**

To allow all outgoing traffic from the server, the **OUTPUT chain** needs to be set to **ACCEPT** (this is usually the default, but it’s good practice to explicitly specify it):

```bash
sudo iptables -A OUTPUT -j ACCEPT
```

This will allow the server to initiate any type of **outgoing connection**.

---

### **4. Block Incoming Traffic from a Specific IP Range (Subnet)**

If you want to block traffic from a **specific IP range** or **subnet**, for example, **192.168.1.0/24**, use:

```bash
sudo iptables -A INPUT -s 192.168.1.0/24 -j DROP
```

This will **block all traffic** from the IP range **192.168.1.0 to 192.168.1.255**.

---

### **5. Allow Incoming HTTP and HTTPS Traffic**

To ensure that your web server is accessible to users on **HTTP (port 80)** and **HTTPS (port 443)**, use the following commands:

```bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # Allow HTTPS
```

These rules will allow **TCP traffic** on ports **80** (HTTP) and **443** (HTTPS).

---

### **6. Block All Incoming Traffic Except for Specific IP Address**

To block all incoming traffic, but allow traffic from a specific IP address (for example, **192.168.1.10**), use the following commands:

```bash
sudo iptables -A INPUT -s 192.168.1.10 -j ACCEPT  # Allow from specific IP
sudo iptables -A INPUT -j DROP  # Drop all other traffic
```

This will allow **incoming traffic** from **192.168.1.10**, while **dropping** all other incoming traffic.

---

### **7. Allow Incoming Traffic on Specific Port Range (e.g., Ports 1000-2000)**

If you want to allow incoming traffic on a range of ports (e.g., ports 1000 to 2000), use the following:

```bash
sudo iptables -A INPUT -p tcp --dport 1000:2000 -j ACCEPT
```

This will allow incoming **TCP traffic** on all ports from **1000 to 2000**.

---

### **8. Block Specific Outgoing Traffic to a Domain or IP Address**

If you want to block outgoing traffic to a specific IP address (e.g., **203.0.113.5**), use:

```bash
sudo iptables -A OUTPUT -d 203.0.113.5 -j REJECT
```

This will block outgoing connections to the IP **203.0.113.5**.

---

### **9. Allow All Traffic to a Specific Network Interface**

If you want to allow all traffic on a specific network interface (e.g., `eth0`), use:

```bash
sudo iptables -A INPUT -i eth0 -j ACCEPT
```

This will allow **all incoming traffic** on the **`eth0` interface**.

---

### **10. Limit the Number of Incoming Connections (Rate Limiting)**

To prevent **DoS (Denial of Service)** attacks or **flooding** by limiting the number of incoming connections per minute, use:

```bash
sudo iptables -A INPUT -p tcp --dport 80 -m limit --limit 5/min -j ACCEPT
```

This limits incoming connections on port **80** to **5 per minute**.

---

### **11. Allow Incoming Traffic on Specific IP Address (Specific Source)**

If you only want to allow traffic from a specific **source IP address** (for example, **192.168.1.50**), use:

```bash
sudo iptables -A INPUT -s 192.168.1.50 -j ACCEPT
```

This will allow **incoming traffic** only from **192.168.1.50** and drop all other traffic.

---

### **12. Drop All Outgoing Traffic to a Specific Port (e.g., Port 25 for SMTP)**

To block outgoing traffic on port **25** (SMTP), which is used for email communication, use:

```bash
sudo iptables -A OUTPUT -p tcp --dport 25 -j REJECT
```

This will **block all outgoing traffic** on port **25** (SMTP).

---

### **13. Block All Traffic (Deny Everything)**

If you want to block **all traffic** (in both directions), you can use the following commands to **drop all connections**:

```bash
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
```

This will block all **incoming and outgoing traffic** unless you explicitly allow it with further rules.

---

### **14. Allow Loopback Traffic (Prevent Localhost Issues)**

To ensure that traffic on the **loopback interface** (localhost, `lo`) is allowed, use:

```bash
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
```

This ensures that **localhost traffic** (from `127.0.0.1` or `localhost`) is **always allowed**.

---

### **15. Allow Incoming Traffic from Specific Subnet (CIDR)**

To allow incoming traffic from a specific **subnet**, for example, **192.168.0.0/24**, use:

```bash
sudo iptables -A INPUT -s 192.168.0.0/24 -j ACCEPT
```

This will allow **incoming traffic** from the **entire subnet** **192.168.0.0/24**.

---

### **Summary of Key iptables Commands:**

- **Allow traffic:** `-A INPUT -p tcp --dport <port> -j ACCEPT`
- **Block traffic:** `-A INPUT -s <ip_address> -j DROP`
- **Limit connections:** `-A INPUT -p tcp --dport <port> -m limit --limit <rate> -j ACCEPT`
- **Drop all traffic:** `-P INPUT DROP` and `-P OUTPUT DROP`
- **Allow traffic on specific interface:** `-A INPUT -i <interface> -j ACCEPT`
- **Allow loopback traffic:** `-A INPUT -i lo -j ACCEPT`

These examples provide a broad range of **allowing**, **blocking**, and **restricting** traffic based on ports, IP addresses, and interfaces, giving you the flexibility to secure your system using iptables.

