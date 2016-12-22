#include <pc.h>
#include <string.h>
#include <time.h>

/* Une série de définitions pour simplifier la programmation */
#define DATA 0x378	 /* Changer l'adresse du port ici */
#define STATUS DATA+1
#define CONTROL DATA+2
#define SET_E outportb(CONTROL,inportb(CONTROL) & 0xFE) /* E=1 (Strobe) */
#define RAZ_E outportb(CONTROL,inportb(CONTROL) | 0x01) /* E=0 (Strobe) */
#define SET_RS outportb(CONTROL, inportb(CONTROL) & 0xF7) /* RS=1, la donnée est un caractère */
#define RAZ_RS outportb(CONTROL, inportb(CONTROL) | 0x08) /* RS=0, la donnée est une instruction */

void Init_LCD (void)
{
	char Init[3],i;
 	Init[0] = 0x0D; /* Initialisation de l'affichage */
 	Init[1] = 0x38; /* 2 lignes, communication sur 8 bits */
 	Init[2] = 0x01; /* Efface l'écran */

 	outportb(CONTROL, inportb(CONTROL) & 0xDF); /* On place le port parallèle en sortie */
 	RAZ_RS;
	
 	for(i=0;i<=2;i++)
  	{
   		outportb(DATA, Init[i]); /* On place la donnée sur le bus */
   		SET_E;
   		delay(20); /* Délais de 20 ms */
   		RAZ_E;
   		delay(20);
  	}
 	SET_RS;
}

void Efface_LCD (void)
{
	RAZ_RS;
	outportb(DATA, 0x01); /* On place l'instruction d'effacement sur le bus */
	SET_E;
   	delay(20);
   	RAZ_E;
   	delay(20);
   	SET_RS;
}

void Ecrire_LCD (char *Chaine, char Position)
{
	int i,Taille;
	Taille=strlen(Chaine);
	RAZ_RS;
	outportb(DATA, 0x80+Position); /* Adresse d'écriture */
	SET_E;
   	delay(20);
   	RAZ_E;
   	delay(20);
   	SET_RS;
 	for(i=0;i<Taille;i++)
  	{
   		outportb(DATA, Chaine[i]); /* On place la donnée sur le bus */
   		SET_E;
   		delay(2);
   		RAZ_E;
   		delay(2);
   	}
}