//
//  MyBadge.swift
//  GameCatalogue
//
//  Created by Mrs.Haddock on 18/7/20.
//  Copyright © 2020 Mrs.Haddock. All rights reserved.
//


import SwiftUI

 struct MyBadge: View {
     var body: some View {
         Home()
     }
}

 
 struct Home : View {
     
     var body: some View{
        VStack{
         
            HStack{
                
                Image("fiona").resizable().frame(width: 100, height: 100)
                VStack{
                Text("Fiona Stefani Limin")
                    .font(.title)
                  
                                   
                Text("Mahasiswa ")
                    .padding(.top, 9)
                                   
                Text("stackOverflow : fiona16ti")
                   .padding(.top, 9)
                }
            
            }.padding(.top, 40)
     
            Text("Contact Me")
            .font(.title).fontWeight(.bold)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .foregroundColor( Color.blue)
   
            HStack{
                VStack{
                    Image("linkedin")
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                                                
                    Text("Fiona Stefani Limin")
                        .foregroundColor(Color.black)
                        .padding(.top, 9)
                }
                VStack{
                    Image("mail")
                      .resizable()
                      .frame(width: 80, height: 80)
                    
                    Text("fiona16ti@gmail.com")
                       .foregroundColor(Color.black)
                        .padding(.top, 9)
                }

                
            }
            Spacer(minLength: 0)

        }
         
       
     }
 }

struct MyBadge_Previews: PreviewProvider {
    static var previews: some View {
        MyBadge()
    }
}
