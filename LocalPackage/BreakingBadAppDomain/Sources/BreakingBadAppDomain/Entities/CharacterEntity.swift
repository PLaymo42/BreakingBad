//
//  CharacterEntity.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct CharacterEntity: Equatable {

    public enum Status: String {
        case alive = "Alive"
        case presumedDead = "Presumed Dead"
        case dead = "Deceased"
        case unknown
    }

    public init(id: Int,
                name: String,
                birthday: String,
                occupation: [String],
                headshotURL: URL? = nil,
                status: Status,
                appearance: [Int],
                nickname: String,
                portrayed: String
    ) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.occupation = occupation
        self.headshotURL = headshotURL
        self.status = status
        self.appearance = appearance
        self.nickname = nickname
        self.portrayed = portrayed
    }

    public var id: Int
    public var name: String
    public var birthday: String
    public var occupation: [String]
    public var headshotURL: URL?
    public var status: Status
    public var appearance: [Int]
    public var nickname: String
    public var portrayed: String
}
