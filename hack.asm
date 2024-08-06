MASK_BUTTON_A   = $40
MASK_BUTTON_C   = $20
NUM_WEAPONS     = 3
CUR_WEAPON      = $fff679

    org 0
    incbin "batman.md"

; only A-presses fire weapon
    org $04ae2c
            dw      MASK_BUTTON_A
    org $04af14
            dw      MASK_BUTTON_A
    org $04b004
            dw      MASK_BUTTON_A
    org $04b208
            dw      MASK_BUTTON_A
    org $04b318
            dw      MASK_BUTTON_A
    org $04b3a2
            dw      MASK_BUTTON_A
    org $04b420
            dw      MASK_BUTTON_A
    org $04b4b2
            dw      MASK_BUTTON_A
    org $04b538
            dw      MASK_BUTTON_A
    org $04b69e
            dw      MASK_BUTTON_A
    org $04b756
            dw      MASK_BUTTON_A
    org $04d052
            dw      MASK_BUTTON_A
    org $04d968
            dw      MASK_BUTTON_A
    org $04da50
            dw      MASK_BUTTON_A
    org $04db40
            dw      MASK_BUTTON_A
    org $04dd44
            dw      MASK_BUTTON_A
    org $04de54
            dw      MASK_BUTTON_A
    org $04dede
            dw      MASK_BUTTON_A
    org $04df5c
            dw      MASK_BUTTON_A
    org $04dfee
            dw      MASK_BUTTON_A
    org $04e074
            dw      MASK_BUTTON_A
    org $04e1da
            dw      MASK_BUTTON_A
    org $04e292
            dw      MASK_BUTTON_A
    org $04fb8e
            dw      MASK_BUTTON_A

; picking up disks never changes weapon
    org $013d0e
            nop
            nop

; picking up any disk always levels up all weapons
    org $013cf6
            bra     $13d06

; C-presses cycle through all weapons
    org $0087c2
            jsr     my_function
    org $1ff000
my_function:
.check_for_new_c_press
            move.b  ($22, a4), d0
            and.b   #MASK_BUTTON_C, d0
            beq     .the_end
.cont
            move.b  (CUR_WEAPON), d0
            add.b   #1, d0
            cmp.b   #NUM_WEAPONS, d0
            bne     .change_weapon
            move.b  #0, d0
.change_weapon
            move.b  d0, (CUR_WEAPON)
.the_end
            ; replace original instructions
            movea.w (6, a6), a6
            movea.l (a6), a5
            rts
