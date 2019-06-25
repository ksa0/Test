
##than podo
$baererToken = "8179-2o0eYtYt2PvzkSIgOQ5w"
$yammerBaseUrl = "https://www.yammer.com/api/v1"
#$email = "ashok.m.mathew@sce.com"
$email = Read-Host -Prompt 'Enter Email Id'
$UserExists = $true;
Function Get-BaererToken() {
    $headers = @{ Authorization=("Bearer " + $baererToken) }
    return $headers
}
$headers = Get-BaererToken
$urlToCall = "$($yammerBaseUrl)/users/by_email.json?email=$($email)"
try{
$webRequest = Invoke-WebRequest -Uri $urlToCall -Method Get -Headers $headers
$user = $webRequest.Content | ConvertFrom-Json
Write-Host "User Id : " $user.Id;
Write-Host "User Email : " $user.email;
#$user | Select-Object id, email
}
catch {
     $geterrorValue= $_.Exception.Response.StatusCode.Value__     
	 $UserExists = $false;
     Write-Host $_.Exception.Response.StatusDescription -ForegroundColor Red        
        	 
	 }
if($UserExists){
$userId = $user.Id
$headers = Get-BaererToken
$urlToCall = "$($yammerBaseUrl)/users/$($userId)?delete=true"
try { 
$webRequest = Invoke-WebRequest -Uri $urlToCall -Method Delete -Headers $headers
Write-Host "Status Code : "$webRequest.StatusCode
if($webRequest.StatusCode -eq 200){
    Write-Host "User Deactivated Succesfully";
    }
}
catch {
      $_.Exception.Response.StatusCode.Value__
	  Write-Host $_.Exception.Response.StatusDescription -ForegroundColor Red
	  }
}
