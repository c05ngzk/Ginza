opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F886
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 10 "D:\Ginza\Ginza.c"
	psect config,class=CONFIG,delta=2 ;#
# 10 "D:\Ginza\Ginza.c"
	dw 0x2BC4 ;#
# 11 "D:\Ginza\Ginza.c"
	psect config,class=CONFIG,delta=2 ;#
# 11 "D:\Ginza\Ginza.c"
	dw 0x3FFF ;#
	FNROOT	_main
	FNCALL	intlevel1,_elapse
	global	intlevel1
	FNROOT	intlevel1
	global	_ad_0
	global	_ad_1
	global	_ad_2
	global	_ad_rtn
	global	_chime_time
	global	_quotient
	global	_b_0
	global	_b_1
	global	_b_2
	global	_b_cur
	global	_key_count
	global	_time
	global	_remainder
	global	_chime_type
	global	_direction
	global	_door_on
	global	_led_on
	global	_b_ok
psect	nvBANK0,class=BANK0,space=1
global __pnvBANK0
__pnvBANK0:
_b_ok:
       ds      1

	global	_pr2_data
_pr2_data:
       ds      1

	global	_sta_num
_sta_num:
       ds      1

	global	_timercount
_timercount:
       ds      1

	global	_at_sta
psect	bitnvCOMMON,class=COMMON,bit,space=1
global __pbitnvCOMMON
__pbitnvCOMMON:
_at_sta:
       ds      1

	global	_initialize
_initialize:
       ds      1

	global	_ADCON0
_ADCON0	set	31
	global	_ADRESH
_ADRESH	set	30
	global	_CCP1CON
_CCP1CON	set	23
	global	_CCPR1L
_CCPR1L	set	21
	global	_PORTA
_PORTA	set	5
	global	_PORTB
_PORTB	set	6
	global	_PORTC
_PORTC	set	7
	global	_T2CON
_T2CON	set	18
	global	_TMR0
_TMR0	set	1
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_PEIE
_PEIE	set	94
	global	_RA5
_RA5	set	45
	global	_RB6
_RB6	set	54
	global	_RB7
_RB7	set	55
	global	_RC0
_RC0	set	56
	global	_RC3
_RC3	set	59
	global	_RC4
_RC4	set	60
	global	_RC5
_RC5	set	61
	global	_T0IE
_T0IE	set	93
	global	_T0IF
_T0IF	set	90
	global	_T1CKPS0
_T1CKPS0	set	132
	global	_T1CKPS1
_T1CKPS1	set	133
	global	_TMR1IF
_TMR1IF	set	96
	global	_TMR1ON
_TMR1ON	set	128
	global	_ADCON1
_ADCON1	set	159
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_OSCCON
_OSCCON	set	143
	global	_PR2
_PR2	set	146
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	global	_TRISC
_TRISC	set	135
	global	_WPUB
_WPUB	set	149
	global	_TMR1IE
_TMR1IE	set	1120
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_ANSEL
_ANSEL	set	392
	global	_ANSELH
_ANSELH	set	393
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
	file	"Ginza.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bitbssCOMMON,class=COMMON,bit,space=1
global __pbitbssCOMMON
__pbitbssCOMMON:
_chime_type:
       ds      1

_direction:
       ds      1

_door_on:
       ds      1

_led_on:
       ds      1

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_remainder:
       ds      2

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_ad_0:
       ds      5

_ad_1:
       ds      5

_ad_2:
       ds      5

_ad_rtn:
       ds      5

_chime_time:
       ds      2

_quotient:
       ds      2

_b_0:
       ds      1

_b_1:
       ds      1

_b_2:
       ds      1

_b_cur:
       ds      1

_key_count:
       ds      1

_time:
       ds      1

psect clrtext,class=CODE,delta=2
global clear_ram
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram:
	clrwdt			;clear the watchdog before getting into this loop
clrloop:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop		;do the next byte

; Clear objects allocated to BITCOMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbitbssCOMMON/8)+0)&07Fh
; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+01Eh)
	fcall	clear_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_elapse
?_elapse:	; 0 bytes @ 0x0
	global	??_elapse
??_elapse:	; 0 bytes @ 0x0
	ds	10
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	_elapse$1730
_elapse$1730:	; 2 bytes @ 0x0
	ds	2
	global	_elapse$1731
_elapse$1731:	; 2 bytes @ 0x2
	ds	2
	global	_elapse$1732
_elapse$1732:	; 2 bytes @ 0x4
	ds	2
	global	_elapse$1733
_elapse$1733:	; 2 bytes @ 0x6
	ds	2
	global	_elapse$1734
_elapse$1734:	; 2 bytes @ 0x8
	ds	2
	global	_elapse$1728
_elapse$1728:	; 1 bytes @ 0xA
	ds	1
	global	elapse@i
elapse@i:	; 1 bytes @ 0xB
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0xC
	ds	2
	global	main@i
main@i:	; 1 bytes @ 0xE
	ds	1
	global	main@i_1725
main@i_1725:	; 1 bytes @ 0xF
	ds	1
;;Data sizes: Strings 0, constant 0, data 0, bss 32, persistent 4 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14     10      14
;; BANK0           80     16      50
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:



