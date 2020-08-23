//
//  Game.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 15/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//
/*id: 3498,
slug: "grand-theft-auto-v",
name: "Grand Theft Auto V",
released: "2013-09-17",
tba: false,
background_image: "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg",
rating: 4.48,
rating_top: 5,*/

import Foundation

struct Game: Codable,Identifiable  {
    var id:Int
    var name:String
    var released: Date
    var background_image:String
    var rating: Double
 
    
    enum CodingKeys: String, CodingKey {
          case id
          case name
          case released
          case background_image
          case rating
      }
      
      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          
          let path = try container.decode(String.self, forKey: .background_image)
        
         let dateString = try container.decode(String.self, forKey: .released)
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          let date = dateFormatter.date(from: dateString)!

          background_image = path
      
          name = try container.decode(String.self, forKey: .name)
          id = try container.decode(Int.self, forKey: .id)
          rating = try container.decode(Double.self, forKey: .rating)
          
          released = date
          
      }
    
}
