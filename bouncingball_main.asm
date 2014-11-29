org $8000
include utils.asm
include bouncingball.asm

main:
    call bouncingball
    di
    halt

end main
