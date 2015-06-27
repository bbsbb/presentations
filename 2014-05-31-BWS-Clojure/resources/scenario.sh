#!/bin/sh

#Deposit 100$
curl -H "Content-Type: application/json" -X POST -d'{"deposit":"100"}' -i http://localhost:3333/checking-account

#Withdraw 50, Process for 5 seconds
curl -H "Content-Type: application/json" -X POST -d'{"withdraw":"50", "delay": "5000"}' -i http://localhost:3333/checking-account &

#Withdraw 30, Process for 3 seconds
# This transaction will complete before the 5 second one, and the 5
# second one restarts.
curl -H "Content-Type: application/json" -X POST -d'{"withdraw":"30", "delay": "3000"}' -i http://localhost:3333/checking-account &

#Withdraw 30, Process for 3 seconds
#This transaction restarts TWICE and then gets declined as 80 has
#already been withdrawn
curl -H "Content-Type: application/json" -X POST -d'{"withdraw":"70", "delay": "7000"}' -i http://localhost:3333/checking-account &
