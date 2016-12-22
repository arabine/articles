/*	Programme compilé avec DJGPP
	Selon le compilateur, outportb() peut se 
	trouver dans bios.h ou dos.h.
*/
	

#include <stdio.h>
#include <pc.h>		/* Fichier contenant la fonction outportb() */
#define DATA 0x378 	/* Adresse du bus de donnees */
#define CONTROL 0x37A	/* L'adresse du registre de contrôle */

void main(void)
{
	unsigned char Valeur;
	clrscr();
	printf("************************************************\n");
	printf("* Ecriture d'une valeur sur le bus de donnees\n");
	printf("*             du port parallele\n");
	printf("*        Pour PC Team - Decembre 2000 -\n");
	printf("* Anthony Rabine arabine@programmationworld.com\n");
	printf("************************************************\n\n\n");
	
	printf("Entrez la valeur a ecrire (0-255):");
	scanf("%d",&Valeur);
	
	outportb(CONTROL,0x00);	/* On configure le bus de donnees en sortie */
	outportb(DATA,Valeur);	/* Ecriture de la valeur dans le registre de donnees */
	
	printf("Ecriture de %d terminee\n",Valeur);
	exit(0);
}