/*
 * procura endereço da string na memoria usando getenv
 * 
*/
#include <cstdlib>
#include <cstdio>
#include <cstring>
 
int main(int argc, char **argv){
 
    char * ptr;
    if(argc < 3)
    {
        printf("Usar: %s <env var="" name=""> <target> program name>\n",argv[0]);
        return 1;
    }
    ptr = getenv(argv[1]);  // pega o endereço da variável
    ptr += strlen(argv[0]) - strlen(argv[2]); //ajustar diferentes em nomes
     
    printf("%s @: %p",argv[1], ptr); // %p mostra o endereço da variável
     
    return 0;
}
