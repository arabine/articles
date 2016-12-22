/*	Programme compilé avec DJGPP
	Selon le compilateur, inportb() et outportb peuvent se 
	trouver dans bios.h ou dos.h.
*/
	

#include <stdio.h>
#include <pc.h>		/* Fichier contenant la fonction inportb() */
#define DATA 0x378	/* Adresse du bus de donnees */
#define CONTROL 0x37A	/* L'adresse du registre de contrôle */

void main(void)
{
	unsigned char Valeur;
	clrscr();
	printf("************************************************\n");
	printf("* Lecture d'une valeur sur le bus de donnees\n");
	printf("*             du port parallele\n");
	printf("*        Pour PC Team - Decembre 2000 -\n");
	printf("* Anthony Rabine arabine@programmationworld.com\n");
	printf("************************************************\n\n\n");
	
	outportb(CONTROL,0x20);	/* Le bus de données est configuré en entrée */
	Valeur=inportb(DATA);	/* La valeur du bus de donnes est rengee dans la variable Valeur */
	
	printf("Valeur lue : %d\nTermine\n",Valeur);
	exit(0);
}