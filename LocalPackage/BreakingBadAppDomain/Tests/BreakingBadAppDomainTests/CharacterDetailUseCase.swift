import XCTest
@testable import BreakingBadAppDomain
import BreakingBadData

fileprivate struct AnyError: Error {
}

final class BreakingBadAppDomainTests: XCTestCase {

    struct CharacterDetailRepositoryMock: CharacterDetailsRepository {
        var character: CharacterEntity?
        var error: Error? = nil
        func get(id: Int, decoder: JSONDecoder) async throws -> CharacterEntity? {
            if let error = error {
                throw error
            }
            return character
        }
    }

    struct QuoteForAuthorRepositoryMock: QuoteForAuthorRepository {
        var quotes: [QuoteEntity]
        var error: Error? = nil
        func get(forAuthor author: String, decoder: JSONDecoder) async throws -> [QuoteEntity] {
            if let error = error {
                throw error
            }
            return quotes
        }
    }

    func testGetDetail() async {

        let characterRepo = CharacterDetailRepositoryMock(
            character: CharacterEntity(
                id: 9,
                name: "name",
                birthday: "01-01-2002",
                occupation: [],
                headshotURL: nil,
                status: .dead,
                appearance: [1,2,3],
                nickname: "nickname",
                portrayed: "actor name"
            )
        )

        let quoteRepo = QuoteForAuthorRepositoryMock(
            quotes: [
                .init(id: 0, quote: "quote 0", author: "author 0"),
                .init(id: 1, quote: "quote 1", author: "author 1"),
                .init(id: 2, quote: "quote 2", author: "author 2")
            ]
        )

        let useCase = CharacterDetailUseCaseImp(
            characterRepository: characterRepo,
            quotesRepository: quoteRepo
        )

        let details = try! await useCase.get(id: 0)
        XCTAssertEqual(details?.quotes, quoteRepo.quotes)
        XCTAssertEqual(details?.infos, characterRepo.character)

    }

    func testGetDetailErrorCharaterRepo() async {

        let characterRepo = CharacterDetailRepositoryMock(
            character: nil,
            error: AnyError()
        )

        let quoteRepo = QuoteForAuthorRepositoryMock(
            quotes: [
                .init(id: 0, quote: "quote 0", author: "author 0"),
                .init(id: 1, quote: "quote 1", author: "author 1"),
                .init(id: 2, quote: "quote 2", author: "author 2")
            ]
        )

        let useCase = CharacterDetailUseCaseImp(
            characterRepository: characterRepo,
            quotesRepository: quoteRepo
        )

        do {
            _ = try await useCase.get(id: 0)
        } catch {
            XCTAssertTrue(error is AnyError)
        }

    }
}
