.text
    main:
        sw    $fp, 0($sp)
        addi  $sp, $sp, -4
        move  $fp, $sp
        addi  $sp, $sp, -4
        li    $a0, 5
        jal   factorial
        move  $t0, $v0
        sw    $t0, -4($fp)
        addi  $sp, $sp, 8
        lw    $fp, 0($sp)
        li    $v0, 10
        syscall

    factorial:
        #### Creacion del marco de la funcion factorial ###
        sw    $fp, 0($sp)
        addi  $sp, $sp, -4
        move  $fp, $sp
        addi  $sp, $sp, -8              #[ra, s0]
        sw    $ra, 0($fp)
        sw    $s0, -4($fp)
        #### Manipulacion de los datos ###
        move  $s0, $a0
        ble   $s0, 1, L1
        addi  $a0, $s0, -1
        jal   factorial
        mult  $s0, $v0
        mflo  $v0
        j     L2
    L1: li    $v0, 1
        ### Liberación del marco ###
    L2: lw    $ra, 0($fp)
        lw    $s0, -4($fp)
        addi  $sp, $sp, 12
        lw    $fp, 0($sp)
        ### Regreso del control a la func. invocadora ###
        jr    $ra
