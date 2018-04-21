start: addi $s0, $r0, 100    #s0 = 100
       addi $s1, $r0, 500    #s1 = 500
       addi $s2, $r0, 0xFFFF #s2 = 0xFFFF
       addi $s2, $s2, 1      #s2 = 0x10000 HAZARD
       add  $s2, $s2, $s0    #s2 = 0x10064 HAZARD
       add  $s1, $s1, $s0    #s1 = 500
       sub  $s2, $s2, $s1    #s2 = 0xFE70 HAZARD
       xor  $s3, $s1, $s2    #s3 = 0xFD90
       addi $s4, $r0, 0xF0FA #s4 = 0xF0FA
       xor  $s4, $s4, $s2    #s4 = 0x0E8A HAZARD
       xor  $s4, $s4, $s2    #s4 = 0xF0FA HAZARD
       sub  $s1, $r0, $s1    #s1 = -500
       beq  $s0, $r0, start  # Branch not taken
       addi $s0, $r0, 0      #s0 = 0
       addi $s6, $r0, 5
       beq  $s0, $r0, loop   # Branch taken
       addi $s0, $s0, 0      # No-op
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
loop:  subi $s6, $s6, 1
       beq  $s6, $r0, exit
       addi $s0, $s0, 0      # No-op
       j    loop
       addi $s0, $s0, 0      # No-op
exit:  addi $sp, $sp, -16    # add 4 words to the stack
       addi $s0, $r0, 0xDEAD
       addi $s1, $r0, 0xBEAF
       addi $s2, $r0, 0xAFAD
       addi $s3, $r0, 0xADAD
       sw   $s0, 0($sp)
       sw   $s1, 4($sp)
       sw   $s2, 8($sp)
       sw   $s3, 12($sp)
       lw   $t0, 0($sp)      #t0 = 0xDEAD
       lw   $t1, 4($sp)      #t1 = 0xBEAF
       lw   $t2, 8($sp)      #t2 = 0xAFAD
       lw   $t3, 12($sp)     #t3 = 0xADAD
       addi $a0, $r0, -40    #a0 = -r0
       addi $a1, $r0, 50     #a1 = 50
       jal  foo              # Test out function calls
       addi $s0, $s0, 0      # No-op
       j    exit
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run
       add  $s2, $s2, $s4    # Not Run

# Recursive Function Foo
# Increments a0 until a0 equals a1
# Returns v0 = number of increments needed
foo:   addi $sp, $sp, -4
       sw   $ra, 0($sp)      # Save return address
       addi $v0, $r0, 0      # r0 = 0
       addi $a0, $a0, 1
       beq  $a0, $a1, lexit
       addi $s0, $s0, 0      # No-op
       jal  foo
       addi $s0, $s0, 0      # No-op
lexit: addi $v0, $v0, 1      # Increment return variable
       lw   $ra, 0($sp)
       jr   $ra

exit:  addi $v0, $v0, 0      # Program exit, no op
