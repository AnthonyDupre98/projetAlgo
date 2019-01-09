import XCTest
import typesAOW

final class ProtocoleCarteTests: XCTestCase {

	func testInit() {
		var carte = ProtocoleCarte("Roi A")
		XCTAssertEqual(1, carte.afficheattaque())
		XCTAssertEqual(4, carte.affichedefenseD())
		XCTAssertEqual(4, carte.affichedefenseO())
	}

	func testaffichernom() {
		var carte = ProtocoleCarte("Roi A")
		XCTAssertEqual("Roi A", carte.affichernom())
	}

	func testdegatsCumules() {
		var carte1 = ProtocoleCarte("Garde")
		carte1.ajoutDegats(1)
		carte1.ajoutDegats(1)
		XCTAssertEqual(2, carte1.degatsCumules())
		
	}

	func testestRetournee() {
		var carte1 = ProtocoleCarte("Garde")
		carte1.redresser()
		XCTAssertEqual(false, carte1.estRetournee())
		carte1.retourner()
		XCTAssertEqual(true, carte1.estRetournee())
	}	

	func testAjoutDegat() {
		var carte1 = ProtocoleCarte("Garde")
		carte1.ajoutDegat(2)
		XCTAssertEqual(1, carte1.affichedefenseD())
		carte1.ajoutDegat(500)
		XCTAssertEqual(0, carte1.affichedefenseD())
	}

	func testRetourner() {
		var carte = ProtocoleCarte("Garde")
		carte.retourner()
		XCTAssertEqual(true, carte.estRetournee())
	}

	func testRedresser() {
		var carte = ProtocoleCarte("Garde")
		carte.retourner()
		carte.ajoutDegat(2)
		carte.redresser()
		XCTAssertEqual(false, carte.estRetournee())
	}

    static var allTestsCarte = [
        ("testInit", testInit),
		("testaffichernom", testaffichernom),
		("testdegatsCumules", testdegatsCumules),
		("testestRetournee", testestRetournee),
		("testAjoutDegat", testAjoutDegat),
		("testRetourner", testRetourner),
		("testRedresser", testRedresser)
    ]	

}

final class ProtocoleChampsDeBatailleTests: XCTestCase {
	
	func testInit() {
		var C1 = ProtocoleChampsDeBataille()
		var i = 0
		var erreur = 0
		for unePosition in C1.position {
			var posF = "F"+i
			var posA = "A"+i
			if unePosition.estFront() {
				if !(posF == unePosition.front + unePosition.getColonne()) {
					erreur += 1		
				}  
			} else {
				if !(posA == unePosition.front + unePosition.getColonne()) {
					erreur += 1
				}
			}
			i += 1
		}
		XCTAssertEqual(0, erreur)
	}

	func testSortir() {
		var C1 = ProtocoleChampsDeBataille()
		var carte = ProtocoleCarte("soldat")
		var p1 = ProtocolePosition(true, 1)
		C1.poser(c: carte, p: p1)	
		var carte1 = C1.sortir(p1)
		XCTAssertEqual(false, C1.checkCarte(p1))
		XCTAssertEqual(carte, carte1)
		XCTAssertEqual("Exception", C1.checkCarte(ProtocolePosition(false,1)))
	}
	
	func testPoser() {
		var C1 = ProtocoleChampsDeBataille()
		var carte = ProtocoleCarte("soldat")
		var p1 = ProtocolePosition(false, 1)	
		C1.poser(carte, p1) //Impossible de la placer à l'arrière car il n'y a pas de carte, elle est donc placée au front.
		XCTAssertEqual(true, C1.checkCarte(ProtocolePosition(true,1)))
		C1.poser(ProtocoleCarte("soldat"), ProtocolePosition(false,1))
		XCTAssertEqual(false, C1.checkCarte(ProtocolePosition(false,1)))
		XCTAssertEqual(false, C1.checkCarte(ProtocolePosition(false,0)))
	}

	func testDeplacer() {
		var C1 = ProtocoleChampsDeBataille()
		var carte1 = ProtocoleCarte("soldat")
		var carte2 = ProtocoleCarte("soldat")
		var p1 = ProtocolePosition(false, 1)	
		var p2 = ProtocolePosition(true, 1)
		C1.poser(carte1, p1)
		C1.poser(carte2, p2)
		carte1.ajouterDegats(12)
		C1.supprimer(p1)
		C1.deplacer(1)
		XCTAssertEqual(true, C1.checkCarte(p1))
		XCTAssertEqual(false, C1.checkCarte(p2))
	}

	func testSupprimer() {
		var C1 = ProtocoleChampsDeBataille()
		var carte = ProtocoleCarte("soldat")
		var p1 = ProtocolePosition(true, 1)	
		C1.poser(carte, p1)
		C1.supprimer(p1)
		XCTAssertEqual(false, C1.checkCarte(p1))		
	}

	func testestAportee() {
		var C1 = ProtocoleChampsDeBataille()
		var C2 = ProtocoleChampsDeBataille()
		var carte = ProtocoleCarte("soldat")
		var p1 = ProtocolePosition(true, 1)
		var p2 = ProtocolePosition(true, 1)	
		C1.poser(carte, p1)
		C2.poser(carte, p2)
		XCTAssertEqual(true,C1.estAportee(p1, C2, p2))
	}

	func testestVide() {
		var C1 = ProtocoleChampsDeBataille()
		XCTAssertEqual(true, C1.estVide())
		C1.poser(ProtocoleCarte("soldat"), ProtocolePosition(true,1))
		XCTAssertEqual(false, C1.estVide())
	}

