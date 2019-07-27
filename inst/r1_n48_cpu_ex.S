#include <asm.h>
#include <regdef.h>

#define LOAD_USER_ADDR(reg, label) \
    la reg, label; \
    and reg, 0x1fffffff

LEAF(cpu_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0xa
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
    mtc0  s7, c0_status
    nop
    lui   s7, 0x000a      #cpu ex, ref return value.
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
    ## test status.cu0
    LOAD_USER_ADDR(t0, 1f)
    mtc0 t0, c0_epc
    li t0, 0x10400010
    mtc0 t0, c0_status
    eret
    b inst_error
1:  nop
    ## test status.um
    LOAD_USER_ADDR(t0, 1f)
    mtc0 t0, c0_epc
    li t0, 0x00400000
    mtc0 t0, c0_status
    eret
    b inst_error
1:  nop
    ## test status.exl
    LOAD_USER_ADDR(t0, 1f)
    mtc0 t0, c0_epc
    li t0, 0x00400012
    mtc0 t0, c0_status
    eret
    b inst_error
1:  nop
    ## Note: now exl is cleared
    LOAD_USER_ADDR(s4, 1f)
1:  eret # this should raise an exception and the handler will set um to 0
    lui s7, 0xa
    ##1
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  tlbr # cpu ex
    bne s2, s7, inst_error
    nop
    ##2
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  tlbwi # cpu ex
    bne s2, s7, inst_error
    nop
    ##3
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  tlbwr # cpu ex
    bne s2, s7, inst_error
    nop
    ##4
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  tlbp # cpu ex
    bne s2, s7, inst_error
    nop
    ##5
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  eret # cpu ex
    bne s2, s7, inst_error
    nop
    ##6
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  mfc0 t0, c0_status # cpu ex
    bne s2, s7, inst_error
    nop
    ##7
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  mtc0 t0, c0_status # cpu ex
    bne s2, s7, inst_error
    nop
    ##8
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  wait # cpu ex
    bne s2, s7, inst_error
    nop
    ##9
    li t0, 0x00400010 # user mode
    mtc0 t0, c0_status
    li s2, -1
    LOAD_USER_ADDR(s4, 1f)
1:  cache 0, 0(zero) # cpu ex
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
END(cpu_ex_test)
