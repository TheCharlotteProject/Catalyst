; Catalyst: A Standalone General Purpose OS Kernel
; Copyright (C) 2023  Mohit D. Patel (mdpatelcsecon)

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see https://www.gnu.org/licenses/

bits 64

section .text

global disable_interrupts
disable_interrupts:
        cli
        ret

global enable_interrupts
enable_interrupts:
        sti
        ret

global hcf
hcf:
        cli ;clear interrupt enable flag
        hlt ;halt in a loop
        jmp hcf

global inb
inb:
        mov dx, di
        in al, dx
        ret

global outb
outb:
        mov dx, di
        mov al, sil
        out dx, al
        ret
