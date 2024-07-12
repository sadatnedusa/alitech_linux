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
000c0000-000c7fff : Video ROM
  000c4000-000c7fff : PCI Bus 0000:00
000c8000-000c8dff : Adapter ROM
000cb800-000d17ff : Adapter ROM
000d1800-000d93ff : Adapter ROM
000dc000-000dc1ff : Adapter ROM
000e0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-5b752fff : System RAM
  4b000000-5affffff : Crash kernel
5b753000-5ba3dfff : ACPI Tables
5ba3e000-5e3a9fff : System RAM
5e3aa000-5e404fff : ACPI Tables
5e405000-5e46cfff : System RAM
5e46d000-5e49bfff : ACPI Tables
5e49c000-5e977fff : System RAM
5e978000-5eb9efff : Reserved
5eb9f000-62563fff : System RAM
62564000-62617fff : Reserved
62618000-62cdcfff : System RAM
62cdd000-62d65fff : Reserved
62d66000-6306bfff : System RAM
6306c000-6386dfff : Reserved
6386e000-63948fff : System RAM
63949000-64948fff : Reserved
64949000-66911fff : System RAM
66912000-66c11fff : Reserved
  66bb5018-66bb5067 : APEI ERST
  66bb5070-66bb5077 : APEI ERST
  66bb5078-66bb7017 : APEI ERST
66c12000-67641fff : ACPI Non-volatile Storage
67642000-67741fff : ACPI Tables
67742000-6f7fffff : System RAM
6f800000-8fffffff : Reserved
  80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
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
  9d614000-9d617fff : 0000:00:04.6
    9d614000-9d617fff : ioatdma
  9d618000-9d61bfff : 0000:00:04.5
    9d618000-9d61bfff : ioatdma
  9d61c000-9d61ffff : 0000:00:04.4
    9d61c000-9d61ffff : ioatdma
  9d620000-9d623fff : 0000:00:04.3
    9d620000-9d623fff : ioatdma
  9d624000-9d627fff : 0000:00:04.2
    9d624000-9d627fff : ioatdma
  9d628000-9d62bfff : 0000:00:04.1
    9d628000-9d62bfff : ioatdma
  9d62c000-9d62ffff : 0000:00:04.0
    9d62c000-9d62ffff : ioatdma
  9d630000-9d6300ff : 0000:00:1f.4
  9d631000-9d631fff : 0000:00:16.4
  9d632000-9d632fff : 0000:00:16.1
  9d633000-9d633fff : 0000:00:16.0
  9d634000-9d634fff : 0000:00:14.2
9d800000-aaffffff : PCI Bus 0000:17
  9d800000-9d800fff : 0000:17:05.4
  9d900000-9d9fffff : PCI Bus 0000:18
    9d900000-9d93ffff : 0000:18:00.0
    9d940000-9d97ffff : 0000:18:00.1
  9da00000-9dafffff : PCI Bus 0000:19
    9da00000-9da3ffff : 0000:19:00.0
    9da40000-9da7ffff : 0000:19:00.1
  aa900000-aabfffff : PCI Bus 0000:18
    aa900000-aa9fffff : 0000:18:00.1
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
ab000000-b87fffff : PCI Bus 0000:3a
  ab000000-b02fffff : PCI Bus 0000:3b
    ab000000-b02fffff : PCI Bus 0000:3c
      ab000000-b02fffff : PCI Bus 0000:3d
        ab000000-abffffff : 0000:3d:00.3
          ab000000-abffffff : i40e
        ac000000-acffffff : 0000:3d:00.2
          ac000000-acffffff : i40e
        ad000000-adffffff : 0000:3d:00.1
          ad000000-adffffff : i40e
        ae000000-aeffffff : 0000:3d:00.0
          ae000000-aeffffff : i40e
        af000000-af3fffff : 0000:3d:00.3
        af400000-af7fffff : 0000:3d:00.2
        af800000-afbfffff : 0000:3d:00.1
        afc00000-afffffff : 0000:3d:00.0
        b0000000-b0007fff : 0000:3d:00.3
          b0000000-b0007fff : i40e
        b0008000-b000ffff : 0000:3d:00.2
          b0008000-b000ffff : i40e
        b0010000-b0017fff : 0000:3d:00.1
          b0010000-b0017fff : i40e
        b0018000-b001ffff : 0000:3d:00.0
          b0018000-b001ffff : i40e
        b0020000-b009ffff : 0000:3d:00.3
        b00a0000-b011ffff : 0000:3d:00.2
        b0120000-b019ffff : 0000:3d:00.1
        b01a0000-b021ffff : 0000:3d:00.0
        b0280000-b02fffff : 0000:3d:00.0
  b0300000-b03fffff : PCI Bus 0000:3b
    b0300000-b031ffff : 0000:3b:00.0
  b0400000-b0400fff : 0000:3a:05.4
