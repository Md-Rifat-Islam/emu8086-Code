.MODEL SMALL
.STACK 1000H
.DATA
N DB ?
M DB ?               
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
    MOV CX, AX
    MOV N, 1
    MOV BL, 0
    MOV BH, 1
    OUTTER_LOOP:
        MOV AH, 09H
        MOV DX, OFFSET MSG2 
        INT 21H  
        MOV M, BH
        CMP BH, 1
        INNER_LOOP:
            MOV AH, 02
            MOV DL, BH
            ADD DL, 30H
            INT 21H
            INC BL
            CMP BL, N
            JE BREAK 
            SUB DL, 30H
            MOV BH, 1
            SUB BH, DL 
            JMP INNER_LOOP
        
        BREAK: 
        CMP M, 1
        JE L2
        MOV BH, 1
        JMP L3
        L2:
        MOV BH, 0
        L3:
        INC N
        MOV BL, 0
        
    LOOP OUTTER_LOOP
    
    
    
    MAIN ENDP
END MAIN