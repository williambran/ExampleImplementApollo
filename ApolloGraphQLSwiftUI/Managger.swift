//
//  Managger.swift
//  ApolloGraphQLSwiftUI
//
//  Created by mac1 on 13/08/21.
//

import Foundation
import Apollo

class Managger {
    
    static let shared = Managger()
    
    lazy var apollo = ApolloClient(url:URL(string: "https://rickandmortyapi.com/graphql")!)
    
    
}
