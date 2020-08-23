//
//  FavoriteService.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 31/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation
class FavoriteService:ObservableObject {

    @Published var favoritedatas = [FavoriteModel]()
    
    private var members: [FavoriteModel] = []
    private var memberId: Int = 0
    private lazy var memberProvider: FavoriteProvider = { return FavoriteProvider() }()

     init() {
         
        self.memberProvider.getAllMember{ (result) in
            DispatchQueue.main.async {
                self.favoritedatas = result
        
        
            }
           
        }
        
        
      }
    
    //untuk refresh data list setelah dihapus
    func fetchData(){
         
        self.memberProvider.getAllMember{ (result) in
            DispatchQueue.main.async {
                self.favoritedatas = result
        
        
            }
           
        }
    }
        

}
