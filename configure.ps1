[CmdletBinding()]
param(
    [Parameter()]
    [int]
    $Instance = $(1)
)

docker exec -it solace-$Instance mkdir /usr/sw/jail/cliscripts/sub
docker cp .\name solace-$($Instance):/usr/sw/jail/cliscripts
docker cp .\mnr solace-$($Instance):/usr/sw/jail/cliscripts/sub
docker cp .\config solace-$($Instance):/usr/sw/jail/cliscripts


# docker exec -it solace-1 /usr/sw/loads/currentload/bin/cli -A -e -p -s name
docker exec -it solace-$Instance /usr/sw/loads/currentload/bin/cli -A -e -p -s sub/mnr