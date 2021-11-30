import XCTest
@testable import BreakingBadData

final class CharacterListAPITests: XCTestCase {

    func testBuild() {
        let api = CharacterListAPI()

        let result = api.build()
        let expected = URLRequest(
            url: URL(string: "https://www.breakingbadapi.com/api/characters")!
        )

        XCTAssertEqual(result, expected)
    }

}
