//
//  DetailApi.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 10/8/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation


class DetailApi:ObservableObject {

    @Published var developersdatas = [Developer]()
    var description:String = ""

    
    init(){
          let url = URL(string: "https://api.rawg.io/api/games/3498")!
          URLSession.shared.dataTask(with: url) {(data,response,error) in
            //
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                          // decodeJSON(data: data)
                           let decoder = JSONDecoder()
                                              
                           let developers = try! decoder.decode(GameDetail.self, from: data)
                           
                           DispatchQueue.main.async {
                            self.developersdatas = developers.developers

                            }
                
                            print("Developer List: \(developers)")
                            print("PAGE: \(developers.description_raw)")//ini penting
                                                    
                            developers.developers.forEach{ dev in
                             print(dev.id)
                             print("NAME: \(dev.name)")
                             print("IMAGE: \(dev.image_background)")
                            
                               
                               
                           }
                                              
                       } else {
                           print("ERROR: \(data), HTTP Status: \(response.statusCode)")
                       }
          }.resume()
        
      }
    func getDetail(nomorid:Int)-> String{
         let url = URL(string: "https://api.rawg.io/api/games/\(nomorid)")!

         URLSession.shared.dataTask(with: url) {(data,response,error) in
           //
           guard let response = response as? HTTPURLResponse, let data = data else { return }
           if response.statusCode == 200 {
                         // decodeJSON(data: data)
                          let decoder = JSONDecoder()
                                             
                          let developers = try! decoder.decode(GameDetail.self, from: data)
                          
                          DispatchQueue.main.async {
                            self.developersdatas = developers.developers
                            self.description = developers.description_raw
                           }
                            
                            print("Developer List: \(developers)")
                            //print("PAGE: \(developers.description_raw)")//ini penting
                                                   
                           developers.developers.forEach{ dev in
                            print(dev.id)
                            print("NAME: \(dev.name)")
                            print("IMAGE: \(dev.image_background)")
                           
                              
                              
                          }
                                             
                      } else {
                          print("ERROR: \(data), HTTP Status: \(response.statusCode)")
                      }
         }.resume()
        //print("Deskripsi: \(description)")
        return description
       
     }
    
        

}
