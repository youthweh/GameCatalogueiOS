//
//  ContentView.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 15/7/20.
//  Copyright © 2020 Mrs.Haddock (Fiona Stefani Limin) . All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileDetailView: View {

    var body: some View {
        MyBadge().navigationBarTitle("About me")
    }
}

struct FavoriteListView: View {

    var body: some View {
        FavoriteView().navigationBarTitle("Favorite Movie")
    }
}

struct ContentView : View {
    
    @ObservedObject var fetch = NetworkingApi()
    
    var body: some View {

        NavigationView{

            List(fetch.gamedatas) { game in
            
                NavigationLink(destination: DetailView(gamedetail: game,gameid: game.id)) {
               
                VStack {
                  
                    WebImage(url: URL(string: "\(game.background_image)")).resizable().placeholder{/*Image("imageIcon")*/ LoadingView()}.transition(.fade)                            .aspectRatio(contentMode: .fill).frame(width: 340, height: 190).padding(.bottom,20)
                    
                    Spacer()
                                   
                    Text("\(game.name)")
                       .font(.system(size: 19, weight: .bold))
                        .fontWeight(.black)
                        //.foregroundColor(.white)
                        .lineLimit(2)
                                  
                    HStack{
                         ForEach(0..<Int(game.rating)){i in
                         Image(systemName: "star.fill").resizable().frame(width: 19, height: 19)
                             .foregroundColor(.yellow)
                         }
                        Text("(\(String(format: "%.1f", game.rating)))")
                    }//hstack
                    Text("Release: \(game.released)")
                        .font(.system(size: 12))
                    
                    
                    Spacer()
                    //vstack
                }.border(Color.purple, width: 4)
                    .cornerRadius(10)
                    .padding([.top])
                    
            }//end list
                    .navigationBarTitle("Game")
                .navigationBarItems(leading:
                    Button(action: {
                                       
                    }) {
                        Text("Home").font(.system(size: 18, weight: .bold))
                        },
                        trailing:
                    HStack{
                        NavigationLink(destination: ProfileDetailView()) {
                            Image(systemName: "person.circle").resizable().frame(width: 28, height: 28)//.foregroundColor(.yellow)
                        }
                        NavigationLink(destination: FavoriteListView()) {
                            Image(systemName: "heart.circle").resizable().frame(width: 28, height: 28).foregroundColor(.pink)
                        }
                        
                        
                        
                    }
                    
                    )//navigationbaritem

            }

                 
        }
     
    }

    
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        
        Group {
            //dark mode
            ContentView().environment(\.colorScheme, .dark)
            //light mode
            ContentView().environment(\.colorScheme, .light)
            
        }
        
    }
}

