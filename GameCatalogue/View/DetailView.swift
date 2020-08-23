//
//  DetailView.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 4/8/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


enum ActiveAlert {
    case first, second
}

struct DetailView: View {

    var gamedetail: Game
    var gameid:Int
    
    //@ObservedObject var fetch2 = DetailApi(nomorid: 3498)
    @ObservedObject var fetch2 = DetailApi()
    

   // @State var showAlert = false
    @State var showAlertFav = false
    
    @State private var showAlert = false
    
    @State private var isFavorite = false
    @State private var isFavoriteBaru = false
    
    @State var linelimit:Int = 2

    
    var body: some View {
     
        ScrollView(.vertical, showsIndicators: true, content: {

            WebImage(url: URL(string: "\(self.gamedetail.background_image)")).resizable().placeholder{LoadingView()}
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 400)

            VStack(alignment: .leading,spacing: 15){
                
                Text("\(gamedetail.name)")
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(2)
                // Text("\(gameid)")

                
                HStack(spacing: 15){
                    
                    ForEach(0..<Int(gamedetail.rating)){i in
                        Image(systemName: "star.fill").resizable().frame(width: 30, height: 30)
                            .foregroundColor(.yellow)
                    }
                    Text("(\(String(format: "%.1f", gamedetail.rating)))") .font(.system(size: 18, weight: .bold))
                }
                
                Text("Released date : \(gamedetail.released)")     .font(.system(size: 14, weight: .bold))
                    .padding(.top, 10)
                
              
                Text("\(fetch2.getDetail(nomorid: gameid))")            .padding(.top, 10)
                    .font(.system(size: 14)).lineLimit(self.linelimit)
       
                Button(action: {
                    self.linelimit = 30
                }) {
                    Text("Read more").font(.system(size: 14, weight: .bold))
                }
                

                Divider()
                
                HStack(alignment:.top, spacing:4){
                    VStack(alignment:.leading, spacing: 4){
                        Text("Developers:").font(.headline)
                        ForEach(fetch2.developersdatas){ dev in
                            Text("\(dev.name)").font(.system(size: 14))
                            
                        }
                        
                    }.frame(minWidth: 0,  alignment: .leading)
                    Spacer()
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment:.top,spacing: 4){
                            //Text("Image:").font(.headline)
                            ForEach(fetch2.developersdatas){ dev in
                                
                                WebImage(url: URL(string: "\(dev.image_background)")).resizable().placeholder{LoadingView()}
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                
                                
                            }
                            
                        }.frame(minWidth: 0,  alignment: .leading)
                    })
                }

                HStack(spacing: 15){
                    Button(action: {}, label: {
                        Text("Buy Now")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.blue)
                            .cornerRadius(19)
                    })
                    
                    Button(action: {
                        //save to favorite
                        let memberProvider: FavoriteProvider = { return FavoriteProvider() }()
                        
                        let id =  self.gamedetail.id
                        let name = "\(self.gamedetail.name)"
                        let deskripsi = "\(self.fetch2.getDetail(nomorid: self.gameid))"
                        let released = "\(self.gamedetail.released)"
                        let imagefav = "\(self.gamedetail.background_image)"
                        let rating = self.gamedetail.rating
                        
                        if self.isFavorite == false {
                            //add to favorite
                                  memberProvider.createMember(id,name,deskripsi, released, imagefav, rating) {
                                       DispatchQueue.main.async {
                            
                                         self.showAlert = true
                                    
                                       }
                                   }
                            self.isFavorite = true
                            self.isFavoriteBaru = true
                        }else {
                            print("game sudah pernah jadi favorit")
                            self.showAlert = true
 
                        }

                    }, label: {
                      if self.isFavorite{
                        Text(" Favorited")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.pink)
                            .cornerRadius(19)
                                            
                      }else {
                        Text("Favorite")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.red.opacity(0.5))
                            .cornerRadius(19)
                        }

                        
                    })

                }.alert(isPresented: $showAlert) {
                    var title:String = ""
                    var message: String = ""
                    if self.isFavoriteBaru == true && self.isFavoriteBaru == true {
                        
                        title = "Game Favorit Ditambah"
                        message = "Game \(self.gamedetail.name) berhasil ditambah ke favorit "
                        
                        
                    } else if self.isFavoriteBaru == false && self.isFavorite == true{
                        title = "Game Favorit Sudah Ada"
                        message = "Game \(self.gamedetail.name) sudah ada di favorit Anda "
                        
                        
                    }
                    
                    
                    return Alert(title: Text("\(title)"), message: Text("\(message)"), dismissButton: .default(Text("Okey!")))
                    
                }.padding(.top, 25)
            }.padding(10)
           // .padding(.top, 25)
           // .padding(.bottom,25)
    
       
        }).onAppear{
            
            let memberProvider: FavoriteProvider = { return FavoriteProvider() }()
            memberProvider.getMember(self.gamedetail.id){ member in
                DispatchQueue.main.async {
                    if member.id != 0{
                        self.isFavorite = true
                    }else {
                        self.isFavorite = false
                    }
                    
                }
                
            }

            
        }
            
            
        .edgesIgnoringSafeArea(.all)

  
    }//body


}

