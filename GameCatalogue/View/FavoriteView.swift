//
//  FavoriteView.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 31/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//
import SwiftUI
import Foundation
import SDWebImageSwiftUI

struct FavoriteView: View {
    
    
    var body: some View {
        
        FavoriteList()
        
    }
}

struct FavoriteList: View {
    @ObservedObject var fetch = FavoriteService()

    var body: some View {
        listView
    }

    var listView: AnyView {
        if self.fetch.favoritedatas.isEmpty {
            return AnyView(emptyListView)
        } else {
            return AnyView(favoritesListView)
        }
    }
    
    var emptyListView: some View {
        VStack{
            Image(systemName: "heart.fill").resizable().frame(width: 40, height: 40).foregroundColor(.pink)
            
            Text("Belum ada data game favorit").font(.system(size: 19, weight: .bold))
            
        }
    }

    var favoritesListView: some View {
        List(fetch.favoritedatas) { fav in
            NavigationLink(destination: DetailFavoriteView(favoritedetail: fav)) {
                
                VStack{
                    WebImage(url: URL(string: "\(fav.imagefav!)")).resizable().placeholder{/*Image("imageIcon")*/ LoadingView()}.transition(.fade)                            .aspectRatio(contentMode: .fill).frame(width: 340, height: 200)
                    
                    Spacer()
                    Text("\(fav.name!)").font(.system(size: 19, weight: .bold))
                        .fontWeight(.black)
                        .lineLimit(3)
                    
                    HStack{
                        ForEach(0..<Int(fav.rating!)){i in
                            Image(systemName: "star.fill").resizable().frame(width: 19, height: 19)
                                .foregroundColor(.yellow)
                        }
                        
                        Text("(\(String(format: "%.1f", fav.rating!)))")
                    }//hstack
                    
                    Text("Release : \(fav.released!)").font(.caption)
                    //Text("\(fav.id!)").font(.caption)
                    
                    Spacer()
                    
                    
                }.border(Color.pink, width: 4)
                    .cornerRadius(10)
                    .padding([.top])
                
                
            }//navigation link
            
            
        }.onAppear{
            //refresh list data
            self.fetch.fetchData()
            
        }
    }
}


struct DetailFavoriteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var favoritedetail: FavoriteModel
    
    
    @State private var isFavorite = false
    
    func dismiss(){
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
    @State var showAlert = false
    
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: true, content: {
            
            WebImage(url: URL(string: "\(self.favoritedetail.imagefav!)")).resizable().placeholder{LoadingView()}
                .aspectRatio(contentMode: .fill)
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 400)
            
            VStack(alignment: .leading,spacing: 15){
                
                Text("\(favoritedetail.name!)")
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(2)
                
                HStack(spacing: 15){
                    
                    ForEach(0..<Int(favoritedetail.rating!)){i in
                        Image(systemName: "star.fill").resizable().frame(width: 30, height: 30)
                            .foregroundColor(.yellow)
                    }
                    Text("(\(String(format: "%.1f", favoritedetail.rating!)))") .font(.system(size: 14, weight: .bold))
                }
                
                Text("Released date : \(favoritedetail.released!)")
                    .padding(.top, 10).font(.system(size: 14))
                
                Text(" \(favoritedetail.deskripsi!)")     .padding(.top, 10)
                    .font(.system(size: 14))
          
                    
                /* Text("id : \(favoritedetail.id!)")
                 .padding(.top, 10)*/
                
                
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        //alert konfirmasi hapus
                        self.showAlert = true
                        
                    }, label: {
                        Text("Hapus Favorit")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.blue)
                            .cornerRadius(19)
                    })
                    
                    /*hstack*/} .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Apakah Anda yakin?"),
                            message: Text("Apakah Game ini dihapus dari favorit?"),
                            primaryButton: .destructive(Text("Ya"), action:{
                                let memberId = self.favoritedetail.id!
                                
                                let memberProvider: FavoriteProvider = { return FavoriteProvider() }()
                                
                                //delete favorite
                                memberProvider.deleteMember(Int(memberId)) {
                                    DispatchQueue.main.async {
                                        print("id \(memberId) berhasil dihapus")
                                        
                                        self.dismiss()
                                        
                                    }
                                }
                            }//action
                            ),
                            secondaryButton: .cancel(Text("Tidak"), action: dismiss)
                        )
                }
      
            }.padding(10)
            
        })
            .edgesIgnoringSafeArea(.all)
        
    }//body
}



struct EmptyListView: View {
    
    @State var putar: Bool = false
    var body: some View {
        VStack{
            Image(systemName: "heart.fill").resizable().frame(width: 40, height: 40).foregroundColor(.pink)
            
            Text("Belum ada data game favorit").font(.system(size: 19, weight: .bold))
                
        }.onAppear{ self.putar.toggle() }
        
    }
}



struct FavoriteView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            //dark mode
            FavoriteView().environment(\.colorScheme, .dark)
            //light mode
            FavoriteView().environment(\.colorScheme, .light)
            
        }
    }
}
