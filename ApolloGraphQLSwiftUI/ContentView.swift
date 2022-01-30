//
//  ContentView.swift
//  ApolloGraphQLSwiftUI
//
//  Created by mac1 on 13/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var personajes = [PersonajesQuery.Data.Character.Result]()
    
    var body: some View {
        NavigationView{
            VStack{
                List(personajes, id:\.id){ item in
                    NavigationLink(destination: DetalleView(idPersona: item.id ?? "1")){
                        VStack{
                            Text(item.name ?? "").font(.title)
                            Text(item.species ?? "").font(.subheadline)
                        }
                        
                    }

                    
                }
            }.navigationTitle("API GRAPHQL")
            .onAppear(perform:{
                Managger.shared.apollo.fetch(query: PersonajesQuery()){ res in
                    
                    switch res {
                    
                    case .success(let graphql):
                        DispatchQueue.main.async {
                            personajes = graphql.data?.characters?.results as! [PersonajesQuery.Data.Character.Result]
                        }
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            })
        }
    }
}

