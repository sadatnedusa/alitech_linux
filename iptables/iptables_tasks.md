## **Task 1: Verify and Install iptables**

### **Step 1: Verify if iptables is already installed**

Before proceeding with the installation, you should first check if `iptables` is already installed on your system.

Run the following command to verify:

```bash
sudo iptables --version
```

- If `iptables` is installed, you will see the version information.
- If it's not installed, you'll get an error message indicating that the command was not found.

### **Step 2: Install iptables**

If `iptables` is not installed, you can install it using your package manager.

For **Debian-based systems** (like Ubuntu), run:

```bash
sudo apt update
sudo apt install -y iptables
```

For **Red Hat-based systems** (like CentOS or Fedora), use:

```bash
sudo yum install -y iptables
```

### **Step 3: Verify the installation**

After installation, verify that `iptables` is installed and functional by running:

```bash
sudo iptables --version
```

This will display the version of iptables installed, confirming the installation.

### **Step 4: Check Current iptables Rules (Optional)**

To check the current rules (if any) in place, you can use:

```bash
sudo iptables -L -n -v
```

This will display the active firewall rules and their associated counters.

### **Task Summary:**

1. First, verify if `iptables` is installed using `sudo iptables --version`.
2. If not installed, use `sudo apt install iptables` (for Debian-based) or `sudo yum install iptables` (for Red Hat-based) to install it.
3. After installation, verify by checking the `iptables` version again with `sudo iptables --version`.

---

## **Task 2: Set Default Policies for Network Traffic**

The objective of this task is to establish secure default policies for your firewall by setting the following default actions:

- **INPUT** chain: DROP all incoming traffic, except for related and established connections.
- **FORWARD** chain: DROP all forwarded traffic.
- **OUTPUT** chain: ACCEPT all outgoing traffic.

### **Step-by-Step Process**

#### **Step 1: Allow Established and Related Connections (to Avoid Locking Yourself Out)**

First, you need to allow established and related connections to ensure you don’t lock yourself out of the system. This is especially important for remote access (SSH, etc.).

Run the following command:

```bash
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

This command allows incoming traffic that is part of an established connection or related to an established connection. This prevents disruption of ongoing sessions like SSH and ensures that responses to outgoing requests can come back into the server.

#### **Step 2: Set the Default Policies for the Chains**

Now, set the default policies to **DROP** for **INPUT** and **FORWARD** chains, and **ACCEPT** for the **OUTPUT** chain.

1. **Set the default policy for the INPUT chain to DROP:**

```bash
sudo iptables -P INPUT DROP
```

2. **Set the default policy for the FORWARD chain to DROP:**

```bash
sudo iptables -P FORWARD DROP
```

3. **Set the default policy for the OUTPUT chain to ACCEPT:**

```bash
sudo iptables -P OUTPUT ACCEPT
```

These commands will:
- **INPUT** chain: Block all incoming traffic by default (except established/related connections).
- **FORWARD** chain: Block all forwarded traffic.
- **OUTPUT** chain: Allow all outgoing traffic.

### **Step 3: Verify the Default Policies**

To verify that the default policies have been set correctly, run:

```bash
sudo iptables -L -v -n
```

You should see the following output for the default policies:

- **INPUT** chain: Drop all traffic (unless established/related).
- **FORWARD** chain: Drop all forwarded traffic.
- **OUTPUT** chain: Accept all outgoing traffic.

### **Final Notes:**
- The INPUT chain controls incoming traffic (from external sources to your server).
- The FORWARD chain controls traffic passing through your server (e.g., routing traffic).
- The OUTPUT chain controls traffic going out from your server to external destinations.

### **Recap of Commands:**
1. Allow established and related connections to avoid being locked out:
   ```bash
   sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
   ```

2. Set default policies:
   ```bash
   sudo iptables -P INPUT DROP
   sudo iptables -P FORWARD DROP
   sudo iptables -P OUTPUT ACCEPT
   ```


---

## **Task 3: Configure Rules for Essential Web Traffic**

To ensure that your web server is accessible to users via HTTP (port 80) and HTTPS (port 443), you need to configure **iptables** to allow traffic on these ports.

#### **Step 1: Allow HTTP (Port 80) and HTTPS (Port 443)**

Run the following commands to allow incoming traffic on ports 80 (HTTP) and 443 (HTTPS):

1. **Allow HTTP (Port 80):**

```bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

2. **Allow HTTPS (Port 443):**

```bash
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```

