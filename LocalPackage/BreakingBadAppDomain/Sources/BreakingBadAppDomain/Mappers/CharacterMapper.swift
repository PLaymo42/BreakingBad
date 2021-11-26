//
//  CharacterMapper.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import BreakingBadData

struct CharacterMapper: Mapper {

    func map(from input: Character) -> CharacterEntity {
        .init(
            id: input.id,
            name: input.name,
            birthday: input.birthday,
            occupation: input.occupation,
            headshotURL: input.headshotURL,
            status: input.status,
            appearance: input.appearance,
            nickname: input.nickname,
            portrayed: input.portrayed
        )
    }

}
