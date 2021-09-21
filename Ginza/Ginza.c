#include <htc.h>
#define _XTAL_FREQ 4000000
#define s_in RB6
#define clk RB7
#define door RA5
#define _latch RC0
#define _e RC3
#define ar_b RC4
#define ar_a RC5
__CONFIG(0x2BC4);
__CONFIG(0x3FFF);

/*
*/

unsigned char read_analog(unsigned char ch);
void set_duty(unsigned char duty);
unsigned int div_cut(unsigned int divided,unsigned int by);

unsigned char ad_0[5];
unsigned char ad_1[5];
unsigned char ad_2[5];
unsigned char ad_rtn[5];
unsigned char b_0;
unsigned char b_1;
unsigned char b_2;
unsigned char b_cur;
unsigned char b_ok;

unsigned char pr2_data;

unsigned int remainder; //ó]ÇË
unsigned int quotient; //è§

unsigned char time;

unsigned char timercount;
unsigned char key_count;

bit initialize;

bit direction;//1Ç≈Bê¸èaíJçs
unsigned char sta_num;//G01:èaíJ G19:êÛëê
bit at_sta;//1Ç≈âwí‚é‘íÜ

bit door_on;
bit led_on;

bit chime_type;
unsigned int chime_time;

void main(void){
	OSCCON=0x61;
	OPTION_REG=0b0101;
	WPUB=0b00111111;
	TRISA=0;
	TRISB=0b00111111;
	TRISC=0;
	PORTA=0;
	PORTB=0;
	PORTC=0;
	ADCON1=0;
	ANSELH=0;
	ANSEL=0;
	
	ar_a=1;
	ar_b=1;
	_latch=1;
	_e=0;
	door_on=0;
	
	b_0=0;
	b_1=0;
	b_2=0;
	b_cur=0;
	b_ok=255;
	
	CCP1CON=0x0c;
	PR2=99;
	T2CON|=0x06;
	CCPR1L=0;
	
	pr2_data=99;
	time=0;
	
	OPTION_REG=0b0101;
	TMR0=131;
	T0IE=1;
	
	T1CKPS1=1;
	T1CKPS0=1;
	TMR1ON=1;
	TMR1IE=1;
	PEIE=1;
	GIE=1;
	
	initialize=1;
	
	timercount=2;
	
	direction=0;
	sta_num=1;
	at_sta=1;
	
	s_in=0;
	for(unsigned char i=0;i<41;i++){
		clk=1;
		clk=0;
	}
	ar_a=0;
	ar_b=0;
	
	chime_type=0;
	chime_time=277;
	
	while(1){
		for(unsigned char i=0;i<6;i++){
			if(b_cur&((unsigned char)1<<i)&b_ok){
				b_ok=b_ok&(~((unsigned char)1<<i));
				switch(i){
					case 0://Ç±ÇÃÉhÉAÇ™äJÇ´Ç‹Ç∑
						door_on=!door_on;
						break;
					case 1://É`ÉÉÉCÉÄ1 554.37/415.30
						//112,149 56,75
						chime_type=0;
						chime_time=0;
						break;
					case 2://É`ÉÉÉCÉÄ2 587.33Hz/440Hz 0.325s(40)/0.425s(53=93-40)
						//105,141 53,71
						chime_type=1;
						chime_time=0;
						break;
					case 4://ï˚å¸êÿä∑
						if((sta_num==1)||(sta_num==19)){at_sta=1;}
						direction=!direction;
						break;
					case 3:
						if(!((sta_num==19)&&at_sta)){
							if(at_sta^direction){
								sta_num++;
							}
							at_sta=!at_sta;
						}
						break;
					case 5:
						if(!((sta_num==1)&&at_sta)){
							if(!(at_sta^direction)){
								sta_num--;
							}
							at_sta=!at_sta;
						}
						break;
					/*	
					case 3://ëOÇÃï\é¶
						if(!(((sta_num==1)&&(!direction))||((sta_num==19)&&(direction)))){
							if(!at_sta){
								sta_num-=direction?-1:1;
							}
							at_sta=!at_sta;
						}
						break;
					case 5://éüÇÃï\é¶
						if(!(((sta_num==1)&&direction)||((sta_num==19)&&(!direction)))){
							if(at_sta){
								sta_num+=direction?-1:1;
							}
							at_sta=!at_sta;
						}
						break;
					*/
				}
			}else{
				if(!((b_cur|b_ok)&((unsigned char)1<<i))){
					b_ok=b_ok|((unsigned char)1<<i);
				}	
			}
		}
		__delay_ms(10);
	}
}

void interrupt elapse(){
	if(TMR1IF){
		TMR1IF=0;
		time++;
		if(time>=2){time=0;}
		led_on=time<1;
		door=led_on&&door_on;
		_latch=0;
		for(unsigned char i=40;i>=1;i--){
			//direction 1Ç≈Bê¸èaíJçs
			//sta_num G01:èaíJ G19:êÛëê
			//at_sta 1Ç≈âwí‚é‘íÜ
			if((((sta_num+1)<<1)==i)&&(at_sta||led_on)){
				s_in=1;
			}else if(((((sta_num+1)<<1)+((direction^at_sta)?1:-1))==i)&&((!at_sta)||led_on)){
				s_in=1;
			}else{
				s_in=0;
			}
			clk=1;
			clk=0;
		}
		s_in=0;
		if(direction){
			ar_a=0;
			ar_b=1;
		}else{
			ar_a=1;
			ar_b=0;
		}
		_latch=1;
	}
	if(T0IF){
		//8MHzÇÃèÍçáÅAé¸ä˙ÇÕ4ms(250Hz)
		T0IF=0;
		while(timercount--);
		#asm
		nop
		nop
		nop
		nop
		#endasm
		timercount=2;
		TMR0=132;
		
		//40,93,184,224,277
		if(chime_time<277){
			if((chime_time<40)||((chime_time>=184)&(chime_time<224))){
				PR2=chime_type?105:112;
				CCPR1L=chime_type?53:56;
			}else if((chime_time<93)||(chime_time>=224)){
				PR2=chime_type?141:149;
				CCPR1L=chime_type?71:75;
			}else{
				CCPR1L=0;
			}
			chime_time++;
		}else{
			CCPR1L=0;
		}
		
		key_count++;
		if(key_count>=2){
			key_count=0;
			b_0=(~PORTB);
			if(b_0==b_1){
				if(b_1==b_2){
					b_cur=b_0;
				}else{
					b_2=b_1;
				}
			}else{
				b_1=b_0;
			}
		}	
	}
}

unsigned char read_analog(unsigned char ch){
	ADCON0=0b10000001|(ch<<2);
	__delay_us(20);
	ADCON0=0b10000011|(ch<<2);
	while(ADCON0&0x02);
	ad_0[ch]=ADRESH;
	if(ad_0[ch]==ad_1[ch]){
		if(ad_1[ch]==ad_2[ch]){
			ad_rtn[ch]=ad_0[ch];
		}else{
			ad_2[ch]=ad_1[ch];
		}
	}else{
		ad_1[ch]=ad_0[ch];
	}
	return ad_rtn[ch];
}

void set_duty(unsigned char duty){
        CCPR1L=((long)duty*(long)(pr2_data+1))>>8;
}

unsigned int div_cut(unsigned int divided,unsigned int by){
        quotient=0;
        remainder=divided;
        while(remainder>=by){
                quotient++;
                remainder-=by;
        }
        return quotient;
}