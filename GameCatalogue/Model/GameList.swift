//
//  GameList.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 16/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation

struct GameList: Codable {

    let totalResults: Int

    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "count"
        case games = "results"
    }
}


