
_MSdelay:

;MyProject03.c,4 :: 		void MSdelay(unsigned int val)
;MyProject03.c,6 :: 		for(i=0;i<val;i++)
	CLRF       _i+0
	CLRF       _i+1
L_MSdelay0:
	MOVF       FARG_MSdelay_val+1, 0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__MSdelay26
	MOVF       FARG_MSdelay_val+0, 0
	SUBWF      _i+0, 0
L__MSdelay26:
	BTFSC      STATUS+0, 0
	GOTO       L_MSdelay1
;MyProject03.c,7 :: 		for(j=0;j<165;j++);
	CLRF       _j+0
	CLRF       _j+1
L_MSdelay3:
	MOVLW      0
	SUBWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__MSdelay27
	MOVLW      165
	SUBWF      _j+0, 0
L__MSdelay27:
	BTFSC      STATUS+0, 0
	GOTO       L_MSdelay4
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
	GOTO       L_MSdelay3
L_MSdelay4:
;MyProject03.c,6 :: 		for(i=0;i<val;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject03.c,7 :: 		for(j=0;j<165;j++);
	GOTO       L_MSdelay0
L_MSdelay1:
;MyProject03.c,8 :: 		}
L_end_MSdelay:
	RETURN
; end of _MSdelay

_UART_Init:

;MyProject03.c,10 :: 		void UART_Init(int baudRate)
;MyProject03.c,12 :: 		TRISC=0xC0;
	MOVLW      192
	MOVWF      TRISC+0
;MyProject03.c,13 :: 		TXSTA=(1<<5);
	MOVLW      32
	MOVWF      TXSTA+0
;MyProject03.c,14 :: 		RCSTA=(1<<7) | (1<<4);
	MOVLW      144
	MOVWF      RCSTA+0
;MyProject03.c,15 :: 		SPBRG = (8000000UL/(long)(64UL*baudRate))-1;
	MOVLW      6
	MOVWF      R0+0
	MOVF       FARG_UART_Init_baudRate+0, 0
	MOVWF      R4+0
	MOVF       FARG_UART_Init_baudRate+1, 0
	MOVWF      R4+1
	MOVLW      0
	BTFSC      R4+1, 7
	MOVLW      255
	MOVWF      R4+2
	MOVWF      R4+3
	MOVF       R0+0, 0
L__UART_Init29:
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Init30
	RLF        R4+0, 1
	RLF        R4+1, 1
	RLF        R4+2, 1
	RLF        R4+3, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__UART_Init29
L__UART_Init30:
	MOVLW      0
	MOVWF      R0+0
	MOVLW      18
	MOVWF      R0+1
	MOVLW      122
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	DECF       R0+0, 0
	MOVWF      SPBRG+0
;MyProject03.c,16 :: 		}
L_end_UART_Init:
	RETURN
; end of _UART_Init

_UART_RxChar:

;MyProject03.c,18 :: 		char UART_RxChar()
;MyProject03.c,20 :: 		while(!(PIR1 & 0xDF));
L_UART_RxChar6:
	MOVLW      223
	ANDWF      PIR1+0, 0
	MOVWF      R0+0
	BTFSS      STATUS+0, 2
	GOTO       L_UART_RxChar7
	GOTO       L_UART_RxChar6
L_UART_RxChar7:
;MyProject03.c,21 :: 		PIR1 = PIR1 & 0xDF;
	MOVLW      223
	ANDWF      PIR1+0, 1
;MyProject03.c,22 :: 		return(RCREG);
	MOVF       RCREG+0, 0
	MOVWF      R0+0
;MyProject03.c,23 :: 		}
L_end_UART_RxChar:
	RETURN
; end of _UART_RxChar

_CCPPWM_init:

;MyProject03.c,24 :: 		void CCPPWM_init(void){
;MyProject03.c,25 :: 		T2CON = 0x07;
	MOVLW      7
	MOVWF      T2CON+0
;MyProject03.c,26 :: 		CCP1CON = 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;MyProject03.c,27 :: 		PR2 = 250;
	MOVLW      250
	MOVWF      PR2+0
;MyProject03.c,28 :: 		CCPR1L= 0;
	CLRF       CCPR1L+0
;MyProject03.c,29 :: 		}
L_end_CCPPWM_init:
	RETURN
; end of _CCPPWM_init

_main:

;MyProject03.c,48 :: 		void main(){
;MyProject03.c,50 :: 		UART_Init(9600);
	MOVLW      128
	MOVWF      FARG_UART_Init_baudRate+0
	MOVLW      37
	MOVWF      FARG_UART_Init_baudRate+1
	CALL       _UART_Init+0
;MyProject03.c,51 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;MyProject03.c,52 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;MyProject03.c,53 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,54 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
	NOP
;MyProject03.c,55 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject03.c,56 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;MyProject03.c,57 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,58 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;MyProject03.c,60 :: 		while(1){
L_main12:
;MyProject03.c,82 :: 		if (UART_RxChar() == 'a'){
	CALL       _UART_RxChar+0
	MOVF       R0+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;MyProject03.c,83 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject03.c,85 :: 		for(ss=0;ss<=255;ss++){
	CLRF       _ss+0
	CLRF       _ss+1
L_main15:
	MOVF       _ss+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVF       _ss+0, 0
	SUBLW      255
L__main34:
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;MyProject03.c,86 :: 		CCPR1L=ss;
	MOVF       _ss+0, 0
	MOVWF      CCPR1L+0
;MyProject03.c,87 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	NOP
;MyProject03.c,85 :: 		for(ss=0;ss<=255;ss++){
	INCF       _ss+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ss+1, 1
;MyProject03.c,88 :: 		}
	GOTO       L_main15
L_main16:
;MyProject03.c,90 :: 		for(ss=255;ss>=0;ss--){
	MOVLW      255
	MOVWF      _ss+0
	CLRF       _ss+1
L_main19:
	MOVLW      0
	SUBWF      _ss+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      0
	SUBWF      _ss+0, 0
L__main35:
	BTFSS      STATUS+0, 0
	GOTO       L_main20
;MyProject03.c,91 :: 		CCPR1L=ss;
	MOVF       _ss+0, 0
	MOVWF      CCPR1L+0
;MyProject03.c,92 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	NOP
;MyProject03.c,90 :: 		for(ss=255;ss>=0;ss--){
	MOVLW      1
	SUBWF      _ss+0, 1
	BTFSS      STATUS+0, 0
	DECF       _ss+1, 1
;MyProject03.c,93 :: 		}
	GOTO       L_main19
L_main20:
;MyProject03.c,95 :: 		}
L_main14:
;MyProject03.c,96 :: 		if (UART_RxChar() == 'b'){
	CALL       _UART_RxChar+0
	MOVF       R0+0, 0
	XORLW      98
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;MyProject03.c,97 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,98 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
	NOP
;MyProject03.c,99 :: 		}
L_main23:
;MyProject03.c,100 :: 		}
	GOTO       L_main12
;MyProject03.c,101 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
