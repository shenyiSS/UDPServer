#!/usr/bin/python

from socket import *


HOST = '192.168.2.4'
PORT = 12345

s = socket(AF_INET, SOCK_DGRAM)
s.bind((HOST, PORT))
print 'Waiting...'

while True :
    data, address = s.recvfrom(1024)
#    print data.decode('utf-8')
    print data

s.close()
print 'over'
