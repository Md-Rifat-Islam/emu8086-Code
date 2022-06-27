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
    MOV N, AL
        
    MOV CX,AX
    OUTTER_LOOP:
        MOV AH, 09H
        MOV DX, OFFSET MSG2
        INT 21H         
                
                MOV M,CL
            IN1_LOOP:
                MOV AH,02H
                MOV DL,032
                INT 21H          
                           
                DEC M
                CMP M,0
                
            JG IN1_LOOP 
            
            MOV AL,N    
            MOV M,AL
            ADD M,1
            SUB M,CL
             
            IN2_LOOP:
                MOV AH,02H
                MOV DL,CL
                ADD DL,48
                INT 21H          
                           
                DEC M
                CMP M,0
                
            JG IN2_LOOP 
          
       
    
    LOOP OUTTER_LOOP    
        
    
    MAIN ENDP
END MAIN
