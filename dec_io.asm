.model small
.stack 100h
.data
msg1 DB "Enter number : ", "$"
msg2 DB 0dh, 0ah, 'Your number is : $' 
.code

main proc
   mov ax,@data
   mov ds,ax
   
   mov ah,09h
   mov dx,offset msg1 
   int 21h
   
   xor ax,ax
   xor bx,bx
   xor cx,cx
   xor dx,dx
   
   call decimal_input
   
   mov ah,2
   mov dl,0ah
   int 21h
   
   mov ah,09h
   mov dx,offset msg2 
   int 21h
   
   call decimal_output
   
   mov ah,2
   mov dl,0ah
   int 21h
   
   mov ah,4ch
   int 21h
    
main endp

decimal_input proc
    xor bx,bx
    mov ah,1
    int 21h
    
    digit:
        cmp al,0dh
        je end_for
        
        and ax,000fh
        
        push ax
        mov ax,10
        mul bx
        mov bx,ax
        
        pop ax
        add bx,ax
        mov ah,1
        int 21h
    
    jmp digit
    
    end_for:
    ret 
    
decimal_input endp

decimal_output proc
    mov ax,bx
    mov bx,10
    xor cx,cx
    
    for2:
        xor dx,dx
        div bx
        push dx
        inc cx
        
        cmp ax,0
        je print
    
    jmp for2
    
    print:
        pop dx
        add dx,'0'
        mov ah,02h
        int 21h          
    loop print
    
    ret
    
decimal_output endp

end main