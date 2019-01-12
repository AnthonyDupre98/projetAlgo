import Foundation


public protocol ProtocoleRoyaume {
    associatedtype ProtocoleCarte

    // init: -> Royaume
    // Création du Royaume (vide)
    init()

    // voirSuivant: Royaume-> (Carte | Vide)
    // Renvoie la prochaine carte que l'on va tirer ou rien si le royaume est videCarte | Vide
    // On renvoie la carte la plus ancienne
    // Post: la première carte disponible dans le royaume
    func voirSuivant() -> ProtocoleCarte?

    // placer: Royaume x Carte -> Royaume
    // Place une carte dans le royaume
    // Pre: la carte que l'on veut placer dans le royaume
    mutating func placer(_ c: ProtocoleCarte)

    //retirer: Royaume-> (Carte | Vide)
    // Retire la carte la plus ancienne du royaume, renvoie Vide si le royaume est vide
    // Post: la carte que l'on veut retirer du royaume
    mutating func retirer() -> ProtocoleCarte?

    // getnbSoldats: Royaume-> Int
    // Renvoie le nombre de soldats présents dans le royaume
    // Post: le nombre de soldats dans le royaume
    func getnbSoldats() -> Int

    // getnbArchers: Royaume-> Int
    // Renvoie le nombre d'archers présents dans le royaume
    // Post: le nombre d'archers dans le royaume
    func getnbArchers() -> Int

    // getnbGardes:Royaume -> Int
    // Renvoie le nombre de gardes présents dans le royaume
    // Post: le nombre de gardes dans le royaume
    func getnbGardes() -> Int

    // getnbCartes: Royaume-> Int
    // Renvoie le nombre de cartes dans le royaume
    // Post: le nombre de cartes dans le royaume
    func getnbCartes() -> Int

}

public class Royaume : ProtocoleRoyaume{
    typealias ProtocoleCarte = Carte
    var roy : [Carte?] = []

    // init: -> Royaume
    // Création du Royaume (vide)
    init(){
        self.roy = roy
    }

    // voirSuivant: Royaume-> (Carte | Vide)
    // Renvoie la prochaine carte que l'on va tirer ou rien si le royaume est videCarte | Vide
    // On renvoie la carte la plus ancienne
    // Post: la première carte disponible dans le royaume
    func voirSuivant() -> Carte? {
        return self.roy.first
    }

    // placer: Royaume x Carte -> Royaume
    // Place une carte dans le royaume
    // Pre: la carte que l'on veut placer dans le royaume
    mutating func placer(_ c: Carte) {
        self.roy.append(c)
    }

    //retirer: Royaume-> (Carte | Vide)
    // Retire la carte la plus ancienne du royaume, renvoie Vide si le royaume est vide
    // Post: la carte que l'on veut retirer du royaume
    mutating func retirer() -> ProtocoleCarte?{
        var firstCarte : Carte = voirSuivant(roy)
        self.roy.removeFirst()
        return firstCarte
    }

    // getnbSoldats: Royaume-> Int
    // Renvoie le nombre de soldats présents dans le royaume
    // Post: le nombre de soldats dans le royaume
    func getnbSoldats() -> Int{
        var nb : Int = 0
        for i in self.roy {
            if i.affichernom=="Soldat"{
                nb = nb + 1
            }
        }
        return nb
    }

    // getnbArchers: Royaume-> Int
    // Renvoie le nombre d'archers présents dans le royaume
    // Post: le nombre d'archers dans le royaume
    func getnbArchers() -> Int{
        var nb : Int = 0
        for i in self.roy {
            if i.affichernom=="Archer"{
                nb = nb + 1
            }
        }
        return nb
    }

    // getnbGardes:Royaume -> Int
    // Renvoie le nombre de gardes présents dans le royaume
    // Post: le nombre de gardes dans le royaume
    func getnbGardes() -> Int {
        var nb : Int = 0
        for i in self.roy {
            if i.affichernom=="Garde"{
                nb = nb + 1
            }
        }
        return nb
    }

    // getnbCartes: Royaume-> Int
    // Renvoie le nombre de cartes dans le royaume
    // Post: le nombre de cartes dans le royaume
    func getnbCartes() -> Int {
        return getnbGardes + getnbArchers + getnbSoldats
    }

}
