#!/usr/bin/env python

import logging, sys, SocketServer

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', stream=sys.stdout)

class SyslogUDPHandler(SocketServer.BaseRequestHandler):
   def handle(self):
       data = bytes.decode(self.request[0].strip())
       socket = self.request[1]
       logging.info(str(data))

if __name__ == "__main__":
   logging.info("Starting...")
   try:
      server = SocketServer.UDPServer(('127.0.0.1',514), SyslogUDPHandler)
      server.serve_forever(poll_interval=0.5)
   except (IOError, SystemExit):
      raise
