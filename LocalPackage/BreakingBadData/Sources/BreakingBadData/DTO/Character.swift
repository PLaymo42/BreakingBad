//
//  Character.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public struct Character: Decodable {
    public var id: Int
    public var name: String
    public var birthday: String
    public var occupation: [String]
    public var headshotURL: URL?
    public var status: String
    public var appearance: [Int]
    public var nickname: String
    public var portrayed: String

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case birthday
        case occupation
        case headshotURL = "img"
        case status
        case appearance
        case nickname
        case portrayed
    }
}