These rules will:
- **Allow incoming TCP traffic** destined for port **80** (HTTP).
- **Allow incoming TCP traffic** destined for port **443** (HTTPS).

#### **Step 2: Verify the Rules**

To verify that the rules were successfully added, run the following command:

```bash
sudo iptables -L -v -n
```

You should see something similar to:

```bash
Chain INPUT (policy DROP 0 packets, 0 bytes)
    pkts bytes target     prot opt in     out     source               destination
      0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:80
      0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:443
```

This confirms that HTTP and HTTPS traffic is now allowed.

---

### **Task 4: Manage ICMP Traffic**

ICMP (Internet Control Message Protocol) is commonly used for network diagnostic tools like `ping`. While useful, it can also be exploited for network scanning and other malicious activities. To protect your server from these potential threats, you can block all incoming ICMP requests.

#### **Step 1: Block All Incoming ICMP Traffic**

Run the following command to block all incoming ICMP requests:

```bash
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
```

This rule will:
- **Block incoming ICMP "echo-request" packets** (commonly used by the `ping` command).

#### **Step 2: Verify the Rule**

To ensure that the rule has been added correctly, run:

```bash
sudo iptables -L -v -n
```

You should see a rule similar to this:

```bash
Chain INPUT (policy DROP 0 packets, 0 bytes)
    pkts bytes target     prot opt in     out     source               destination
      0     0 DROP       icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmp echo-request
```

This confirms that incoming ICMP "echo-request" packets (ping requests) are now blocked.

### **Recap of Commands**

1. **Configure rules for essential web traffic (HTTP & HTTPS):**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
   sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
   ```

2. **Block incoming ICMP requests:**
   ```bash
   sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
   ```
---


## **Task 5: Remove the ICMP Block Rule**

To remove the rule blocking ICMP requests (which was added in **Task 4**), you need to **delete** the specific iptables rule that blocks incoming ICMP `echo-request` packets.

#### **Step 1: Identify the Rule to Delete**

Run the following command to list all iptables rules and identify the ICMP block rule:

```bash
sudo iptables -L -v -n --line-numbers
```

Look for the rule that blocks ICMP requests. It will look similar to this:

```bash
Chain INPUT (policy DROP 0 packets, 0 bytes)
    num  target     prot opt in     out     source               destination
    1    DROP       icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmp echo-request
```

In this case, the rule number is **1**.

#### **Step 2: Delete the Rule**

To remove the rule, use the `-D` option with the rule number:

```bash
sudo iptables -D INPUT 1
```

This will **delete** the rule that blocks ICMP requests.

#### **Step 3: Verify the Rule is Removed**

Run the following command to verify that the ICMP block rule is removed:

```bash
sudo iptables -L -v -n
```

You should no longer see the ICMP block rule.

---

## **Task 6: Block Traffic from a Specific IP Address**

Now, you need to add a rule to block all access from the IP range **192.0.2.0/24**, which includes addresses from **192.0.2.0** to **192.0.2.255**.

#### **Step 1: Add a Rule to Block Traffic from the IP Range**

Run the following command to block all traffic from the IP range **192.0.2.0/24**:

```bash
sudo iptables -A INPUT -s 192.0.2.0/24 -j DROP
```

This rule does the following:
- **`-A INPUT`**: Appends the rule to the **INPUT** chain (inbound traffic).
- **`-s 192.0.2.0/24`**: Specifies the source IP address range to block (**192.0.2.0/24**).
- **`-j DROP`**: Drops all packets from this IP range.

#### **Step 2: Verify the Rule**

To verify that the rule has been successfully added, run:

```bash
sudo iptables -L -v -n
```

You should see an entry like this:

```bash
Chain INPUT (policy DROP 0 packets, 0 bytes)
    pkts bytes target     prot opt in     out     source               destination
      0     0 DROP       all  --  *      *       192.0.2.0/24         0.0.0.0/0
```

This confirms that all traffic from the IP range **192.0.2.0/24** will be blocked.

### **Recap of Commands:**

1. **Remove the ICMP Block Rule:**
   - List rules to identify the rule number:
     ```bash
     sudo iptables -L -v -n --line-numbers
     ```
   - Delete the blocking rule (replace `1` with the correct rule number if needed):
     ```bash
     sudo iptables -D INPUT 1
     ```

2. **Block Traffic from a Specific IP Address (192.0.2.0/24):**
   ```bash
   sudo iptables -A INPUT -s 192.0.2.0/24 -j DROP
   ```

