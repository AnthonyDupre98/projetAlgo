import Foundation

//Type ChampsDeBataille: (CDB: (ProtocoleCarte | Vide))
public protocol ProtocoleChampsDeBataille: Sequence {
    associatedtype ProtocoleCarte 
    associatedtype ProtocolePosition 
    associatedtype ProtocoleRoyaume 
    associatedtype IteratorChampsDeBataille : IteratorProtocol where IteratorChampsDeBataille.Element == ProtocolePosition
    associatedtype CDB2 : ProtocoleChampsDeBataille

    // init: -> ChampsDeBataille
    // Création du champs de bataille avec 6 positions: 3 Fronts et 3 Arrières (vide)
    init()

    // sortir: ChampsDeBataille x Position -> ChampsDeBataille x Carte
    // Supprime une carte du champs de bataille, et retourne la carte en question à partir d'une position
    // Pre: Position qui correspond à la position où est la carte que l'on veut supprimer du champs de bataille
    // Post: la carte que l'on veut supprimer du champs de bataille
    mutating func sortir(_ p: ProtocolePosition) -> ProtocoleCarte

    // poser: ChampsDeBataille x Carte x Position x Royaume -> ChampsDeBataille
    // Ajoute une carte au champs de bataille à partir d'une position, une carte ne peut être posé à l'arrière à moins
    // qu'il y ait une carte posée au front correspondant, dans le cas échéant, la carte est posée au front. Si une carte est déjà présente à la position où
    // on veut poser la carte, l'ancienne carte est envoyé dans le Royaume, et la nouvelle Carte prend sa place
    // Pre: Carte qui correspond à la carte que l'on veut poser & Position qui correspond à la position à laquelle on veut poser la carte
    mutating func poser(_ c: ProtocoleCarte, _ p: ProtocolePosition, _ r: ProtocoleRoyaume) throws

    // deplacer: ChampsDeBataille x Int -> ChampsDeBataille
    // Déplace la carte présente sur le champs de bataille sur la colonne en parametre de l'arrière au front
    // Renvoie une erreur si la position à l'arrière est vide
    // Pre: 0<=colonne<=3
    mutating func deplacer(_ colonne: Int) throws

    // supprimer: ChampsDeBataille x position -> ChampsDeBataille
    // supprime la carte situé a la position _p1
    mutating func supprimer(_ p1: ProtocolePosition)

    // afficherposition: ChampsDeBataille x Bool x Int -> Position
    //renvoie la position du champs de bataille lié à ces coordonnés
    //Pre: 1<=colonne<=3
    func afficherposition(_ front: Bool, _ colonne: Int)->ProtocolePosition

    // estAportee: ChampsDeBataille x Position x ChampsDeBataille x Position -> Bool
    // à une position donnée et une position ciblée, au champs de bataille adverse, renvoie true s'il y a une carte à portée, false sinon.
    // Pre: Position de départ p1, ChampsDeBataille que l'on veut cibler, Position à attaquer p2
    // Post: true si il y a une carte a portée, false sinon
    func estAportee(_ p1: ProtocolePosition, _ C2: CDB2, _ p2: ProtocolePosition) -> Bool

   // makeIterator : ChampsDeBataille -> ItChampsDeBataille
   // crée un itérateur sur la collection pour la parcourir dans l'ordre croissant des positions du front
    func makeItFront() -> IteratorChampsDeBataille

    // estVide: ChampsDeBataille -> Bool
    // estVide: Renvoie true si le champs de bataille ne possède pas de carte
    func estVide()-> Bool
}


public class ChampsDeBataille: ProtocoleChampsDeBataille {

    var CDB : [Carte?] = [nil,nil,nil,nil,nil,nil]
    // init: -> ChampsDeBataille
    // Création du champs de bataille avec 6 positions: 3 Fronts et 3 Arrières (vide)
    init(){
        // 1, 2, 3 les 3 cases du haut et 4, 5, 6 les 3 cases du bas
        self.CDB = CDB
    }

