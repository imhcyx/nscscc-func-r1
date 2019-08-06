#include <asm.h>
#include <regdef.h>
#include <cpu_cde.h>

#define TEST_BEQL_DS(op, dest, ...) \
    addiu s5, zero, 0x1; \
    op  dest , ##__VA_ARGS__; \
    beql s5, zero, 1000f; \
    addiu dest, zero, 0x1; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    beql s5, s5, 2000f; \
    op  s7 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

LEAF(beql_ds_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x00
###test inst
    TEST_BEQL_DS(lui,   t0,0x800d)
    TEST_BEQL_DS(addiu, t1, t0, 0x8123)
    TEST_BEQL_DS(sw,    t1, -0x7120(t0))
    TEST_BEQL_DS(lw,    t2, -0x7120(t0))
    TEST_BEQL_DS(addu,  t3, t1, t2)
    TEST_BEQL_DS(or,    t4, s1, s2)
    TEST_BEQL_DS(slt,   t5, s2, s3)
    TEST_BEQL_DS(slti,  t6, s2, 0x8011)
    TEST_BEQL_DS(sltiu, t7, s2, 0x8011)
    TEST_BEQL_DS(sltu,  t8, s2, s3)
    TEST_BEQL_DS(sll,   t1, s2, 0x11)
    TEST_BEQL_DS(add,   t2, t0, s0)
    TEST_BEQL_DS(addi,  t3, s0, 0x8002)
    TEST_BEQL_DS(sub,   t4, t0, s0)
    TEST_BEQL_DS(subu,  t5, t0, s0)
    TEST_BEQL_DS(and,   t6, t0, s0)
    TEST_BEQL_DS(andi,  t7, s0, 0x8ff2)
    TEST_BEQL_DS(nor,   t8, t0, s0)
    TEST_BEQL_DS(ori,   t1, s0, 0x8ff2)
    TEST_BEQL_DS(xor,   t2, t0, s0)
    TEST_BEQL_DS(xori,  t3, s0, 0x8ff2)
    TEST_BEQL_DS(sllv,  t4, t0, s0)
    TEST_BEQL_DS(sra,   t5, s0, 0x8)
    TEST_BEQL_DS(srav,  t6, t0, s0)
    TEST_BEQL_DS(srl,   t7, s0, 0x8)
    TEST_BEQL_DS(srlv,  t8, t0, s0)
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
END(beql_ds_test)
