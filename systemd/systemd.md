# systemd cheat sheet
---
## Here’s a helpful cheat sheet for working with **systemd** commands and comparing them to traditional **SysVinit** commands. 
### This guide covers various use cases like managing services, viewing system information, changing system states, and checking logs.

### **Viewing Systemd Information**
- **Show a unit’s dependencies**:  
  ```bash
  systemctl list-dependencies
  ```
- **List sockets and what activates**:  
  ```bash
  systemctl list-sockets
  ```
- **View active systemd jobs**:  
  ```bash
  systemctl list-jobs
  ```
- **See unit files and their states**:  
  ```bash
  systemctl list-unit-files
  ```
- **Show if units are loaded/active**:  
  ```bash
  systemctl list-units
  ```
- **List default target (similar to runlevel)**:  
  ```bash
  systemctl get-default
  ```

### **Working with Services**
- **Stop a running service**:  
  ```bash
  systemctl stop <service>
  ```
- **Start a service**:  
  ```bash
  systemctl start <service>
  ```
- **Restart a running service**:  
  ```bash
  systemctl restart <service>
  ```
- **Reload service configuration without restarting**:  
  ```bash
  systemctl reload <service>
  ```
- **Check if a service is running or enabled**:  
  ```bash
  systemctl status <service>
  ```
- **Enable a service to start on boot**:  
  ```bash
  systemctl enable <service>
  ```
- **Disable a service from starting on boot**:  
  ```bash
  systemctl disable <service>
  ```
- **Show properties of a service**:  
  ```bash
  systemctl show <service>
  ```
- **Run systemctl command remotely**:  
  ```bash
  systemctl -H <host> status <service>
  ```

### **Changing System States**
- **Reboot the system**:  
  ```bash
  systemctl reboot
  ```
- **Power off the system**:  
  ```bash
  systemctl poweroff
  ```
- **Put system into emergency mode**:  
  ```bash
  systemctl emergency
  ```
- **Return to default system state**:  
  ```bash
  systemctl default
  ```

### **Viewing Log Messages**
- **Show all collected log messages**:  
  ```bash
  journalctl
  ```
- **See logs for a specific service**:  
  ```bash
  journalctl -u <service>
  ```
- **Follow log messages as they appear**:  
  ```bash
  journalctl -f
  ```
- **Show only kernel messages**:  
  ```bash
  journalctl -k
  ```

### **SysVinit to Systemd Cheat Sheet**
| SysVinit Command                        | Systemd Equivalent                                 | Notes                                                                                     |
|-----------------------------------------|---------------------------------------------------|-------------------------------------------------------------------------------------------|
| `service <service> start`               | `systemctl start <service>`                       | Starts a service.                                                                         |
| `service <service> stop`                | `systemctl stop <service>`                        | Stops a service.                                                                          |
| `service <service> restart`             | `systemctl restart <service>`                     | Restarts a service.                                                                       |
| `service <service> reload`              | `systemctl reload <service>`                      | Reloads the configuration without interrupting operations.                                |
| `service <service> condrestart`         | `systemctl condrestart <service>`                 | Restarts the service only if it’s already running.                                         |
| `service <service> status`              | `systemctl status <service>`                      | Checks the status of a service.                                                           |
| `chkconfig <service> on`                | `systemctl enable <service>`                      | Enables the service to start at boot.                                                     |
| `chkconfig <service> off`               | `systemctl disable <service>`                     | Disables the service from starting at boot.                                               |
| `chkconfig <service>`                   | `systemctl is-enabled <service>`                  | Checks if a service is enabled.                                                           |
| `chkconfig --list`                      | `systemctl list-unit-files --type=service`        | Lists unit files and states.                                                              |
| `chkconfig --list | grep 5:on`          | `systemctl list-dependencies graphical.target`     | Lists services that start in graphical mode.                                               |
| `chkconfig <service> --list`            | `ls /etc/systemd/system/*.wants/<service>.service`| Lists where the service is configured on/off.                                              |
| `chkconfig <service> --add`             | `systemctl daemon-reload`                         | Reloads daemon configuration.                                                             |

