# What is systemd?

`systemd` is a system and service manager for Linux operating systems. It initializes the system, manages services, and provides various features for service management, logging, and configuration. It aims to unify service behavior across different Linux distributions.

## Refer : https://opensource.com/article/20/4/systemd for more information

### Key Concepts

1. **Units**: The core building blocks of `systemd`. There are several types of units, including:
   - **Service Units (`*.service`)**: Define services that run in the background.
   - **Target Units (`*.target`)**: Group other units for synchronization (e.g., `multi-user.target`).
   - **Socket Units (`*.socket`)**: Define sockets for inter-process communication.
   - **Mount Units (`*.mount`)**: Manage filesystem mounts.
   - **Timer Units (`*.timer`)**: Schedule tasks to run at specific intervals.

2. **Configuration Files**: Unit files are typically located in `/etc/systemd/system/` (for user-defined units) or `/lib/systemd/system/` (for system-provided units).

3. **Dependencies**: Units can specify dependencies on other units, allowing for complex service interactions.

4. **States**: Units can be in various states, such as:
   - **active**: Running.
   - **inactive**: Not running.
   - **failed**: An error occurred.

### Common Commands

Here are some common `systemd` commands you can use:

1. **Start a Service**:
   ```bash
   sudo systemctl start <service_name>
   ```

2. **Stop a Service**:
   ```bash
   sudo systemctl stop <service_name>
   ```

3. **Restart a Service**:
   ```bash
   sudo systemctl restart <service_name>
   ```

4. **Check the Status of a Service**:
   ```bash
   systemctl status <service_name>
   ```

5. **Enable a Service at Boot**:
   ```bash
   sudo systemctl enable <service_name>
   ```

6. **Disable a Service from Starting at Boot**:
   ```bash
   sudo systemctl disable <service_name>
   ```

7. **List All Loaded Units**:
   ```bash
   systemctl list-units
   ```

8. **List All Failed Units**:
   ```bash
   systemctl list-units --failed
   ```

9. **View Journal Logs**:
   ```bash
   journalctl -u <service_name>
   ```

### Example: Creating and Managing a Custom Service

Let's create a simple custom service that runs a script. 

#### Step 1: Create a Script

1. Create a new script. For example, `/usr/local/bin/hello.sh`:
   ```bash
   sudo nano /usr/local/bin/hello.sh
   ```

2. Add the following content to the script:
   ```bash
   #!/bin/bash
   echo "Hello, World!" >> /var/log/hello.log
   ```

3. Make the script executable:
   ```bash
   sudo chmod +x /usr/local/bin/hello.sh
   ```

#### Step 2: Create a Systemd Service Unit

1. Create a service unit file at `/etc/systemd/system/hello.service`:
   ```bash
   sudo nano /etc/systemd/system/hello.service
   ```

2. Add the following content to the unit file:
   ```ini
   [Unit]
   Description=Hello World Service

   [Service]
   ExecStart=/usr/local/bin/hello.sh

   [Install]
   WantedBy=multi-user.target
   ```

#### Step 3: Manage the Service

1. **Reload the systemd configuration** to recognize the new service:
   ```bash
   sudo systemctl daemon-reload
   ```

2. **Start the service**:
   ```bash
   sudo systemctl start hello.service
   ```

3. **Check the status** of the service:
   ```bash
   systemctl status hello.service
   ```

4. **View the output** in the log file:
   ```bash
   cat /var/log/hello.log
   ```

5. **Enable the service** to start on boot:
   ```bash
   sudo systemctl enable hello.service
   ```

6. **Stop the service**:
   ```bash
   sudo systemctl stop hello.service
   ```

### Troubleshooting

- **Check logs** for any errors related to your service:
  ```bash
  journalctl -u hello.service
  ```

- **View all logs**:
  ```bash
  journalctl -xe
  ```

- **Slow Booting**:

  To understand more.
  
```bash
systemd-analyze blame
systemctl status plymouth-quit-wait.service
systemctl list-dependencies --reverse plymouth-quit-wait.service
```
- Please run the following command in the terminal:

  
```bash
systemd-analyze plot > ~/SystemdAnalyzePlot.svg
```
