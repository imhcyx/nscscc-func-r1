#include <asm.h>
#include <regdef.h>

#define LOAD_USER_ADDR(reg, label) \
    la reg, label; \
    and reg, 0x1fffffff

LEAF(krnl_as_test)
    .set noreorder
    addiu s0, s0, 1
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
    mtc0  s7, c0_status
    nop
###test inst
    ## jump to user space first to avoid adel in kernel space
    li t0, 0x01ffe000
    mtc0 t0, c0_pagemask
    li t0, 0x1e000000
    mtc0 t0, c0_entryhi
    li t0, (0x1e000<<6)|0x7
    mtc0 t0, c0_entrylo0
    li t0, (0x1f000<<6)|0x7
    mtc0 t0, c0_entrylo1
    mtc0 zero, c0_index
    tlbwi
    LOAD_USER_ADDR(t0, 1f)
    jr t0
    nop
1:
    ## adel load
    li    t0, 0x800d0000
    li    s2, 0x4
    sw    s2, 0(t0)
    # switch to user mode
    li t0, 0x00400010
    mtc0 t0, c0_status
    lui   s7, 0x0004
    li t0, 0x80000000
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  lw t0, 0(t0)
    bne s2, s7, inst_error
    nop
    ## ades
    li    t0, 0x800d0000
    li    s2, 0x5
    sw    s2, 0(t0)
    # switch to user mode
    li t0, 0x00400010
    mtc0 t0, c0_status
    lui   s7, 0x0005
    li t0, 0x80000000
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  sw t0, 0(t0)
    bne s2, s7, inst_error
    nop
    ## adel fetch
    li    t0, 0x800d0000
    li    s2, 0x6
    sw    s2, 0(t0)
    # switch to user mode
    li t0, 0x00400010
    mtc0 t0, c0_status
    lui   s7, 0x0006
    li s4, 0xbfc00000
    li s2, -1
    LOAD_USER_ADDR(s5, 2f)
    jr s4
2:  nop
    bne s2, s7, inst_error
    nop
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    la t0, 1f
    jr t0
    nop
1:
    li t0, 0x0040ff02
    mtc0 t0, c0_status
    mtc0 zero, c0_cause
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(krnl_as_test)
