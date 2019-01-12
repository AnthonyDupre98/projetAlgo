import typesAOW
//main
func inputint(_a: String,_valmin:Int, _valmax:Int)->Int{// Test si ce que l'utilisateur a entré est compris entre valmin et valmax
    var choix = true
    while choix{
        print (\(_a))
        let b = readLine()
        try? int(b){
            let c = int(b)
            if c >= _valmin && c <= _valmax{
                choix = false
            }
        }
    }
    return c
}

func input_main(main:ProtocoleMain, J:String )->String{//Choix d'une carte dans la main
    var choix = true
    while choix{
        print (J)
        print ("Choisissez une carte dans votre main")
        let b = readLine()
        for i in main{
            if i.affichernom() == b{
                choix = false
            }
        }
    }
    return b
}



func choixposition(champs:ProtocoleChampsDeBataille J:String){
    var b: Int
    b = inputint("Choisissez une colonne (1 ou 2 ou 3), " + J,1,3)

    let col:Int = b

    b = inputint("0: arriere, 1: front, ",0,1)

    if b==0{
        let front: Bool = false
    }
    else{
        let front: Bool = true
    }
    return(champs.afficherposition(front, col))
}



func poserfront(carte: ProtocoleCarte, champs:ProtocoleChampsDeBataille,roy: ProtocoleRoyaume, J:String){
    print("La carte sera placée au front")
    let col:Int = inputint("Choisissez une colonne (1 ou 2 ou 3), " + J,1,3)
    let front: Bool = true
    let pos = champs.afficherposition(front, col)
    champs.poser(c,pos,roy)
}

