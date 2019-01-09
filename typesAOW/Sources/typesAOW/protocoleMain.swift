import Foundation

//Type Main(carte: (ProtocoleCarte | Vide), nbcartes: Int, suiv: (ProtocoleCarte | Vide))
public protocol ProtocoleMain : Sequence {
    associatedtype ProtocoleCarte
    associatedtype IteratorMain : IteratorProtocol where IteratorMain.Element == ProtocoleCarte

    // init: -> Main
    // Création de la main (vide)
    init()

    // taille: Main -> Int
    // Retourne le nombre de cartes dans la main
    // Post: le nombre de cartes dans la main
    func taille() -> Int

    // ajouter: Main x Carte -> Main
    // Ajoute une carte à la main
    // Pre: Une Carte
    mutating func ajouter(_ c: ProtocoleCarte)

    // retirer: Main x String-> Carte x Main
    // Retire une carte de la main
    // Pre: le nom de la carte que l'on veut retirer
    // Post: la carte que l'on veut retirer
    mutating func retirer(_ c: String) -> ProtocoleCarte

   // makeIterator : Main -> ItMain
   // crée un itérateur sur le collection pour itérer avec for in. L'itération se fait dans l'ordre de tirage des cartes
    func makeIterator() -> IteratorMain
}


public class Main : ProtocoleMain {

    // init: -> Main
    // Création de la main (vide)
    var file: [Carte?]
    var nbcartes: Bool
    init(){
        self.nbcartes = 0
        self.file = nil
    }

    // taille: Main -> Int
    // Retourne le nombre de cartes dans la main
    // Post: le nombre de cartes dans la main
    func taille() -> Int{
        return self.nbcartes
    }

    // ajouter: Main x Carte -> Main
    // Ajoute une carte à la main
    // Pre: Une Carte
    mutating func ajouter(_ c: Carte){
        file.append(c)
    }

    // retirer: Main x String-> Carte x Main
    // Retire une carte de la main
    // Pre: le nom de la carte que l'on veut retirer
    // Post: la carte que l'on veut retirer
    mutating func retirer(_ c: String) -> Carte{
        var r : Carte? = nil
        var b : Bool = false
        while b{
            for i in self{
                var count : Int = 0
                count = count + 1
                if c == i.file{
                    self.remove(at: count-1)
                    r = i
                    b = true
                }
            }
        }
        return r
    }

   // makeIterator : Main -> ItMain
   // crée un itérateur sur le collection pour itérer avec for in. L'itération se fait dans l'ordre de tirage des cartes
    func makeIterator() -> IteratorMain{
        return IteratorMain(self)
    }
}

struct IteratorMain: IteratorProtocol{

    var m : Main
    var suiv : Carte?
    var i : Int
    init(Main:Main){
        self.m = Main
        self.i = 0
        self.suiv = Main.file[i]
    }

    mutating func next() -> Carte?{
        var x : Carte = self.m.file[i]
        i = i + 1
        return x
    }
}