    // sortir: ChampsDeBataille x Position -> ChampsDeBataille x Carte
    // Supprime une carte du champs de bataille, et retourne la carte en question à partir d'une position
    // Pre: Position qui correspond à la position où est la carte que l'on veut supprimer du champs de bataille
    // Post: la carte que l'on veut supprimer du champs de bataille
    mutating func sortir(_ p: Position) -> Carte{
        var pos : Int
        var carte : ProtocoleCarte
        if p.estFront(){
            pos = p.getColonne()
        }
        else{
            pos = p.getColonne() + 3
        }
        if CDB[pos] is ProtocoleCarte{
            carte = CDB[pos]
            CDB[pos] = nil
        }
        return carte
    }

    // poser: ChampsDeBataille x Carte x Position x Royaume -> ChampsDeBataille
    // Ajoute une carte au champs de bataille à partir d'une position, une carte ne peut être posé à l'arrière à moins
    // qu'il y ait une carte posée au front correspondant, dans le cas échéant, la carte est posée au front. Si une carte est déjà présente à la position où
    // on veut poser la carte, l'ancienne carte est envoyé dans le Royaume, et la nouvelle Carte prend sa place
    // Pre: Carte qui correspond à la carte que l'on veut poser & Position qui correspond à la position à laquelle on veut poser la carte
    mutating func poser(_ c: Carte, _ p: Position, _ r: Royaume) throws{
        var pos : Int
        if p.estFront(){
            pos = p.getColonne()
        }
        else{
            pos = p.getColonne() + 3
        }
        //cas ou la position donne est a l'arriere
        if CDB[pos] > 3{
            //cas ou la case au front est vide alors que la position donnee est a l'arriere
            if CDB[pos - 3] == nil{
                CDB[pos - 3] = c
            }
            //cas ou la position au front est deja occupee
            else{
                //la position est vide
                if CDB[pos] == nil{
                    CDB[pos] = c
                }
                    //la position est occupee
                else{
                    r.placer(CDB[pos])
                    CDB[pos] = c
                }
            }
        }
        //la position donnee est au front
        else{
            //la position est vide
            if CDB[pos] == nil{
                CDB[pos] = c
            }
            //la position est occupee
            else{
                r.placer(CDB[pos])
                CDB[pos] = c
            }
        }
    }

    // deplacer: ChampsDeBataille x  Int -> ChampsDeBataille
    // Déplace la carte présente sur le champs de bataille sur la colonne en parametre de l'arrière au front
    // Renvoie une erreur si la position à l'arrière est vide
    // Pre: 1<=colonne<=3
    mutating func deplacer(_ colonne: Int) throws{
        if !CDB[colonne + 3]{
            return ERROR
        }
        CDB[colonne] = CDB[colonne + 3]
        CDB[colonne + 3] = nil
    }

    // supprimer: ChampsDeBataille x position -> ChampsDeBataille
    // supprime la carte situé a la position _p1
    mutating func supprimer(_ p1: Position){
        var pos : Int
        if p1.estFront(){
            pos = p1.getColonne()
        }
        else{
            pos = p1.getColonne() + 3
        }
        if CDB[pos] is Carte{
            CDB[pos] = nil
        }
    }

    // afficherposition: ChampsDeBataille x Bool x Int -> Position
    //renvoie la position du champs de bataille lié à ces coordonnés
    //Pre: 1<=colonne<=3
    func afficherposition(_ front: Bool, _ colonne: Int)->Position{
        var position : Position
        var i : Int
        var carte : Carte?
        if front{
            i = colonne
        }
        else{
            i = colonne + 3
        }
        carte = CDB[i]
        return position(front, colonne, carte)
    }

