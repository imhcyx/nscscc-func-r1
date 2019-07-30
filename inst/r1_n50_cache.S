#include <asm.h>
#include <regdef.h>

LEAF(cache_test)
    .set noreorder
    addiu s0, s0, 1
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
    mtc0  s7, c0_status
    nop
###test inst
    li  t0, 0x800d0000
    li t1, -1
    sw t1, 0(t0)
    ##1
    la s5, inst_error
    mtc0 zero, c0_taglo
    li t0, 0x9fc00000
    cache 0x10, 0(t0)
    cache 0x10, 1(t0)
    ##2
    la s5, 1f
    li s7, -1
    li t0, 0x66666666
    cache 0x10, 0(t0)
    b inst_error
    nop
1:  li t0, 0xbfc00200
    bne t0, s7, inst_error
    nop
    ##3
    li t0, 0x01ffe000
    mtc0 t0, c0_pagemask
    li t0, 0x1e000000
    mtc0 t0, c0_entryhi
    mtc0 zero, c0_entrylo0
    mtc0 zero, c0_entrylo1
    mtc0 zero, c0_index
    tlbwi
    la s5, 1f
    li s7, -1
    li t0, 0x1fc00000
    cache 0x10, 0(t0)
    b inst_error
    nop
1:  li t0, 0xbfc00380
    bne t0, s7, inst_error
    nop
    ##4
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
    la s5, inst_error
    li t0, 0x1fc00000
    cache 0x10, 0(t0)
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    li t0, 0x0040ff02
    mtc0 t0, c0_status
    mtc0 zero, c0_cause
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(cache_test)
