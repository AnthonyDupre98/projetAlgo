import Foundation


public protocol ProtocolePioche {
    associatedtype ProtocoleCarte

    // init: -> Pioche
    // Création de la pioche composée de 9 soldats, 6 gardes, 5 archers déposés aléatoirement
    init()

    // piocher: Pioche -> (Carte | Vide)
    // Retourne une carte
    // Post: la carte que l'on pioche ou Vide si il n'y a plus de cartes
    func piocher() -> ProtocoleCarte?

    // getnbCartes: Pioche -> Int
    // Renvoie le nombre de cartes présentes dans la pioche
    // Post: le nombre de cartes dans la pioche
    func getnbCartes() -> Int

}

public class Pioche : ProtocolePioche {
    associatedtype ProtocoleCarte

    // init: -> Pioche
    // Création de la pioche composée de 9 soldats, 6 gardes, 5 archers déposés aléatoirement

    var pioche : [Carte?] = []

    init(){
        self.pioche = pioche
        var sol : Int = 9
        var gard : Int = 6
        var arch : Int = 5
        while ((sol != 0)||(gard != 0)||(arch != 0)){
            let rdm = Int.random(in: 0...2)
            if (rdm == 0) && (sol!=0) {
                pioche.push(Carte("Soldat"))
                sol = sol - 1
            }
            if (rdm == 1) && (gard!=0) {
                pioche.push(Carte("Garde"))
                gard = gard-1
            }
            if (rdm == 2) && (arch!=0) {
                pioche.push(Carte("Archer"))
                arch = arch - 1
            }
        }
    }

    // piocher: Pioche -> (Carte | Vide)
    // Retourne une carte
    // Post: la carte que l'on pioche ou Vide si il n'y a plus de cartes
    mutating func piocher() -> Carte? {
            return pioche.popLast()
    }

    // getnbCartes: Pioche -> Int
    // Renvoie le nombre de cartes présentes dans la pioche
    // Post: le nombre de cartes dans la pioche
    func getnbCartes() -> Int {
        return pioche.count
    }

    mutating func push(_ element: Carte){
            pioche.append(element)
        }
}