# Initialisation du module & de l'environnement PowerCLI
If ( (Get-PSSnapin -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue) -eq $null )
    {
        Add-PSSnapin VMware.VimAutomation.Core
    }  
    
"C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1"





#========== On indique les librairies de gestion graphique ==========#
 
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

#====================================================================#


#==================== Création de la fenetre ========================#

$form = New-Object System.Windows.Forms.Form
#$form.Size = New-Object System.Drawing.Size(620,480)
$form.Text = "Deploiement VM" 
#$form.backcolor = "#EEC493"
$Image = [system.drawing.image]::FromFile("C:\Users\Aleveque\Desktop\app.jpg")
$form.BackgroundImage = $Image
$form.BackgroundImageLayout = "None"
    # None, Tile, Center, Stretch, Zoom 
$form.Width = $Image.Width
$form.Height = $Image.Height
$Icon = New-Object system.drawing.icon ("C:\Users\Aleveque\Desktop\icone.ico")
$Form.Icon = $Icon
 



 #Gestion des la font
 $Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::Bold)
 $Font1 = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
 # Font styles are: Regular, Bold, Italic, Underline, Strikeout
#====================================================================#


#======================= Informations & Connexion ===================#


# Titre de la zone "Connexion au serveur"
$textLabel0 = New-Object System.Windows.Forms.Label;
$textLabel0.Size = New-Object System.Drawing.Size(215,20);
$textLabel0.Location = New-Object System.Drawing.Point(25,60)
$textLabel0.Text = "Connexion au serveur"
$textLabel0.BackColor = "#BD2846"
$textLabel0.Font = $Font1

# Text Label Serveur
$textLabel1 = New-Object System.Windows.Forms.Label;
$textLabel1.Size = New-Object System.Drawing.Size(250,30);
$textLabel1.Location = New-Object System.Drawing.Point(20,90);
$textLabel1.Text = "Serveur";
$textLabel1.BackColor = "Transparent"
$textLabel1.Font = $Font
# Text box Serveur 
$txtbx1 = New-Object System.Windows.Forms.TextBox;
$txtbx1.Name = "Serveur";
$txtbx1.Size = New-Object System.Drawing.Size(100,40);
$txtbx1.TabIndex = 1;
$txtbx1.Location = New-Object System.Drawing.Point (80,90);


# Text Label Port
$textLabel2 = New-Object System.Windows.Forms.Label;
$textLabel2.Size = New-Object System.Drawing.Size(100,15);
$textLabel2.Location = New-Object System.Drawing.Point(280,90);
$textLabel2.Text = "Port";
$textLabel2.BackColor = "Transparent"
$textLabel2.Font = $Font
# Text box Port 
$txtbx2 = New-Object System.Windows.Forms.TextBox;
$txtbx2.Name = "Port";
$txtbx2.Size = New-Object System.Drawing.Size(100,40);
$txtbx2.TabIndex = 2;
$txtbx2.Location = New-Object System.Drawing.Point (340,90);


# Text Label utilisateur 
$textLabel3 = New-Object System.Windows.Forms.Label;
$textLabel3.Size = New-Object System.Drawing.Size(250,30);
$textLabel3.Location = New-Object System.Drawing.Point(20,125);
$textLabel3.Text = "User";
$textLabel3.BackColor = "Transparent"
$textLabel3.Font = $Font
# Text box utilisateur
$txtbx3 = New-Object System.Windows.Forms.TextBox;
$txtbx3.Name = "User";
$txtbx3.Size = New-Object System.Drawing.Size(100,30);
$txtbx3.TabIndex = 3;
$txtbx3.Location = New-Object System.Drawing.Point (80,120);


# Text Label mot de passe  
$textLabel4 = New-Object System.Windows.Forms.Label;
$textLabel4.Size = New-Object System.Drawing.Size(250,20);
$textLabel4.Location = New-Object System.Drawing.Point(280,125);
$textLabel4.Text = "Mdp";
$textLabel4.BackColor = "Transparent"
$textLabel4.Font = $Font
# Text box mot de passe 
$txtbx4 = New-Object System.Windows.Forms.MaskedTextBox;
$txtbx4.PasswordChar = '*';
$txtbx4.Name = "Mdp";
$txtbx4.Size = New-Object System.Drawing.Size(100,60);
$txtbx4.TabIndex = 4;
$txtbx4.Location = New-Object System.Drawing.Point (340,120);


# Bouton de connexion 
$btn2 = New-Object System.Windows.Forms.Button
$btn2.Name = "connect"
$btn2.Size = New-Object System.Drawing.Size(75,30)
$btn2.Text = "connect"
$btn2.TabIndex = 5
$btn2.Location = New-Object System.Drawing.Point(170,160)
$btn2.BackColor = "white"
$btn2.add_Click(
{
$srv = $txtbx1.Text
$prt = $txtbx2.Text
$ptc = "https" 
$usr = $txtbx3.Text
$mdp = $txtbx4.Text 


    
    try 
    {
        Connect-VIServer -Server $srv -Port $prt -Protocol $ptc -User $usr -Password $mdp  -ErrorAction Stop
    }
    catch 
    {   
    <#          
        $txtlabelverif1 = New-Object System.Windows.Forms.Label;
        $txtlabelverif1.Size = New-Object System.Drawing.Size(120,30);
        $txtlabelverif1.Location = New-Object System.Drawing.Point(400,140)
        $txtlabelverif1.Text = "Connexion non établie"
        $form.Controls.Add($txtlabelverif1)
    #>
    }           
    finally
    {   
        $txtlabelverif0 = New-Object System.Windows.Forms.Label;
        $txtlabelverif0.Size = New-Object System.Drawing.Size(120,30);
        $txtlabelverif0.Location = New-Object System.Drawing.Point(400,160)
        $txtlabelverif0.Text = "Connexion OK";
        $txtlabelverif0.Backcolor = "Green";
        $txtlabelverif0.Font = $Font
        $form.Controls.Add($txtlabelverif0);
    }
 })


