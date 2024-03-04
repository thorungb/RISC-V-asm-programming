.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
massage: .string "The dot product is: "
newline: .string "\n"

.text
main:
   addi x5, x0, 0                   # let x5 be i and set it to 0
   addi x6, x0, 0                   # let x6 be sop and set it to 0

   la x7, a                         # loading the address of a to x7
   la x8, b                         # loading the address of b to x8
   
   addi x9, x0, 5

for_loop:
    bge x5, x9, exit                # condition
    slli x18, x5, 2                 # set x10 to i*4
    add x19, x18, x7                # add i*4 to the base address off a and put it to x19
    lw x20, 0(x19)                  # x20 has a[i]
    
    add x21, x18, x8                # add i*4 to the base address off a and put it to x21
    lw x22, 0(x21)                  # x22 has b[i]
    
    mul x23, x20, x22               # x21 = a[i] * b[i];
    add x6, x6, x23                 # sop += a[i] * b[i];
    addi x5, x5, 1                  # i++
    j for_loop
    
exit:
    addi a0, x0, 4
    la a1, massage               # print string
    ecall

    addi a0, x0, 1
    add a1, x0, x6              # print sop
    ecall
    
    addi a0, x0, 4
    la a1, newline               # print newline
    ecall
    
    addi    a0, x0, 10
    ecall                       # terminate ecall         exit()
    