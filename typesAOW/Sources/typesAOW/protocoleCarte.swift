import Foundation

public protocol ProtocoleCarte {


    // Indication:
    //La portée est representé par un tableau de booléen de taille 3, La premiere valeur
    // désigne si elle peut toucher la colonne du champs de bataille de l'unité qui attaque
    // la deuxieme colonne si elle peut toucher les colonnes à sa droite et à sa gauche
    // la troisieme colonne  si elle peut touùcher les colonne deux cases à droite et deux case à gauche


    //init: -> Carte
    // Pre: String représente le nom de la carte que l'on veut créer :
    // RoiA(attaque: 1, defenseD: 4, defenseO: 4, porteeCac:  [1,1,1], porteeDist: [1,0,0])
    // RoiB(attaque: 1, defenseD: 5, defenseO: 4, porteeCac: [1,1,1], porteeDist: [0,0,0])
    // Soldat(attaque: Main.taille(), defenseD: 2, defenseO: 1, porteeCac: [1,0,0], porteeDist[0,0,0])
    // Garde(attaque: 1, defenseD: 3, defenseO: 2, porteeCac: [1,0,0], porteeDist: [0,0,0])
    // Archer(attaque: 1, defenseD: 2, defenseO: 1, porteeCac:[0,0,1], porteeDist[0,1,0])
    // sinon la création échoue
    init(_ c: String)



    //affichernom: Carte -> String
    //Affiche le nom de la Carte
    //Post: renvoie une chaîne de caractères contenant le nom de la carte
    func affichernom()-> String

    //degatsCumules: Carte-> Int
    //Retourne les dégats qu'à subit une carte pendant 1 tour (est remis à 0 lorsque l'on redresse une carte)
    //Post: le nombre de dégats subit en un tour
    func degatsCumules() -> Int

    //afficheattaque:Carte -> Int
    //Retourne la valeur de l'attaque
    //Post: la valeur de l'attaque
    func afficheattaque()-> Int

    //affichedefenseD:Carte -> Int
    //Retourne la valeur de la defense en position verticale
    //Post: la valeur de la défenseD
    func affichedefenseD()-> Int

    //affichedefenseO:Carte -> Int
    //Retourne la valeur de la defense en position horizontale
    //Post: la valeur de la défenseO
    func affichedefenseO()-> Int

    //estRetournee:Carte -> Bool
    //Mode de la carte, 0 si verticale, 1 si horizontale
    //Post: true si retournée, false sinon
    func estRetournee()->Bool

    //ajoutdegat: Carte x Int -> Carte
    //ajoute au degat cumulé la valeur a>=0
    //Pre: le nombre de dégats que l'on veut infliger
    mutating func ajoutdegat(_a:Int)

    //redresser :Carte ->Carte
    //Remet la carte en mode vertical (au début du tour), remet à 0 degatsCumules
    mutating func redresser()

    // retourner: Carte-> Carte
    //Met la carte en mode horizontal (après attaque)
    mutating func retourner()


}
