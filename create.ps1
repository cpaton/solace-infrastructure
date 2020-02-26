function CreateContainer()
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]
        $Instance
    )

    $cmd = @"
docker container run ``
--detach ``
--mount type=volume,source=solace-$($Instance)-var,target=/usr/sw/var ``
--expose 8080 ``
--expose 55555 ``
--expose 22 ``
--expose 2222 ``
--expose 55556 ``
--expose 55003 ``
--expose 32768-61000 ``
--publish 808$($Instance):8080 ``
--publish 5000$($Instance):55555 ``
--publish 220$($Instance):22 ``
--publish 222$($Instance):2222 ``
--shm-size=2g ``
--ulimit core=-1 ``
--ulimit memlock=-1 ``
--memory-swap=-1 ``
--restart=unless-stopped ``
--env username_admin_globalaccesslevel=admin ``
--env username_admin_password=admin ``
--env 'logging/command/output=all' ``
--env 'logging/command/format=legacy' ``
--env 'logging/event/output=all' ``
--env 'logging/event/format=legacy' ``
--env 'logging/debug/output=all' ``
--env 'logging/debug/format=legacy' ``
--env 'routername=solace-$Instance' ``
--env 'system/scaling/maxconnectioncount=1000' ``
--env 'nodetype=message_routing' ``
--env TZ=UTC ``
--hostname=solace-$Instance ``
--name=solace-$Instance ``
solace-pubsub-standard:9.4.0.78
"@

    Write-Host $cmd
    Invoke-Expression $cmd
}

CreateContainer 1
CreateContainer 2