## 🟢 **`systemctl` – The Heart of `systemd` Service Management**  

`systemctl` is the main command to **manage services**, **system state**, and **targets** in **`systemd`**-based Linux distributions (e.g., Ubuntu, Fedora, Arch, RHEL).

Let’s break it down and explore its **core functionalities**:

## 📌 **1. Service Management with `systemctl`**

A **service** in `systemd` is a background process (e.g., SSH, Apache).

### ✅ **Check Service Status**
```bash
systemctl status <service>
```
Example:
```bash
systemctl status sshd
```
Outputs service **status**, **PID**, logs, and whether it’s enabled at boot.


### ✅ **Start, Stop, Restart Services**
| Action        | Command                        |
|---------------|--------------------------------|
| **Start**     | `systemctl start <service>`    |
| **Stop**      | `systemctl stop <service>`     |
| **Restart**   | `systemctl restart <service>`  |
| **Reload**    | `systemctl reload <service>`   |

Example:
```bash
systemctl restart nginx
```
👉 **Reload** reloads configurations without stopping the service.

### ✅ **Enable and Disable Services (Startup Control)**

| Action         | Command                         |
|----------------|---------------------------------|
| **Enable**     | `systemctl enable <service>`    |
| **Disable**    | `systemctl disable <service>`   |
| **Check**      | `systemctl is-enabled <service>`|

Example:
```bash
systemctl enable docker
systemctl is-enabled docker
```
> **Enable** adds a symlink in `/etc/systemd/system/multi-user.target.wants/`.

### ✅ **Mask and Unmask Services**

- **Masking** prevents the service from starting (even manually).  
- **Unmasking** removes this restriction.

| Action         | Command                          |
|----------------|----------------------------------|
| **Mask**       | `systemctl mask <service>`       |
| **Unmask**     | `systemctl unmask <service>`     |

Example:
```bash
systemctl mask bluetooth
systemctl unmask bluetooth
```

## 📌 **2. Understanding `systemd` Units**

A **unit** is a configuration file describing system resources. Common types:

| Unit Type     | Description                          | File Extension |
|---------------|--------------------------------------|----------------|
| **Service**   | Background processes (daemons)       | `.service`     |
| **Target**    | System states (like runlevels)       | `.target`      |
| **Mount**     | Filesystem mount points              | `.mount`       |
| **Socket**    | IPC or network sockets               | `.socket`      |
| **Timer**     | Scheduled jobs (cron replacement)    | `.timer`       |
| **Path**      | Directory or file monitoring         | `.path`        |

👉 **Unit Files** are located in:
- `/etc/systemd/system/` – Custom overrides  
- `/usr/lib/systemd/system/` – Default system units  

### ✅ **View All Units**
```bash
systemctl list-units --type=service
```

### ✅ **Show a Specific Unit File**
```bash
systemctl cat sshd.service
```

### ✅ **Edit Unit Files (Overrides)**
```bash
systemctl edit nginx.service
```
This opens a drop-in override under `/etc/systemd/system/nginx.service.d/`.

## 📌 **3. System State and Targets**

**Targets** in `systemd` are equivalent to **runlevels** in **SysVinit**.

| Target             | Purpose                           | Equivalent Runlevel |
|--------------------|-----------------------------------|---------------------|
| `default.target`   | Default boot target                | -                  |
| `multi-user.target`| Non-GUI multi-user system          | 3                  |
| `graphical.target` | GUI system                         | 5                  |
| `rescue.target`    | Single-user mode (repair)          | 1                  |
| `emergency.target` | Minimal emergency shell (no init)  | -                  |

### ✅ **Check Current Target**
```bash
systemctl get-default
```

### ✅ **Switch to a Different Target**
```bash
systemctl isolate multi-user.target
```

### ✅ **Change the Default Boot Target**
```bash
systemctl set-default graphical.target
```

## 📌 **4. Analyzing Boot and Logs**

### ✅ **Analyze Boot Time**
```bash
systemd-analyze
```
Outputs:
```
Startup finished in 2.3s (kernel) + 4.1s (userspace) = 6.4s
```

✅ **List Critical Boot Processes**
```bash
systemd-analyze blame
```

✅ **Display Boot Dependency Graph**
```bash
systemd-analyze plot > boot.svg
```

### ✅ **View Logs (journalctl)**

`systemd` uses **journald** for logging.

