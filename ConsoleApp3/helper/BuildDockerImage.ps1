$ImageName= "console-app-3"
$ImagePath = "C:\Users\itra\source\repos\DockerApplications\ConsoleApp3\"

function Invoke-Docker-Build ([string]$ImageName, [string]$ImagePath) {

    Invoke-Expression "docker build -t $ImageName . -f $ImagePath\Dockerfile.txt"
}

try {

	Write-Host "Creating the docker image..."
	Write-Host ""
    Write-Progress -Activity "Creating the docker image..."
    Invoke-Docker-Build -ImageName $ImageName -ImagePath $ImagePath
    
    Write-Progress -Activity "Creating the docker image..." -Completed
    Write-Host "Docker image has been properly created and all operations have been performed properly." -ForegroundColor "Green"
	Write-Host ""
}

catch {

    Write-Error $_.Exception.Message
	Exit 1
}