;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _elapse in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _elapse in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _elapse in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _elapse in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _elapse in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 2, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 4     4      0     202
;;                                             12 BANK0      4     4      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 0
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (1) _elapse                                              22    22      0     234
;;                                              0 COMMON    10    10      0
;;                                              0 BANK0     12    12      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 1
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;
;; _elapse (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       2       0       14.3%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      A       E       1      100.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       0       2        0.0%
;;ABS                  0      0      40       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50     10      32       5       62.5%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0      40      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 52 in file "D:\Ginza\Ginza.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               1   15[BANK0 ] unsigned char 
;;  i               1   14[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       4       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\Ginza\Ginza.c"
	line	52
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 7
; Regs used in _main: [wreg-fsr0h+status,2+status,0]
	line	53
	
l3706:	
;Ginza.c: 53: OSCCON=0x61;
	movlw	(061h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(143)^080h	;volatile
	line	54
;Ginza.c: 54: OPTION_REG=0b0101;
	movlw	(05h)
	movwf	(129)^080h	;volatile
	line	55
;Ginza.c: 55: WPUB=0b00111111;
	movlw	(03Fh)
	movwf	(149)^080h	;volatile
	line	56
	
l3708:	
;Ginza.c: 56: TRISA=0;
	clrf	(133)^080h	;volatile
	line	57
	
l3710:	
;Ginza.c: 57: TRISB=0b00111111;
	movlw	(03Fh)
	movwf	(134)^080h	;volatile
	line	58
;Ginza.c: 58: TRISC=0;
	clrf	(135)^080h	;volatile
	line	59
;Ginza.c: 59: PORTA=0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	60
;Ginza.c: 60: PORTB=0;
	clrf	(6)	;volatile
	line	61
;Ginza.c: 61: PORTC=0;
	clrf	(7)	;volatile
	line	62
;Ginza.c: 62: ADCON1=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(159)^080h	;volatile
	line	63
;Ginza.c: 63: ANSELH=0;
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	clrf	(393)^0180h	;volatile
	line	64
;Ginza.c: 64: ANSEL=0;
	clrf	(392)^0180h	;volatile
	line	66
	
l3712:	
;Ginza.c: 66: RC5=1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(61/8),(61)&7
	line	67
	
l3714:	
;Ginza.c: 67: RC4=1;
	bsf	(60/8),(60)&7
	line	68
	
l3716:	
;Ginza.c: 68: RC0=1;
	bsf	(56/8),(56)&7
	line	69
	
l3718:	
;Ginza.c: 69: RC3=0;
	bcf	(59/8),(59)&7
	line	70
	
l3720:	
;Ginza.c: 70: door_on=0;
	bcf	(_door_on/8),(_door_on)&7
	line	72
	
l3722:	
;Ginza.c: 72: b_0=0;
	clrf	(_b_0)
	line	73
	
l3724:	
;Ginza.c: 73: b_1=0;
	clrf	(_b_1)
	line	74
	
l3726:	
;Ginza.c: 74: b_2=0;
	clrf	(_b_2)
	line	75
	
l3728:	
;Ginza.c: 75: b_cur=0;
	clrf	(_b_cur)
	line	76
	
l3730:	
;Ginza.c: 76: b_ok=255;
	movlw	(0FFh)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_b_ok)
	line	78
	
l3732:	
;Ginza.c: 78: CCP1CON=0x0c;
	movlw	(0Ch)
	movwf	(23)	;volatile
	line	79
	
l3734:	
;Ginza.c: 79: PR2=99;
	movlw	(063h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(146)^080h	;volatile
	line	80
	
l3736:	
;Ginza.c: 80: T2CON|=0x06;
	movlw	(06h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	iorwf	(18),f	;volatile
	line	81
	
l3738:	
;Ginza.c: 81: CCPR1L=0;
	clrf	(21)	;volatile
	line	83
	
l3740:	
;Ginza.c: 83: pr2_data=99;
	movlw	(063h)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_pr2_data)
	line	84
	
l3742:	
;Ginza.c: 84: time=0;
	clrf	(_time)
	line	86
	
l3744:	
;Ginza.c: 86: OPTION_REG=0b0101;
	movlw	(05h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	87
	
l3746:	
;Ginza.c: 87: TMR0=131;
	movlw	(083h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(1)	;volatile
	line	88
	
l3748:	
;Ginza.c: 88: T0IE=1;
	bsf	(93/8),(93)&7
	line	90
	
l3750:	
;Ginza.c: 90: T1CKPS1=1;
	bsf	(133/8),(133)&7
	line	91
	
l3752:	
;Ginza.c: 91: T1CKPS0=1;
	bsf	(132/8),(132)&7
	line	92
	
l3754:	
;Ginza.c: 92: TMR1ON=1;
	bsf	(128/8),(128)&7
	line	93
	
l3756:	
;Ginza.c: 93: TMR1IE=1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1120/8)^080h,(1120)&7
	line	94
	
l3758:	
;Ginza.c: 94: PEIE=1;
	bsf	(94/8),(94)&7
	line	95
	
l3760:	
;Ginza.c: 95: GIE=1;
	bsf	(95/8),(95)&7
	line	97
	
l3762:	
;Ginza.c: 97: initialize=1;
	bsf	(_initialize/8),(_initialize)&7
	line	99
	
l3764:	
;Ginza.c: 99: timercount=2;
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_timercount)
	line	101
	
l3766:	
;Ginza.c: 101: direction=0;
	bcf	(_direction/8),(_direction)&7
	line	102
;Ginza.c: 102: sta_num=1;
	clrf	(_sta_num)
	bsf	status,0
	rlf	(_sta_num),f
	line	103
	
l3768:	
;Ginza.c: 103: at_sta=1;
	bsf	(_at_sta/8),(_at_sta)&7
	line	105
	
l3770:	
;Ginza.c: 105: RB6=0;
	bcf	(54/8),(54)&7
	line	106
	
l3772:	
;Ginza.c: 106: for(unsigned char i=0;i<41;i++){
	clrf	(main@i)
	
l3774:	
	movlw	(029h)
	subwf	(main@i),w
	skipc
	goto	u3331
	goto	u3330
u3331:
	goto	l1015
u3330:
	goto	l1016
	
l3776:	
	goto	l1016
	
l1015:	
	line	107
;Ginza.c: 107: RB7=1;
	bsf	(55/8),(55)&7
	line	108
;Ginza.c: 108: RB7=0;
	bcf	(55/8),(55)&7
	line	106
	
l3778:	
	movlw	(01h)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	addwf	(main@i),f
	
l3780:	
	movlw	(029h)
	subwf	(main@i),w
	skipc
	goto	u3341
	goto	u3340
u3341:
	goto	l1015
u3340:
	
l1016:	
	line	110
;Ginza.c: 109: }
;Ginza.c: 110: RC5=0;
	bcf	(61/8),(61)&7
	line	111
;Ginza.c: 111: RC4=0;
	bcf	(60/8),(60)&7
	line	113
;Ginza.c: 113: chime_type=0;
	bcf	(_chime_type/8),(_chime_type)&7
	line	114
	
l3782:	
;Ginza.c: 114: chime_time=277;
	movlw	low(0115h)
	movwf	(_chime_time)
	movlw	high(0115h)
	movwf	((_chime_time))+1
	goto	l3784
	line	116
;Ginza.c: 116: while(1){
	
l1017:	
	line	117
	
l3784:	
;Ginza.c: 117: for(unsigned char i=0;i<6;i++){
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(main@i_1725)
	movlw	(06h)
	subwf	(main@i_1725),w
	skipc
	goto	u3351
	goto	u3350
u3351:
	goto	l3788
u3350:
	goto	l3834
	
l3786:	
	goto	l3834
	
l1018:	
	line	118
	
l3788:	
;Ginza.c: 118: if(b_cur&((unsigned char)1<<i)&b_ok){
	movlw	(01h)
	movwf	(??_main+0)+0
	incf	(main@i_1725),w
	goto	u3364
u3365:
	clrc
	rlf	(??_main+0)+0,f
u3364:
	addlw	-1
	skipz
	goto	u3365
	movf	0+(??_main+0)+0,w
	andwf	(_b_cur),w
	andwf	(_b_ok),w
	btfsc	status,2
	goto	u3371
	goto	u3370
u3371:
	goto	l3828
u3370:
	line	119
	
l3790:	
;Ginza.c: 119: b_ok=b_ok&(~((unsigned char)1<<i));
	movlw	(01h)
	movwf	(??_main+0)+0
	incf	(main@i_1725),w
	goto	u3384
u3385:
	clrc
	rlf	(??_main+0)+0,f
u3384:
	addlw	-1
	skipz
	goto	u3385
	movf	0+(??_main+0)+0,w
	xorlw	0ffh
	andwf	(_b_ok),w
	movwf	(??_main+1)+0
	movf	(??_main+1)+0,w
	movwf	(_b_ok)
	line	120
;Ginza.c: 120: switch(i){
	goto	l3826
	line	121
;Ginza.c: 121: case 0:
	
l1022:	
	line	122
	
l3792:	
;Ginza.c: 122: door_on=!door_on;
	movlw	1<<((_door_on)&7)
	xorwf	((_door_on)/8),f
	line	123
;Ginza.c: 123: break;
	goto	l1040
	line	124
;Ginza.c: 124: case 1:
	
l1024:	
	line	126
;Ginza.c: 126: chime_type=0;
	bcf	(_chime_type/8),(_chime_type)&7
	line	127
	
l3794:	
;Ginza.c: 127: chime_time=0;
	clrf	(_chime_time)
	clrf	(_chime_time+1)
	line	128
;Ginza.c: 128: break;
	goto	l1040
	line	129
;Ginza.c: 129: case 2:
	
l1025:	
	line	131
;Ginza.c: 131: chime_type=1;
	bsf	(_chime_type/8),(_chime_type)&7
	line	132
	
l3796:	
;Ginza.c: 132: chime_time=0;
	clrf	(_chime_time)
	clrf	(_chime_time+1)
	line	133
;Ginza.c: 133: break;
	goto	l1040
	line	134
;Ginza.c: 134: case 4:
	
l1026:	
	line	135
	
l3798:	
;Ginza.c: 135: if((sta_num==1)||(sta_num==19)){at_sta=1;}
	movf	(_sta_num),w
	xorlw	01h
	skipnz
	goto	u3391
	goto	u3390
u3391:
	goto	l1029
u3390:
	
l3800:	
	movf	(_sta_num),w
	xorlw	013h
	skipz
	goto	u3401
	goto	u3400
u3401:
	goto	l3802
u3400:
	
l1029:	
	bsf	(_at_sta/8),(_at_sta)&7
	goto	l3802
	
l1027:	
	line	136
	
l3802:	
;Ginza.c: 136: direction=!direction;
	movlw	1<<((_direction)&7)
	xorwf	((_direction)/8),f
	line	137
;Ginza.c: 137: break;
	goto	l1040
	line	138
;Ginza.c: 138: case 3:
	
l1030:	
	line	139
	
l3804:	
;Ginza.c: 139: if(!((sta_num==19)&&at_sta)){
	movf	(_sta_num),w
	xorlw	013h
	skipz
	goto	u3411
	goto	u3410
u3411:
	goto	l3808
u3410:
	
l3806:	
	btfsc	(_at_sta/8),(_at_sta)&7
	goto	u3421
	goto	u3420
u3421:
	goto	l1040
u3420:
	goto	l3808
	
l1033:	
	line	140
	
l3808:	
;Ginza.c: 140: if(at_sta^direction){
	btfsc	(_direction/8),(_direction)&7
	goto	u3431
	goto	u3430
u3431:
	movlw	1
	goto	u3432
u3430:
	movlw	0
u3432:
	movwf	(??_main+0)+0
	btfsc	(_at_sta/8),(_at_sta)&7
	goto	u3441
	goto	u3440
u3441:
	movlw	1
	goto	u3442
u3440:
	movlw	0
u3442:
	xorwf	(??_main+0)+0,w
	skipnz
	goto	u3451
	goto	u3450
u3451:
	goto	l3812
u3450:
	line	141
	
l3810:	
;Ginza.c: 141: sta_num++;
	movlw	(01h)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	addwf	(_sta_num),f
	goto	l3812
	line	142
	
l1034:	
	line	143
	
l3812:	
;Ginza.c: 142: }
;Ginza.c: 143: at_sta=!at_sta;
	movlw	1<<((_at_sta)&7)
	xorwf	((_at_sta)/8),f
	goto	l1040
	line	144
	
l1031:	
	line	145
;Ginza.c: 144: }
;Ginza.c: 145: break;
	goto	l1040
	line	146
;Ginza.c: 146: case 5:
	
l1035:	
	line	147
	
l3814:	
;Ginza.c: 147: if(!((sta_num==1)&&at_sta)){
	movf	(_sta_num),w
	xorlw	01h
	skipz
	goto	u3461
	goto	u3460
u3461:
	goto	l3818
u3460:
	
l3816:	
	btfsc	(_at_sta/8),(_at_sta)&7
	goto	u3471
	goto	u3470
u3471:
	goto	l1040
u3470:
	goto	l3818
	
l1038:	
	line	148
	
l3818:	
;Ginza.c: 148: if(!(at_sta^direction)){
	btfsc	(_direction/8),(_direction)&7
	goto	u3481
	goto	u3480
u3481:
	movlw	1
	goto	u3482
u3480:
	movlw	0
u3482:
	movwf	(??_main+0)+0
	btfsc	(_at_sta/8),(_at_sta)&7
	goto	u3491
	goto	u3490
u3491:
	movlw	1
	goto	u3492
u3490:
	movlw	0
u3492:
	xorwf	(??_main+0)+0,w
	skipz
	goto	u3501
	goto	u3500
u3501:
	goto	l3822
u3500:
	line	149
	
l3820:	
;Ginza.c: 149: sta_num--;
	movlw	low(01h)
	subwf	(_sta_num),f
	goto	l3822
	line	150
	
l1039:	
	line	151
	
l3822:	
;Ginza.c: 150: }
;Ginza.c: 151: at_sta=!at_sta;
	movlw	1<<((_at_sta)&7)
	xorwf	((_at_sta)/8),f
	goto	l1040
	line	152
	
l1036:	
	line	153
;Ginza.c: 152: }
;Ginza.c: 153: break;
	goto	l1040
	line	172
	
l3824:	
;Ginza.c: 172: }
	goto	l1040
	line	120
	
l1021:	
	
l3826:	
	movf	(main@i_1725),w
	; Switch size 1, requested type "space"
; Number of cases is 6, Range of values is 0 to 5
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           19    10 (average)
; direct_byte           26     8 (fixed)
; jumptable            260     6 (fixed)
; rangetable            10     6 (fixed)
; spacedrange           18     9 (fixed)
; locatedrange           6     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l3792
	xorlw	1^0	; case 1
	skipnz
	goto	l1024
	xorlw	2^1	; case 2
	skipnz
	goto	l1025
	xorlw	3^2	; case 3
	skipnz
	goto	l3804
	xorlw	4^3	; case 4
	skipnz
	goto	l3798
	xorlw	5^4	; case 5
	skipnz
	goto	l3814
	goto	l1040
	opt asmopt_on

	line	172
	
l1023:	
	line	173
;Ginza.c: 173: }else{
	goto	l1040
	
l1020:	
	line	174
	
l3828:	
;Ginza.c: 174: if(!((b_cur|b_ok)&((unsigned char)1<<i))){
	movlw	(01h)
	movwf	(??_main+0)+0
	incf	(main@i_1725),w
	goto	u3514
u3515:
	clrc
	rlf	(??_main+0)+0,f
u3514:
	addlw	-1
	skipz
	goto	u3515
	movf	(_b_cur),w
	iorwf	(_b_ok),w
	andwf	0+(??_main+0)+0,w
	btfss	status,2
	goto	u3521
	goto	u3520
u3521:
	goto	l1040
u3520:
	line	175
	
l3830:	
;Ginza.c: 175: b_ok=b_ok|((unsigned char)1<<i);
	movlw	(01h)
	movwf	(??_main+0)+0
	incf	(main@i_1725),w
	goto	u3534
u3535:
	clrc
	rlf	(??_main+0)+0,f
u3534:
	addlw	-1
	skipz
	goto	u3535
	movf	0+(??_main+0)+0,w
	iorwf	(_b_ok),w
	movwf	(??_main+1)+0
	movf	(??_main+1)+0,w
	movwf	(_b_ok)
	goto	l1040
	line	176
	
l1041:	
	line	177
	
l1040:	
	line	117
	movlw	(01h)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	addwf	(main@i_1725),f
	
l3832:	
	movlw	(06h)
	subwf	(main@i_1725),w
	skipc
	goto	u3541
	goto	u3540
u3541:
	goto	l3788
u3540:
	goto	l3834
	
l1019:	
	line	179
	
l3834:	
;Ginza.c: 176: }
;Ginza.c: 177: }
;Ginza.c: 178: }
;Ginza.c: 179: _delay((unsigned long)((10)*(4000000/4000.0)));
	opt asmopt_off
movlw	13
movwf	((??_main+0)+0+1),f
	movlw	251
movwf	((??_main+0)+0),f
u3557:
	decfsz	((??_main+0)+0),f
	goto	u3557
	decfsz	((??_main+0)+0+1),f
	goto	u3557
	nop2
opt asmopt_on

	goto	l3784
	line	180
	
l1042:	
	line	116
	goto	l3784
	
l1043:	
	line	181
	
l1044:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_elapse
psect	text125,local,class=CODE,delta=2
global __ptext125
__ptext125:

;; *************** function _elapse *****************
;; Defined at:
;;		line 183 in file "D:\Ginza\Ginza.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               1   11[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0      12       0       0       0
;;      Temps:         10       0       0       0       0
;;      Totals:        10      12       0       0       0
;;Total ram usage:       22 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text125
	file	"D:\Ginza\Ginza.c"
	line	183
	global	__size_of_elapse
	__size_of_elapse	equ	__end_of_elapse-_elapse
	
_elapse:	
	opt	stack 7
; Regs used in _elapse: [wreg+status,2+status,0+btemp+1]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_elapse+6)
	movf	fsr0,w
	movwf	(??_elapse+7)
	movf	pclath,w
	movwf	(??_elapse+8)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_elapse+9)
	ljmp	_elapse
psect	text125
	line	184
	
i1l3560:	
;Ginza.c: 184: if(TMR1IF){
	btfss	(96/8),(96)&7
	goto	u286_21
	goto	u286_20
u286_21:
	goto	i1l1047
u286_20:
	line	185
	
i1l3562:	
;Ginza.c: 185: TMR1IF=0;
	bcf	(96/8),(96)&7
	line	186
	
i1l3564:	
;Ginza.c: 186: time++;
	movlw	(01h)
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	addwf	(_time),f
	line	187
	
i1l3566:	
;Ginza.c: 187: if(time>=2){time=0;}
	movlw	(02h)
	subwf	(_time),w
	skipc
	goto	u287_21
	goto	u287_20
u287_21:
	goto	i1l1048
u287_20:
	
i1l3568:	
	clrf	(_time)
	
i1l1048:	
	line	188
;Ginza.c: 188: led_on=time<1;
	movf	(_time)
	skipnz
	goto	u288_21
	goto	u288_20
	
u288_21:
	bsf	(_led_on/8),(_led_on)&7
	goto	u289_24
u288_20:
	bcf	(_led_on/8),(_led_on)&7
u289_24:
	line	189
;Ginza.c: 189: RA5=led_on&&door_on;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(_elapse$1728)
	btfss	(_led_on/8),(_led_on)&7
	goto	u290_21
	goto	u290_20
u290_21:
	goto	i1l3574
u290_20:
	
i1l3570:	
	btfss	(_door_on/8),(_door_on)&7
	goto	u291_21
	goto	u291_20
u291_21:
	goto	i1l3574
u291_20:
	
i1l3572:	
	clrf	(_elapse$1728)
	bsf	status,0
	rlf	(_elapse$1728),f
	goto	i1l3574
	
i1l1050:	
	
i1l3574:	
	movf	(_elapse$1728),w
	skipz
	bsf	(45/8),(45)&7
	skipnz
	bcf	(45/8),(45)&7
	line	190
	
i1l3576:	
;Ginza.c: 190: RC0=0;
	bcf	(56/8),(56)&7
	line	191
	
i1l3578:	
;Ginza.c: 191: for(unsigned char i=40;i>=1;i--){
	movlw	(028h)
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	movwf	(elapse@i)
	movf	(elapse@i),f
	skipz
	goto	u292_21
	goto	u292_20
u292_21:
	goto	i1l3582
u292_20:
	goto	i1l1052
	
i1l3580:	
	goto	i1l1052
	
i1l1051:	
	line	195
	
i1l3582:	
;Ginza.c: 195: if((((sta_num+1)<<1)==i)&&(at_sta||led_on)){
	movf	(_sta_num),w
	movwf	(??_elapse+0)+0
	clrf	(??_elapse+0)+0+1
	movlw	01h
	movwf	btemp+1
u293_25:
	clrc
	rlf	(??_elapse+0)+0,f
	rlf	(??_elapse+0)+1,f
	decfsz	btemp+1,f
	goto	u293_25
	movf	0+(??_elapse+0)+0,w
	addlw	low(02h)
	movwf	(??_elapse+2)+0
	movf	1+(??_elapse+0)+0,w
	skipnc
	addlw	1
	addlw	high(02h)
	movwf	1+(??_elapse+2)+0
	movf	(elapse@i),w
	xorwf	0+(??_elapse+2)+0,w
	iorwf	1+(??_elapse+2)+0,w
	skipz
	goto	u294_21
	goto	u294_20
u294_21:
	goto	i1l3588
u294_20:
	
i1l3584:	
	btfsc	(_at_sta/8),(_at_sta)&7
	goto	u295_21
	goto	u295_20
u295_21:
	goto	i1l1055
u295_20:
	
i1l3586:	
	btfss	(_led_on/8),(_led_on)&7
	goto	u296_21
	goto	u296_20
u296_21:
	goto	i1l3588
u296_20:
	
i1l1055:	
	line	196
;Ginza.c: 196: RB6=1;
	bsf	(54/8),(54)&7
	line	197
;Ginza.c: 197: }else if(((((sta_num+1)<<1)+((direction^at_sta)?1:-1))==i)&&((!at_sta)||led_on)){
	goto	i1l1056
	
i1l1053:	
	
i1l3588:	
	btfsc	(_at_sta/8),(_at_sta)&7
	goto	u297_21
	goto	u297_20
u297_21:
	movlw	1
	goto	u297_22
u297_20:
	movlw	0
u297_22:
	movwf	(??_elapse+0)+0
	btfsc	(_direction/8),(_direction)&7
	goto	u298_21
	goto	u298_20
u298_21:
	movlw	1
	goto	u298_22
u298_20:
	movlw	0
u298_22:
	xorwf	(??_elapse+0)+0,w
	skipz
	goto	u299_21
	goto	u299_20
u299_21:
	goto	i1l3592
u299_20:
	
i1l3590:	
	movlw	low(-1)
	movwf	(_elapse$1730)
	movlw	high(-1)
	movwf	((_elapse$1730))+1
	goto	i1l3594
	
i1l1059:	
	
i1l3592:	
	movlw	low(01h)
	movwf	(_elapse$1730)
	movlw	high(01h)
	movwf	((_elapse$1730))+1
	goto	i1l3594
	
i1l1061:	
	
i1l3594:	
	movf	(_sta_num),w
	movwf	(??_elapse+0)+0
	clrf	(??_elapse+0)+0+1
	movlw	01h
	movwf	btemp+1
u300_25:
	clrc
	rlf	(??_elapse+0)+0,f
	rlf	(??_elapse+0)+1,f
	decfsz	btemp+1,f
	goto	u300_25
	movf	(_elapse$1730),w
	addwf	0+(??_elapse+0)+0,w
	movwf	(??_elapse+2)+0
	movf	(_elapse$1730+1),w
	skipnc
	incf	(_elapse$1730+1),w
	addwf	1+(??_elapse+0)+0,w
	movwf	1+(??_elapse+2)+0
	movf	0+(??_elapse+2)+0,w
	addlw	low(02h)
	movwf	(??_elapse+4)+0
	movf	1+(??_elapse+2)+0,w
	skipnc
	addlw	1
	addlw	high(02h)
	movwf	1+(??_elapse+4)+0
	movf	(elapse@i),w
	xorwf	0+(??_elapse+4)+0,w
	iorwf	1+(??_elapse+4)+0,w
	skipz
	goto	u301_21
	goto	u301_20
u301_21:
	goto	i1l1057
u301_20:
	
i1l3596:	
	btfss	(_at_sta/8),(_at_sta)&7
	goto	u302_21
	goto	u302_20
u302_21:
	goto	i1l1063
u302_20:
	
i1l3598:	
	btfss	(_led_on/8),(_led_on)&7
	goto	u303_21
	goto	u303_20
u303_21:
	goto	i1l1057
u303_20:
	
i1l1063:	
	line	198
;Ginza.c: 198: RB6=1;
	bsf	(54/8),(54)&7
	line	199
;Ginza.c: 199: }else{
	goto	i1l1056
	
i1l1057:	
	line	200
;Ginza.c: 200: RB6=0;
	bcf	(54/8),(54)&7
	goto	i1l1056
	line	201
	
i1l1064:	
	
i1l1056:	
	line	202
;Ginza.c: 201: }
;Ginza.c: 202: RB7=1;
	bsf	(55/8),(55)&7
	line	203
;Ginza.c: 203: RB7=0;
	bcf	(55/8),(55)&7
	line	191
	
i1l3600:	
	movlw	low(01h)
	subwf	(elapse@i),f
	
i1l3602:	
	movf	(elapse@i),f
	skipz
	goto	u304_21
	goto	u304_20
u304_21:
	goto	i1l3582
u304_20:
	
i1l1052:	
	line	205
;Ginza.c: 204: }
;Ginza.c: 205: RB6=0;
	bcf	(54/8),(54)&7
	line	206
;Ginza.c: 206: if(direction){
	btfss	(_direction/8),(_direction)&7
	goto	u305_21
	goto	u305_20
u305_21:
	goto	i1l1065
u305_20:
	line	207
	
i1l3604:	
;Ginza.c: 207: RC5=0;
	bcf	(61/8),(61)&7
	line	208
;Ginza.c: 208: RC4=1;
	bsf	(60/8),(60)&7
	line	209
;Ginza.c: 209: }else{
	goto	i1l1066
	
i1l1065:	
	line	210
;Ginza.c: 210: RC5=1;
	bsf	(61/8),(61)&7
	line	211
;Ginza.c: 211: RC4=0;
	bcf	(60/8),(60)&7
	line	212
	
i1l1066:	
	line	213
;Ginza.c: 212: }
;Ginza.c: 213: RC0=1;
	bsf	(56/8),(56)&7
	line	214
	
i1l1047:	
	line	215
;Ginza.c: 214: }
;Ginza.c: 215: if(T0IF){
	btfss	(90/8),(90)&7
	goto	u306_21
	goto	u306_20
u306_21:
	goto	i1l1102
u306_20:
	line	217
	
i1l3606:	
;Ginza.c: 217: T0IF=0;
	bcf	(90/8),(90)&7
	line	218
;Ginza.c: 218: while(timercount--);
	goto	i1l3608
	
i1l1069:	
	goto	i1l3608
	
i1l1068:	
	
i1l3608:	
	movlw	low(01h)
	subwf	(_timercount),f
	movf	((_timercount)),w
	xorlw	0FFh
	skipz
	goto	u307_21
	goto	u307_20
u307_21:
	goto	i1l3608
u307_20:
	
i1l1070:	
	line	220
# 220 "D:\Ginza\Ginza.c"
  nop ;#
	line	221
# 221 "D:\Ginza\Ginza.c"
  nop ;#
	line	222
# 222 "D:\Ginza\Ginza.c"
  nop ;#
	line	223
# 223 "D:\Ginza\Ginza.c"
  nop ;#
psect	text125
	line	225
	
i1l3610:	
;Ginza.c: 225: timercount=2;
	movlw	(02h)
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(_timercount)
	line	226
;Ginza.c: 226: TMR0=132;
	movlw	(084h)
	movwf	(1)	;volatile
	line	229
;Ginza.c: 229: if(chime_time<277){
	movlw	high(0115h)
	subwf	(_chime_time+1),w
	movlw	low(0115h)
	skipnz
	subwf	(_chime_time),w
	skipnc
	goto	u308_21
	goto	u308_20
u308_21:
	goto	i1l3646
u308_20:
	line	230
	
i1l3612:	
;Ginza.c: 230: if((chime_time<40)||((chime_time>=184)&(chime_time<224))){
	movlw	high(028h)
	subwf	(_chime_time+1),w
	movlw	low(028h)
	skipnz
	subwf	(_chime_time),w
	skipc
	goto	u309_21
	goto	u309_20
u309_21:
	goto	i1l1074
u309_20:
	
i1l3614:	
	movlw	high(0B8h)
	subwf	(_chime_time+1),w
	movlw	low(0B8h)
	skipnz
	subwf	(_chime_time),w
	skipc
	goto	u310_21
	goto	u310_20
u310_21:
	goto	i1l3628
u310_20:
	
i1l3616:	
	movlw	high(0E0h)
	subwf	(_chime_time+1),w
	movlw	low(0E0h)
	skipnz
	subwf	(_chime_time),w
	skipnc
	goto	u311_21
	goto	u311_20
u311_21:
	goto	i1l3628
u311_20:
	
i1l1074:	
	line	231
;Ginza.c: 231: PR2=chime_type?105:112;
	btfsc	(_chime_type/8),(_chime_type)&7
	goto	u312_21
	goto	u312_20
u312_21:
	goto	i1l3620
u312_20:
	
i1l3618:	
	movlw	low(070h)
	movwf	(_elapse$1731)
	movlw	high(070h)
	movwf	((_elapse$1731))+1
	goto	i1l1078
	
i1l1076:	
	
i1l3620:	
	movlw	low(069h)
	movwf	(_elapse$1731)
	movlw	high(069h)
	movwf	((_elapse$1731))+1
	
i1l1078:	
	movf	(_elapse$1731),w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(146)^080h	;volatile
	line	232
	
i1l3622:	
;Ginza.c: 232: CCPR1L=chime_type?53:56;
	btfsc	(_chime_type/8),(_chime_type)&7
	goto	u313_21
	goto	u313_20
u313_21:
	goto	i1l3626
u313_20:
	
i1l3624:	
	movlw	low(038h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(_elapse$1732)
	movlw	high(038h)
	movwf	((_elapse$1732))+1
	goto	i1l1082
	
i1l1080:	
	
i1l3626:	
	movlw	low(035h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_elapse$1732)
	movlw	high(035h)
	movwf	((_elapse$1732))+1
	
i1l1082:	
	movf	(_elapse$1732),w
	movwf	(21)	;volatile
	line	233
;Ginza.c: 233: }else if((chime_time<93)||(chime_time>=224)){
	goto	i1l3644
	
i1l1072:	
	
i1l3628:	
	movlw	high(05Dh)
	subwf	(_chime_time+1),w
	movlw	low(05Dh)
	skipnz
	subwf	(_chime_time),w
	skipc
	goto	u314_21
	goto	u314_20
u314_21:
	goto	i1l1086
u314_20:
	
i1l3630:	
	movlw	high(0E0h)
	subwf	(_chime_time+1),w
	movlw	low(0E0h)
	skipnz
	subwf	(_chime_time),w
	skipc
	goto	u315_21
	goto	u315_20
u315_21:
	goto	i1l3642
u315_20:
	
i1l1086:	
	line	234
;Ginza.c: 234: PR2=chime_type?141:149;
	btfsc	(_chime_type/8),(_chime_type)&7
	goto	u316_21
	goto	u316_20
u316_21:
	goto	i1l3634
u316_20:
	
i1l3632:	
	movlw	low(095h)
	movwf	(_elapse$1733)
	movlw	high(095h)
	movwf	((_elapse$1733))+1
	goto	i1l1090
	
i1l1088:	
	
i1l3634:	
	movlw	low(08Dh)
	movwf	(_elapse$1733)
	movlw	high(08Dh)
	movwf	((_elapse$1733))+1
	
i1l1090:	
	movf	(_elapse$1733),w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(146)^080h	;volatile
	line	235
	
i1l3636:	
;Ginza.c: 235: CCPR1L=chime_type?71:75;
	btfsc	(_chime_type/8),(_chime_type)&7
	goto	u317_21
	goto	u317_20
u317_21:
	goto	i1l3640
u317_20:
	
i1l3638:	
	movlw	low(04Bh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(_elapse$1734)
	movlw	high(04Bh)
	movwf	((_elapse$1734))+1
	goto	i1l1094
	
i1l1092:	
	
i1l3640:	
	movlw	low(047h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_elapse$1734)
	movlw	high(047h)
	movwf	((_elapse$1734))+1
	
i1l1094:	
	movf	(_elapse$1734),w
	movwf	(21)	;volatile
	line	236
;Ginza.c: 236: }else{
	goto	i1l3644
	
i1l1084:	
	line	237
	
i1l3642:	
;Ginza.c: 237: CCPR1L=0;
	clrf	(21)	;volatile
	goto	i1l3644
	line	238
	
i1l1095:	
	goto	i1l3644
	
i1l1083:	
	line	239
	
i1l3644:	
;Ginza.c: 238: }
;Ginza.c: 239: chime_time++;
	movlw	low(01h)
	addwf	(_chime_time),f
	skipnc
	incf	(_chime_time+1),f
	movlw	high(01h)
	addwf	(_chime_time+1),f
	line	240
;Ginza.c: 240: }else{
	goto	i1l3648
	
i1l1071:	
	line	241
	
i1l3646:	
;Ginza.c: 241: CCPR1L=0;
	clrf	(21)	;volatile
	goto	i1l3648
	line	242
	
i1l1096:	
	line	244
	
i1l3648:	
;Ginza.c: 242: }
;Ginza.c: 244: key_count++;
	movlw	(01h)
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	addwf	(_key_count),f
	line	245
	
i1l3650:	
;Ginza.c: 245: if(key_count>=2){
	movlw	(02h)
	subwf	(_key_count),w
	skipc
	goto	u318_21
	goto	u318_20
u318_21:
	goto	i1l1102
u318_20:
	line	246
	
i1l3652:	
;Ginza.c: 246: key_count=0;
	clrf	(_key_count)
	line	247
	
i1l3654:	
;Ginza.c: 247: b_0=(~PORTB);
	comf	(6),w	;volatile
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	movwf	(_b_0)
	line	248
	
i1l3656:	
;Ginza.c: 248: if(b_0==b_1){
	movf	(_b_0),w
	xorwf	(_b_1),w
	skipz
	goto	u319_21
	goto	u319_20
u319_21:
	goto	i1l3664
u319_20:
	line	249
	
i1l3658:	
;Ginza.c: 249: if(b_1==b_2){
	movf	(_b_1),w
	xorwf	(_b_2),w
	skipz
	goto	u320_21
	goto	u320_20
u320_21:
	goto	i1l3662
u320_20:
	line	250
	
i1l3660:	
;Ginza.c: 250: b_cur=b_0;
	movf	(_b_0),w
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	movwf	(_b_cur)
	line	251
;Ginza.c: 251: }else{
	goto	i1l1102
	
i1l1099:	
	line	252
	
i1l3662:	
;Ginza.c: 252: b_2=b_1;
	movf	(_b_1),w
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	movwf	(_b_2)
	goto	i1l1102
	line	253
	
i1l1100:	
	line	254
;Ginza.c: 253: }
;Ginza.c: 254: }else{
	goto	i1l1102
	
i1l1098:	
	line	255
	
i1l3664:	
;Ginza.c: 255: b_1=b_0;
	movf	(_b_0),w
	movwf	(??_elapse+0)+0
	movf	(??_elapse+0)+0,w
	movwf	(_b_1)
	goto	i1l1102
	line	256
	
i1l1101:	
	goto	i1l1102
	line	257
	
i1l1097:	
	goto	i1l1102
	line	258
	
i1l1067:	
	line	259
	
i1l1102:	
	movf	(??_elapse+9),w
	movwf	btemp+1
	movf	(??_elapse+8),w
	movwf	pclath
	movf	(??_elapse+7),w
	movwf	fsr0
	swapf	(??_elapse+6)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_elapse
	__end_of_elapse:
;; =============== function _elapse ends ============

	signat	_elapse,88
psect	text126,local,class=CODE,delta=2
global __ptext126
__ptext126:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
