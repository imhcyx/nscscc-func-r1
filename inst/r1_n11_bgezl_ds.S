#include <asm.h>
#include <regdef.h>
#include <cpu_cde.h>

#define TEST_BGEZL_DS(op, dest, ...) \
    li a0, 0x80000000; \
    bgezl a0, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bgezl zero, 2000f; \
    op  s7 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

#define TEST_BGEZL_DS_MD(...) \
    li a0, 0x80000000; \
    li v0, 0; \
    li v1, 0; \
    bgezl a0, 1000f; \
   ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    bgezl zero, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

LEAF(bgezl_ds_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x00
###test inst
    TEST_BGEZL_DS(lui,   t0,0x800d)
    TEST_BGEZL_DS(addiu, t1, t0, 0x8123)
    TEST_BGEZL_DS(sw,    t1, -0x7120(t0))
    TEST_BGEZL_DS(lw,    t2, -0x7120(t0))
    TEST_BGEZL_DS(addu,  t3, t1, t2)
    TEST_BGEZL_DS(or,    t4, s1, s2)
    TEST_BGEZL_DS(slt,   t5, s2, s3)
    TEST_BGEZL_DS(slti,  t6, s2, 0x8011)
    TEST_BGEZL_DS(sltiu, t7, s2, 0x8011)
    TEST_BGEZL_DS(sltu,  t8, s2, s3)
    TEST_BGEZL_DS(sll,   t1, s2, 0x11)
    TEST_BGEZL_DS(add,   t2, t0, s0)
    TEST_BGEZL_DS(addi,  t3, s0, 0x8002)
    TEST_BGEZL_DS(sub,   t4, t0, s0)
    TEST_BGEZL_DS(subu,  t5, t0, s0)
    TEST_BGEZL_DS(and,   t6, t0, s0)
    TEST_BGEZL_DS(andi,  t7, s0, 0x8ff2)
    TEST_BGEZL_DS(nor,   t8, t0, s0)
    TEST_BGEZL_DS(ori,   t1, s0, 0x8ff2)
    TEST_BGEZL_DS(xor,   t2, t0, s0)
    TEST_BGEZL_DS(xori,  t3, s0, 0x8ff2)
    TEST_BGEZL_DS(sllv,  t4, t0, s0)
    TEST_BGEZL_DS(sra,   t5, s0, 0x8)
    TEST_BGEZL_DS(srav,  t6, t0, s0)
    TEST_BGEZL_DS(srl,   t7, s0, 0x8)
    TEST_BGEZL_DS(srlv,  t8, t0, s0)
    lui t0, 0x8000
    li  t1, 0x00008000
    TEST_BGEZL_DS_MD(div    zero, t0, t1)
    TEST_BGEZL_DS_MD(divu   zero, t0, t1)
    TEST_BGEZL_DS_MD(mult   t0, t1)
    TEST_BGEZL_DS_MD(multu  t0, t1)
    TEST_BGEZL_DS(mfhi, t7)
    TEST_BGEZL_DS(mflo, t6)
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
END(bgezl_ds_test)
