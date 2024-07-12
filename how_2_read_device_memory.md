# How check Reserved memory space for various devices/cards on linux machine

## 

	dmidecode -t bios
	
	Read the memory from C:0000 to F:FFFF without the need for dmidecode

		dd if=/dev/mem bs=1k skip=768  count=256 2>/dev/null | strings -n 8



This worked for me in VirtualBox:

$ grep ROM /proc/iomem
which results in:
000c0000-000c7fff : Video ROM
000e2000-000e2fff : Adapter ROM
000f0000-000fffff : System ROM

System ROM starts at 000f0000, which is 0xF0000.

Open browser and go to http://www.hexadecimaldictionary.com/hexadecimal/0xF0000. This says the decimal value is 983040, which divided by 1024 to get kilobytes is 960 which is the starting point and the value for 'skip'.

The end number is 0xFFFFF which is 1048575 which is just shy of 1024. 1024 - 960 is 64, which is the value of 'count'.

The command to run to dump the bios is thus:

	dd if=/dev/mem of=pcbios.bin bs=1k skip=960 count=64


# Real time example

## Intel Server Wolf pass cpu

# cat /proc/iomem
00000000-00000fff : Reserved
00001000-00097fff : System RAM
00098000-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
.
.
.
90000000-9d7fffff : PCI Bus 0000:00
  91000000-920fffff : PCI Bus 0000:01
    91000000-920fffff : PCI Bus 0000:02
      91000000-91ffffff : 0000:02:00.0
      92000000-9201ffff : 0000:02:00.0
  92100000-9217ffff : 0000:00:17.0
    92100000-9217ffff : ahci
  92180000-921fffff : 0000:00:11.5
    92180000-921fffff : ahci
  92200000-92203fff : 0000:00:1f.2
  92204000-92205fff : 0000:00:17.0
    92204000-92205fff : ahci
  92206000-92207fff : 0000:00:11.5
    92206000-92207fff : ahci
  92208000-922080ff : 0000:00:17.0
    92208000-922080ff : ahci
  92209000-922090ff : 0000:00:11.5
    92209000-922090ff : ahci
  9220a000-9220afff : 0000:00:05.4
  9d600000-9d60ffff : 0000:00:14.0
    9d600000-9d60ffff : xhci-hcd
  9d610000-9d613fff : 0000:00:04.7
    9d610000-9d613fff : ioatdma
.
.
.
      aa900000-aa9fffff : qla2xxx
    aaa00000-aaafffff : 0000:18:00.0
      aaa00000-aaafffff : qla2xxx
    aab00000-aab01fff : 0000:18:00.1
      aab00000-aab01fff : qla2xxx
    aab02000-aab03fff : 0000:18:00.0
      aab02000-aab03fff : qla2xxx
    aab04000-aab04fff : 0000:18:00.1
      aab04000-aab04fff : qla2xxx
    aab05000-aab05fff : 0000:18:00.0
      aab05000-aab05fff : qla2xxx
  aac00000-aaefffff : PCI Bus 0000:19
    aac00000-aacfffff : 0000:19:00.1
      aac00000-aacfffff : qla2xxx
    aad00000-aadfffff : 0000:19:00.0
      aad00000-aadfffff : qla2xxx
    aae00000-aae01fff : 0000:19:00.1
      aae00000-aae01fff : qla2xxx
    aae02000-aae03fff : 0000:19:00.0
      aae02000-aae03fff : qla2xxx
    aae04000-aae04fff : 0000:19:00.1
      aae04000-aae04fff : qla2xxx
    aae05000-aae05fff : 0000:19:00.0
      aae05000-aae05fff : qla2xxx
.
.

ff800000-100bfffff : Reserved
100c00000-c03fffffff : System RAM
  ae00c00000-ae01801447 : Kernel code
  ae01801448-ae029babff : Kernel data
  ae03005000-ae03dfffff : Kernel bss
  bfff000000-c03effffff : Crash kernel


```bash
# cat memDifference
#!/bin/bash
action1=$1
action2=$2
action3=$3
part1=$(($action2-$action1))
part1=$(($part1+1))
part2=$(($action1))
part1kb=$(($part1/990))
part2kb=$(($part2/990))

printf '\ndumping memory with dd & /dev/mem with these values:\n\ntotal amount ~ hex: '$action1' / decimal: '$part1kb'kb/s\nstart location ~ hex: '$action2' / decimal: '$part2kb'kb/s''\n\n'
dd if=/dev/mem of=$action3 skip=$part2 bs=1 count=$part1 status=progress


```


---

** Change the permissions of the file "memDifference" 755**

```
	# chmod 755 memDifference
```

If you want view the hex / unicode / ascii or whatever just use:
```
	# xxd output | less
```
---

If you want to modify the hex, the best tool is:

```
	# hexcurse



	# ./memDifference 0xb8900000 0xb890ffff /tmp/megasas
```

Dumping memory with dd & /dev/mem with these values:

total amount ~ hex: 0xb8900000 / decimal: 66kb/s
start location ~ hex: 0xb890ffff / decimal: 3127722kb/s

65536+0 records in
65536+0 records out
65536 bytes (66 kB, 64 KiB) copied, 0.616504 s, 106 kB/s
