Start: ; Étiquette pour redémarrer le script

; Création de la fenêtre GUI pour demander le délai et le texte
Gui, Add, Text,, Entrez le délai en secondes (5 par défaut) :
Gui, Add, Edit, vDelay, 5 ; Champ de saisie avec une valeur par défaut de 5
Gui, Add, Text,, Entrez le texte à taper :
Gui, Add, Edit, vInputString, ; Champ de saisie pour le texte
Gui, Add, Button, gSubmit, Soumettre ; Bouton pour soumettre

; Affiche la fenêtre GUI
Gui, Show, , Délai et Texte
return

; Gestion du bouton "Soumettre"
Submit:
    Gui, Submit ; Récupère les valeurs des champs
    Countdown := Delay ; Stocke la valeur initiale du délai pour le compte à rebours

    ; Affichage du compte à rebours dans la barre de titre
    Loop, %Delay%
    {
        ToolTip, Temps restant : %Countdown% secondes
        Sleep, 1000 ; Attend une seconde (1000 ms)
        Countdown-- ; Réduit le compteur
    }
    ToolTip ; Cache le ToolTip une fois le délai terminé

    ; Ajouter un délai de 50 ms entre chaque frappe
    SetKeyDelay, 100

    ; Simulation de la frappe du texte après le compte à rebours
    ;SendInput, %InputString%
	
	send %InputString%
	

    
    ; Demande si l'utilisateur veut recommencer ou quitter
    MsgBox, 4, Recommencer?, Voulez-vous recommencer ou quitter le script ?`nOui = Recommencer`nNon = Quitter
    IfMsgBox Yes
    {
        ; Retourne au début du script avec Goto
        Gui, Destroy ; Ferme l'ancienne fenêtre GUI
        Goto, Start
    }
    else
    {
        ; Ferme le script
        ExitApp
    }
return
