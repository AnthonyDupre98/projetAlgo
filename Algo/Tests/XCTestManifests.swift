import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ProtocoleCarteTests.allTestsCarte),
	testCase(ProtocoleChampsDeBatailleTests.allTestsChampsDeBataille),
	testCase(ProtocoleCimetiereTests.allTestsCimetiere),
	testCase(ProtocoleMainTests.allTestsMain),
	testCase(ProtocolePiocheTests.allTestsPioche),
	testCase(ProtocolePositionTests.allTestsPosition),
	testCase(ProtocoleRoyaumeTests.allTestsRoyaume)
    ]
}
#endif
