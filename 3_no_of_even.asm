.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'ENTER NO OF IP: $'
MSG2 DB 'NUMBER OF EVEN NUMBER IS: $'
MSG3 DB 'NUMBER OF ODD NUMBER IS: $'
COUNT DW 0
TOTAL DW 0
VAR DW 0   
.CODE


MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX 
  
   
   MOV AX,0
   MOV BX,0
   MOV CX,0
   MOV DX,0
    
   MOV AH,09
   MOV DX,OFFSET MSG1
   INT 21H
    
   CALL DECIMAL_INPUT  
   MOV COUNT,BX
   MOV TOTAL,BX 
   
   MOV AH,2
   MOV DL,0AH
   INT 21H 
   
    
   
   MOV AX,0
   MOV BX,0
   MOV CX,0
   MOV DX,0

   BEGIN:
   
   CALL DECIMAL_INPUT 
   
   MOV AH,2
   MOV DL,0AH
   INT 21H  
   
   AND BX,0001H
   
   CMP BX,0
   JNE ODD
   INC VAR
   ODD:  
    DEC COUNT
    CMP COUNT,0
    JNZ BEGIN  
     
    MOV BX,VAR
  
   MOV AH,09
   MOV DX,OFFSET MSG2
   INT 21H 
   
   CALL DECIMAL_OUTPUT 
   
   
   MOV AH,2
   MOV DL,0AH
   INT 21H
    
   MOV BX,VAR
   SUB TOTAL,BX
   
   MOV BX,TOTAL
  
    MOV AH,09
   MOV DX,OFFSET MSG3
   INT 21H 
   
   CALL DECIMAL_OUTPUT
   
   
   
   
   MOV AH,4CH ;DOS EXITT
   INT 21H
     
MAIN ENDP
    
    
DECIMAL_INPUT PROC
    XOR BX,BX     ;CLEAR REGISTER
    
    MOV AH,1
    INT 21H
                  ;INPUT 1 DIGITAL CHAR
    
  DIGIT:
    CMP AL,0DH
    JE END_FOR
    
   AND AX,000FH        
   
   ;SUB AX,30H
   PUSH AX        ;NUMBER TA JOG ER JONNE PUSHED
                  ; AX USED TO STORE 10 FOR MULTIPLICATION 
                  ;SO PUSHED TEMPORARILY IN STACK
   MOV AX,10
   MUL BX         ; DX : AX = AX * SRC [SRC=BX]
   MOV BX,AX      ; MULTIPLICATION RESULT JETA AX E 
                  ;SHETAKE BX E PATHACCHI
   POP AX
   ADD BX,AX
   MOV AH,1
   INT 21H
   
   JMP DIGIT
    
    
    END_FOR:
    
    RET 
    
DECIMAL_INPUT ENDP 

 
 
 

DECIMAL_OUTPUT PROC
    

MOV AX,BX
MOV BX,10    ;DIVISOR
MOV CX,0 
  


FOR2:
   MOV DX,0
   DIV BX     
   PUSH DX
   INC CX
   
   
   CMP AX,0
   JE PRINT
   
JMP FOR2  


PRINT:
  POP DX 
  ADD DX,'0'
  MOV AH,02H
  INT 21H
LOOP PRINT
    
RET

DECIMAL_OUTPUT ENDP
   
   
       
END MAIN
