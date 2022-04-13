.text
    main:
          addi  $sp, $zero, 124   # initializes the stack pointer
          sw    $fp, 0($sp)       # pushes the frame pointer 
          addi  $sp, $sp, -4      ##
          or    $fp, $zero, $sp   # $fp = $sp
          addi  $sp, $sp, -4      # $sp = $sp - 4
          addi  $a0, $zero, 5     # $a0 = 5
          jal   factorial         # calls factorial
          or    $t0, $zero, $v0   # $t0 = $v0
          sw    $t0, -4($fp)      # M[$fp - 4] = $t0
          addi  $sp, $sp, 8       # $sp = $sp + 8
          lw    $fp, 0($sp)       # pops the frame pointer
    END:  j     END               # stops the execution

    factorial:
          #### Creacion del marco de la funcion factorial ###
          sw    $fp, 0($sp)         # pushes $fp
          addi  $sp, $sp, -4        ##
          or    $fp, $zero, $sp     # $fp = $sp
          addi  $sp, $sp, -8        # frame size [ra, s0]
          sw    $ra, 0($fp)         # pushes $ra
          sw    $s0, -4($fp)        # pushes #s0
          #### Manipulacion de los datos ###
          or    $s0, $zero, $a0     # $s0 = $a0
          addi  $at, $s0, -1        # ble   $s0, 1, L1
          slti  $at, $at, 1         ##
          bne   $at, $zero, L1      ##
          addi  $a0, $s0, -1        # $a0 = $s0 -1
          jal   factorial           # calls factorial
          or    $a0, $zero, $s0     # $a0 = $s0
          or    $a1, $zero, $v0     # $a0 = $s0
          jal   mult_u              # calls mult_u
          j     L2
    L1:   addi  $v0, $zero, 1       # $v0 = 1
        ### Liberación del marco ###
    L2:   lw    $ra, 0($fp)         # pops $ra
          lw    $s0, -4($fp)        # pops $s0
          addi  $sp, $sp, 12        # $sp = $sp + 12
          lw    $fp, 0($sp)         # pops $fp
          ### Regreso del control a la func. invocadora ###
          jr    $ra

    mult_u:
          and   $t0, $0, $0         # accum = 0
          and   $t1, $0, $0         # i = 0
          j     LF0
    LF1:  add   $t0, $t0, $a0       # accum = accum + x
          addi  $t1, $t1, 1         # i++
    LF0:  slt   $at, $t1, $a1       # i < y
          bne   $at, $zero, LF1     ##
          or    $v0, $zero, $t0     # return accum
          jr    $ra                 ##

