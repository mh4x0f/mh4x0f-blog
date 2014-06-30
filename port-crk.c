/* Scanner porta com socket
 * link: http://chmodsecurity.com.br/artigo/10/escrevendo-um-scanner-port-em-c-0xc3
 * tutorial 
 * instrodução a socket em C 
 ***************************************************
/*

#include <stdio.h>

#include <netinet/in.h>

#include <sys/socket.h>

#define STARTPORT 1         /* começo da porta a se escaneada */

#define ENDPORT   1024      /* final da porta do renge*/

#define OPEN      1            /* define open 1 */

#define CLOSED    2            /* define fechado com 2 */

#define ERROR    -1  // -1 em caso de erro

int checkprt(int port, char *ip)

{

  int test = 0;

  int sockfd;

  struct sockaddr_in servaddr;

  sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if(sockfd < 0) {

      printf("error socket não foi criado\n");

      return ERROR;

    }

  servaddr.sin_family = AF_INET;

  servaddr.sin_addr.s_addr = inet_addr(ip);

  servaddr.sin_port = htons(port);

  test = connect(sockfd, (struct sockaddr_in *)&servaddr, sizeof(servaddr));

  if(test == -1){

    close(sockfd);

    return CLOSED;

  }

  close(sockfd);

  return OPEN;

}

int main(int argc, char **argv)

{

  int i;

  char *dest;

  if(argc != 2) {

    printf("[*] %s IP-alvo\n",argv[0]);

    return ERROR;

  }

  dest = argv[1];


  printf("\t-----------------------------------\n");

  printf("start scan :D %d até %d -> %s\n\n",STARTPORT, ENDPORT, argv[1]);

  for(i = STARTPORT; i <= ENDPORT; i++)

    if(checkprt(i,dest) == OPEN)

      printf("port %d está aberta brown\n",i);

  printf("scan terminado\n");

  return 0;

}
