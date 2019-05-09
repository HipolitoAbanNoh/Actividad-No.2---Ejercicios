;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID
;ELABORADO POR: HIPOLITO ABAN NOH
;FECHA: 09/05/2019 
.MODEL SMALL  
.STACK 120
.DATA 
    menu db "MENU DE OPERACIONES$"
    operaciones1 db "(1) OPERACIONES BASICAS$" 
    nummayor1 db "(2) NUMERO MAYOR$"
    opcion db "SELECCIONESUNA OPCION:$"  
      
;variables de operaciones basicas
    ;declarando variables globales
    numero1 db 0,"$"
    numero2 db 0,"$"
    suma db 0,"$"
    resta db 0,"$"
    multiplicacion db 0,"$"
    division db 0,"$"
    
    msjn1 db 10,13, "Ingrese el primer numero= ",'$';ingrese n1
    msjn2 db 10,13, "Ingrese el segundo numero= ",'$';ingrese n2
    
    ;mensaje para mostrar los resultados
     
    msjnS db 10,13, "La suma es= ",'$'
    msjnR db 10,13, "La resta= ",'$'
    msjnM db 10,13, "La Multiplicacion es= ",'$'
    msjnD db 10,13, "La division es = ",'$' 

;fin ariables operacioneS
;inicio de numeros mayores
    MSJ1 DB 10,13,'INGRESE TRES DIGITOS DEL 0 AL 9 : $'
    MAYOR DB 10,13,'EL DIGITO MAYOR ES: $'  
    DIGITO1 DB 100 DUP(' $')
    DIGITO2 DB 100 DUP(' $')
    DIGITO3 DB 100 DUP(' $')
;fin de numeros mayores
.CODE 
    MOV AX,@DATA
    MOV DS,AX    
;------------------------
;RECORRIDO DE PANTALLA COMPLETA..........
    
    MOV AH,06H
    MOV AL,0
    MOV BH,3FH   ;COLOR FONDO /TEXTO
    MOV CX,0000H ;FILA/COLUMA INICIO
    MOV DX,184FH ;FILA/COLUMNA FINAL
    INT 10H       ;INTERRUPCION
    
                 
;RECORRIDO DE PANTALLA MENU

    MOV AH,06H
    MOV AL,0
    MOV BH,0FH ;FONDO NEGRO
    MOV CX,0209H;FILA 3, COLUMNA 10
    MOV DX,0245H;FILA 4, COLUMNA 15 
    INT 10H   
;RECORRIDO DE PANTALLA OPERACIONES BASICAS
    MOV AH,06H
    MOV AL,0
    MOV BH,1FH ;FONDO AZUL 
    MOV CX,0409H;FILA 4, COLUMNA 10
    MOV DX,1545H ;FILA 19, COLUMNA 69
    INT 10H 
    
;------------------------    
;PUNTERO.................................  
;IMPRESION MENU
    MOV AH,02H
    MOV BH,0
    MOV DH,02H ; FILA
    MOV DL,1EH ; COLUMNA
    INT 10H
       
    MOV AH,09H
    MOV DX,OFFSET menu
    INT 21H
;IMPRESION OPERACIONES 
;OPERACIONES BASICAS
    MOV AH,02H
    MOV BH,0
    MOV DH,07H ;FILA
    MOV DL,13H ;COLUMNA
    INT 10H
    
    MOV AH,09H
    MOV DX,OFFSET operaciones1
    INT 21H 
;NUMERO MAYOR
    MOV AH,02H
    MOV BH,0
    MOV DH,09H ;FILA
    MOV DL,13H ;COLUMNA
    INT 10H  
    
    MOV AH,09H
    MOV DX,OFFSET nummayor1
    int 21H   
    
; SELECCION
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 16H; 22
    MOV DL, 2FH; 52 
    INT 10H
    MOV AH, 09H
    MOV DX,OFFSET opcion
    INT 21H

