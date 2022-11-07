OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80200000;

SECTIONS
{
    . = BASE_ADDRESS;
    /*80200000*/
    skernel = .;

    /*80200000*/
    stext = .;
    .text : {
        *(.text.entry)
        *(.text .text.*)
    }

    . = ALIGN(4K);
    /*填充到 4K 对齐, 也即 4*1024 = 1K(16x) 因此增加了 6K(16x) 到 80206000 */
    etext = .;
    /*read only 只读全局数据段 80206000*/
    srodata = .;
    .rodata : {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);
    /*可更改全局数据段, 80208000*/
    erodata = .;
    sdata = .;
    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);
    /*未初始化全局数据段, 栈在这里, 手动初始化 80209000*/
    edata = .;
    .bss : {
        *(.bss.stack) /*栈大小 10000(16x) */
        /*实际上的 bss 全局数据段开始 80219000*/
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }

    . = ALIGN(4K);
    /*8021a000*/
    ebss = .;
    ekernel = .;

    /DISCARD/ : {
        *(.eh_frame)
    }
}