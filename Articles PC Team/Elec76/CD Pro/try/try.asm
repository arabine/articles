	include	<p16f84a.inc>

CSTE 	EQU     0x04	; Sens moteur droit RB4
	org	00h		 
	goto	START
	org	05h

START:
	; init du PORTA
	bcf     STATUS, RP0	; Select Bank 0
	clrf    PORTA
	bsf     STATUS, RP0	; Select Bank 1
	movlw   CSTE		; 0 = sortie, 1 = entr�e
    	movwf   TRISA
	bcf     STATUS, RP0 	; Select Bank 0

FIN:	goto	FIN
	end
