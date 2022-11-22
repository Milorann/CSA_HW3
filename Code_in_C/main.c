#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

extern double tg(double x);
extern double generate();
extern double input(const char *inp);
extern void output(const char *outp, double xps, double x_precise, long t);

int main(int argc, char *argv[])
{
    if(argc != 5){
        printf("Wrong number of command line arguments. Termination.\n");
        exit(1);
    }
    int choice = atoi(argv[3]);
    double x = 0;
    if(choice == 1){
        x = input(argv[1]);
    }
    if(choice == 2){
        x = generate();
    }
    double ans = 0;
    time_t start = time(NULL);
    for(int i = 0; i < atoi(argv[4]); i++){
        ans = tg(x);
    }
    time_t end = time(NULL);
    output(argv[2], ans, tan(x), end-start);
    return 0;
}
