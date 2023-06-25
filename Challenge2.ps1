param (
    [string]$endpoint = "/metadata/instance"
)

$ImdsServer = "http://169.254.169.254"
$InstanceEndpoint = $ImdsServer + $endpoint

function Query-InstanceEndpoint
{
    $uri = $InstanceEndpoint + "?api-version=2021-02-01"
    $result = Invoke-RestMethod -Method GET -NoProxy -Uri $uri -Headers @{"Metadata"="True"}
    return $result
}

# Make Instance call and print the response
$result = Query-InstanceEndpoint
$result | ConvertTo-JSON -Depth 99