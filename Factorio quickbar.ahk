Processname=factorio.exe
Process, Exist, %Processname%

; Note
; Spécifier le délais si trop court. (ligne 9-11)
; Spécifier la quickbar
; Sécifier le nombre d'item, 5 à 9. 
; S'assurer que < ouvre la console lua. 

Delay=2
DelayRequest=10 ; Delay pour la section des demandes logistics bots
DelayBlueprint=1000 ; Delay Pour les Blueprints
;0123456789



Quickbars=0123456789RC
;Quickbars=0123456789
Quickbars=012789CR
;Quickbars=R
;Quickbars=0
;Quickbars=2345678R

NbItem=9
;NbItem=9
;NbItem=8
;NbItem=7
;NbItem=6
;NbItem=5

;hauteurRequest=20
hauteurRequest=0
ItemPosGap=39 ; La taille d'un carré pour un item
switch NbItem
{
	case 9:	hauteur:=0
	case 8: hauteur:=(ItemPosGap*1)
	case 7: hauteur:=(ItemPosGap*2)
	case 6: hauteur:=(ItemPosGap*3)
	case 5: hauteur:=(ItemPosGap*4)


}
; Position du menu logistique, production, intermediate et combat
ItemTypeX=850
ItemTypeY= % 564+hauteur ; (9 items)
;ItemTypeY=564 ; (8 items)
;ItemTypeY=650 Crash site. Extra item (+2,9 total)
ItemTypeGap=105

; Position de l'item
ItemPosX=801
ItemPosY= % 627+hauteur ; (9 items)
;ItemPosY=636 ;(8 item)
;ItemPosY=712 ;6 items
;ItemPosY=672 ;7 items

;Emplacement de la QuickBar, premiere case en haut a gauche 
CaseX=785 
CaseY=1013
CaseGap=40

; Request slots
; Position barre de menu
RequestMenuOrgX=899
RequestMenuOrgY=261

RequestMenuMovedX=899
RequestMenuMovedY=12

; Position boite 1
RequestHautGaucheX=779
RequestHautGaucheY=88
RequestGapX=40
RequestGapY=40

;Position des catégories
RequestItemCategoryX=822
RequestItemCategoryY=% 177-hauteurRequest

;Position des items
RequestItemPosX=805
RequestItemPosY=% 244-hauteurRequest

RequestCheckboxX=1165
RequestCheckboxY=% 639-hauteurRequest

RequestMinX=820
RequestMinY=% 639-hauteurRequest

RequestMaxX=1108
RequestMaxY=% 639-hauteurRequest

If !ErrorLevel
{
   MsgBox, % "Process " Processname " does not exist"
   return
}
 
