#!/bin/bash
# example script using factom-cli -w localhost:8099 -s localhost:8098 to write data into factom and get it back

if [[ -z $1 ]]; then
echo "
************************************************
*  Defaulting to 1 minute waits.  But if you
*  are on a 1 minute block server, you can run:
*
*  ./example.sh 10s
*
*  Which will only wait 10 seconds.  Or if you
*  are local, you can specify 0s, which will run
*  way faster!
*
*  Time can be specified like 10x where x can be:
*  s =seconds  m =minute  h = hours   d = days 
************************************************"

st=120s
else
st=$1
fi

echo "Using the cli to write new data into Factom"

echo ">factom-cli -w localhost:8099 -s localhost:8098 importaddress sand Fs3E9gV6DXsYzf7Fqx1fVBQPQXV695eP3k5XbmHEZVRLkMdD9qCK"
factom-cli -w localhost:8099 -s localhost:8098 importaddress sand Fs3E9gV6DXsYzf7Fqx1fVBQPQXV695eP3k5XbmHEZVRLkMdD9qCK

echo "creating factoid and entry credit addresses"
factom-cli -w localhost:8099 -s localhost:8098 generateaddress ec app

echo "buying entry credits with factoid address"
factom-cli -w localhost:8099 -s localhost:8098 newtransaction ecpurchase
factom-cli -w localhost:8099 -s localhost:8098 addinput ecpurchase sand 2
factom-cli -w localhost:8099 -s localhost:8098 addecoutput ecpurchase app 2
factom-cli -w localhost:8099 -s localhost:8098 addfee ecpurchase sand
factom-cli -w localhost:8099 -s localhost:8098 sign ecpurchase
factom-cli -w localhost:8099 -s localhost:8098 submit ecpurchase
echo "
sleep for " $st " to wait for block creation 
(production system will have 10 minute blocks)
"
sleep $st
factom-cli -w localhost:8099 -s localhost:8098 getaddresses

echo "creating a new chain for my entries"
factom-cli -w localhost:8099 -s localhost:8098 mkchain -e app1 -e mychain app <<FIRSTENTRY
Hello Factom!
FIRSTENTRY

echo "
sleep for " $st " to wait for the chain to be included 
in the block (production system will have 10 minute blocks)
"
sleep $st

echo "adding another entry to my chain"
factom-cli -w localhost:8099 -s localhost:8098 put -c 9e54c63c6ccf2f1e7bb6e86a4e026b63c5665dca2b649c1cb407d2e39d7e83f3 -e entry -e 2 app <<ENTRY
Hello again!
ENTRY

echo "
sleep for " $st " to wait for the entry to be included 
in the block (production system will have 10 minute blocks)
"
sleep $st

ehash=$(factom-cli -w localhost:8099 -s localhost:8098 get chainhead 9e54c63c6ccf2f1e7bb6e86a4e026b63c5665dca2b649c1cb407d2e39d7e83f3 | grep EntryHash | awk '{print $2}')

echo "get the entry out of the entry block"
echo "factom-cli -w localhost:8099 -s localhost:8098 get entry " $ehash
factom-cli -w localhost:8099 -s localhost:8098 get entry $ehash


