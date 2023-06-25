function Get-ValueFromNestedObject {
    param (
        [Parameter(Mandatory=$true)]
        [Object]$Object,

        [Parameter(Mandatory=$true)]
        [String]$Key
    )

    $keys = $Key -split '/'
    $value = $Object

    foreach ($k in $keys) {
        if ($value -is [System.Collections.IDictionary] -and $value.ContainsKey($k)) {
            $value = $value[$k]
        }
        else {
            Write-Host "Nested object does not contain key $key"
            return $null
        }
    }
    return $value
}


$object1 = @{ "a" = @{ "b" = @{ "c" = "d" } } }
$key1 = "a/b/c"
Get-ValueFromNestedObject -Object $object1 -Key $key1


$object2 = @{ "x" = @{ "y" = @{ "z" = "a" } } }
$key2 = "x/y/z"
Get-ValueFromNestedObject -Object $object2 -Key $key2

$object3 = @{ "x" = @{ "y" = @{ "z" = "a" } } }
$key3 = "a/b/c"
Get-ValueFromNestedObject -Object $object3 -Key $key3

$object4 = @{ "x" = @{ "y" = @{ "z" = "a" } } }
$key4 = "x/y/z/a"
Get-ValueFromNestedObject -Object $object4 -Key $key4

$object5 = @{ "x" = @{ "y" = @{ "z" = "a" } } }
$key5 = "x"
Get-ValueFromNestedObject -Object $object5 -Key $key5
