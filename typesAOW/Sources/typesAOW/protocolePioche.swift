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
