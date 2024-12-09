## How to extract RPM contents?

```
   # mkdir rpm_extract; # cd rpm_extract
   # rpm2cpio ../foo.rpm | cpio -idmv
   # ls -lrta OR # find . 
```

### cpio arguments
```
   -i = extract
   -d = make directories
   -m = preserve modification time
   -v = verbose
```
