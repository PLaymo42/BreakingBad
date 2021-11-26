//
//  CharacterEntity.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct CharacterEntity: Decodable {
    public var id: Int
    public var name: String
    public var birthday: String
    public var occupation: [String]
    public var headshotURL: URL?
    public var status: String
    public var appearance: [Int]
    public var nickname: String
    public var portrayed: String
}
