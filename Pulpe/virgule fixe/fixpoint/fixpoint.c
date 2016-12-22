#include <stdio.h>
#include <math.h>

#define TOFIX(d, q) ((int)( (d)*(double)(1<<(q)) ))
#define TODBL(a, q) ( (double)(a)/(double)(1<<(q)) )

#define pi 3.14159265358979323846

/**
 * sinus est compris entre -1 et +1, on va le stocker en Q15 (arbitraire)
 */
void gen_sin_tab()
{
	FILE *out;
	int i;
	int nb_points=100;   // nombre de points à prendre dans le sinus

	out = fopen("sin_table.h", "wt");

	fprintf(out, "// Lookup-table de sinus en Q15\n");
	fprintf(out,"static int sin_table[] = {\n");


	for(i=0;i<nb_points;i++)
	{
		fprintf(out, "%d,", TOFIX(sin(i*2*pi/nb_points),15));
		if(!(i%10))
			fprintf(out,"\n");
	}

	fprintf(out,"};\n");
	fclose(out);
}


int main(void)
{

  double out;
  int r=6, p, fix_pi;

  // calcul du perimètre d'un cercle, p = 2*pi*r

  fix_pi = TOFIX(pi, 14);      // Q2.14... plus un bit de signe !
  p = fix_pi * 2;              // Q2.14 + Q2.14 = Q3.14 : possibilité d'overflow
  p = p * 6;              // Q3.14 * 6 = Q6.14 car maxi==6*7=42, tient sur 6 bits

  // a partir de la, on sait que l'on tient toujours sur 32 bits (6+14<32) 
  // donc c'est bon...
  out = TODBL(p, 14);   // pour verifier
  printf("%lf\n",out);  // en double
  printf("0x%X\n",p);   // en fixpoint... calculez, en placant la virgule en Q14


  gen_sin_tab();

  return 0;
}