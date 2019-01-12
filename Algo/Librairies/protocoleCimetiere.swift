import Foundation


public protocol ProtocoleCimetiere {
    associatedtype ProtocoleCarte

    // init: -> Cimetiere
    // Création du cimetière (vide)
    init()

    // ajouter: Cimetiere x Carte -> Cimetiere
    // Ajoute une carte au cimetière
    // Pre: Carte qui représente la carte qu'on ajoute au cimetière
    mutating func ajouter(_ c: ProtocoleCarte)
}


public class Cimetiere : ProtocoleCimetiere{

    var cim: [Carte?] = []
    // init: -> Cimetiere
    // Création du cimetière (vide)
    init(){
        self.cim = cim
    }

    // ajouter: Cimetiere x Carte -> Cimetiere
    // Ajoute une carte au cimetière
    // Pre: Carte qui représente la carte qu'on ajoute au cimetière
    mutating func ajouter(_ c: Carte){
        cim.append(c)
    }
}
