//
//  Mapper.swift
//  
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation

public protocol Mapper {
    associatedtype IN
    associatedtype OUT
    func map(from input: IN) -> OUT
}