func champsdebattaillevide(main: ProtocoleMain, champs: ProtocoleChampsDeBataille, royaume: ProtocoleRoyaume, J: String){
    var c: ProtocoleCarte
    let a: String
    print ("Champs de bataille vide, " + J)
    if c = royaume2.retirer(){
        print (c.affichernom)
        poserfront(carte = c, champs = champs,roy = royaume, J = J)

    }
    else{
        print("Royaume vide, " + J)
        a=input_main(main = main, J = J)
        c=main2.retirer(a)
        poserfront(carte = c, champs = champs,roy = royaume, J = J)
}

func appercu(main: ProtocoleMain, J:String){
    print ("Champs de bataille de J1:")
    for i in champsdebataille1{
        if var c = i.afficher{
            if !c.estRetournee{
            print (c.affichernom())
            print ("Est Front: \(i.estfront())")
            print ("Colonne: \(i.getColonne()")
            print ("A attaqué: \(c.estRetournee())")
            print ("Degat cumulé: \(c.degatsCumules)")
        }
    }
    print ("Champs de bataille de J2:")
    for i in champsdebataille2{
        if var c = i.afficher{
            print (c.affichernom())
            print ("Est Front: \(i.estfront())")
            print ("Colonne: \(i.getColonne())")
            print ("A attaqué: \(c.estRetournee())")
            print ("Degat cumulé: \(c.degatsCumules)")
        }
    }

    print("Royaume de J1")
    print("Nombre d'archer: \(royaume1.getnbArchers())")
    print("Nombre de soldats: \(royaume1.getnbSoldats())")
    print("Nombre de garde: \(royaume1.getnbGardes())")
    if c = royaume1.voirSuivant(){
        print("Prochaine Carte à sortir:" + c.affichernom)
    }

    print("Royaume de J1")
    print("Nombre d'archer: \(royaume2.getnbArchers())")
    print("Nombre de soldats: \(royaume2.getnbSoldats())")
    print("Nombre de garde: \(royaume2.getnbGardes())")
    if c = royaume2.voirSuivant(){
        print("Prochaine Carte à sortir:" + c.affichernom)
    }
    print("Nombre de carte dans la pioche de J1: \(pioche1.getnbCartes())")
    print("Nombre de carte dans la pioche de J2: \(pioche2.getnbCartes())")

    print("Main de " + J)
    for c in main{
        print (c.affichernom())
    }

}
func tour(mainjoueur: ProtocoleMain, champsjoueur: ProtocoleChampsDeBataille , royjoueur: ProtocoleRoyaume, cimjoueur: ProtocoleCimetiere, joueur: String, mainadver: ProtocoleMain, champsadver: ProtocoleChampsDeBataille, royadver: ProtocoleRoyaume, cimadver: ProtocoleCimetiere, adver: String)-> Bool{
    var a: String
    var b: Int
    var c: ProtocoleCarte
    for i in champsdebataille1{
        if c = i.afficher{
            i.redresser()

        }
    }
    apperçu(main = mainjoueur, J = joueur)


    let action = inputint("0: Ne rien faire, 1: Déployer une unité, 2: Attaquer, "+joueur,0 ,2)

    if action == 1{//Premier choix: deployer une unité
        a = input_main(mainjoueur, joueur)
        c = main1.retirer(a)
        pos1 = choixposition(champs =champsjoueur, J = joueur)
        do try champsjoueur.poser(c,pos1){}
        catch{
            print("Unité placé dans le Royaume")
            let f=champsjoueur.retirer(pos1)
            royaume1.placer(f)
            champsjoueur.poser(c,pos1,royjoueur)
        }
    }
    else if action == 2 {
        var attaque = true
        while attaque{
            appercu(main = main1, J = joueur)
            b = inputint("1: attaquer, 0:pour arreter l'attaque; " + joueur,0,1)
            if b == 1{

                pos1 = choixposition(champs = champsjoueur, J = joueur)
                print ("Ennemie à porté de la Carte")
                var ennemivalable=[]
                for i in champsadver{
                    if c = i.afficher{
                        if champsjoueur.estAportee(p1 = pos1,C2 = champsadver, p2 = i){
                            print (c.affichernom())
                            print ("Est Front:"\i.estfront())
                            print ("Colonne:"\i.getColonne())
                            print ("A attaqué:"\c.estRetournee())
                        ennemivalable.append(i)
                        }
                    }

                }
                print("Choisissez la cible de l'attaque")
                pos2 = choixposition(champs = champsadver, J = joueur)

                positionaportee = false//Verifie si la coordonné entré par l'utilisateur est une position valide
                for i in ennemivalable{
                    if i == pos2{
                        positionaportee = true
                    }
                }
                if positionaportee{
                    c = pos2.afficher()
                    unite = pos1.afficher()
                    let defense: Int
                    if c.estRetournee(){// On recupere la valeur de la defense de la carte adverse
                        defense = c.defenseO()
                    }
                    else{
                        defense = c.defenseD()
                    }
                    if c.degatsCumules() == 0  && unite.afficheattaque() == defense{//on capture la carte
                        c=champsadver.retirer(pos2)
                        royaumejoueur.placer(c)
                        print("Ennemie capturé")
                        ennemie_abattu = true
                    }
                    else if (c.degatsCumules() + unite.afficheattaque()) >= defense{//on détruit la carte
                        c=champsadver.retirer(pos2)
                        cimadver.ajouter(c)
                        print("Ennemie abattue")
                        ennemie_abattu = true
                    }
                    else {//on fait des degat à la cart
                        print("L'ennemie prend \(unite.attaque) dégats")
                        c.ajoutdegat(unite.attaque)
                        champsadver.supprimer(pos2)
                        champsadver.poser(c,pos2,royadver)
                    }
                    if ennemie_abbatu{
                        try? champsadver.deplacer(pos2.getColonne()){}
                        if c.affichernom == "RoiA" or c.affichernom == "RoiB"{
                            print("Le Roi est mort")
                            jeu = false
                            attaque =false
                        }
                        else if champsadver.estVide(){// conscription
                            champsdebattaillevide(main = mainadver, champs = champsadver, royaume: royadver, J: "J2")
                            }
                        }
                    }
                    //on dit que cette unité a attaqué
                    unite.retourner()
                    champsjoueur.supprimer(pos1)
                    champsjoueur.ajouter(unite,pos1)

                }
            }
            else{
                attaque = false

            }
        }
    }
    if jeu{
        b = inputint("0: ne pas placer d'unité dans le royaume, 1: placer une unité",0,1)
        if mainjoueur.taille()>=6 || b == 1{
            a = input_main(main = mainjoueur, J = joueur )
            c = mainjoueur.retirer(a)
            royaumejoueur.placer(c)
        }
    }
    return !jeu
}




var main1 = ProtocoleMain()
var main2 = ProtocoleMain()
var pioche1 = ProtocolePioche ()
var pioche2 = ProtocolePioche ()
var royaume1 = ProtocoleRoyaume()
var royaume2 = ProtocoleRoyaume()
var champsdebataille1 = ProtocoleChampsDeBataille()
var champsdebataille2 = ProtocoleChampsDeBataille()
var cimetiere1 = ProtocoleCimetiere()
var cimetiere2 = ProtocoleCimetiere()


var a: String
var nom: String
var pos1: ProtocolePosition()
var pos2: ProtocolePosition()
var c:ProtocoleCarte()
var positionaportee: Bool
var b: Int

var choix:Bool = true
while choix {
    print (""J1, choisissez le Roi A ou B (tapez A pour le Roi A et B pour le roi B)"")
    a=readLine()
    if a == "A" || a == "a"{
        var roi1 = ProtocoleCarte("ROIA")
        var roi2 = ProtocoleCarte("ROIB")
        main1.ajouter(roi1)
        main2.ajouter(roi2)
        choix = false
    }
    else if a == "B" || a == "b"{
        var roi1 = ProtocoleCarte("ROIB")
        var roi2 = ProtocoleCarte("ROIA")
        main1.ajouter(roi1)
        main2.ajouter(roi2)
        choix = false
    }
    else{
        print("Veuillez tapez A ou B")
    }
}


for i in 1...3{
    c = pioche1.piocher()
    guard c is Carte else{throw Probleme}
    main1.ajouter(c)
}

for i in 1...3{
    c = pioche2.piocher()
    guard c is Carte else{throw Probleme}
    main2.ajouter(c)
}

c = pioche1.piocher()
guard c is Carte else{throw Probleme}
royaume1.placer(c)

c = pioche2.piocher()
guard c is Carte else{throw Probleme}
royaume2.placer(c)

for i in main1{
    print(i.afficher())
}

a = input_main(main = main1, J = "J1")
c=main1.retirer(a)
poserfront(carte = c, champs = champsdebataille1, roy = royaume1, J = "J1")

a = input_main(main = main2, J = "J2")
c=main2.retirer(a)
poserfront(carte = c, champs = champsdebataille2, roy = royaume2, J = "J2")


var jeu=true
var tourdeJ1=true
var attaque: bool
while jeu{
    if tourdeJ1{
        if let c = pioche1.piocher()
            main1.ajouter(c)
            roimort = tour(mainjoueur = main1, champsjoueur = champsdebataille1, royjoueur = royaume1, cimjoueur = cimetiere1, joueur = "J1", mainadver = main2, champsadver = champsdebataille2, royadver = royaume2, cimadver = cimetiere2, adver = "J2")
            if roimort{
                jeu = false
        }
        else{
            print("Plus de cartes dans la pioche")
            jeu = false
        }
        tourdeJ1 = false
    }


    else{
        if let c =  pioche2.piocher()
            main2.ajouter(c)
            roimort = tour(mainjoueur = main2, champsjoueur = champsdebataille2, royjoueur = royaume2, cimjoueur = cimetiere2, joueur = "J2", mainadver = main1, champsadver = champsdebataille1, royadver = royaume1, cimadver = cimetiere1, adver = "J1")
            if roimort{
                jeu = false
            }
        else{
            print("Plus de cartes dans la pioche")
            jeu = false
        }
        tourdeJ1 = true
    }
}
if roimort && !tourdeJ1{// on a atteint la fin du tour de J1
    print ("J1 a gagné")
}
else if roimort && tourdeJ1{
    print ("J2 a gagné")
}
else{
    print("Le royaume de J1 possède \(royaume1.getnbCartes())")
    print("Le royaume de J2 possède \(royaume2.getnbCartes())")
    if royaume1.getnbCartes() > royaume2.getnbCartes(){
        print ("J1 a gagné")
    }
    else if royaume1.getnbCartes() < royaume2.getnbCartes(){
        print ("J2 a gagné")
    }
    else {
        print("C'est une égalité !")
    }
}
