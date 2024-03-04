.text
main:
    addi a0, x0, 110            # pass the first argument to a0
    addi a1, x0, 50             # pass the second argument to a1
    jal mult
    
    # print int
    mv a1, a0                   # by convention the return value is always in a0
    addi a0, x0, 1
    ecall

    # exit cleanly
    addi a0, x0, 10
    ecall

mult:
    # base case
    addi t0, x0, 1
    beq a1, t0, exit_base_case      # compare a1 with 1, if the two are equal, exit the mult function
    
    # recursive case
    addi sp, sp, -4                 # if b != 1 do this
    sw ra, 0(sp)                    # storing the ra value on to the stack

    # mult(a, b-1)
    addi sp, sp, -4
    sw a0, 0(sp)
    addi a1, a1, -1
    jal mult
    
    # a + mult(a, b-1)
    mv t1, a0
    
    # restore the original a value before the call to mult
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

exit_base_case:
    jr ra