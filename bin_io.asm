.model small    
.stack 100h
.data
   
.code       
    main proc 
       
        
        mov bx,0
        mov cx,8
    again:        
        mov ah,1
        int 21h
        cmp al,13
        je print
        
        and al,0fh
        shl bl,1
        or bl,al
        loop again   
    print:
    
        mov cx,8
    next:
        shl bl,1
        jnc again1 
        
        mov dl,49
        mov ah,2
        int 21h
        jmp disp
    
    again1:
        mov dl,48
        mov ah,2
        int 21h
    disp:
        loop next
        
     
        main endp
    end main