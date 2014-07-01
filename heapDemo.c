/*
 * Demostração HEAP overflow 
 * link: http://chmodsecurity.com.br/artigo/13/heap-overflow-na-pratica-0x05
 * código feito por diego(f0x) com intuito de ajudar na compreenção da falha
 * heap overflow onde os dados da varivável 'nome' invadi o espaço da outra 'command'
*/
#include <stdio.h>
#include <stdlib.h>

main (){
     
     static char name[20]; 
     static char command[50];
     
     printf ("Endereco fisico de name   : %d\n", name);
     printf ("Endereco fisico de command: %d\n", command);
      
     puts (""); // To skip a line

     sprintf (command, "echo Bem vindo a %s!", "Matrix"); 
     puts ("\nMe diga seu nome:");
     gets (name);
     
     system (command);
}
