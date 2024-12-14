.model small
.stack 100h
.data
    prompt_rows db 'Enter the number of rows: $'
    prompt_char db 'Enter the pattern character: $'
    newline db 0Dh, 0Ah, '$'
    rows db 0
    pattern db 0
.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, prompt_rows
    mov ah, 09h
    int 21h
    call read_number
    mov rows, al

    lea dx, prompt_char
    mov ah, 09h
    int 21h
    call read_char
    mov pattern, al

    lea dx, newline
    mov ah, 09h
    int 21h

    mov cl, 1
generate_row:
    mov ch, cl
    call print_pattern

    lea dx, newline
    mov ah, 09h
    int 21h

    inc cl
    cmp cl, rows
    jbe generate_row

    mov ah, 4Ch
    int 21h

read_number proc
    mov ah, 01h
    int 21h
    sub al, '0'
    ret
read_number endp

read_char proc
    mov ah, 01h
    int 21h
    ret
read_char endp

print_pattern proc
    mov al, pattern
print_pattern_loop:
    dec ch
    jl done_pattern
    mov ah, 02h
    int 21h
    jmp print_pattern_loop
done_pattern:
    ret
print_pattern endp

main endp
end main
