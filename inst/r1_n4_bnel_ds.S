#include <asm.h>
#include <regdef.h>
#include <cpu_cde.h>

#define TEST_BNEL_DS(op, dest, ...) \
    addiu s5, zero, 0x1; \
    bnel s5, s5, 1000f; \
    op  dest, ##__VA_ARGS__; \
    op  s6, ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bnel s5, zero, 2000f; \
    op  s7, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

LEAF(bnel_ds_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x00
###test inst
    TEST_BNEL_DS(lui,   a0,0x800d)
    TEST_BNEL_DS(addiu, a1, a0, 0x8123)
    TEST_BNEL_DS(sw,    a1, 0x0120(a0) )
    TEST_BNEL_DS(lw,    a2, 0x0120(a0) )
    TEST_BNEL_DS(addu,  a3, a1, a2)
    TEST_BNEL_DS(or,    t1, s1, s2)
    TEST_BNEL_DS(slt,   t2, s2, s3)
    TEST_BNEL_DS(slti,  t3, s2, 0x8011)
    TEST_BNEL_DS(sltiu, t7, s2, 0x8011)
    TEST_BNEL_DS(sltu,  t8, s2, s3)
    TEST_BNEL_DS(sll,   t1, s2, 0x11)
    TEST_BNEL_DS(add,   t2, t0, s0)
    TEST_BNEL_DS(addi,  t3, s0, 0x8002)
    TEST_BNEL_DS(sub,   t4, t0, s0)
    TEST_BNEL_DS(subu,  t5, t0, s0)
    TEST_BNEL_DS(and,   t6, t0, s0)
    TEST_BNEL_DS(andi,  t7, s0, 0x8ff2)
    TEST_BNEL_DS(nor,   t8, t0, s0)
    TEST_BNEL_DS(ori,   t1, s0, 0x8ff2)
    TEST_BNEL_DS(xor,   t2, t0, s0)
    TEST_BNEL_DS(xori,  t3, s0, 0x8ff2)
    TEST_BNEL_DS(sllv,  t4, t0, s0)
    TEST_BNEL_DS(sra,   t5, s0, 0x8)
    TEST_BNEL_DS(srav,  t6, t0, s0)
    TEST_BNEL_DS(srl,   t7, s0, 0x8)
    TEST_BNEL_DS(srlv,  t8, t0, s0)
###detect exception
    bne s2, zero, inst_error
    nop
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(bnel_ds_test)