# Bouton de deconnexion 
$btn3 = New-Object System.Windows.Forms.Button
$btn3.Name = "disconnect"
$btn3.Size = New-Object System.Drawing.Size(75,30)
$btn3.Text = "Disconnect"
$btn3.TabIndex = 6
$btn3.Location = New-Object System.Drawing.Point(290,160)
$btn3.BackColor = "white"
$btn3.add_Click(
{
$srv = $txtbx1.Text
Disconnect-VIServer -Server $srv 
})

#====================================================================#


#======================= Informations & Creation ===================#


# Titre de la zone "Création de la machine virtuelle"
$textLabel00 = New-Object System.Windows.Forms.Label;
$textLabel00.Size = New-Object System.Drawing.Size(300,20);
$textLabel00.Location = New-Object System.Drawing.Point(25,215)
$textLabel00.Text = "Création de la machine virtuelle"
$textLabel00.BackColor = "#BD2846"
$textLabel00.Font = $Font1


# Text Label Nom de la VM 
$textLabel5 = New-Object System.Windows.Forms.Label;
$textLabel5.Size = New-Object System.Drawing.Size(650,30);
$textLabel5.Location = New-Object System.Drawing.Point(25,260);
$textLabel5.Text = "Nom";
$textLabel5.BackColor = "Transparent"
$textLabel5.Font = $Font
# Text box Nom de la VM 
$txtbx5 = New-Object System.Windows.Forms.TextBox;
$txtbx5.Name = "Nom";
$txtbx5.Size = New-Object System.Drawing.Size(100,30);
$txtbx5.TabIndex = 7;
$txtbx5.Location = New-Object System.Drawing.Point (120,260);


# Text Label Choix du template 
$textLabel6 = New-Object System.Windows.Forms.Label;
$textLabel6.Size = New-Object System.Drawing.Size(80,30);
$textLabel6.Location = New-Object System.Drawing.Point(25,300);
$textLabel6.Text = "Template  ";
$textLabel6.BackColor = "Transparent"
$textLabel6.Font = $Font
#Liste déroulante choix du template
$lst1 = New-Object System.Windows.Forms.Combobox
$lst1.Location = New-Object Drawing.Point(120,300) 
$lst1.Size = New-Object System.Drawing.Size(100,60)
$lst1.DropDownStyle = "DropDownList"
$lst1.Items.AddRange(("","TP-2012R2-Std"))
$lst1.SelectedIndex = 0


#Progress bar
$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$progressBar1.Name = 'progressBar1'
$progressBar1.Value = 0
$progressBar1.Style="Continuous"
$progressBar1.Maximum = 100
$progressBar1.Minimum = 0
$progressBar1.Location = new-object System.Drawing.Size(30,400)
$progressBar1.size = new-object System.Drawing.Size(250,20)
$i = 0



# Bouton d'envoie de la commande 
$btn1 = New-Object System.Windows.Forms.Button
$btn1.Name = "send"
$btn1.Size = New-Object System.Drawing.Size(75,30)
$btn1.Text = "Créer"
$btn1.TabIndex = 8
$btn1.Location = New-Object System.Drawing.Point(85,350)
$btn1.BackColor = "white"
$btn1.add_Click({

    While ($i -le 100){
        $progressBar1.Status = $createvm
    
            $srv = $txtbx1.Text
            $hst = "192.168.1.242"
            $prt = $txtbx2.Text
            $vmname = $txtbx5.Text
            $template = $lst1.Text
           
            
$createvm = New-vm -vmhost $hst -Name $vmname -Template $template
$createvm
        $i
        $i += 1
        }
})



#====================================================================#
 
 
 
 # Affichage du label et de la textbox
$form.Controls.Add($txtbx1)
$form.Controls.Add($txtbx2)
$form.Controls.Add($txtbx3)
$form.Controls.Add($txtbx4)
$form.Controls.Add($txtbx5)
$form.Controls.Add($textLabel0)
$form.Controls.Add($textLabel00)
$form.Controls.Add($textLabel1)
$form.Controls.Add($textLabel2)
$form.Controls.Add($textLabel3)
$form.Controls.Add($textLabel4)
$form.Controls.Add($textLabel5)
$form.Controls.Add($textLabel6)
$form.Controls.Add($btn1)
$form.Controls.Add($btn2)
$form.Controls.Add($btn3)
$form.Controls.Add($lst1)
$form.Controls.Add($progressBar1)






#===================== Affichage de la fenetre ======================#

$form.ShowDialog()| Out-Null

#====================================================================#