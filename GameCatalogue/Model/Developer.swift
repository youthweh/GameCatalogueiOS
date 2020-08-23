//
//  Developer.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 10/8/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//


import Foundation

struct Developer: Codable,Identifiable  {
    var id:Int
    var name:String
    var games_count:Int
    var image_background:String
    
    enum CodingKeys: String, CodingKey {
          case id
          case name
          case games_count
          case image_background
      }
      
      init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          
          id = try container.decode(Int.self, forKey: .id)
          name = try container.decode(String.self, forKey: .name)
          games_count = try container.decode(Int.self, forKey: .games_count)
          let path = try container.decode(String.self, forKey: .image_background)
          image_background =  "\(path)"
          
      }
    
}
