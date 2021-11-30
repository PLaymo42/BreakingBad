import XCTest
@testable import BreakingBadData

final class QuoteForAuthorAPITests: XCTestCase {

    func testBuildWithoutId() {
        let api = QuoteForAuthorAPI()
        let result = api.build()
        XCTAssertEqual(result, nil)
    }

    func testBuild() {
        var api = QuoteForAuthorAPI()
        api.setAuthor("Walter White")

        let result = api.build()
        let expected = URLRequest(
            url: URL(string: "https://www.breakingbadapi.com/api/quote?author=Walter+White")!
        )

        XCTAssertEqual(result, expected)
    }
}