    static var allTestsChampsDeBataille = [
        ("testInit", testInit),
		("testSortir", testSortir),
		("testPoser", testPoser),
		("testDeplacer", testDeplacer),
		("testSupprimer", testSupprimer),
		("testestAportee", testestAportee),
		("testestVide", testestVide)
    ]
}


final class ProtocoleCimetiereTests: XCTestCase {
	
	func testInit() {
		var C = ProtocoleCimetiere()
		XCTAssertEqual(true, C.estVide())
	}

	func testAjouter() {
		var C = ProtocoleCimetiere()
		var carte = ProtocoleCarte("soldat")
		C.ajouter(carte)
		XCTAssertEqual(false, C.estVide())
	}

    static var allTestsCimetiere = [
        ("testInit", testInit),
		("testAjouter", testAjouter)
    ]
}

final class ProtocoleMainTests: XCTestCase {
	
	func testInit() {
		var M = ProtocoleMain()
		XCTAssertEqual(false, M.taille())
	}

	func testAjouter() {
		var M = ProtocoleMain()
		var carte = ProtocoleCarte("soldat")
		M.ajouter(carte)
	}

	func testRetirer() {
		var M = ProtocoleMain()
		var carte = ProtocoleCarte("soldat")
		M.ajouter(carte)
		let c = M.retirer("soldat")
		XCTAssertEqual(carte, c)
	}

    static var allTestsMain = [
        ("testInit", testInit),
		("testAjouter", testAjouter),
		("testRetirer", testRetirer)
    ]
}

final class ProtocolePiocheTests: XCTestCase {

	func testInit() {
		var P = ProtocolePioche()
		XCTAssertEqual(20, P.getnbCartes())
	}

	func testPiocher() {
		var P = ProtocolePioche()
		let carte = P.piocher()
		XCTAssertEqual(ProtocoleCarte, carte)
	}

	func testgetnbCartes() {
		var P = ProtocolePioche()
		XCTAssertEqual(20, P.getnbCartes())
	}

    static var allTestsPioche = [
        ("testInit", testInit),
		("testPiocher", testPiocher),
		("testgetnbCartes", testgetnbCartes)
    ]
}

final class ProtocolePositionTests: XCTestCase {
	
	func testInit() {
		var C1 = ProtocoleChampsDeBataille()
		var carte = ProtocoleCarte("soldat")
		var p = ProtocolePosition(true, 1)
		C1.placer(carte, p)		
		XCTAssertTrue(p is ProtocoleCarte)
	}

	func testAfficher() {
		var p = ProtocolePosition(true, 1)
		XCTAssertEqual(nil, p.afficher())
		var C1 = ProtocoleChampsDeBataille()
		C1.poser(ProtocoleCarte("soldat"), p)
		XCTAssertEqual(C1, p.afficher())
		
	}

	func testEstFront() {
		var p = ProtocolePosition(true, 1)
		XCTAssertEqual(true, p.estFront())	
	}

	func testgetColonne() {
		var p = ProtocolePosition(true, 1)
		XCTAssertEqual(true, p.getColonne())
	}

    static var allTestsPosition = [
        ("testInit", testInit),
		("testAfficher", testAfficher),
		("testEstFront", testEstFront),
		("testgetColonne", testgetColonne)
    ]
	
}

final class ProtocoleRoyaumeTests: XCTestCase {
	
	func testInit() {
		var R = ProtocoleRoyaume()
		XCTAssertEqual(0, R.getnbCartes())
	}
	
	func testVoirSuivant() {
		var R = ProtocoleRoyaume()
		XCTAssertEqual(nil, R.VoirSuivant())
		var carte = ProtocoleCarte("soldat")
		R.placer(carte)
		XCTAssertEqual(carte, R.VoirSuivant())
		
	}

	func testPlacer() {
		var R = ProtocoleRoyaume()
		R.placer(ProtocoleCarte("soldat"))
		XCTAssertEqual(ProtocoleCarte("soldat"), R.VoirSuivant())
	}

	func testRetirer() {
		var R = ProtocoleRoyaume()
		R.placer(ProtocoleCarte("soldat"))
		XCTAssertEqual(ProtocoleCarte("soldat"), R.retirer())
		XCTAssertEqual(false, R.getnbCartes())
	}

	func testgetnbArchers() {
		var R = ProtocoleRoyaume()
		R.placer(ProtocoleCarte("archer"))
		R.placer(ProtocoleCarte("archer"))
		XCTAssertEqual(2, R.getnbArchers())
	}

	func testgetnbGardes() {
		var R = ProtocoleRoyaume()
		R.placer(ProtocoleCarte("garde"))
		R.placer(ProtocoleCarte("garde"))
		XCTAssertEqual(2, R.getnbGardes())
	}

	func testgetnbSoldats() {
		var R = ProtocoleRoyaume()
		R.placer(ProtocoleCarte("soldat"))
		R.placer(ProtocoleCarte("soldat"))
		XCTAssertEqual(2, R.getnbSoldats())
	}

	func testgetnbCartes() {
		var R = ProtocoleRoyaume()
		R.placer(ProtocoleCarte("soldat"))
		R.placer(ProtocoleCarte("soldat"))
		R.placer(ProtocoleCarte("garde"))
		R.placer(ProtocoleCarte("garde"))
		XCTAssertEqual(4, R.getnbCartes())
	}

    static var allTestsRoyaume = [
        ("testInit", testInit),
		("testVoirSuivant", testVoirSuivant),
		("testPlacer", testPlacer),
		("testRetirer", testRetirer),
		("testgetnbArchers", testgetnbArchers),
		("testgetnbGardes", testgetnbGardes),
		("testgetnbSoldats", testgetnbSoldats),
		("testgetnbCartes", testgetnbCartes)
    ]
}
