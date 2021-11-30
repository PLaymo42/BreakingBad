import XCTest
@testable import BreakingBadData
import Helper

final class CharacterListRepositoryTests: XCTestCase {


    struct CharacterOutput {
        var name: String
    }

    struct CharacterMapper: Mapper {
        func map(from input: Character) -> CharacterOutput {
            .init(name: input.name)
        }
    }

    func testErrorCode() async {

        let session = NetworkSessionMock(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "www.google.com")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        let repository = CharacterListRepositoryImp(
            api: CharacterListAPI(),
            urlSession: session,
            mapper: CharacterMapper()
        )

        do {
            _ = try await repository.get(decoder: JSONDecoder())
        } catch {
            let statusError = error as? StatusCodeError
            XCTAssertNotNil(statusError)
            XCTAssertEqual(statusError?.code, 404)
        }

    }

    func testSuccess() async {
        let testData =
        """
        [
            {
                "char_id": 1,
                "name": "Walter White",
                "birthday": "09-07-1958",
                "occupation": [
                    "High School Chemistry Teacher",
                    "Meth King Pin"
                ],
                "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
                "status": "Presumed dead",
                "nickname": "Heisenberg",
                "appearance": [
                    1,
                    2,
                    3,
                    4,
                    5
                ],
                "portrayed": "Bryan Cranston",
                "category": "Breaking Bad",
                "better_call_saul_appearance": []
            },
            {
                "char_id": 2,
                "name": "Jesse Pinkman",
                "birthday": "09-24-1984",
                "occupation": [
                    "Meth Dealer"
                ],
                "img": "https://vignette.wikia.nocookie.net/breakingbad/images/9/95/JesseS5.jpg/revision/latest?cb=20120620012441",
                "status": "Alive",
                "nickname": "Cap n' Cook",
                "appearance": [
                    1,
                    2,
                    3,
                    4,
                    5
                ],
                "portrayed": "Aaron Paul",
                "category": "Breaking Bad",
                "better_call_saul_appearance": []
            }
            ]
        """.data(using: .utf8)!

        let session = NetworkSessionMock(
            data: testData,
            response: HTTPURLResponse(
                url: URL(string: "www.google.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        let repository = CharacterListRepositoryImp(
            api: CharacterListAPI(),
            urlSession: session,
            mapper: CharacterMapper()
        )

        do {
            let characters = try await repository.get(decoder: JSONDecoder())
            XCTAssertEqual(characters.count, 2)

            let names = characters.map { $0.name }
            XCTAssertEqual(names, ["Walter White", "Jesse Pinkman"])

        } catch {
            XCTFail("This shouldn't return an error \(error)")
        }

    }
}
