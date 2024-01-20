unsigned int i;
unsigned int j;

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
/*
char UART_RxChar()
{
 while(!(PIR1 & 0xDF));
 PIR1 = PIR1 & 0xDF;
 return(RCREG);
}*/
void UART_tx(unsigned char t){
    while(!(TXSTA & 0x02));
    TXREG = t;
}
void ADC_init(void){
 ADCON1=0xCE;
 ADCON0= 0x41;
 TRISA=0x01;

}
unsigned int analogread(void){
 unsigned int read;
 ADCON0 = ADCON0 | 0x04;
 while( ADCON0 & 0x04);
 read=(ADRESH<<8)| ADRESL;
 return read;
}
void main(){
    ADC_init();
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


         if(analogread() <= 350){
               UART_tx('a');
               delay_ms(1000);
               PORTB = 0xFF;
               delay_ms(5000);
               PORTB = 0x00;
               delay_ms(5000);
         }
         else if(analogread() > 350){
               UART_tx('b');
               delay_ms(1000);
               PORTB = 0xFF;
               delay_ms(2000);
               PORTB = 0x00;
               delay_ms(2000);
         }
         
         
         /*
         if (UART_RxChar() == 'a'){
         PORTB = 0xFF;
         delay_ms(2000);
         }
         PORTB = 0x00;
         delay_ms(5000);
         */
    }
}