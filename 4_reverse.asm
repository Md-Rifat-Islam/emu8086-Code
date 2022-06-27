.MODEL SMALL
.STACK 100H
.DATA
  
.CODE


MAIN PROC
    MOV CX,0
    MOV AX,0
    mov DX,0
    BEGIN:
    MOV AH,01H 
    INT 21H 
           
              
    MOV DX,AX
    
    CMP AL,0DH
    JE BREAK
    PUSH DX
    INC CX
    JMP BEGIN
    
    
    BREAK:
    MOV AH,02H
    MOV DL,0AH ;LINE BREAK
    INT 21H
    L:
    POP DX
    MOV AH,02H 
    INT 21H
    LOOP L
    
 
   MAIN ENDP
END MAIN
 