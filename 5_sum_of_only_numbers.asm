.MODEL SMALL
.STACK 100H
.DATA
MSG DB "ENTER A DECIMAL DIGIT STRING: ","$" 
MSG1 DB "THE SUM= ","$"
.CODE


MAIN PROC
    
    
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG 
    MOV AH,09H 
    INT 21H 
    
    MOV AX,0
    MOV DX,0
    MOV BX,0
    
    BEGIN:       
    MOV AH,01H 
    INT 21H 
    MOV BX,0
    MOV BL,AL 
    
    CMP BL,0DH
    JE BREAK
     
    CMP BL,'9'
    JG SKIP
    CMP BL,'0'
    JL SKIP
    
  
    SUB BX,48
    ADD DX,BX
    
     
    SKIP:
    
    JMP BEGIN 
    
    BREAK:
    MOV BX,DX
    MOV AH,02H
    MOV DL,0AH ;LINE BREAK
    INT 21H 
      
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG1 
    MOV AH,09H 
    INT 21H
    CALL DECIMAL_OUTPUT
    MOV AH,4CH  ;DOS EXITT
    INT 21H
       
MAIN ENDP 
DECIMAL_OUTPUT PROC
    

MOV AX,BX
MOV BX,10    ;DIVISOR
MOV CX,0 ;COUNTER

FOR2:
   XOR DX,DX
   DIV BX  
   PUSH DX
   INC CX
   
   CMP AX,0
   JE PRINT
   
JMP FOR2  


PRINT:
  POP DX 
  ADD DX,'0' ;ASCII TE CONVERT
  MOV AH,02H
  INT 21H
LOOP PRINT
    
RET

DECIMAL_OUTPUT ENDP  
       
END MAIN
 
   
 
   
   