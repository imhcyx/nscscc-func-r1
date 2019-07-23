#include <asm.h>
#include <regdef.h>
#include <cpu_cde.h>

#define TEST_NUM 89


##s0, number
##s1, number adress 
##s2, exception use
##s3, score
##s4, exception pc
	.set	noreorder
	.globl	_start
	.globl	start
	.globl	__main
_start:
start:
    disable_trace_cmp_s
    li    t0, 0xffffffff
    addiu t0, zero, 0xffff
	b	locate
	nop

##avoid "j locate" not taken
    lui   t0, 0x8000
    addiu t1, t1, 1
    or    t2, t0, zero
    addu  t3, t5, t6
    lw    t4, 0(t0)
    nop

##avoid cpu run error
.org 0x0ec
    lui   t0, 0x8000
    addiu t1, t1, 1
    or    t2, t0, zero
    addu  t3, t5, t6
    lw    t4, 0(t0)
.org 0x100
test_finish:
    addiu t0, t0, 1
    li t1, 0xff
    LI (t2, UART_ADDR)
    sw t1, 0x0(t2)
    b test_finish
    nop
##avoid cpu run error
    lui   t0, 0x8000
    addiu t1, t1, 1
    or    t2, t0, zero
    addu  t3, t5, t6
    lw    t4, 0(t0)
/*
 *  exception handle
 */

.org 0x200
    j test_end
    nop

.org 0x380
    b common_exception_handler
    nop

common_exception_handler:
1:  
    mfhi k0
    mflo k1
    li  k0, 0x800d0000
    lw  k1, 0x0(k0)
    li  k0, 0x01 # syscall
    beq k1, k0, syscall_ex
    nop
    li  k0, 0x02 # break
    beq k1, k0, break_ex
    nop
    li  k0, 0x03 # overflow
    beq k1, k0, overflow_ex
    nop
    li  k0, 0x04 # adel(load)
    beq k1, k0, adel_load_ex
    nop
    li  k0, 0x05 # ades
    beq k1, k0, ades_ex
    nop
    li  k0, 0x06 # adel(inst fetch)
    beq k1, k0, adel_if_ex
    nop
    li  k0, 0x07 # reserved inst
    beq k1, k0, reserved_inst_ex
    nop
    li  k0, 0x08 # int
    beq k1, k0, int_ex
    nop
    j test_end
    nop

syscall_ex:
    addu  s2, zero, zero
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2
    li   k1, 0x20 # 010_0000
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02
    li   k1, 0x02
    bne  k0, k1, ex_finish
    nop
    lui  s2, 0x1
    b ex_finish
    nop

break_ex:
    addu  s2, zero, zero
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2
    li   k1, 0x24 # 010_0100
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li   k1, 0x02 # exl = 1
    bne  k0, k1, ex_finish
    nop
    lui  s2, 0x2
    b ex_finish
    nop

overflow_ex:
    addu s2, zero, zero 
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2 exc code
    li   k1, 0x30 # 011_0000
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li k1, 0x02 # exl = 1
    bne k0, k1, ex_finish
    nop
    lui s2, 0x3
    b ex_finish
    nop

adel_load_ex:
    addu s2, zero, zero 
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2 exc code
    li   k1, 0x10 # 001_0000
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li k1, 0x02 # exl = 1
    bne k0, k1, ex_finish
    nop
    lui s2, 0x4
    b ex_finish
    nop

ades_ex:
    addu s2, zero, zero 
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2 exc code
    li   k1, 0x14 # 001_0100
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li k1, 0x02 # exl = 1
    bne k0, k1, ex_finish
    nop
    lui s2, 0x5
    b ex_finish
    nop

adel_if_ex:
    addu s2, zero, zero 
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    mtc0 s5, c0_epc
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2 exc code
    li   k1, 0x10 # 001_0000
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li k1, 0x02 # exl = 1
    bne k0, k1, ex_finish
    nop
    lui s2, 0x6
    b ex_finish
    nop

reserved_inst_ex:
    addu s2, zero, zero 
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    mfc0 k0, c0_cause
    andi k0, k0, 0x7c # 6..2 exc code
    li   k1, 0x28 # 010_1000
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li k1, 0x02 # exl = 1
    bne k0, k1, ex_finish
    nop
    lui s2, 0x7
    b ex_finish
    nop

int_ex:
    addu s2, zero, zero 
    mfc0 k0, c0_epc
    bne  k0, s4, ex_finish
    nop
    addiu k0, k0, 8
    mtc0  k0, c0_epc   //epc+8
    mfc0 k0, c0_cause  //dont compare cause.bd
    andi k0, k0, 0x7c # 6..2 exc code
    li   k1, 0x00 # 000_0000
    bne  k0, k1, ex_finish
    nop
    mfc0 k0, c0_status
    andi k0, k0, 0x02 # exl
    li k1, 0x02 # exl = 1
    bne k0, k1, ex_finish
    nop
    li   k0, 0xffffffff
    li   k1, 0x00000000
    mtc0 k0, c0_compare //clear compare
    mtc0 k1, c0_cause
    lui s2, 0x8
    b ex_ret
    nop