### **Runlevels to Systemd Targets Cheat Sheet**
| Runlevel (SysVinit)                     | Systemd Target                                    | Description                                                                                |
|-----------------------------------------|---------------------------------------------------|--------------------------------------------------------------------------------------------|
| `0`                                     | `runlevel0.target`, `poweroff.target`             | Halt the system.                                                                           |
| `1`, `s`, `single`                      | `runlevel1.target`, `rescue.target`               | Single-user mode.                                                                          |
| `2`, `4`                                | `runlevel2.target`, `runlevel4.target`, `multi-user.target`| User-defined/Site-specific. By default, same as runlevel 3.                                  |
| `3`                                     | `runlevel3.target`, `multi-user.target`           | Multi-user, non-graphical mode.                                                            |
| `5`                                     | `runlevel5.target`, `graphical.target`            | Multi-user, graphical login.                                                               |
| `6`                                     | `runlevel6.target`, `reboot.target`               | Reboot the system.                                                                         |
| `emergency`                             | `emergency.target`                                | Emergency shell.                                                                           |

### **Changing Runlevels with Systemd**
- **Switch to multi-user runlevel (non-graphical)**:  
  ```bash
  systemctl isolate multi-user.target
  ```
  **(or)**  
  ```bash
  systemctl isolate runlevel3.target
  ```

- **Set multi-user runlevel as the default**:  
  ```bash
  ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target
  ```

This cheat sheet should make it easier to manage services, logs, and system states whether you're familiar with **SysVinit** or new to **systemd**!

---

# systemctl_list-units_--all

The `systemctl list-units --all` command in Linux is used to list all the units that are loaded by `systemd`, including active, inactive, and failed units. Units represent resources that systemd knows about, such as services, sockets, devices, and mounts. Here's what each part of the command does:

- **`systemctl`**: The main command to interact with the `systemd` system and service manager.
- **`list-units`**: This subcommand lists all currently loaded units in `systemd`.
- **`--all`**: This option includes not only active units but also inactive or failed ones in the output.

The output will typically include the following columns:
- **UNIT**: The name of the unit.
- **LOAD**: Whether the unit's configuration has been properly loaded.
- **ACTIVE**: The high-level unit activation state (e.g., active, inactive, failed).
- **SUB**: The low-level unit activation state.
- **DESCRIPTION**: A brief description of the unit.

You can also filter by specific types of units, like services, using:
```bash
systemctl list-units --type=service --all
```

If you'd like assistance with a specific unit or need help interpreting the output, feel free to ask!

---

# systemd-analyze_blame

- The systemd-analyze blame command in Linux is used to analyze the time taken by each service during the system boot process. 
- It lists the services and shows how much time each took to start up. 
- This can be useful for identifying any services that are taking longer than expected to start, potentially impacting system boot times.
- If you'd like more specific information or need assistance interpreting the output of systemd-analyze blame, feel free to ask!

---
# systemctl_list-units_--failed

The `systemctl list-units --failed` command lists all the units that have failed on your system. This is useful for identifying services or other systemd-managed resources that are not functioning correctly.

Here's what each part of the command does:

- **`systemctl`**: The main command to control the systemd system and service manager.
- **`list-units`**: Lists all loaded units (services, sockets, devices, etc.).
- **`--failed`**: Filters the output to show only units that have failed.

The output will show:
- **UNIT**: The name of the unit.
- **LOAD**: Whether the unit's configuration has been properly loaded.
- **ACTIVE**: This will usually be "failed."
- **SUB**: A more detailed state (e.g., "failed").
- **DESCRIPTION**: A brief description of the unit.

This command helps you quickly identify problematic units that may require attention or debugging.

---
# systemd-analyze dump

The `systemd-analyze dump` command is used to output detailed information about the systemd state and configuration. It provides a snapshot of the current state of the systemd manager, including various runtime parameters and information about all loaded units, their dependencies, and their configuration.

### Key Points about `systemd-analyze dump`:

- **Overview**: The command outputs a comprehensive dump that includes:
  - The state of the `systemd` manager.
  - Information about units, including their types, load states, and activation states.
  - Dependency trees of the units.
  - Active job lists, which show currently running operations.

- **Usage**: To use the command, simply run:
  ```bash
  systemd-analyze dump
  ```

- **Output**: The output can be quite verbose and includes sections for different types of information. It's often more detailed than typical commands like `list-units` or `blame`.

- **Use Cases**: This command is helpful for:
  - Troubleshooting issues with unit failures.
  - Understanding the overall state of the system and how different units interact.
  - Getting insights into performance bottlenecks during boot or unit activation.

### Example Command:
```bash
systemd-analyze dump
```


