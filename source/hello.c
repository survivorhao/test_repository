#include <stdio.h>
#include <stdint.h>
#include "fun.h"

void specific_main_branch_have(void)
{
    printf("this is only main branch have \n");


}

int main(int argc, char *argv[])
{
    if(argc==2)
    {
	printf("hello %s \n",argv[1]);
    }
    specific_main_branch_have();
    
    func1();
    func2();
    user_hhhao_hao_edit();

    
    return 0;


}
