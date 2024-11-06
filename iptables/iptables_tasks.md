### **Task 2: Set Default Policies for Network Traffic**

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