ex_finish:
    mfc0 k0,c0_cause
    lui k1,0x8000
    and k0,k0,k1
    mfc0 k1,c0_epc
    addiu k1,k1,0x4
    beq k0,zero, 1f
    nop
    addiu k1,k1,0x4
1:  
    mtc0  k1,c0_epc
    nop
    bne s2, zero, ex_ret
    nop
    lui s2, 0xffff
ex_ret:
    //.set mips32
    eret
    //.set mips1
    nop

locate:
	.set noreorder

    LI (a0, LED_RG1_ADDR)
    LI (a1, LED_RG0_ADDR)
    LI (s1, NUM_ADDR)

    LI (t1, 0x0002)
    LI (t2, 0x0001)
    lui s3, 0

    sw t1, 0(a0)
    sw t2, 0(a1)
    sw s3, 0(s1)

    lui s0, 0          ## initial run number

inst_test:
    #1
    jal beql_test
    nop
    jal wait_1s
    nop
    #2
    jal bnel_test
    nop
    jal wait_1s
    nop
    #3
    jal beql_ds_test
    nop
    jal wait_1s
    nop
    #4
    jal bnel_ds_test
    nop
    jal wait_1s
    nop
    #5
    jal bgezl_test
    nop
    jal wait_1s
    nop
    #6
    jal bgtzl_test
    nop
    jal wait_1s
    nop
    #7
    jal blezl_test
    nop
    jal wait_1s
    nop
    #8
    jal bltzl_test
    nop
    jal wait_1s
    nop
    #9
    jal bltzall_test
    nop
    jal wait_1s
    nop
    #10
    jal bgezall_test
    nop
    jal wait_1s
    nop
    #11
    jal bgezl_ds_test
    nop
    jal wait_1s
    nop
    #12
    jal bgtzl_ds_test
    nop
    jal wait_1s
    nop
    #13
    jal blezl_ds_test
    nop
    jal wait_1s
    nop
    #14
    jal bltzl_ds_test
    nop
    jal wait_1s
    nop
    #15
    jal bltzall_ds_test
    nop
    jal wait_1s
    nop
    #16
    jal bgezall_ds_test
    nop
    jal wait_1s
    nop
    #17
    jal beql_ds_ex_test
    nop
    jal wait_1s
    nop
    #18
    jal bnel_ds_ex_test
    nop
    jal wait_1s
    nop
    #19
    jal bgezl_ds_ex_test
    nop
    jal wait_1s
    nop
    #20
    jal bgtzl_ds_ex_test
    nop
    jal wait_1s
    nop
    #21
    jal blezl_ds_ex_test
    nop
    jal wait_1s
    nop
    #22
    jal bltzl_ds_ex_test
    nop
    jal wait_1s
    nop
    #23
    jal bltzall_ds_ex_test
    nop
    jal wait_1s
    nop
    #24
    jal bgezall_ds_ex_test
    nop
    jal wait_1s
    nop
    
###check io access
    LI  (a0, IO_SIMU_ADDR)
    LI  (t0, 0x1234)
    sw   t0, 0(a0)
    lw   t1, 0(a0)   //t1=0x12340000
    sll  t0, t0, 16
    bne  t0, t1, io_err
    nop

    LI  (t0, 0x56780000)
    sw   t0, 0(a0)
    srl  t0, t0, 16
    lw   t1, 0(a0)   //t1=0x5678
    bne  t0, t1, io_err
    nop
    b    test_end
    nop
io_err:
    addiu s0, s0, 1
    sw    s0, 0(s1)

test_end:
    LI  (s0, TEST_NUM)
    beq s0, s3, 1f
    nop

    LI (a0, LED_ADDR)
    LI (a1, LED_RG1_ADDR)
    LI (a2, LED_RG0_ADDR)
	
    LI (t1, 0x0002)
    
    sw zero, 0(a0)
    sw t1, 0(a1)
    sw t1, 0(a2)
    b  2f
    nop
1:
    LI (t1, 0x0001)
    LI (a0, LED_RG1_ADDR)
    LI (a1, LED_RG0_ADDR)
    sw t1, 0(a0)
    sw t1, 0(a1)

2:
    jal test_finish
    nop

wait_1s:
    LI (t0,SW_INTER_ADDR)
    LI (t1, 0xaaaa)

    #initial t3
    lw    t2, 0x0(t0)   #switch_interleave: {switch[7],1'b0, switch[6],1'b0...switch[0],1'b0}
    xor   t2, t2, t1
    sll   t3, t2, 9     #t3 = switch interleave << 9
    addiu t3, t3, 1

sub1:  
    addiu t3, t3, -1

    #select min{t3, switch_interleave}
    lw    t2, 0x0(t0)   #switch_interleave: {switch[7],1'b0, switch[6],1'b0...switch[0],1'b0}
    xor   t2, t2, t1
    sll   t2, t2, 9     #switch interleave << 9
    sltu  t4, t3, t2
    bnez  t4, 1f 
    nop
    addu  t3, t2, 0
1:
    bne   t3,zero, sub1
    nop
    jr ra
    nop
