//
//  NetworkApi.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 15/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation

class NetworkingApi:ObservableObject {

    @Published var gamedatas = [Game]()

     init() {
          let url = URL(string: "https://api.rawg.io/api/games")!
          URLSession.shared.dataTask(with: url) {(data,response,error) in
            //
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                          // decodeJSON(data: data)
                           let decoder = JSONDecoder()
                                              
                           let games = try! decoder.decode(GameList.self, from: data)
                           
                           DispatchQueue.main.async {
                            self.gamedatas = games.games
                           }
                
                            print("Game List: \(games)")
                            print("PAGE: \(games.totalResults)")
                            print("Game List: \(games)")
                                                     
                           games.games.forEach{ game in
                               print(game.id)
                               print("NAME: \(game.name)")
                               print("IMAGE: \(game.background_image)")
                               print("RELEASED: \(game.released)")
                               print("RATING: \(game.rating)")
                               
                               
                           }
                
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
          }.resume()
        
    }
    

    
        

}

