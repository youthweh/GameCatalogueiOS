//
//  FavoriteMode;.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 31/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation
import UIKit
struct FavoriteModel : Codable,Identifiable {
    
    var id:Int32?
    var name:String?
    var deskripsi:String?
    var released: String?
    var imagefav:String?
    var rating: Double?
    
}
