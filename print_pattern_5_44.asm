.MODEL SMALL
.STACK 1000H
.DATA
N DB ?               
MSG1 DB "Enter n:", "$" 
MSG2 DB 0DH, 0AH, '$'
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 09H
    MOV DX, OFFSET MSG1
    INT 21H
    
    MOV AH, 01H
    INT 21H
    AND AX, 000FH
    MOV N, AL
        
    MOV CX, AX
    
    OUTTER_LOOP:
        MOV AH, 09H
        MOV DX, OFFSET MSG2
        INT 21H     
        
        ;PUSH CX               
        MOV BL, N        
        
        INNER_LOOP:
            MOV AH, 02H
            MOV DL, CL
            ADD DL, 30H
            INT 21H
            
            DEC BL
            CMP BL, CL
            JGE INNER_LOOP
        ;POP CX
        LOOP OUTTER_LOOP
    
    MAIN ENDP
END MAIN