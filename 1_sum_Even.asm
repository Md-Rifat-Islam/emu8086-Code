;Decimal Input output Code

.model small
.stack 100h                     ;size of stack
.data                           ;data section
msg1 db 'Enter n : $'           ;message 1
msg2 db 0dh,0ah,'Sum is : $'    ;message 2
.code                           ;code section
                                ;main function
main proc                       ;retrive data section
    mov ax,@data
    mov ds,ax
    
    mov ah,09h                  ;String output
    mov dx,offset msg1
    int 21h
                                ;make ax 0
    xor ax,ax                   ;make bx 0
    xor bx,bx                   ;make cx 0
    xor cx,cx                   ;make dx 0
    xor dx,dx
    
    call decimal_input          ;calling function decimal_input---->ans in bx
    
    mov cx,bx                   ;insert value of bx into cx
    xor bx,bx                   ;make bx 0
    xor dx,dx                   ;make dx 0
    
    lv:
        add dx,bx
        add bx,2
    loop lv
    mov bx,dx
    
    mov ah,09h                  ;print String message 2
    mov dx,offset msg2
    int 21h
    
    call decimal_output         ;calling function decimal_output---->ans in bx
    
    mov ah,4ch                  ;Terminate main proc
    int 21h
    
    
main endp

decimal_input proc              ;decimal_input proc start
    xor bx,bx
    mov ah,1                    ;input a char
    int 21h
    
    digit:                      
        cmp al,0dh              ;compare al with "enter"/newline
        je endd
        
        and ax,000fh            ;make all value 0 ecxcept last one
        push ax
        mov ax,10
        mul bx
        mov bx,ax
        pop bx
        add bx,ax
        
        mov ah,1
        int 21h
        
    jmp digit
    
    endd:
    ret
decimal_input endp              ;decimal_input proc end

decimal_output proc             ;decimal_output proc start 
    mov ax,bx
    mov bx,10
    xor cx,0
    
    l1:
        xor dx,dx
        div bx
        push dx                 ;push the reminder into stack
        inc cx
        cmp ax,0
        je printt
    jmp l1
    
    printt:
        pop dx
        add dx,'0'
        mov ah,02h              ;Print character
        int 21h
    loop printt
    ret
decimal_output endp             ;decimal_output proc end

end main                        ;end code