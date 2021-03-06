/* Programme de gestion de LCD adapt� pour linux 
 compiler avec gcc -O2 pour les macros inb et outb */

#include <stdio.h>
#include <unistd.h>
#include <asm/io.h>

#define lpt_port 0x378	 /* Changer l'adresse du port ici */
#define STATUS lpt_port+1
#define CONTROL lpt_port+2

/* Une s�rie de d�finitions pour simplifier la programmation */
#define SET_E outb(inb(CONTROL) & 0xFE,CONTROL) /* E=1 (Strobe) */
#define RAZ_E outb(inb(CONTROL) | 0x01,CONTROL) /* E=0 (Strobe) */
#define SET_RS outb(inb(CONTROL) & 0xF7,CONTROL) /* RS=1, la donn�e est un caract�re */
#define RAZ_RS outb(inb(CONTROL) | 0x08,CONTROL) /* RS=0, la donn�e est une instruction */

void Init_LCD (void);
void Efface_LCD (void);
void Ecrire_LCD (char *Chaine, char Position);

/*
	Adresse du curseur (en hexad�cimal):
	
	digit  : 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16
	ligne 1: 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
	ligne 2: 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F
*/

int main(void)
{
  char *Phrase="Channel #pcteam",*Phrase2="C'est RuLeZ ! ;D"; /* Changer la phrase � �crire ici */

  if(ioperm(lpt_port,3,1))
  {
    perror("ioperm");
    exit(1);
  }
	Init_LCD();
	//clrscr();
	printf("*************************************************\n");
	printf("*      Programme de test d'un ecran LCD         *\n");
	printf("*              2 * 16 caracteres                *\n");
	printf("*        Pour PC Team 64 - Janvier 2001 -       *\n");
	printf("* Anthony Rabine arabine@programmationworld.com *\n");
	printf("*************************************************\n\n\n");
	Ecrire_LCD(Phrase,0x00);
	Ecrire_LCD(Phrase2,0x40);
	printf("Ecriture de \"%s\" terminee.\n",Phrase);
	printf("Ecriture de \"%s\" terminee.\n",Phrase2);
	printf("Appuyez sur une touche pour effacer l'ecran.\n");
	getchar();
	Efface_LCD();
	printf("L'ecran est efface.\n");
	return 0;
}

void Init_LCD (void)
{
  char Init[3],i;
  Init[0] = 0x0D; /* Initialisation de l'affichage */
  Init[1] = 0x38; /* 2 lignes, communication sur 8 bits */
  Init[2] = 0x01; /* Efface l'�cran */
  
  outb(inb(CONTROL) & 0xDF,CONTROL); /* On place le port parall�le en sortie */
  RAZ_RS;
  
  for(i=0;i<=2;i++)
  {
    outb(Init[i],lpt_port); /* On place la donn�e sur le bus */
    SET_E;
    usleep(20000); /* D�lais de 20 ms */
    RAZ_E;
    usleep(20000);
  }
  SET_RS;
}

void Efface_LCD (void)
{
 RAZ_RS;
 outb(0x01,lpt_port); /* On place l'instruction d'effacement sur le bus */
 SET_E;
 usleep(20000);
 RAZ_E;
 usleep(20000);
 SET_RS;
}

void Ecrire_LCD (char *Chaine, char Position)
{
  int i,Taille;
  Taille=strlen(Chaine);
  RAZ_RS;
  outb(0x80+Position,lpt_port); /* Adresse d'�criture */
  SET_E;
  usleep(20000);
  RAZ_E;
  usleep(20000);
  SET_RS;
  for(i=0;i<Taille;i++)
  {
   outb(Chaine[i],lpt_port); /* On place la donn�e sur le bus */
   SET_E;
   usleep(2000);
   RAZ_E;
   usleep(2000);
  }
}
