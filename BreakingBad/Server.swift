//
//  Server.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 31/03/2022.
//

import Foundation
import BreakingBadData

enum Server {
    
    static let breakingBadService = BreakingBadService(urlSession: .shared)
    
}
