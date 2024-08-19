MASK_BUTTON_C   = $20
NUM_WEAPONS     = 3
WEAPON_P1       = $fff679
WEAPON_P2       = $fff6b9

    org 0
    incbin "batman.md"

; picking up disks never changes weapon
    org $013d0e
            nop
            nop

; picking up any disk always levels up all weapons
    org $013cf6
            bra     $13d06

    org $002032
            jmp     suppress_c_presses

    org $0087c2
            jsr     player1

    org $0087ca
            jsr     player2

    org $1ff000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
suppress_c_presses:
            and.w   (a2)+, d0
            and.w   #$dfdf, d0
            beq.w   .do_nothing
.do_something
            jmp     $2d22
.do_nothing
            jmp     $2038

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
player1:
.check_for_new_c_press
            move.b  ($22, a4), d0
            and.b   #MASK_BUTTON_C, d0
            beq     .the_end
.cont
            move.b  (WEAPON_P1), d0
            add.b   #1, d0
            cmp.b   #NUM_WEAPONS, d0
            bne     .change_weapon
            move.b  #0, d0
.change_weapon
            move.b  d0, (WEAPON_P1)
.the_end
            ; replace original instructions
            movea.w (6, a6), a6
            movea.l (a6), a5
            rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
player2:
.check_for_new_c_press
            move.b  ($22, a4), d0
            and.b   #MASK_BUTTON_C, d0
            beq     .the_end
.cont
            move.b  (WEAPON_P2), d0
            add.b   #1, d0
            cmp.b   #NUM_WEAPONS, d0
            bne     .change_weapon
            move.b  #0, d0
.change_weapon
            move.b  d0, (WEAPON_P2)
.the_end
            ; replace original instructions
            movea.w (6, a6), a6
            movea.l (a6), a5
            rts
