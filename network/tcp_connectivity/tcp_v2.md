## step by step breakdown of TCP

- Understanding how a **TCP (Transmission Control Protocol)** connection works from **source application to destination application** involves multiple layers of the OSI model 
  - (primarily the Application, Transport, Network, and Data Link layers). 

- Below is a **step-by-step breakdown** of the entire process, from how a connection is established, data is transferred, and finally, how the connection is closed.

---

## 🌐 0. Overview of Layers Involved (TCP/IP Stack)

| Layer | OSI Layer   | Example Protocols | Role                  |
| ----- | ----------- | ----------------- | --------------------- |
| 4     | Application | HTTP, FTP, SSH    | User interaction      |
| 3     | Transport   | **TCP**, UDP      | End-to-end connection |
| 2     | Internet    | IP                | Routing packets       |
| 1     | Link        | Ethernet, Wi-Fi   | Physical transmission |

---

## 🔌 1. TCP Connection Establishment (3-Way Handshake)

### Example: Client wants to connect to server (e.g., HTTP on port 80)

1. **Source Application (e.g., browser)** requests a TCP connection to `example.com:80`.
2. **TCP Layer (Transport Layer)** in the OS kernel builds a packet with:

   * SYN (synchronize) flag set
   * Initial Sequence Number (ISN), e.g., `x`
3. **IP Layer** wraps this into an IP packet (adds IP headers).
4. **Network Interface Driver (e.g., Ethernet driver)** wraps the IP packet in a frame (adds MAC addresses).
5. **Network Switch** receives the frame, uses MAC address to forward it.
6. **Destination Kernel** receives the frame, unwraps to IP, then TCP.
7. **Destination TCP** processes SYN, replies with:

   * SYN + ACK
   * Its own ISN `y`, ACK to client’s ISN: `x + 1`
8. **Client TCP** receives SYN+ACK, replies with:

   * ACK (acknowledging `y + 1`)
9. ✅ **Connection is now established.**

```
Client            Server
  | ---SYN(x)--->   |
  | <--SYN-ACK(y)-- |
  | ---ACK(y+1)---> |
```

---

## 📦 2. Data Transmission (Reliable, Ordered)

Once the handshake is complete:

### Sending Data

1. **App (e.g., browser)** sends data to the **kernel's TCP stack** using `send()` system call.
2. TCP breaks data into **segments** (typically <1460 bytes due to MTU).
3. TCP assigns:

   * Sequence numbers
   * ACK numbers (tracking what was received)
4. Each segment goes to IP layer, then data link layer (Ethernet, Wi-Fi), and sent over the network.

### On the Receiver Side

1. **NIC (network card)** receives the frame.
2. Data moves up: Ethernet → IP → TCP.
3. TCP:

   * Reorders segments if out of order
   * Sends **ACK** for each received segment
   * Buffers data until the application calls `recv()` or `read()`

### Key TCP Features

* Retransmission: If ACK not received in time, TCP will resend the segment.
* Congestion Control: Adjusts send rate based on perceived network congestion.
* Flow Control: Uses **window size** to prevent overwhelming the receiver.

---

## 🔁 3. Continuation: More Packets

### A typical back-and-forth looks like:

* Client sends request: `GET /index.html`
* Server responds: `HTTP/1.1 200 OK...`
* Each direction has:

  * ACKs
  * Sequence number tracking
* Packets may be:

  * Lost (TCP retransmits)
  * Out of order (TCP reorders)
  * Duplicated (TCP discards duplicates)

---

## 🔚 4. Connection Teardown (Graceful Shutdown)

TCP uses a **4-way handshake** to close:

```
Client            Server
  | ---FIN--->      |
  | <--ACK---       |
  | <--FIN---       |
  | ---ACK--->      |
```

1. **FIN**: Sender says, "I'm done sending."
2. Receiver ACKs the FIN.
3. Receiver sends its own FIN.
4. Sender ACKs, then connection is closed.

---

## 🔍 Underlying Protocols & Tools

| Protocol       | Layer       | Role                       |
| -------------- | ----------- | -------------------------- |
| TCP            | Transport   | Reliable, ordered delivery |
| IP             | Internet    | Routing                    |
| ARP            | Link        | Resolves IP to MAC         |
| DNS            | Application | Resolves hostname to IP    |
| Ethernet/Wi-Fi | Link        | Frame transmission         |

---

## 🛠️ Common Tools to Observe TCP

* `netstat -tn` or `ss -t` – show active TCP connections
* `tcpdump` – capture packets
* `wireshark` – visual packet analysis
* `traceroute` – route taken by packets
* `iptables` / `nftables` – firewall rules

---

## 🧠 Recap Flow from Source to Destination

1. **App** calls `connect()` / `send()`.
2. **TCP Stack** segments data, adds headers.
3. **IP Stack** wraps with destination IP.
4. **NIC Driver** wraps with MAC address.
5. **Network Switch** forwards frame.
6. **Remote NIC** receives, unwraps to IP → TCP.
7. **TCP stack** reorders, checks, ACKs.
8. **App on target** reads data using `recv()`.

---

## 📘 Want to go deeper?

* **RFC 793** – TCP Specification
* **RFC 2581** – TCP Congestion Control
* **Books**:

  * *TCP/IP Illustrated* by W. Richard Stevens
  * *Computer Networking: A Top-Down Approach* by Kurose & Ross


    <img width="465" height="466" alt="image" src="https://github.com/user-attachments/assets/61bb5fe8-97f6-4e31-a198-44153da679d8" />