;SALTO EN OTRA PANTALLA
    
    PAG:
        ;LEER CARACTER
        MOV AH, 0H
        INT 16H
    
        CMP AL, "1"
        JE OPERACIONESBASICAS
        CMP AL, "2"
        JE NUMMAYOR
        
        JMP FIN    
    OPERACIONESBASICAS: 
    
        MOV AH, 05H
        MOV AL, 1
        INT 10H  
        
        MOV AH, 06H
        MOV AL, 0
        MOV BH, 3FH
        MOV CX, 0000H;0, 0
        MOV DX, 184FH;24,79
        INT 10H 
        
             
        ;inicio operaciones basicas
        begin proc far
                                
            ;solicitar del teclado numero 1
            
            mov ah, 09
            lea dx, msjn1
            int 21h
            mov ah, 01
            int 21h
            sub al, 30h
            mov numero1,al
            
            ;solicitar del teclado numero 2
            
            mov ah, 09
            lea dx, msjn2
            int 21h
            mov ah, 01
            int 21h
            sub al, 30h
            mov numero2,al
            
            ;operaciones aritmeticas
                          
            ;SUMA             
            mov al,numero1
            add al,numero2
            mov suma,al  
            
            ;RESTA
            mov al,numero1
            sub al,numero2
            mov resta,al
            
            ;MULTIPLICACION
            mov al,numero1
            mul numero2
            mov multiplicacion,al
            
            ;DIVISION
            mov al,numero1
            div numero2
            mov division,al
                
            ;Mostrar los mensajes de los resultados 
            
            ;mostrando la suma
            mov ah,09
            lea dx,msjnS
            int 21h
            mov dl,suma
            add dl,30h 
            mov ah,02
            int 21h  
            
            ;mostrando la resta
            mov ah,09
            lea dx,msjnR
            int 21h
            mov dl,resta
            add dl,30h 
            mov ah,02
            int 21h
            
            ;mostrando la multiplicacion
            mov ah,09
            lea dx,msjnM
            int 21h
            mov dl,multiplicacion
            add dl,30h 
            mov ah,02
            int 21h
            
            ;mostrando la division
            mov ah,09
            lea dx,msjnD
            int 21h
            mov dl,division
            add dl,30h 
            mov ah,02
            int 21h
            
            MOV AH, 0H
            INT 16H 
        begin endp
        ;fin operaciones basicas
        CMP AL, 032
        JE ATRAS
        JMP FIN 
        
    NUMMAYOR:  
     INICIO:
      
      MOV SI,0
      MOV AX,@DATA    
      MOV DS,AX
        ;salto de otra pantalla 
        MOV AH, 05H
        MOV AL, 2
        INT 10H 
        
        MOV AH, 06H
        MOV AL, 0
        MOV BH, 3FH
        MOV CX, 0000H;0, 0
        MOV DX, 184FH;24,79 
        INT 10H  
        
        MOV AH,09 
        MOV DX,OFFSET MSJ1 ;Imprimimos el msj1  
        INT 21H
      
          CALL SALTODELINEA;llamamos el metodo saltodelinea.
          CALL PEDIRCARACTER ;llamamos al metodo      
          MOV DIGITO1,AL ;lo guardado en AL a digito1  
          CALL SALTODELINEA
          CALL PEDIRCARACTER 
          MOV DIGITO2,AL          
          CALL SALTODELINEA            
          CALL PEDIRCARACTER           
          MOV DIGITO3,AL          
          CALL SALTODELINEA
          
    ;---------------------------------------------------------------
          MOV AH,DIGITO1
          MOV AL,DIGITO2 
          
          CMP AL,AL ;compara primero con el segundo
          JA COMPARA-1-3 ;si es mayor el primero, ahora lo compara con el tercero 
          JMP COMPARA-2-3 ;si el primero no es mayor,ahora compara el 2 y 3 digito 
          COMPARA-1-3:   
          
          MOV AL,DIGITO3 ;ah=primer digito, al=tercer digito 
          CMP AH,AL ;compara primero con tercero 
          
          JA MAYOR1 ;si es mayor que el tercero, entonces el primero es mayor que los 3  
          
          COMPARA-2-3:
          MOV AH,DIGITO2
          MOV AL,DIGITO3  
          
          CMP AH,AL ;compara 2 y 3, YA NO es necesario compararlo con el 1,porque ya sabemos que el 1 no es mayor que el 2
          JA MAYOR2 ;Si es mayor el 2,nos vamos al metodo para imprimirlo 
          
          JMP MAYOR3 ;Si el 2 no es mayor, el 3 es el mayor
          
    
          MAYOR1: 
          CALL MENSAJEMAYOR ;llama al metodo que dice: El digito mayor es: 
          MOV DX, OFFSET DIGITO1 ;Imprir El Digito 1 es mayor 
          MOV AH, 9
          INT 21H
          JMP EXIT
          
          MAYOR2:
          CALL MENSAJEMAYOR 
          
          MOV DX, OFFSET DIGITO2 ;Salto de linea 
          MOV AH, 9
          INT 21H
          JMP EXIT
          
          MAYOR3:
          CALL MENSAJEMAYOR
          
          MOV DX, OFFSET DIGITO3 ;Salto de linea
          MOV AH, 9
          INT 21H
          JMP EXIT
          
          
          ;METODOS
          MENSAJEMAYOR:
          MOV DX, OFFSET MAYOR ;El digito Mayor es:
          MOV AH, 9
          INT 21H 
          
          RET
          PEDIRCARACTER:
          MOV AH,01H; pedimos primer digito
          INT 21H
          RET
          
          SALTODELINEA:
          MOV DX,OFFSET SALTODELINEA ;Salto de linea
          MOV AH,9
          INT 21H
          RET
          
          EXIT:
            
        MOV AH, 0H
        INT 16H 
        
        CMP AL, 032
        JE ATRAS
        JMP FIN 
            
    ATRAS:
        MOV AH, 05H
        MOV AL, 0
        INT 10H
        JMP PAG 
        
    
    FIN:
        INT 21H     
END