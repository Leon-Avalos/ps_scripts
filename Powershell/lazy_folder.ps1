

ForEach($database in Get-Content "databases.txt")
{
    mkdir $database
}