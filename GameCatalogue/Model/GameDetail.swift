//
//  GameDetail.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 10/8/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//id: 3498,description_raw: "Rock...."

import Foundation
struct GameDetail:Codable{
    
    let description_raw: String
    let id:Int

    let developers: [Developer]
       
    enum CodingKeys: String, CodingKey {
           case description_raw = "description_raw"
           case id = "id"
           case developers = "developers"
    }
    
}