| Action               | Command                         |
|----------------------|---------------------------------|
| **View Logs**        | `journalctl`                    |
| **Follow Logs**      | `journalctl -f`                 |
| **Filter by Service**| `journalctl -u sshd`            |
| **Since Boot**       | `journalctl -b`                 |
| **Specific Time**    | `journalctl --since "1 hour ago"`|

Example:
```bash
journalctl -u nginx -b
```

## 📌 **5. Advanced `systemctl` Operations**

### ✅ **Restart the System**
```bash
systemctl reboot
```

✅ **Power Off the System**
```bash
systemctl poweroff
```

✅ **Rescue Mode (Single User)**
```bash
systemctl rescue
```

✅ **Emergency Shell**
```bash
systemctl emergency
```

✅ **Reload `systemd` Itself**
```bash
systemctl daemon-reexec
```
This is useful after **package updates**.


## 📌 **6. Troubleshooting with `systemctl`**

### ✅ **Check for Failed Services**
```bash
systemctl --failed
```

✅ **Debug a Service**
```bash
systemctl status network.service
journalctl -u network
```

✅ **Manual Service Restart**
If `systemctl` fails:
```bash
/usr/bin/nginx
```

✅ **Force Service Reload**
```bash
systemctl reload-or-restart sshd
```

## 📌 **7. Summary Cheatsheet**

| Action                | Command                              |
|-----------------------|--------------------------------------|
| **Start Service**     | `systemctl start <service>`          |
| **Stop Service**      | `systemctl stop <service>`           |
| **Restart Service**   | `systemctl restart <service>`        |
| **Enable Service**    | `systemctl enable <service>`         |
| **Disable Service**   | `systemctl disable <service>`        |
| **Check Status**      | `systemctl status <service>`         |
| **View Logs**         | `journalctl -u <service>`            |
| **Analyze Boot Time** | `systemd-analyze blame`              |
| **List Units**        | `systemctl list-units --type=service`|
| **Change Target**     | `systemctl isolate multi-user.target`|
| **Get Default Target**| `systemctl get-default`              |
| **Emergency Shell**   | `systemctl emergency`                |

---



### 🟢 **1. Creating Custom `systemd` Unit Files**

A **unit file** in `systemd` defines how a service, socket, or timer behaves. Let’s walk through **building a service** from scratch.

---

### ✅ **Basic Structure of a Service Unit**
Unit files live in:

- **User-specific**: `~/.config/systemd/user/`
- **System-wide**: `/etc/systemd/system/`

Here’s a sample **custom service** to run a Python script:

```bash
sudo nano /etc/systemd/system/myapp.service
```

**`myapp.service`**:
```ini
[Unit]
Description=My Python App
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/myapp/app.py
Restart=always
User=youruser
WorkingDirectory=/opt/myapp

[Install]
WantedBy=multi-user.target
```

---

### ✅ **Enable and Start Your Custom Service**
```bash
# Reload systemd to recognize the new unit
sudo systemctl daemon-reload

# Enable the service (start on boot)
sudo systemctl enable myapp.service

# Start it immediately
sudo systemctl start myapp.service

# Check status and logs
systemctl status myapp
journalctl -u myapp
```

### ✅ **Key Directives in Service Files**
| Directive        | Purpose                              |
|------------------|-------------------------------------|
| **Description**  | Service description for logs.        |
| **After**        | Order of execution (e.g., after networking). |
| **ExecStart**    | Main command to run the service.     |
| **Restart**      | Auto-restart policy (`always`, `on-failure`). |
| **User**         | Runs as a specific user.             |
| **WorkingDirectory** | Directory where the service runs.  |
| **WantedBy**     | Defines the target (like runlevels). |

👉 **More restart options**:
- `Restart=always` – Restart no matter what.
- `Restart=on-failure` – Restart on non-zero exit.
- `Restart=on-abort` – Restart on uncaught signals.


## 🔵 **2. Scheduling Tasks with `systemd` Timers**

Timers in `systemd` **replace cron jobs**. They allow scheduled and event-driven execution.

### ✅ **Create a Timer and Service**
Example: Run a **backup** every day at 2 AM.

1️⃣ **Create the service**:
```bash
sudo nano /etc/systemd/system/backup.service
```

```ini
[Unit]
Description=Daily Backup Service

[Service]
ExecStart=/usr/local/bin/backup.sh
```

