# Deep Dive into **Stateful vs Stateless Filtering** in the context of `iptables` 

## How connection states affect packet filtering.

### **Stateful vs Stateless Filtering: Overview**

- **Stateful Filtering**: 
  - `iptables` is capable of tracking the **state** of network connections, such as whether a connection is new, established, or related to an existing connection.
  - **Stateful filtering** allows the firewall to make decisions based on the state of a connection. For instance, it can allow responses to outgoing connections even if they weren't explicitly requested by an incoming rule, making it more efficient and dynamic in handling traffic.

- **Stateless Filtering**: 
  - **Stateless filtering** treats each packet individually without keeping track of the connection state.
  - Each packet is inspected in isolation, and `iptables` doesn’t remember if it’s part of an ongoing connection. This means the firewall doesn't differentiate between legitimate response packets and unsolicited traffic, leading to a more rigid approach.

---

### **Stateful Filtering:**

In stateful filtering, `iptables` uses a **connection tracking module** to track the states of connections. It keeps track of established connections and related connections, meaning that it "remembers" the packets belonging to a specific session and ensures only valid packets are allowed.

#### **Connection States** in Stateful Filtering:
The connection tracking mechanism in `iptables` can detect four states:

1. **NEW**: 
   - This state is used when a packet is attempting to initiate a new connection. For example, when a client sends a request to connect to a server.
   - If you want to allow new incoming connections on a specific port, you would use the `NEW` state.

2. **ESTABLISHED**: 
   - This state refers to packets that are part of an already established connection.
   - For example, if a client initiates an SSH session, any data packets that are exchanged between the client and server are part of the **ESTABLISHED** connection.
   - You allow **ESTABLISHED** connections so that response packets can reach the original requestor.

3. **RELATED**:
   - This state is for packets that are related to an existing connection but are not part of the original connection itself.
   - For instance, if a user establishes an FTP connection, the data connection that’s established as part of that FTP session (even though it’s on a different port) would be considered **RELATED**.
   - You allow **RELATED** traffic to ensure that responses such as FTP data transfers are handled.

4. **INVALID**:
   - This state refers to packets that are not part of any valid connection.
   - Invalid packets are often discarded, as they may be malformed or out of sequence.

#### **Example of Stateful Filtering Rule:**

```bash
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
```

**Explanation**:
- `-A INPUT`: Add this rule to the `INPUT` chain (for incoming packets).
- `-m state`: Use the `state` match module (enables connection tracking).
- `--state RELATED,ESTABLISHED`: This allows packets that are either part of an already established connection or related to an existing connection.
- `-j ACCEPT`: If the packet matches the conditions, it is allowed.

This rule is crucial because it allows the firewall to accept response packets to previously initiated connections without the need for explicit rules for each one.

##### **Scenario:**
Let’s consider the following sequence:

1. **You initiate an HTTP request** to a web server from your local machine.
2. The **outgoing HTTP request** is considered **NEW** by the firewall.
3. The server sends an **HTTP response** back to your machine. Since the connection was initiated, the response packet is **ESTABLISHED** and allowed by the rule `--state ESTABLISHED`.
4. The response packets are associated with the already established connection, and they are allowed back through without requiring a new rule.

This is an example of **stateful filtering**, as the firewall tracks the state of the connection and ensures only valid packets are passed.

---

### **Stateless Filtering:**

In contrast, **stateless filtering** doesn’t track the connection state. Every incoming or outgoing packet is evaluated independently of the others. This means that even if a connection has been established, stateless filtering would treat every packet as if it’s a new packet, with no knowledge of the connection's history or context.

#### **Example of Stateless Filtering Rule:**

```bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

**Explanation**:
- `-A INPUT`: Add this rule to the `INPUT` chain (for incoming packets).
- `-p tcp`: Match only TCP packets.
- `--dport 80`: Match traffic destined for port 80 (HTTP).
- `-j ACCEPT`: If the packet matches the conditions, it is allowed.

This rule is a simple **stateless** filter. It accepts packets coming to port 80, but it doesn't care whether the packet is part of a new, established, or related connection. It just checks if it matches the conditions and then applies the action (ACCEPT).

##### **Scenario with Stateless Filtering**:
If you use only stateless filtering, the server would need an explicit rule for every incoming connection and wouldn't automatically allow the response to a request (such as a response to an HTTP request).

For instance:
- When an incoming **HTTP request** is received, it would be allowed because it matches the port 80 rule.
- However, **response packets** from the server would not be automatically allowed. Each new packet (even if it’s part of an already established connection) would need a rule for it to pass through, which would make the firewall configuration complex.

---

### **Key Differences between Stateful and Stateless Filtering:**

| **Aspect**               | **Stateful Filtering**                              | **Stateless Filtering**                        |
|--------------------------|-----------------------------------------------------|------------------------------------------------|
| **Connection Tracking**   | Tracks connection states (NEW, ESTABLISHED, RELATED, INVALID) | Does not track any connection states.         |
| **Efficiency**            | More efficient for dynamic traffic, allows easy handling of response packets. | Less efficient, requires explicit rules for each packet. |
| **Configuration Complexity** | Easier configuration for common scenarios (e.g., allow responses to initiated connections). | Requires more rules and complex configurations for handling connections. |
| **Use Cases**             | Ideal for most common networking situations (e.g., web, SSH). | Used for strict or simple use cases where no connection tracking is needed. |
| **Security**              | Generally more secure because it ensures that only valid response packets are allowed. | Can be less secure if not properly configured to handle responses or unsolicited traffic. |

---

### **When to Use Stateful vs Stateless Filtering?**

- **Stateful Filtering**:
  - Use this for most modern firewall setups, especially when you need to manage complex traffic patterns like web browsing, SSH, or FTP.
  - Stateful filtering is more efficient and secure because it allows response packets from already established connections to pass automatically.
  - Ideal for environments where stateful inspection is required to validate traffic dynamically.

- **Stateless Filtering**:
  - Useful in simpler environments or for very specific purposes, such as **restrictive firewalls**, or where connection tracking is not desired (e.g., very low-power devices, high-performance scenarios).
  - Stateless filtering is often used in simpler setups or testing scenarios where the security of connection tracking is not needed.

---

### **Example of Stateful Filtering in Practice:**

Let’s assume you want to allow the following:
- Outgoing HTTP and HTTPS traffic.
- Incoming SSH traffic.
- Drop all other traffic.

#### Step 1: Allow outgoing HTTP and HTTPS traffic
```bash
sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT  # HTTP
sudo iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT  # HTTPS
```

#### Step 2: Set default policy for incoming traffic to DROP
```bash
sudo iptables -P INPUT DROP
```

#### Step 3: Allow incoming SSH traffic (Stateful)
```bash
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
```

#### Step 4: Allow responses to established connections (Stateful)
```bash
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

### **Conclusion:**

- **Stateful filtering** is more secure and efficient for handling dynamic traffic because it keeps track of the connection state.
- **Stateless filtering** is simpler and can be used for strict, controlled scenarios where connection state isn’t needed or desired.

