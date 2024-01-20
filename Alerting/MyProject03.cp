#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/02/MyProject03.c"
unsigned int i;
unsigned int j;
unsigned int ss;
void MSdelay(unsigned int val)
{
 for(i=0;i<val;i++)
 for(j=0;j<165;j++);
}

void UART_Init(int baudRate)
{
 TRISC=0xC0;
 TXSTA=(1<<5);
 RCSTA=(1<<7) | (1<<4);
 SPBRG = (8000000UL/(long)(64UL*baudRate))-1;
}

char UART_RxChar()
{
 while(!(PIR1 & 0xDF));
 PIR1 = PIR1 & 0xDF;
 return(RCREG);
}
void CCPPWM_init(void){
 T2CON = 0x07;
 CCP1CON = 0x0C;
 PR2 = 250;
 CCPR1L= 0;
}
#line 48 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/02/MyProject03.c"
void main(){

 UART_Init(9600);
 delay_ms(500);
 TRISB = 0x00;
 PORTB = 0x00;
 delay_ms(1000);
 PORTB = 0xFF;
 delay_ms(1000);
 PORTB = 0x00;
 delay_ms(1000);

 while(1){
#line 82 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/02/MyProject03.c"
 if (UART_RxChar() == 'a'){
 PORTB = 0xFF;

 for(ss=0;ss<=255;ss++){
 CCPR1L=ss;
 delay_ms(10);
 }

 for(ss=255;ss>=0;ss--){
 CCPR1L=ss;
 delay_ms(10);
 }

 }
 if (UART_RxChar() == 'b'){
 PORTB = 0x00;
 delay_ms(2000);
 }
 }
}
