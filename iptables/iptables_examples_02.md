# Here are **more iptables** examples that demonstrate additional **allowing**, **blocking**, and **restricting** scenarios.
## These examples will help you refine your understanding of how to manage firewall rules for different network security requirements.

---

### **16. Allow Incoming FTP Traffic (Port 21)**

To allow incoming FTP connections (which use **port 21**), you can use the following command:

```bash
sudo iptables -A INPUT -p tcp --dport 21 -j ACCEPT
```

This will allow **TCP traffic** on **port 21** (FTP).

---

### **17. Block Traffic from a Range of IP Addresses (IP Range)**

To block traffic from an **IP range**, such as **192.168.1.50 to 192.168.1.100**, use:

```bash
sudo iptables -A INPUT -m iprange --src-range 192.168.1.50-192.168.1.100 -j DROP
```

This will **drop traffic** from IPs in the specified range, **192.168.1.50 to 192.168.1.100**.

---

### **18. Block Incoming Traffic Based on Source Port**

To block incoming traffic from a **specific source port** (e.g., port **12345**), use:

```bash
sudo iptables -A INPUT -p tcp --sport 12345 -j DROP
```

This will **drop incoming TCP traffic** that originates from **port 12345**.

---

### **19. Allow Traffic from a Specific User (UID)**

If you want to allow traffic from a specific user (e.g., **UID 1001**), you can use:

```bash
sudo iptables -A INPUT -m owner --uid-owner 1001 -j ACCEPT
```

This rule will allow traffic from **user with UID 1001**.

---

### **20. Limit Number of Connections per IP (Connection Rate Limiting)**

To prevent abuse and limit the number of connections from a single IP, you can apply rate limiting using:

```bash
sudo iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --set
sudo iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
```

This limits the number of **new connections on port 80 (HTTP)** to **10 per minute** from the same IP address. If more than 10 attempts are made in 60 seconds, they will be **dropped**.

---

### **21. Block Incoming Traffic for Specific Time (Time-based Blocking)**

To block incoming traffic on **port 80** during specific hours, use the `time` module:

```bash
sudo iptables -A INPUT -p tcp --dport 80 -m time --timestart 20:00 --timestop 06:00 -j DROP
```

This blocks traffic to **port 80** between **8:00 PM and 6:00 AM**.

---

### **22. Allow Incoming DNS Traffic (Port 53)**

To allow incoming **DNS** traffic (which uses **port 53** for both UDP and TCP), use:

```bash
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT  # UDP DNS
sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT  # TCP DNS
```

This allows **both UDP and TCP traffic** on **port 53**, commonly used by **DNS**.

---

### **23. Allow Web Traffic Only from a Specific IP Range**

If you want to allow web traffic (port 80 and 443) only from a specific **IP range** (e.g., **192.168.2.0/24**), use:

```bash
sudo iptables -A INPUT -p tcp -s 192.168.2.0/24 --dport 80 -j ACCEPT  # HTTP
sudo iptables -A INPUT -p tcp -s 192.168.2.0/24 --dport 443 -j ACCEPT  # HTTPS
```

This will allow web traffic on **ports 80 and 443** from **192.168.2.0/24** but **block** it from other IP addresses.

---

### **24. Block All Outbound HTTP Traffic**

To block all **outgoing HTTP traffic** (port 80), use:

```bash
sudo iptables -A OUTPUT -p tcp --dport 80 -j REJECT
```

This will **reject all outgoing traffic** on **port 80**, which is typically used for **HTTP** connections.

---

### **25. Allow Only SSH Traffic from a Specific Subnet**

To only allow **SSH** traffic (port 22) from a specific **subnet** (e.g., **192.168.0.0/24**), use:

```bash
sudo iptables -A INPUT -p tcp -s 192.168.0.0/24 --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j DROP
```

This will allow **SSH access** only from the **192.168.0.0/24 subnet** and block all other sources from accessing SSH.

---

### **26. Block Traffic from an IP Address but Allow Specific Port**

To block all traffic from **192.168.1.50** except for **HTTP traffic (port 80)**, use:

```bash
sudo iptables -A INPUT -s 192.168.1.50 -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -s 192.168.1.50 -j DROP
```

This allows **HTTP traffic (port 80)** from **192.168.1.50** but **drops all other traffic** from that IP.

---

### **27. Allow Only Local Traffic (localhost) on Port 8080**

If you want to allow traffic to **port 8080** only from the **localhost** (127.0.0.1), use:

```bash
sudo iptables -A INPUT -p tcp --dport 8080 -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j DROP
```

This will allow **TCP traffic on port 8080** from the **localhost** interface and **block** traffic from any other source.

---

### **28. Allow Incoming Mail Traffic (SMTP, IMAP, POP3)**

To allow incoming **email traffic** for SMTP, IMAP, and POP3, use:

```bash
sudo iptables -A INPUT -p tcp --dport 25 -j ACCEPT  # SMTP
sudo iptables -A INPUT -p tcp --dport 143 -j ACCEPT  # IMAP
sudo iptables -A INPUT -p tcp --dport 110 -j ACCEPT  # POP3
```

This allows incoming email traffic on **SMTP (25)**, **IMAP (143)**, and **POP3 (110)**.

---

### **29. Allow Only Incoming Connections from Localhost for a Specific Port**

To allow incoming connections to a specific port, like **port 8080**, **only from localhost**, use:

```bash
sudo iptables -A INPUT -p tcp -i lo --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j DROP
```

This will allow connections to **port 8080** only from **localhost** (`lo` interface) and drop connections from any other source.

---

### **30. Logging Rejected Traffic**

To log the details of rejected traffic before dropping it, use:

```bash
sudo iptables -A INPUT -j LOG --log-prefix "Dropped Traffic: " --log-level 4
sudo iptables -A INPUT -j DROP
```

This will **log** details of dropped packets with the prefix `"Dropped Traffic:"` and **then drop** the traffic.

---

### **31. Block Traffic from a Specific Port**

If you want to block traffic **to a specific port** (e.g., port 25, which is used for SMTP), you can use:

```bash
sudo iptables -A INPUT -p tcp --dport 25 -j REJECT
```

This will **reject incoming traffic** on **port 25**.

---

### **32. Allow HTTP and HTTPS Traffic But Block All Other Ports**

To allow **HTTP (port 80)** and **HTTPS (port 443)** traffic, but **block all other traffic**, use:

```bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # Allow HTTPS
sudo iptables -A INPUT -j DROP  # Block all other traffic
```

This will allow **HTTP** and **HTTPS traffic** and **block** all other incoming traffic.

---

These examples cover various use cases of **allowing**, **blocking**, and **restricting** traffic with **iptables** to help you configure network security for different scenarios.

