#article: http://chmodsecurity.com.br/artigo/16/tecnicas-avancadas-shellcoding-[assembly].html

xorl% eax,% eax #zera eax
xorl% ebx,% ebx #novamente
movb $ 0x17,% al #setuid(0) 
int $ 0x80 // sys call parceiro 
 
# Modo AutoBoot Megatron(de onde eu tirei isso kkk)
xorl% ebx,% ebx # 
leal 0x17 (% ebx),% al # forma Hitler kkk
int $ 0x80 # syscall