    // estAportee: ChampsDeBataille x Position x ChampsDeBataille x Position -> Bool
    // à une position donnée et une position ciblée, au champs de bataille adverse, renvoie true s'il y a une carte à portée, false sinon.
    // Pre: Position de départ p1, ChampsDeBataille que l'on veut cibler, Position à attaquer p2
    // Post: true si il y a une carte a portée, false sinon
    func estAportee(_ p1: Position, _ C2: CDB2, _ p2: Position) -> Bool{
        var carte1 : Carte?
        var pos1 : Int
        if p1.estFront(){
            pos1 = p1.getColonne()
        }
        else{
            pos1 = p1.getColonne() + 3
        }
        var pos2 : Int
        if p1.estFront(){
            pos2 = p2.getColonne()
        }
        else{
            pos2 = p2.getColonne() + 3
        }
        carte1 = CDB[pos1]
        //position1 n'a pas de carte donc ne peut pas attaquer
        if carte1 == nil {
            return false
        }
        //position1 a une carte
        //peut attaquer que au cac
        if carte1.getPorteeDist() == [false, false, false]{
            //si carte1 a l'arriere alors ne peut pas attaquer OU si carte2 est a l'arriere alors ne peut pas attaquer
            if !p1.getFront() || !p2.getFront(){
                return false
            }
            //roiB
            if carte1.getPorteeCac() == [true, true, true]{
                if p2.getFront(){
                    return true
                }
                else{
                    return false
                }
            }
            //garde ou soldat
            else{
                if (p1.getColonne() == 1 && p2.getColonne() == 3) || (p1.getColonne() == 2 && p2.getColonne() == 2) || (p1.getColonne() == 3 && p2.getColonne() == 1){
                    return true
                }
                else{
                    return false
                }
            }
        }
        //peut attaquer a distance
        else{
            //roiA
            if carte1.getPorteeDist() == [true, true, true]{
                //roiA a l'arriere
                if !p1.getFront(){
                    //ennemi au front
                    if p2.getFront(){
                        return true
                    }
                    //nnemi a l'arriere
                    if !p2.getFront(){
                        return false
                    }
                }
                //roiA au front
                else{
                    //ennemi a l'arriere
                    if !p2.getFront(){
                        if (p1.getColonne() == 1 && p2.getColonne() == 3) || (p1.getColonne() == 2 && p2.getColonne() == 2) || (p1.getColonne() == 3 && p2.getColonne() == 1){
                            return true
                        }
                        else{
                            return false
                        }
                    }
                    //ennemi a au front
                    else{
                        return true
                    }
                }
            }
            //archer
            else{
                //archer en position 1
                if pos1 == 1{
                    return (pos2 == 1 || pos2 = 5)
                }
                //archer en position 2
                if pos1 == 2{
                    return( pos2 == 4 || pos2 = 6)
                }
                //archer en position 3
                if pos1 == 3{
                    return (pos2 == 3 || pos2 = 5)
                }
                //archer en position 5
                if pos1 == 5{
                    return (pos2 == 1 || pos2 = 3)
                }
                //archer en position 4 ou 6
                else{
                    return (pos2 == 1 || pos2 = 3)
                }
            }
        }
    }

   // makeIterator : ChampsDeBataille -> ItChampsDeBataille
   // crée un itérateur sur la collection pour la parcourir dans l'ordre croissant des positions du front
    func makeItFront() -> IteratorChampsDeBataille{
        return IteratorChampsDeBataille(self)
    }

    // estVide: ChampsDeBataille -> Bool
    // estVide: Renvoie true si le champs de bataille ne possède pas de carte
    func estVide()-> Bool{
        var b : Bool = true
        for i in 1..6{
            if CDB[i] is Carte{
                b = false
            }
        }
        return b
    }
}

struct IteratorChampsDeBataille: IteratorProtocol{
    
    var cdb : ChampsDeBataille
    var suiv : Bool
    var i : Int
    init(ChampsDeBataille:ChampsDeBataille){
        self.cdb = ChampsDeBataille
        self.i = 1
        self.suiv = ChampsDeBataille.file[i]
    }
    
    mutating func next() -> Carte?{
        var x : ChampsDeBataille = self.cdb.CDB[i]
        i = i + 1
        return x
    }
}
