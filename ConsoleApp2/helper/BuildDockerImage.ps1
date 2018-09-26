$ImageName= "console-app-2"
$ImagePath = "C:\Users\itra\source\repos\DockerApplications\ConsoleApp2\"
$MSBuildPath = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe"
$ApplicationExePath = "C:\Users\itra\source\repos\DockerApplications\ConsoleApp2\ConsoleApp2.csproj"

function Invoke-MSBuild ([string]$MSBuildPath, [string]$MSBuildParameters) {
    Invoke-Expression "$MSBuildPath $MSBuildParameters"
}

function Invoke-Docker-Build ([string]$ImageName, [string]$ImagePath) {

    Invoke-Expression "docker build -t $ImageName . -f $ImagePath\Dockerfile.txt"
}

try {

    Write-Host "Building the project..."
    Write-Progress -Activity "Preparing the docker" -CurrentOperation "Building the project..." -PercentComplete 50.0
    Invoke-MSBuild -MSBuildPath $MSBuildPath -MSBuildParameters ($ApplicationExePath + " -p:OutputPath=.\publish -p:Configuration=Release")

	Write-Host ""
	Write-Host "Creating the docker image..."
	Write-Host ""
    Write-Progress -Activity "Preparing the docker" -CurrentOperation "Creating the docker image..." -PercentComplete 90.0
    Invoke-Docker-Build -ImageName $ImageName -ImagePath $ImagePath

    Write-Progress -Activity "Preparing the docker" -Completed
    Write-Host "Docker has been properly created." -ForegroundColor "Green"
	Write-Host ""
}

catch {

    Write-Error $_.Exception.Message
	Exit 1
}