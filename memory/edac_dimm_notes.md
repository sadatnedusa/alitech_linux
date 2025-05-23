## Subject: EDAC Module Usage Policy

-  Intel does not recommend using the EDAC (Error Detection and Correction) module for identifying problematic DIMMs. As a result, we have blacklisted the EDAC module and do not rely on it for memory diagnostics or error reporting.
---

### Overview

This document outlines our official stance and policy regarding the use of the EDAC (Error Detection and Correction) module in systems utilizing Intel processors.
Based on recommendations from Intel and our operational requirements, we are blacklisting the EDAC module across our infrastructure.

### Background

EDAC is a Linux kernel subsystem that provides error detection and correction handling for memory modules, primarily intended to log and report memory errors (e.g., correctable/un-correctable ECC errors).

However, Intel does not recommend using the EDAC module for identifying faulty or problematic DIMMs. 
The data it provides can be incomplete, inconsistent across platforms, or lead to misinterpretation in the absence of vendor-specific error translation layers.

### Key Issues with EDAC

* **Lack of Vendor Endorsement:** Intel does not officially support EDAC as a reliable diagnostic tool for DIMMs on their platforms.
* **Inconsistent Reporting:** The way EDAC interprets and reports errors can vary depending on kernel version, platform configuration, and chipset support.
* **Limited Diagnostic Value:** EDAC may not always map physical memory errors to the correct DIMM slot or provide actionable data for root cause analysis.

### Policy

Effective immediately:

* The **EDAC kernel module will be blacklisted** on all Intel-based systems to prevent automatic loading at boot time.
* Administrators and support teams should **use vendor-recommended tools**, such as Intel® Memory and Storage Tool (IMST), firmware event logs (SEL), or platform-specific BMC tools for diagnosing memory errors.
* EDAC logs will **not be used as a primary source of truth** for DIMM error diagnosis or incident reports.

### Implementation

1. **Blacklisting EDAC:**
   Add the following line to `/etc/modprobe.d/blacklist.conf`:

   ```
   blacklist edac_core
   blacklist edac_mce_amd
   blacklist i7core_edac
   blacklist sb_edac
   ```

2. **System Configuration Update:**
   Ensure the changes take effect on the next reboot or reload the kernel module blacklist.

3. **Monitoring Tools:**
   Transition to using OEM-provided or officially supported monitoring tools for memory health reporting.

