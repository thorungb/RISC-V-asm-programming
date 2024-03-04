.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
massage: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, a                         # pass the first argument to a0
    la a1, b                         # pass the second argument to a1
    addi t0, x0, 5                   # size

    jal dot_product_recursive

    # print meassage
    addi a0, x0, 4
    la a1, massage
    ecall

    # print result
    mv a1, a0                   # by convention the return value is always in a0
    addi a0, x0, 1
    ecall

    # print newline
    addi a0, x0, 4
    la a1, newline               # print newline
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall


dot_product_recursive:
    # base case
    addi t1, x0, 1
    beq t0, t1, exit_base_case      # compare size with 1, if the two are equal, exit the function

    # recursive case
    addi sp, sp, -4                 # if size != 1 do this
    sw ra, 0(sp)                    # storing the ra value on to the stack

    # dot_product_recursive(a+1, b+1, size-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a0, a0, 1                  # a+1
    addi a1, a1, 1                  # b+1
    addi t0, t0, -1                 # size-1
    jal dot_product_recursive

    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    mv t1, a0

    # restore the original a value before the call to function
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

    
exit_base_case:
    mul t1, a0, a1
    jr ra
