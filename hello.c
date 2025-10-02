#include <stdio.h>
#include <stdint.h>



int main(int argc, char *argv[])
{
    if(argc==2)
    {
	printf("hello %s \n",argv[1]);
    }

    printf("hello git world \n");
    
    for(uint8_t i=0;i<4;i++)
    {
	    printf("hello linux \n");
    }

    return 0;


}
