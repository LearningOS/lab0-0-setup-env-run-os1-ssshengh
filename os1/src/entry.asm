    # 放在该段，对应链接文件就可以看见放在了 text 段的第一个位置
    .section .text.entry
    # 0x80200000
    .globl _start
_start:
    la sp, boot_stack_top
    call rust_main

    # 段大小是 16 个 1K, 也即 10000(16x)
    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096 * 16
    .globl boot_stack_top
boot_stack_top: