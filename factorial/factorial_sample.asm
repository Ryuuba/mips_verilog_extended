# Ensamblador MIPS     # Código
addi  $sp, $zero, 124  # 20 1d 00 7c 
sw    $fp, 0($sp)      # af be 00 00
addi  $sp, $sp, -4     # 23 bd ff fc
or    $fp, $zero, $sp  # 00 1d f0 25
addi  $sp, $sp, -4     # 23 bd ff fc
addi  $a0, $zero, 5    # 20 04 00 05
jal   factorial        # 20 04 00 05


