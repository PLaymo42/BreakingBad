import XCTest
@testable import BreakingBadData

final class CharacterDetailsAPITests: XCTestCase {

    func testBuildWithoutId() {
        let api = CharacterDetailsAPI()
        let result = api.build()
        XCTAssertEqual(result, nil)
    }

    func testBuild() {
        var api = CharacterDetailsAPI()
        api.setCharacterID(9)

        let result = api.build()
        let expected = URLRequest(
            url: URL(string: "https://www.breakingbadapi.com/api/characters/9")!
        )

        XCTAssertEqual(result, expected)
    }
}
