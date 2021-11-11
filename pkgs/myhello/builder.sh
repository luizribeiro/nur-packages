source $stdenv/setup

mkdir -p $out/bin

cat >$out/bin/hello <<EOF
#!$SHELL
echo HELLO
EOF

chmod +x $out/bin/hello
