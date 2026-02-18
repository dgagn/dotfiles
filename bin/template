#!/usr/bin/env python3

import subprocess
import os
import stat
import sys
import argparse
from pwnlib.context import context as ctx
from pwnlib.elf.elf import ELF
from pwn import log
from elftools.common.exceptions import ELFError

def parse_args():
    parser = argparse.ArgumentParser(
        description="Generate pwntools exploit template with real argument parsing.",
        add_help=False
    )
    parser.add_argument("binary", help="Path to the binary")
    parser.add_argument("-f", "--force", action="store_true", help="Overwrite existing file (default: False)")
    parser.add_argument("--host", "-h", default="localhost", help="Remote host (default: localhost)")
    parser.add_argument("--port", "-p", type=int, default=443, help="Remote port (default: 1337)")
    parser.add_argument("--ssl", action="store_true", help="Use SSL (default: False)")
    parser.add_argument("--stdout", action="store_true", help="Use stdout (default: False)")
    parser.add_argument("--name", "-n", default="ape.py", help="Output file (default: ape.py)")
    parser.add_argument("--patch", "-P", action="store_true", help="Patch the binary (default: False)")
    parser.add_argument("--make", "-m", action="store_true", help="Generate Makefile (default: False)")
    parser.add_argument("--libc", "-l", action="store_true", help="Creates a binding to libc")
    parser.add_argument("--help", action="help", help="Show this help message and exit")

    return parser.parse_args()


args = parse_args()

base_directory = os.path.dirname(args.binary)
binary = args.binary
file = args.name
stdout = args.stdout

if not os.path.exists(binary):
    print(f"Error: {binary} not found", file=sys.stderr)
    sys.exit(1)

try:
   ctx.binary = ELF(binary, checksec=False)
except ELFError:
    pass

checksec_binary = ctx.binary.checksec(color=False).splitlines()

arch = ctx.binary.arch + "-" + str(ctx.binary.bits) + "-" + ctx.binary.endian
comment = f"# Arch:       {arch}\n"
for line in checksec_binary:
    comment += f"# {line}\n"

comment = comment.strip()

binary_name = os.path.basename(binary)
template = f'''
#!/usr/bin/env python3
from pwn import *

{comment}

elf = context.binary = ELF('./{binary_name if not args.patch else binary_name + "_patched"}')
libc = elf.libc

context.log_level = 'info'
context.aslr = True

def start():
    host = args.HOST or '{args.host}'
    port = int(args.PORT or {args.port})
    if args.REMOTE:
        return remote(host, port{", ssl=True" if args.ssl else ""})
    io = elf.process()
    if args.GDB:
        gdb.attach(io, gdbscript)
    return io


gdbscript = \'\'\'
continue
\'\'\'


io = start()

io.interactive()
'''.strip()

libc_path = os.path.join(base_directory, "libc.so.6")

if args.libc and not os.path.exists(libc_path):
    os.symlink("/usr/lib/ctf/ubuntu24/libc.so.6", "libc.so.6")

if args.patch:
    cmd = ["unstrip", binary]
    if args.force:
        cmd.append("-f")
    result = subprocess.run(cmd)
    if result.returncode != 0:
        log.error(f"Error: unstrip failed")
        sys.exit(1)

template_path = os.path.join(base_directory, file)
print(template_path)
if stdout:
    print(template)
else:
    if os.path.exists(template_path) and not args.force:
        log.error(f"Error: {file} already exists")
        sys.exit(1)
    with open(template_path, "w") as f:
        f.write(template)
    st = os.stat(template_path)
    os.chmod(template_path, st.st_mode | stat.S_IEXEC)
    log.success(f"Template saved to {file}")
