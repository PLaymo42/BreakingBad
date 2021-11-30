//
//  CharacterDetailEntity.swift
//  
//
//  Created by Anthony Soulier on 29/11/2021.
//

import Foundation

public struct CharacterDetailEntity: Equatable {
    public var infos: CharacterEntity
    public var quotes: [QuoteEntity]
}
