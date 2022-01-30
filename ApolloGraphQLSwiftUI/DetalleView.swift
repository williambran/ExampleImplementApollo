//
//  DetalleView.swift
//  ApolloGraphQLSwiftUI
//
//  Created by mac1 on 13/08/21.
//

import SwiftUI

struct DetalleView: View {
    
    var idPersona: String
    @State private var  personaje: GetPersonajeQuery.Data.Character?
    
    var body: some View {
        VStack{
            if personaje?.image == nil {
                ProgressView()
            }else{
                Image(systemName: "people.fill")
                    .data(url: URL(string: personaje?.image ?? "")!)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .clipShape(Circle())
                Text(personaje?.name ?? "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(personaje?.species ?? "").font(.subheadline)
                Text(personaje?.gender ?? "").font(.subheadline)
                Text(personaje?.status ?? "").font(.subheadline)

            }
        }.onAppear(perform: {
            Managger.shared.apollo.fetch(query: GetPersonajeQuery(id: idPersona)) { res in
                
                switch res {
                
                case .success(let graphql):
                    DispatchQueue.main.async {
                        personaje = graphql.data?.character
                    }
                    
                case .failure(let error):
                    print("error\(error.localizedDescription)")
                }
            }
        })
        
    }
}


extension Image{
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        return self .resizable()
    }
}

