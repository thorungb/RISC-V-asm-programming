.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "\n"

# Register NOT to be used: x0 to x4 and x10 to x17
# Register that we can use: x5 to x9 and x18 to x31

.text
main:
   addi x5, x0, 10                  # let x5 be size and set it to 10
   addi x6, x0, 0                   # let x6 be sum1 and set it to 0
   addi x7, x0, 0                   # let x7 be sum2 and set it to 0
   
   addi x8, x0, 0                   # let x8 be i and set it to 0
   la x9, arr1                      # loading the address of arr1 to x9

for_loop1:
    bge x8, x5, exit1               # condition
    # we need to calculate &arr1[i]
    # we need the base address of arr1 then, we add an offset of i*4 to the base address
    slli x18, x8, 2                 # set x10 to i*4
    add x19, x18, x9                # add i*4 to the base address off arr1 and put it to x19
    addi x20, x8, 1                 # set x20 to i + 1
    sw x20, 0(x19)                  # arr[i] = i + 1
    addi x8, x8, 1                  # i++
    j for_loop1
    
exit1:
    addi x8, x0, 0                  # set i to zero again
    la x21, arr2                    # loading the address of arr2 to x21

for_loop2:
    bge x8, x5, exit2               # condition
    # we need to calculate &arr2[i]
    # we need the base address of arr2 then, we add an offset of i*4 to the base address
    slli x18, x8, 2                 # set x10 to i*4
    add x19, x18, x21               # add i*4 to the base address off arr2 and put it to x19
    add x20, x8, x8                # set x20 to i + i (2*i)
    sw x20, 0(x19)                  # arr[i] = 2*i
    addi x8, x8, 1                  # i++
    j for_loop2

exit2:
    addi x8, x0, 0                  # set i to zero again

for_loop3:
    bge x8, x5, exit3               # condition
    # we need to calculate &arr1[i]
    # we need the base address of arr1 then, we add an offset of i*4 to the base address
    slli x18, x8, 2                 # set x10 to i*4
    add x19, x18, x9                # add i*4 to the base address off arr1 and put it to x19
    lw x20, 0(x19)                  # x20 has arr1[i]
    add x6, x6, x20                 # sum1 = sum1 + arr1[i]
    add x19, x18, x21               # add i*4 to the base address off arr2 and put it to x19
    lw x20, 0(x19)                  # x20 hass arr2[i]
    add x7, x7, x20                 # sum2 = sum2 + arr2[i]
    
    addi x8, x8, 1                  # i++
    j for_loop3

exit3:
    addi a0, x0, 1
    add a1, x0, x6              # print sum1
    ecall
    
    addi a0, x0, 4              # print newline
    la a1, newline
    ecall
    
    addi a0, x0, 1
    add a1, x0, x7              # print sum2 
    ecall
    
    addi a0, x0, 4              # print newline
    la a1, newline
    ecall
    
    addi    a0, x0, 10
    ecall                       # terminate ecall         exit()
    