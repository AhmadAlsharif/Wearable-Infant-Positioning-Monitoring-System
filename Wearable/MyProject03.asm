
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

_UART_tx:

;MyProject03.c,24 :: 		void UART_tx(unsigned char t){
;MyProject03.c,25 :: 		while(!(TXSTA & 0x02));
L_UART_tx6:
	BTFSC      TXSTA+0, 1
	GOTO       L_UART_tx7
	GOTO       L_UART_tx6
L_UART_tx7:
;MyProject03.c,26 :: 		TXREG = t;
	MOVF       FARG_UART_tx_t+0, 0
	MOVWF      TXREG+0
;MyProject03.c,27 :: 		}
L_end_UART_tx:
	RETURN
; end of _UART_tx

_ADC_init:

;MyProject03.c,28 :: 		void ADC_init(void){
;MyProject03.c,29 :: 		ADCON1=0xCE;
	MOVLW      206
	MOVWF      ADCON1+0
;MyProject03.c,30 :: 		ADCON0= 0x41;
	MOVLW      65
	MOVWF      ADCON0+0
;MyProject03.c,31 :: 		TRISA=0x01;
	MOVLW      1
	MOVWF      TRISA+0
;MyProject03.c,33 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_analogread:

;MyProject03.c,34 :: 		unsigned int analogread(void){
;MyProject03.c,36 :: 		ADCON0 = ADCON0 | 0x04;
	BSF        ADCON0+0, 2
;MyProject03.c,37 :: 		while( ADCON0 & 0x04);
L_analogread8:
	BTFSS      ADCON0+0, 2
	GOTO       L_analogread9
	GOTO       L_analogread8
L_analogread9:
;MyProject03.c,38 :: 		read=(ADRESH<<8)| ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;MyProject03.c,39 :: 		return read;
;MyProject03.c,40 :: 		}
L_end_analogread:
	RETURN
; end of _analogread

_main:

;MyProject03.c,41 :: 		void main(){
;MyProject03.c,42 :: 		ADC_init();
	CALL       _ADC_init+0
;MyProject03.c,43 :: 		UART_Init(9600);
	MOVLW      128
	MOVWF      FARG_UART_Init_baudRate+0
	MOVLW      37
	MOVWF      FARG_UART_Init_baudRate+1
	CALL       _UART_Init+0
;MyProject03.c,44 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
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
;MyProject03.c,45 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;MyProject03.c,46 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,47 :: 		delay_ms(1000);
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
;MyProject03.c,48 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject03.c,49 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
;MyProject03.c,50 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,51 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;MyProject03.c,53 :: 		while(1){
L_main14:
;MyProject03.c,56 :: 		if(analogread() <= 350){
	CALL       _analogread+0
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVF       R0+0, 0
	SUBLW      94
L__main35:
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;MyProject03.c,57 :: 		UART_tx('a');
	MOVLW      97
	MOVWF      FARG_UART_tx_t+0
	CALL       _UART_tx+0
;MyProject03.c,58 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	NOP
;MyProject03.c,59 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject03.c,60 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
	NOP
;MyProject03.c,61 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,62 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;MyProject03.c,63 :: 		}
	GOTO       L_main20
L_main16:
;MyProject03.c,64 :: 		else if(analogread() > 350){
	CALL       _analogread+0
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVF       R0+0, 0
	SUBLW      94
L__main36:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;MyProject03.c,65 :: 		UART_tx('b');
	MOVLW      98
	MOVWF      FARG_UART_tx_t+0
	CALL       _UART_tx+0
;MyProject03.c,66 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
	NOP
;MyProject03.c,67 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject03.c,68 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
;MyProject03.c,69 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject03.c,70 :: 		delay_ms(2000);
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
;MyProject03.c,71 :: 		}
L_main21:
L_main20:
;MyProject03.c,82 :: 		}
	GOTO       L_main14
;MyProject03.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
