docker cp .\get-hostname solace-1:/usr/sw/jail/cliscripts
docker exec -it solace-1 /usr/sw/loads/currentload/bin/cli -A -e -p -s get-hostname