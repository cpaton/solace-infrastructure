[CmdletBinding()]
param(
    [Parameter()]
    [int]
    $Instance = $(1)
)

if ($Instance -eq 1)
{
    $neighbourName = "solace-2"
    $neighbourIp = "172.17.0.3"

}
else
{
    $neighbourName = "solace-1"
    $neighbourIp = "172.17.0.2"
}

$scriptContent = @"
home
enable
configure
  routing
    mode multi-node-routing defer
    multi-node-routing
      create cspf neighbor $neighbourName
          ! 55555 is the default SMF port which is used if compression is off
          ! 55003 is the port if compression is being used
          connect-via $($neighbourIp):55555
          ! Default routing control port is 55556
          ! control-port 55556
          no compressed-data
          no ssl-data
          link-cost 100
          exit
        exit
      exit
    ! would also assign routing interfaces here
    interface intf0
    ! enable routing protocol
    no shutdown
    exit
  exit
reload
"@
$scriptFilePath = [IO.Path]::GetTempFileName()
Set-Content -Path $scriptFilePath -Value $scriptContent 

Write-Verbose $scriptContent

docker cp $scriptFilePath solace-$($Instance):/usr/sw/jail/cliscripts/configure
docker exec -it solace-$Instance /usr/sw/loads/currentload/bin/cli -A -e -p -s configure


# docker exec -it solace-$Instance mkdir /usr/sw/jail/cliscripts/sub
# docker cp .\name solace-$($Instance):/usr/sw/jail/cliscripts
# docker cp .\mnr solace-$($Instance):/usr/sw/jail/cliscripts/sub
# docker cp .\config solace-$($Instance):/usr/sw/jail/cliscripts


# docker exec -it solace-1 /usr/sw/loads/currentload/bin/cli -A -e -p -s name
# docker exec -it solace-$Instance /usr/sw/loads/currentload/bin/cli -A -e -p -s configure