pid := ErrorLevel
IfWinNotActive, % "ahk_pid " pid 
{
	
	Global Quickbars
	WinActivate, % "ahk_pid " pid
	
	BlockInput, MouseMove
	sleep, 4000
	
 If Quickbars contains C
 {
	sleep, %DelayBlueprint%
	send < /color 202 201 141 `r
	}

	If Quickbars contains 0
	{
		send +0 ;Early buildings
		AddItem(1,1,"Electric Mining drill","P")
		AddItem(2,1,"Steam engine","P")
		AddItem(3,1,"Boiler","P")
		AddItem(4,1,"Stone Furnace","P")
		AddItem(5,1,"Pipe","L")
		AddItem(6,1,"Pipe to Ground","L")
		AddItem(7,1,"Offshore Pump","L")
		AddItem(8,1,"Burner Inserter","L")
		AddItem(9,1,"Steel furnace","P")
		AddItem(10,1,"Medium electric pole","L")
	}
	
	if Quickbars contains 1
	{
		send +1 ;Early
		AddItem(1,1,"Transport Belt","L")
		AddItem(2,1,"Underground Belt","L")
		AddItem(3,1,"Splitter","L")
		AddItem(4,1,"Small electric pole","L")
		AddItem(5,2,"Inserter","L")
		AddItem(6,1,"Long-Handed Inserter","L")
		AddItem(7,1,"Iron Chest","L")
		AddItem(8,1,"Wooden Chest","L")
		AddItem(9,1,"Lamp","L")
		AddItem(10,1,"Assembling machine","P")
	}
	
	If Quickbars contains 2
	{
		send +2 ;Mid
		AddItem(1,1,"Fast Transport Belt",0)
		AddItem(2,1,"Fast Underground Belt",0)
		AddItem(3,1,"Fast Splitter",0)
		AddItem(4,1,"Medium electric pole",0)
		AddItem(5,1,"Big electric pole",0)
		AddItem(6,1,"SubStation",0)
		AddItem(7,1,"Fast Inserter",0)
		AddItem(8,1,"Pipe",0)
		AddItem(9,1,"Pipe to Ground",0)
		AddItem(10,1,"Radar","C")
	}
	If Quickbars contains 3
	{
		send +3 ;End
		AddItem(1,1,"Express Transport Belt",0)
		AddItem(2,1,"Express Underground Belt",0)
		AddItem(3,1,"Express Splitter",0)
		AddItem(4,1,"Medium electric pole",0)
		AddItem(5,1,"Big electric pole",0)
		AddItem(6,1,"SubStation",0)
		AddItem(7,1,"Stack Inserter",0)
		AddItem(8,1,"Requester Chest",0)
		AddItem(9,1,"Passive Provider Chest",0)
		AddItem(10,1,"Roboport","L")
	}
	
		If  Quickbars contains 6
	{
		send +6 ; Blueprints
		AddBluePrint(1,1,"Balancer - 2",5)
		AddBluePrint(2,1,"Balancer - 3",5)
		AddBluePrint(3,1,"Split",10)
		;AddBluePrint(4,1,"Gare Balafré",10)
		AddBluePrint(5,1,"Rails",5)
		AddBluePrint(6,1,"Smelting",5)
		AddBluePrint(7,1,"Mines",10)
		AddBluePrint(8,1,"Pont Bots",5)
		AddBluePrint(9,1,"Pétrole",5)
		AddBluePrint(10,1,"Circuits",5)
	}

	If Quickbars contains 7
	{
		send +7 ;defenses
		AddItem(1,1,"Radar","C")
		AddItem(2,1,"Gun Turret","C")
		AddItem(3,1,"Laser Turret",0)
		AddItem(4,1,"Flamethrower turret",0)
		AddItem(5,1,"Gate",0)
		AddItem(6,1,"Wall",0)
		;AddItem(7,1,"")
		;AddItem(8,1,"")
		AddItem(9,1,"Artillery turret",0)
		AddItem(10,1,"Artillery targeting",0)
	}

	If Quickbars contains 8
	{
		send +8 ;Pipes
		AddItem(1,1,"Pipe","L")
		AddItem(2,1,"Pipe to Ground",0)
		AddItem(3,1,"Pump",0)
		AddItem(4,1,"Oil Refinery",0)
		AddItem(5,1,"Chemical Plant",0)
		AddItem(6,1,"Substation",0)
		AddItem(7,1,"Storage Tank",0)
		;AddItem(8,1,"")
		;AddItem(9,1,"")
		AddBluePrint(10,1,"Pétrole",10)
	}

	If Quickbars contains 9
	{
		send +9 ;Trains 
		AddItem(1,1,"rail",0)
		AddItem(2,1,"Rail signal",0)
		AddItem(3,1,"Rail chain signal",0)
		AddItem(4,1,"Stack inserter",0)
		AddItem(5,1,"Train stop",0)
		AddItem(6,1,"Steel chest",0)
		AddItem(7,1,"Storage tank",0)
		AddItem(8,1,"Locomotive",0)
		AddItem(9,1,"Fluid Wagon",0)
		AddItem(10,1,"Cargo Wagon",0)
	}

; limite de 5 rangée
	if Quickbars contains R
	{
		; Ouvre le menu et le déplace en haut.
		send e
		MouseClickDrag, left, RequestMenuOrgX, RequestMenuOrgY, RequestMenuMovedX, RequestMenuMovedY , 10
		
		;(CasePos, LinePos, ItemPos, Item, ItemType, QtyMin, QtyMax)
		AddItemRequest(1,1,1,"Transport Belt","L",0,0)
		AddItemRequest(2,1,1,"Underground Belt","L",0,0)
		AddItemRequest(3,1,1,"Splitter","L",0,0)
		AddItemRequest(4,1,1,"Fast Transport Belt","L",300,-1)
		AddItemRequest(5,1,1,"Fast Underground Belt","L",100,-1)
		AddItemRequest(6,1,1,"Fast Splitter","L",50,-1)
		AddItemRequest(7,1,1,"Express Transport Belt","L",300,-1)
		AddItemRequest(8,1,1,"Express Underground Belt","L",100,-1)
		AddItemRequest(9,1,1,"Express Splitter","L",50,-1)
		AddItemRequest(10,1,1,"Small electric pole","L",0,0)
		
		AddItemRequest(1,2,1,"Big Electric Pole","L",48,-1)
		AddItemRequest(2,2,1,"Substation","L",48,-1)
		AddItemRequest(3,2,1,"Medium Electric Pole","L",48,-1)
		AddItemRequest(4,2,1,"Roboport","L",10,-1)
		AddItemRequest(5,2,1,"Steel Chest","L",45,-1)
		;AddItemRequest(6,2,1,"Low density","I",60,60)
		AddItemRequest(7,2,1,"Stack Inserter","L",48,-1)
		AddItemRequest(8,2,1,"Fast Inserter","L",48,-1)
		AddItemRequest(9,2,1,"Pipe","L",100,-1)
		AddItemRequest(10,2,1,"Pipe to Ground","L",100,-1)
		
		AddItemRequest(1,3,1,"rail","L",200,-1)
		AddItemRequest(2,3,1,"Rail signal","L",48,-1)
		AddItemRequest(3,3,1,"Rail chain signal","L",48,-1)
		AddItemRequest(4,3,1,"Train stop","L",10,15)
		AddItemRequest(5,3,1,"Locomotive","L",5,10)
		AddItemRequest(6,3,1,"Cargo Wagon","L",5,10)
		AddItemRequest(7,3,1,"Radar","C",15,30)
		AddItemRequest(8,3,1,"Laser Turret","C",30,-1)
		AddItemRequest(9,3,1,"Gate","C",20,-1)
		AddItemRequest(10,3,1,"Wall","C",100,-1)
		
		AddItemRequest(1,4,1,"Battery","I",190,200)
		AddItemRequest(2,4,1,"Electronic","I",200,600)
		AddItemRequest(3,4,1,"Advanced","I",200,600)
		AddItemRequest(4,4,1,"Processing","I",100,600)
		AddItemRequest(5,4,1,"Steel plate","I",300,600)
		AddItemRequest(6,4,1,"Iron plate","I",300,600)
		AddItemRequest(7,4,1,"Copper plate","I",300,600)
		AddItemRequest(8,4,1,"Construction Robot","L",50,50)
		AddItemRequest(9,4,1,"engine unit","I",40,50)
		AddItemRequest(10,4,1,"electric engine unit","I",40,50)
		
		AddItemRequest(1,5,1,"Iron ore","I",0,0)
		AddItemRequest(2,5,1,"Copper ore","I",0,0)
		AddItemRequest(3,5,1,"Uranium ore","I",0,0)
		AddItemRequest(4,5,1,"Sulfur","I",0,0)
		AddItemRequest(5,5,1,"Coal","I",0,30)
		AddItemRequest(6,5,1,"Wood","I",0,30)
		AddItemRequest(7,5,1,"piercing round","I",200,-1)
		AddItemRequest(8,5,1,"Cliff explosives","C",20,80)
		AddItemRequest(9,5,1,"Assembling Machine 3","P",20,100)
		AddItemRequest(10,5,1,"iron gear wheel","I",300,500)
		
		AddItemRequest(1,6,1,"Arithmetic combinator","L",48,-1)
		AddItemRequest(2,6,1,"Decider combinator","L",48,-1)
		AddItemRequest(3,6,1,"Constant combinator","L",48,-1)
		AddItemRequest(4,6,1,"Repair pack","P",100,100)	
	;	AddItemRequest(4,6,1,"Sulfur","I",0,0)#
	;	AddItemRequest(5,6,1,"Coal","I",0,30)
	;	AddItemRequest(6,6,1,"Wood","I",0,30)
	;	AddItemRequest(7,6,1,"piercing round","I",200,-1)
	;	AddItemRequest(8,6,1,"Cliff explosives","C",20,80)
	;	AddItemRequest(9,6,1,"Assembling Machine 3","P",20,100)
	;	AddItemRequest(10,6,1,"iron gear wheel","I",300,500)
		
		
	}

/*	
	send +2
	AddItem(1,1,"")
	AddItem(2,1,"")
	AddItem(3,1,"")
	AddItem(4,1,"")
	AddItem(5,1,"")
	AddItem(6,1,"")
	AddItem(7,1,"")
	AddItem(8,1,"")
	AddItem(9,1,"")
	AddItem(10,1,"")
*/
	BlockInput, MouseMoveOff

	;MouseClick, left, 795, 708 ; item no1
	;MouseClick, left, 832, 707 ; item no2
	;MouseClick, left, 872, 670 ; item no2
	;Send, Transport Belt
	
	exit
}

; Item de la QuickBar
	AddItem(CasePos, ItemPos, Item, ItemType)
	{
		
		; Declaration des variables. Utilisation des valeurs globales déclarées en haut
		global Delay
		global ItemTypeX
		global ItemTypeY
		global ItemTypeGap

		global ItemPosX
		global ItemPosY
		global ItemPosGap
		
		global CaseX
		global CaseY
		global CaseGap
		
		; Ajustement car le menu ouvre en fonction de la case.
			switch CasePos ; Hauteur 977, Largeur 785 + 40
			{
				case 1:	ajustement:=0 ; case no1
				case 2: ajustement:=(CaseGap*1) ; case no2
				case 3: ajustement:=(CaseGap*2) ; case no3
				case 4: ajustement:=(CaseGap*3) ; case no4 
				case 5: ajustement:=(CaseGap*4) ; case no5
				case 6: ajustement:=(CaseGap*5) ; case no6
				case 7: ajustement:=(CaseGap*6) ; case no7
				case 8: ajustement:=(CaseGap*7) ; case no8
				case 9: ajustement:=(CaseGap*8) ; case no9
				case 10: ajustement:=(CaseGap*9) ; case no10
			}
		
		; Effacer un item si présent dans la case
		sleep, %Delay%
		MouseClick, middle, % CaseX+ajustement, CaseY ; la case
		
		; Clic aléatoire. Éviter que la fenêtre reste ouverte.
		sleep, %Delay%
		MouseClick, left, % 393,498 ; millieu gauche de l'écran
		
		
		sleep, %Delay%
		MouseClick, left, % CaseX+ajustement, CaseY ; la case
		sleep, %Delay%
		Send, ^f%Item%
		sleep, % 2 * Delay
		
		switch ItemType
		{
			case "L": MouseClick, left, % ItemTypeX+ajustement, ItemTypeY ; Logistics 833, 657 
			case "P": MouseClick, left, % ItemTypeX+ItemTypeGap+ajustement, ItemTypeY ; Production 936, 656
			case "I": MouseClick, left, % ItemTypeX+ItemTypeGap+ItemTypeGap+ajustement, ItemTypeY ; Intermediate products 1043, 649
			case "C": MouseClick, left, % ItemTypeX+ItemTypeGap+ItemTypeGap+ItemTypeGap+ajustement, ItemTypeY ; Combat 1149, 650
		}		
		sleep, %Delay%
		
		switch ItemPos
		{
			case 1: MouseClick, left, % ItemPosX+ajustement, ItemPosY ; item no1
			case 2: MouseClick, left, % ItemPosX+ItemPosGap+ajustement, ItemPosY ; item no2
			case 3: MouseClick, left, % ItemPosX+ItemPosGap+ItemPosGap+ajustement, ItemPosY ; item no2
		}
		sleep, %Delay%
		
		; Clic aléatoire. Éviter que la fenêtre reste ouverte.
		MouseClick, left, % 393,498 ; millieu gauche de l'écran
		sleep, %Delay%
	}
	; Logistics bots
	AddItemRequest(CasePos, LinePos, ItemPos, Item, ItemType, QtyMin, QtyMax )
	{
		
		; Declaration des variables. Utilisation des valeurs globales déclarées en haut
		global DelayRequest
		global RequestItemCategoryX
		global RequestItemCategoryY
		global ItemTypeGap

		global RequestItemPosX
		global RequestItemPosY
		global ItemPosGap
		
		global RequestHautGaucheX
		global RequestHautGaucheY
		global RequestGapY
		global RequestGapX
		
		global RequestCheckboxX
		global RequestCheckboxY

		global RequestMinX
		global RequestMinY

		global RequestMaxX
		global RequestMaxY
		
		
		
		
		; Ajustement car le menu ouvre en fonction de la case.
			switch CasePos ; Hauteur 977, Largeur 785 + 40
			{
				case 1:	ajustementX:=0 ; case no1
				case 2: ajustementX:=(RequestGapX*1) ; case no2
				case 3: ajustementX:=(RequestGapX*2) ; case no3
				case 4: ajustementX:=(RequestGapX*3) ; case no4 
				case 5: ajustementX:=(RequestGapX*4) ; case no5
				case 6: ajustementX:=(RequestGapX*5) ; case no6
				case 7: ajustementX:=(RequestGapX*6) ; case no7
				case 8: ajustementX:=(RequestGapX*7) ; case no8
				case 9: ajustementX:=(RequestGapX*8) ; case no9
				case 10: ajustementX:=(RequestGapX*9) ; case no10
			}
			
			switch LinePos ; Hauteur 977, Largeur 785 + 40
			{
				case 1:	ajustementY:=0 ; case no1
				case 2: ajustementY:=(RequestGapY*1) ; case no2
				case 3: ajustementY:=(RequestGapY*2) ; case no3
				case 4: ajustementY:=(RequestGapY*3) ; case no4 
				case 5: ajustementY:=(RequestGapY*4) ; case no5
				case 6: ajustementY:=(RequestGapY*5) ; case no6
				case 7: ajustementY:=(RequestGapY*6) ; case no7
				case 8: ajustementY:=(RequestGapY*7) ; case no8
				case 9: ajustementY:=(RequestGapY*8) ; case no9
				case 10: ajustementY:=(RequestGapY*9) ; case no10
			}
			
			
			
		
		; Effacer un item si présent dans la case
		;sleep, %Delay%
		;MouseClick, right, % RequestHautGaucheX+ajustementX, % RequestHautGaucheY+ajustementY ; la case
		; Clic aléatoire. Éviter que la fenêtre reste ouverte.
		sleep, %DelayRequest%
		MouseClick, left, % 219,194 ; millieu gauche de l'écran
		
		
		sleep, %DelayRequest%
		MouseClick, left, % RequestHautGaucheX+ajustementX, % RequestHautGaucheY+ajustementY ; la case
		sleep, %DelayRequest%
		Send, ^f%Item%
		sleep, % 2 * DelayRequest
		
		switch ItemType
		{
			case "L": MouseClick, left, % RequestItemCategoryX+ajustementX, % RequestItemCategoryY+ajustementY ; Logistics 833, 657 
			case "P": MouseClick, left, % RequestItemCategoryX+ItemTypeGap+ajustementX, % RequestItemCategoryY+ajustementY ; Production 936, 656
			case "I": MouseClick, left, % RequestItemCategoryX+ItemTypeGap+ItemTypeGap+ajustementX, % RequestItemCategoryY+ajustementY ; Intermediate products 1043, 649
			case "C": MouseClick, left, % RequestItemCategoryX+ItemTypeGap+ItemTypeGap+ItemTypeGap+ajustementX, % RequestItemCategoryY+ajustementY ; Combat 1149, 650
		}		
		sleep, %DelayRequest%
		
		switch ItemPos
		{
			case 1: MouseClick, left, % RequestItemPosX+ajustementX, % RequestItemPosY+ajustementY ; item no1
			case 2: MouseClick, left, % RequestItemPosX+ItemPosGap+ajustementX, % RequestItemPosY+ajustementY ; item no2
			case 3: MouseClick, left, % RequestItemPosX+ItemPosGap+ItemPosGap+ajustementX, % RequestItemPosY+ajustementY ; item no2
		}
		sleep, %DelayRequest%
		
		MouseClick, left, % RequestMinX+ajustementX, % RequestMinY+ajustementY ; Qty minimum
		Send, ^a%QtyMin%
		sleep, %DelayRequest%
		
		if QtyMax >= 0
		{
		MouseClick, left, % RequestMaxX+ajustementX, % RequestMaxY+ajustementY ; Qty minimum
		Send, ^a%QtyMax%
		sleep, %DelayRequest%
		}
		
		MouseClick, left, % RequestCheckboxX+ajustementX, % RequestCheckboxY+ajustementY ; Crochet vert
		sleep, % 2 * DelayRequest
		
		
		
		; Clic aléatoire. Éviter que la fenêtre reste ouverte.
		MouseClick, left, % 219,194 ; millieu gauche de l'écran
		sleep, %DelayRequest%
	}
	
	
	AddBluePrint(CasePos, ItemPos, Item, Attente)
	{
	
		global CaseX
		global CaseY
		global CaseGap
		global DelayBlueprint
		
		global Delay
			switch CasePos ; Hauteur 977, Largeur 785 + 40
			{
				case 1:	ajustement:=0 ; case no1
				case 2: ajustement:=(CaseGap*1) ; case no2
				case 3: ajustement:=(CaseGap*2) ; case no3
				case 4: ajustement:=(CaseGap*3) ; case no4 
				case 5: ajustement:=(CaseGap*4) ; case no5
				case 6: ajustement:=(CaseGap*5) ; case no6
				case 7: ajustement:=(CaseGap*6) ; case no7
				case 8: ajustement:=(CaseGap*7) ; case no8
				case 9: ajustement:=(CaseGap*8) ; case no9
				case 10: ajustement:=(CaseGap*9) ; case no10
			}
			
		sleep, % 2 * Delay
		Send, b
		sleep, % DelayBlueprint

		Send, ^f%Item%
		sleep, % 2 * Delay
		switch ItemPos ; Position des items Blueprint. 
		{ 
			case 1: MouseClick, left, 962, 210 ; item no1
			case 2: MouseClick, left, 1144, 210 ; item no2
			case 3: MouseClick, left, 1134, 210 ; item no2
		}
		sleep, %DelayBlueprint%
		MouseClick, left, % CaseX+ajustement, CaseY ; la case
		sleep, % 2 * Delay
		;Sortir du blueprint
		Send, b
		sleep, % DelayBlueprint
		Send q
		sleep, % DelayBlueprint
	}


	AddRadar(CasePos, ItemPos, Item)
	{
		global Delay
		global CaseX
		global CaseY
		global CaseGap
		switch CasePos ; Hauteur 977, Largeur 785 + 40 ; 883 + 40, 611
		{
			case 1:	ajustement:=0 ; case no1
			case 2: ajustement:=(40*1) ; case no2
			case 3: ajustement:=(40*2) ; case no3
			case 4: ajustement:=(40*3) ; case no4 
			case 5: ajustement:=(40*4) ; case no5
			case 6: ajustement:=(40*5) ; case no6
			case 7: ajustement:=(40*6) ; case no7
			case 8: ajustement:=(40*7) ; case no8
			case 9: ajustement:=(40*8) ; case no9
			case 10: ajustement:=(40*9) ; case no10
		}
			
		sleep, %Delay%
		MouseClick, left, % 785+ajustement, 977 ; la case
		sleep, %Delay%
		Send, ^fRadar
		sleep, % 2 * Delay
		MouseClick, left, % 1144+ajustement, 535 ; Items de combat
		sleep, %Delay%
		
		switch ItemPos
		{ 
			case 1: MouseClick, left, % 808+ajustement, 716 ; item no1
			case 2: MouseClick, left, % 850+ajustement, 716 ; item no2
			case 3: MouseClick, left, % 889+ajustement, 716 ; item no2
		}
		sleep, %Delay%
	}


/*
				case 1:	MouseClick, left, 785, 977 ; case no1
				case 2: MouseClick, left, 819, 977 ; case no2
				case 3: MouseClick, left, 860, 977 ; case no3
				case 4: MouseClick, left, 904, 977 ; case no4 
				case 5: MouseClick, left, 939, 977 ; case no5
				case 6: MouseClick, left, 990, 977 ; case no6
				case 7: MouseClick, left, 1024, 977 ; case no7
				case 8: MouseClick, left, 1068, 977 ; case no8
				case 9: MouseClick, left, 1105, 977 ; case no9
				case 10: MouseClick, left, 1154, 977 ; case no10
*/

ESC::ExitApp