2️⃣ **Create the timer**:
```bash
sudo nano /etc/systemd/system/backup.timer
```

```ini
[Unit]
Description=Runs Backup Daily

[Timer]
OnCalendar=*-*-* 02:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

### ✅ **Enable and Manage the Timer**
```bash
# Reload to pick up new units
sudo systemctl daemon-reload

# Start the timer
sudo systemctl enable --now backup.timer

# Check if timer is active
systemctl list-timers
```

👉 **Common Timer Expressions**:
| Expression         | Meaning                     |
|--------------------|-----------------------------|
| `OnCalendar=daily` | Every day at midnight       |
| `OnCalendar=hourly`| Every hour                  |
| `*-*-* 14:00:00`   | Every day at 2 PM           |
| `Mon *-*-* 08:00`  | Every Monday at 8 AM        |
| `OnBootSec=5min`   | 5 minutes after boot        |


## 🟠 **3. Troubleshooting `systemd` Services**

When things go wrong, here’s how to diagnose and fix issues.

### ✅ **1. Check Service Logs**
```bash
# Check service status
systemctl status myapp

# View logs (real-time)
journalctl -u myapp -f
```

### ✅ **2. Diagnose Failed Services**
```bash
# List all failed units
systemctl --failed

# Debug specific service
systemctl status myapp
journalctl -u myapp
```


### ✅ **3. Verify Unit Configuration**
```bash
# Syntax check
systemd-analyze verify /etc/systemd/system/myapp.service
```

### ✅ **4. Inspect Service Execution**
```bash
# Check what command systemd is running
systemctl show myapp.service --property=ExecStart
```

### ✅ **5. Handle Hanging or Stuck Services**
1. **Force Stop a Service**:
```bash
sudo systemctl stop myapp
sudo systemctl kill myapp
```

2. **Reset a Failed Service**:
```bash
sudo systemctl reset-failed myapp
```

### ✅ **6. Debug with `systemd-analyze`**
Analyze service startup delays:
```bash
systemd-analyze blame
```

Examine dependencies:
```bash
systemctl list-dependencies myapp.service
```

## 🔴 **4. Recovering from Broken Boots**

When a system refuses to boot correctly, use these steps:

### ✅ **1. Boot into Rescue Mode**
Rescue mode provides minimal services with the root filesystem.

```bash
systemctl rescue
```

If the system won’t boot:
1. Access **GRUB menu** during startup.
2. Edit the kernel line and append:
   ```
   systemd.unit=rescue.target
   ```

### ✅ **2. Boot into Emergency Mode**
For deeper repair (no services, no networking):

1. Interrupt **GRUB** and add:
   ```
   systemd.unit=emergency.target
   ```

2. After booting:
```bash
mount -o remount,rw /
journalctl -xb
```

### ✅ **3. Repair Failed Units**
```bash
systemctl status <failed-service>
journalctl -u <failed-service>
```

Force re-execute `systemd`:
```bash
systemctl daemon-reexec
```

## 🟢 **5. Advanced `systemctl` Tricks**


### ✅ **1. Debug Service Environment**
Inspect environment variables:
```bash
systemctl show myapp.service --property=Environment
```

### ✅ **2. Isolate Specific Targets**
Change to **multi-user mode**:
```bash
systemctl isolate multi-user.target
```

### ✅ **3. Temporary Override of a Unit**
If you need a quick, temporary change:
```bash
systemctl edit --runtime nginx.service
```

### ✅ **4. Manage User-Specific Units**
Enable user services:
```bash
systemctl --user enable myapp
systemctl --user start myapp
```

User units live under:
```bash
~/.config/systemd/user/
```

### 📊 **Quick Cheatsheet**

| Action                 | Command                              |
|------------------------|--------------------------------------|
| **Create Service**      | `nano /etc/systemd/system/app.service` |
| **Start Service**       | `systemctl start app.service`         |
| **Enable at Boot**      | `systemctl enable app.service`        |
| **Check Logs**          | `journalctl -u app.service`          |
| **List Timers**         | `systemctl list-timers`              |
| **Emergency Shell**     | `systemctl emergency`                |
| **Analyze Boot Time**   | `systemd-analyze blame`              |
| **Verify Unit**         | `systemd-analyze verify app.service` |

Would you like to explore **systemctl internals**, **kernel debugging**, or **specific issues** further? 🚀
