.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
message: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, a                                # pass the first argument to a0
    la a1, b                                # pass the second argument to a1
    addi a2, x0, 5                          # size
    addi t0, x0, 1                          # 1

    jal dot_product_recursive

    mv t3, a0
    
    addi a0, x0, 4                          # print message
    la a1, message
    ecall
    
    li a0, 1                                # print result
    mv a1, t3
    ecall
    
    addi a0, x0, 4                          # print newline
    la a1, newline
    ecall

    #exit cleanly
    addi a0, x0, 10
    ecall

dot_product_recursive:
    # base case
    beq a2, t0, exit_base_case              # compare size with 1, if the two are equal, exit the function

    # recursive case
    addi sp, sp, -12
    sw a0, 8(sp)
    sw a1, 4(sp)
    sw ra, 0(sp)

    # dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4                          # a+1
    addi a1, a1, 4                          # b+1
    addi a2, a2, -1                         # size-1
    
    jal dot_product_recursive

    lw t1, 8(sp)
    lw t2, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12

    lw t1, 0(t1)
    lw t2, 0(t2)
    
    mul t1, t1, t2
    add a0, a0, t1
   
    jr ra
    
exit_base_case:
    lw t1, 0(a0)                            # a2 = a[0]
    lw t2, 0(a1)                            # a3 = b[0]
    mul a0, t1, t2                          # a0 = a[0]*b[0]
    jr ra
