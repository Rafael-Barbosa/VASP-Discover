#include<stdio.h>
#include<stdlib.h>
int main (int argc, char **argv)
{
	double x0,y0,z0;
	double x1,y1,z1;
	int nkpoints;
	int i;

if(argc != 8){
printf("digite:\n\n  %s 0.0 0.0 0.0 0.5 0.5 0.5 100 \n\nonde x_0, y_0 e z_0  são os  pontos iniciais e x_1, y_1, z_1 são os pontos finais e depois o número de pontos\n", argv[0]);
exit(0);
}

x0= atof(argv[1]);
y0= atof(argv[2]);
z0= atof(argv[3]);

x1= atof(argv[4]);
y1= atof(argv[5]);
z1= atof(argv[6]);

nkpoints= atof(argv[7]);

//	printf("Enter starting point :\n");
//	scanf("%f %f %f",&x0,&y0,&z0);
//   printf("Enter end point :\n");
//   scanf("%f %f %f",&x1,&y1,&z1);
//  printf("\nEnter number of kpoints :\n");
//  scanf("%d",&nkpoints);
	double spacing1,spacing2,spacing3;
	spacing1 = (x1-x0)/(nkpoints-1);
	spacing2 = (y1-y0)/(nkpoints-1);
	spacing3 = (z1-z0)/(nkpoints-1);

	for(i=0;i<nkpoints;i++)
	   {
	    printf("    %.14lf    %.14lf    %.14lf             0.0\n",x0+spacing1*i,y0+spacing2*i,z0+spacing3*i);
	   }
	return 0;
}
