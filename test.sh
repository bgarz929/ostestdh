ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
    LINKER="/system/bin/linker64"
else
    LINKER="/system/bin/linker"
fi
# Bikin memfd anonymous file descriptor
MEMFD=$(memfd_create "exec_bin_$RANDOM")
# Salin file binary lokal ke dalam memfd
cat "/data/user/0/com.carius.danta/cache/test" > /proc/self/fd/$MEMFD
# Kasih permission execute ke memfd
chmod 755 /proc/self/fd/$MEMFD
# Jalankan binary lewat linker biar bypass SELinux execmem restriction
exec $LINKER /proc/self/fd/$MEMFD
