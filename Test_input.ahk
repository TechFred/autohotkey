Start: ; �tiquette pour red�marrer le script

; Cr�ation de la fen�tre GUI pour demander le d�lai et le texte
Gui, Add, Text,, Entrez le d�lai en secondes (5 par d�faut) :
Gui, Add, Edit, vDelay, 5 ; Champ de saisie avec une valeur par d�faut de 5
Gui, Add, Text,, Entrez le texte � taper :
Gui, Add, Edit, vInputString, ; Champ de saisie pour le texte
Gui, Add, Button, gSubmit, Soumettre ; Bouton pour soumettre

; Affiche la fen�tre GUI
Gui, Show, , D�lai et Texte
return

; Gestion du bouton "Soumettre"
Submit:
    Gui, Submit ; R�cup�re les valeurs des champs
    Countdown := Delay ; Stocke la valeur initiale du d�lai pour le compte � rebours

    ; Affichage du compte � rebours dans la barre de titre
    Loop, %Delay%
    {
        ToolTip, Temps restant : %Countdown% secondes
        Sleep, 1000 ; Attend une seconde (1000 ms)
        Countdown-- ; R�duit le compteur
    }
    ToolTip ; Cache le ToolTip une fois le d�lai termin�

    ; Ajouter un d�lai de 50 ms entre chaque frappe
    SetKeyDelay, 100

    ; Simulation de la frappe du texte apr�s le compte � rebours
    ;SendInput, %InputString%
	
	send %InputString%
	

    
    ; Demande si l'utilisateur veut recommencer ou quitter
    MsgBox, 4, Recommencer?, Voulez-vous recommencer ou quitter le script ?`nOui = Recommencer`nNon = Quitter
    IfMsgBox Yes
    {
        ; Retourne au d�but du script avec Goto
        Gui, Destroy ; Ferme l'ancienne fen�tre GUI
        Goto, Start
    }
    else
    {
        ; Ferme le script
        ExitApp
    }
return