b8800000-c5ffffff : PCI Bus 0000:5d
  b8800000-b89fffff : PCI Bus 0000:5e
    b8800000-b88fffff : 0000:5e:00.0
    b8900000-b890ffff : 0000:5e:00.0
      b8900000-b890ffff : megasas: LSI
  b8a00000-b8a00fff : 0000:5d:05.4
  b8b00000-b8cfffff : PCI Bus 0000:5f
  b8d00000-b8efffff : PCI Bus 0000:5f
  b8f00000-b90fffff : PCI Bus 0000:60
  b9100000-b92fffff : PCI Bus 0000:60
c6000000-d37fffff : PCI Bus 0000:80
  c6000000-c6000fff : 0000:80:05.4
  d3600000-d3603fff : 0000:80:04.7
    d3600000-d3603fff : ioatdma
  d3604000-d3607fff : 0000:80:04.6
    d3604000-d3607fff : ioatdma
  d3608000-d360bfff : 0000:80:04.5
    d3608000-d360bfff : ioatdma
  d360c000-d360ffff : 0000:80:04.4
    d360c000-d360ffff : ioatdma
  d3610000-d3613fff : 0000:80:04.3
    d3610000-d3613fff : ioatdma
  d3614000-d3617fff : 0000:80:04.2
    d3614000-d3617fff : ioatdma
  d3618000-d361bfff : 0000:80:04.1
    d3618000-d361bfff : ioatdma
  d361c000-d361ffff : 0000:80:04.0
    d361c000-d361ffff : ioatdma
d3800000-e0ffffff : PCI Bus 0000:85
  d3800000-d3800fff : 0000:85:05.4
  d3900000-d39fffff : PCI Bus 0000:86
    d3900000-d397ffff : 0000:86:00.0
    d3980000-d39fffff : 0000:86:00.1
  d3a00000-d3afffff : PCI Bus 0000:87
    d3a00000-d3a3ffff : 0000:87:00.0
    d3a40000-d3a7ffff : 0000:87:00.1
  e0900000-e0bfffff : PCI Bus 0000:86
    e0900000-e09fffff : 0000:86:00.1
      e0900000-e09fffff : bnxt_en
    e0a00000-e0afffff : 0000:86:00.0
      e0a00000-e0afffff : bnxt_en
    e0b00000-e0b0ffff : 0000:86:00.1
      e0b00000-e0b0ffff : bnxt_en
    e0b10000-e0b1ffff : 0000:86:00.0
      e0b10000-e0b1ffff : bnxt_en
    e0b20000-e0b21fff : 0000:86:00.1
      e0b20000-e0b21fff : bnxt_en
    e0b22000-e0b23fff : 0000:86:00.0
      e0b22000-e0b23fff : bnxt_en
  e0c00000-e0efffff : PCI Bus 0000:87
    e0c00000-e0cfffff : 0000:87:00.1
      e0c00000-e0cfffff : qla2xxx
    e0d00000-e0dfffff : 0000:87:00.0
      e0d00000-e0dfffff : qla2xxx
    e0e00000-e0e01fff : 0000:87:00.1
      e0e00000-e0e01fff : qla2xxx
    e0e02000-e0e03fff : 0000:87:00.0
      e0e02000-e0e03fff : qla2xxx
    e0e04000-e0e04fff : 0000:87:00.1
      e0e04000-e0e04fff : qla2xxx
    e0e05000-e0e05fff : 0000:87:00.0
      e0e05000-e0e05fff : qla2xxx
