## S **step-by-step guide to set up the ELK Stack (Elasticsearch, Logstash, Kibana)** along with **Filebeat** on a Linux system (e.g., Ubuntu 20.04+).
- This will help you ship and visualize system logs centrally.

---

## 🚀 ELK Stack + Filebeat Installation on Ubuntu (Quickstart)

### ✅ Prerequisites:

* A Linux VM or server (Ubuntu 20.04 or later)
* At least **4 GB RAM** recommended
* `sudo` access
* Internet connectivity

---

## 🧩 Step 1: Install Elasticsearch

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

sudo apt-get update && sudo apt-get install elasticsearch
```

### Enable and start the service:

```bash
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
```

Test:

```bash
curl -X GET "localhost:9200"
```

---

## 🧩 Step 2: Install Logstash

```bash
sudo apt-get install logstash
```

We'll configure it later in **Step 5**.

---

## 🧩 Step 3: Install Kibana

```bash
sudo apt-get install kibana
```

Enable and start:

```bash
sudo systemctl enable kibana
sudo systemctl start kibana
```

Access Kibana:

```bash
http://<your-server-ip>:5601
```

> ⚠️ If you're using a remote server, open port **5601** in your firewall or cloud security group.

---

## 🧩 Step 4: Install Filebeat (Log Shipper)

```bash
sudo apt-get install filebeat
```

Enable and start:

```bash
sudo systemctl enable filebeat
sudo systemctl start filebeat
```

---

## 🧩 Step 5: Configure Logstash Pipeline

Create a basic config file:

```bash
sudo nano /etc/logstash/conf.d/system-logs.conf
```

Paste this example:

```conf
input {
  beats {
    port => 5044
  }
}

filter {
  grok {
    match => { "message" => "%{SYSLOGTIMESTAMP:timestamp} %{SYSLOGHOST:hostname} %{DATA:program}(?:\[%{POSINT:pid}\])?: %{GREEDYDATA:log_message}" }
  }
}

output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "system-logs-%{+YYYY.MM.dd}"
  }
}
```

Start Logstash:

```bash
sudo systemctl start logstash
```

---

## 🧩 Step 6: Configure Filebeat to Talk to Logstash

Edit Filebeat config:

```bash
sudo nano /etc/filebeat/filebeat.yml
```

Find and modify these sections:

```yaml
output.logstash:
  hosts: ["localhost:5044"]

filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/syslog
```

Enable Filebeat modules (optional):

```bash
sudo filebeat modules enable system
```

Reload Filebeat:

```bash
sudo systemctl restart filebeat
```

---

## ✅ Step 7: Check Logs in Kibana

1. Open: `http://<your-server-ip>:5601`
2. Go to: **Discover**
3. Create index pattern: `system-logs-*`
4. View your parsed syslog entries 🎉

---

## 📌 Tips

* Use **Kibana Visualize** to build bar charts, pie charts, and dashboards.
* Use **Dev Tools > Console** to run Elasticsearch queries.
* Set up **alerts** using Kibana’s Observability features.

