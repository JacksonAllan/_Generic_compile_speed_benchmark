Write-Output 'Outputting build times (best of five):'

$compileCommandLists = @{
  'gcc' = 'gcc _Generic.c -O1 -std=c11 -o temp/out', 'gcc _Generic.c -O3 -std=c11 -o temp/out'
  'clang' = 'clang _Generic.c -O1 -std=c11 -o temp/out', 'clang _Generic.c -O3 -std=c11 -o temp/out'
  'cl' = 'cl _Generic.c /Od /std:c11 /nologo /Fotemp\ /Fetemp\temp.exe', 'cl _Generic.c /O2 /std:c11 /nologo /Fotemp\ /Fetemp\temp.exe'
}

foreach( $arg in $args )
{
  $compileCommand = $compileCommandLists[ $arg ]

  if( -not $compileCommandLists.ContainsKey( $arg ) )
  {
    Write-Output "Unrecognized compiler ${arg}"
    exit
  }
}

if( -not( Test-Path 'temp' ) )
{
  New-Item -Path 'temp' -ItemType Directory | Out-Null
}

foreach( $arg in $args )
{
  foreach( $compileCommand in $compileCommandLists[ $arg ] )
  {
    $bestTime = [System.Double]::MaxValue

    for( $i = 0; $i -lt 5; $i++ )
    {
      $startTime = Get-Date
      Invoke-Expression( $compileCommand + ' 1>$null' )
      $endTime = Get-Date
      $elapsedTime = $endTime - $startTime
      if( $elapsedTime.TotalSeconds -lt $bestTime )
      {
        $bestTime = $elapsedTime.TotalSeconds
      }
    }

    Write-Output "  ${compileCommand}: $([math]::Round( $bestTime, 2 ))s"
  }
}

Remove-Item 'temp' -Recurse | Out-Null