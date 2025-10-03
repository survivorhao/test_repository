#include <stdio.h>
#include <stdint.h>
#include "fun.h"



int main(int argc, char *argv[])
{
    if(argc==2)
    {
	printf("hello %s \n",argv[1]);
    }
    func1();
    func2();

    return 0;


}
