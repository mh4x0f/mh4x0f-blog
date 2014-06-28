#!/usr/bin/env python
# sniff http 
# link: http://chmodsecurity.com.br/artigo/7/scapy-manipulando-de-pacotes-na-rede-[python]
from scapy.all import *
from scapy.error import Scapy_Exception
 
m_iface="wlan0"
filter_message="http"
count=0
 
def pktTCP(pkt):
        global count
        if pkt.haslayer(TCP) and pkt.getlayer(TCP).dport == 80 and pkt.haslayer(Raw):
                count=count+1
                print pkt.getlayer(Raw).load
 
sniff(iface=m_iface,prn=pktTCP)
