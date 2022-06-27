.MODEL SMALL
.STACK 1000H
.DATA
NEWL DB  10,13,"$"
.CODE 

MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
    
    XOR BL,BL
    
    MOV CX,4 
        
    INPUT:
    MOV AH,01H
    INT 21H
    SUB AL,48
    SHL BL,1
    OR BL,AL
    LOOP INPUT
      
      
    MOV AH,09H
    MOV DX,OFFSET NEWL
    INT 21H  
      
         
    NEXT:
    CMP BL,5
    JL XX 
    ADD BL,6
    XX:
    
    SHL BL,4
    MOV CX,4
    OUTPUT:
    SHL BL,1
    JNC ZERO
    
    ONE:
    MOV AH,02
    MOV DL,49
    JMP DISP
    
    
    ZERO:
    MOV AH,02
    MOV DL,48
    
    DISP:
    INT 21H
    
    
    LOOP OUTPUT
      
    MAIN ENDP
END MAIN
