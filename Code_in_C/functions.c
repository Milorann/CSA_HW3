#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

unsigned long long factorials[21] = {1, 1, 2, 6, 24, 120, 720, 5040, 40320, 
                362880, 3628800, 39916800, 479001600, 6227020800, 87178291200, 
                1307674368000, 20922789888000, 355687428096000, 
                6402373705728000, 121645100408832000, 2432902008176640000};
double bernulli[21] = {1, -1/2., 1/6., 0, -1/30., 0, 1/42., 0, -1/30., 0, 5/66.,
                0, -691/2730., 0, 7/6., 0, -3617/510., 0, 43867/798., 0, 
                -174611/330.};

double input(const char *inp){
    FILE *myfile;
    myfile = fopen(inp, "r");
    if (myfile == NULL) {
        printf("Cannot open file.\n");
        exit(1);
    }
    double x;
    fscanf(myfile, "%lf", &x);
    fclose(myfile);
    return x;
}

void output(const char *outp, double x, double ans_ps, double ans_precise, long t){
    FILE *myfile;
    myfile = fopen(outp, "w");
    fprintf(myfile, "Number: %lf\n", x);
    fprintf(myfile, "Power series answer: %lf\n", ans_ps);
    fprintf(myfile, "Precise answer: %lf\n", ans_precise);
    fprintf(myfile, "Time spent: %ld\n", t);
    fclose(myfile);
}

double tg(double x){
    double ans = 0;
    for(int i = 1; i < 11; i++){
        ans += bernulli[2 * i] * pow(-4, i) * (1 - pow(4, i)) /
            factorials[2 * i] * powl(x, 2 * i - 1);
    }
    return ans;
}

double generate(){
    srand(time(NULL));
    double x = -1.5707 + (rand() / (RAND_MAX / (1.5707 + 1.5707)));
    return x;
}
