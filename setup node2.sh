
echo ">factom-cli -w localhost:8099 -s localhost:8098 importaddress zeros Es2Rf7iM6PdsqfYCo3D1tnAR65SkLENyWJG1deUzpRMQmbh9F3eG"
factom-cli -w localhost:8099 -s localhost:8098 importaddress zeros Es2Rf7iM6PdsqfYCo3D1tnAR65SkLENyWJG1deUzpRMQmbh9F3eG

echo ">factom-cli -w localhost:8099 -s localhost:8098 importaddress sand Fs3E9gV6DXsYzf7Fqx1fVBQPQXV695eP3k5XbmHEZVRLkMdD9qCK"
factom-cli -w localhost:8099 -s localhost:8098 importaddress sand Fs3E9gV6DXsYzf7Fqx1fVBQPQXV695eP3k5XbmHEZVRLkMdD9qCK

echo ">factom-cli -w localhost:8099 -s localhost:8098 newtransaction trans1"
factom-cli -w localhost:8099 -s localhost:8098 newtransaction trans1

echo ">factom-cli -w localhost:8099 -s localhost:8098 addinput trans1 sand 10"
factom-cli -w localhost:8099 -s localhost:8098 addinput trans1 sand 10

echo ">factom-cli -w localhost:8099 -s localhost:8098 addecoutput trans1 zeros 10"
factom-cli -w localhost:8099 -s localhost:8098 addecoutput trans1 zeros 10

echo ">factom-cli -w localhost:8099 -s localhost:8098 addfee trans1 sand"
factom-cli -w localhost:8099 -s localhost:8098 addfee trans1 sand

echo ">factom-cli -w localhost:8099 -s localhost:8098 sign trans1"
factom-cli -w localhost:8099 -s localhost:8098 sign trans1

echo ">factom-cli -w localhost:8099 -s localhost:8098 transactions"
factom-cli -w localhost:8099 -s localhost:8098 transactions

echo ">factom-cli -w localhost:8099 -s localhost:8098 submit trans1"
factom-cli -w localhost:8099 -s localhost:8098 submit trans1


echo ">this may take a while, scanning the blockchain for balances"
echo ">factom-cli -w localhost:8099 -s localhost:8098 balances"
factom-cli -w localhost:8099 -s localhost:8098 balances
