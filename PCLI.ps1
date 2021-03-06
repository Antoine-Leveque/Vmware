# Initialisation du module & de l'environnement PowerCLI
    If ( (Get-PSSnapin -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue) -eq $null )
        {
            Add-PSSnapin VMware.VimAutomation.Core
        }  
    
        "C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1"
        
# Formulaire de connexion au serveur 
    $srv = Read-Host "Adresse IP ou nom DNS du serveur" 
    $prt = Read-Host "Port de connexion" 
    $usr = Read-Host "Utilisateur" 
    $mdp = Read-Host "Mot de passe" 
    $ptc = Read-Host "Protocole (HTTPS/HTTP)" 
    
# Connexion au serveur         
    Connect-VIServer -Server $srv -Port $prt -Protocol $ptc -User $usr -Password $mdp  
    
# Récupération des informations pour la création
    $vmname     = Read-Host "Entrer le nom de la machine"
    
# Liste des hôtes de virtualisation
    $vmhost = get-vmhost
    Write-Host "Hôtes disponibles :" $vmhost -foreground "Green"
    $vmhost = Read-Host "Entrer l'adresse de l'hôte"
    
# Liste des templates
    $vmtemplate = get-template
    Write-Host "Templates disponibles :"$vmtemplate -foreground "Green"
    $vmtemplate = Read-Host "Choisir le template"

# Liste des datastore
    $datastore = get-datastore
    Write-Host "Datastores disponibles :"$datastore -foreground "Green"
    $datastore  = Read-Host "Choisir un Datastore"

# Création de la machine virtuelle
    New-vm -vmhost $vmhost -datastore $datastore -Name $vmname -Template $vmtemplate
    Start-vm -VM $vmname

# Récupération de l'adresse IP de la machine virtuelle
    $vmguest = Get-vmguest $vmname 

# Attente de récupération de l'addresse IP 
    Start-Sleep -s 30          

# Affichage de l'adresse IP        
    Get-VM $vmname | Select Name, @{N="IP Address";E={@($_.guest.IPAddress[0])}} 