e1000000-ee7fffff : PCI Bus 0000:ae
  e1000000-e10fffff : PCI Bus 0000:b0
    e1000000-e10fffff : 0000:b0:00.0
      e1000000-e10fffff : mpt3sas
  e1100000-e1100fff : 0000:ae:05.4
  e1200000-e12fffff : PCI Bus 0000:af
    e1200000-e127ffff : 0000:af:00.0
    e1280000-e12fffff : 0000:af:00.1
  ee200000-ee4fffff : PCI Bus 0000:af
    ee200000-ee2fffff : 0000:af:00.1
      ee200000-ee2fffff : bnxt_en
    ee300000-ee3fffff : 0000:af:00.0
      ee300000-ee3fffff : bnxt_en
    ee400000-ee40ffff : 0000:af:00.1
      ee400000-ee40ffff : bnxt_en
    ee410000-ee41ffff : 0000:af:00.0
      ee410000-ee41ffff : bnxt_en
    ee420000-ee421fff : 0000:af:00.1
      ee420000-ee421fff : bnxt_en
    ee422000-ee423fff : 0000:af:00.0
      ee422000-ee423fff : bnxt_en
  ee500000-ee6fffff : PCI Bus 0000:b0
    ee500000-ee5fffff : 0000:b0:00.0
      ee500000-ee5fffff : mpt3sas
    ee600000-ee6fffff : 0000:b0:00.0
      ee600000-ee6fffff : mpt3sas
ee800000-fbffffff : PCI Bus 0000:d7
  ee800000-ee8fffff : PCI Bus 0000:da
    ee800000-ee8fffff : 0000:da:00.0
      ee800000-ee8fffff : mpt3sas
  ee900000-ee900fff : 0000:d7:05.4
  eea00000-eebfffff : PCI Bus 0000:d8
  eec00000-eedfffff : PCI Bus 0000:d8
  eee00000-eeffffff : PCI Bus 0000:d9
  ef000000-ef1fffff : PCI Bus 0000:d9
  fbd00000-fbefffff : PCI Bus 0000:da
    fbd00000-fbdfffff : 0000:da:00.0
      fbd00000-fbdfffff : mpt3sas
    fbe00000-fbefffff : 0000:da:00.0
      fbe00000-fbefffff : mpt3sas
fd000000-fe7fffff : Reserved
  fd000000-fdabffff : pnp 00:04
  fdad0000-fdadffff : pnp 00:04
  fdb00000-fdffffff : pnp 00:04
    fdc6000c-fdc6000f : iTCO_wdt
  fe000000-fe00ffff : pnp 00:04
  fe010000-fe010fff : PCI Bus 0000:00
    fe010000-fe010fff : 0000:00:1f.5
  fe011000-fe01ffff : pnp 00:04
  fe036000-fe03bfff : pnp 00:04
  fe03d000-fe3fffff : pnp 00:04
  fe410000-fe7fffff : pnp 00:04
fec00000-fed00fff : Reserved
  fec00000-fecfffff : PNP0003:00
    fec00000-fec00fff : Reserved
      fec00000-fec003ff : IOAPIC 0
    fec01000-fec013ff : IOAPIC 1
    fec08000-fec083ff : IOAPIC 2
    fec10000-fec103ff : IOAPIC 3
    fec18000-fec183ff : IOAPIC 4
    fec20000-fec203ff : IOAPIC 5
    fec28000-fec283ff : IOAPIC 6
    fec30000-fec303ff : IOAPIC 7
    fec38000-fec383ff : IOAPIC 8
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed12000-fed1200f : pnp 00:01
fed12010-fed1201f : pnp 00:01
fed1b000-fed1bfff : pnp 00:01
fed1c000-fed3ffff : pnp 00:01
fed45000-fed8bfff : pnp 00:01
fee00000-feefffff : pnp 00:01
  fee00000-fee00fff : Local APIC
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




Change the permissions of the file "memDifference" 755
`code`
	# chmod 755 memDifference
`code`

If you want view the hex / unicode / ascii or whatever just use:
`code`
 # xxd output | less
`code`
If you want to modify the hex, the best tool is:

 # hexcurse





# ./memDifference 0xb8900000 0xb890ffff /tmp/megasas

dumping memory with dd & /dev/mem with these values:

total amount ~ hex: 0xb8900000 / decimal: 66kb/s
start location ~ hex: 0xb890ffff / decimal: 3127722kb/s

65536+0 records in
65536+0 records out
65536 bytes (66 kB, 64 KiB) copied, 0.616504 s, 106 kB/s
