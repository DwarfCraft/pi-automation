#!/usr/bin/python
import socket
from datetime import datetime
import time

remote_host = ["10.0.0.14"]
while(True):
    for host in remote_host:
        for remote_port in [24642]:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(2)
            now = datetime.now()
            try:
                sock.connect((host, remote_port))
            except Exception as e:
                print(str(now) + " checking host: " + str(host) + " on port: " + str(remote_port) + " closed ***")
            else:
                print(str(now) + " checking host: " + str(host) + " on port: " + str(remote_port) + " open ")
            sock.close()
        time.sleep(.05)
