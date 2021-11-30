//
//  CharacterMapper.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

public struct CharacterMapper: Mapper {

    public init() { }

    public func map(from input: Character) -> CharacterEntity {
        .init(
            id: input.id,
            name: input.name,
            birthday: input.birthday,
            occupation: input.occupation,
            headshotURL: input.headshotURL,
            status: .init(rawValue: input.status) ?? .unknown,
            appearance: input.appearance,
            nickname: input.nickname,
            portrayed: input.portrayed
        )
    }

}
