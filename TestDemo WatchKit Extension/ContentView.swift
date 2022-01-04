//
//  ContentView.swift
//  TestDemo WatchKit Extension
//
//  Created by Home on 4/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var pokemonAPIClient = PokemonAPIClient()
    @State var search: String = ""
    @State var isSearching: Bool = false
    
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 100)), count: 1)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(listPokemons()) { pokemon in
                        HStack(spacing: 0) {
                            VStack {
                                PokemonNameAndTypeView(pokemon: pokemon)
                                Spacer()
                                PokemonImageAndShadowView(pokemon: pokemon)
                            }
                        }
                        .overlay(Text("#\(pokemon.id)")
                                    .foregroundStyle(.tertiary)
                                    .font(.footnote)
                                    .padding())
                        .frame(maxWidth: .infinity, minHeight: 260)
                        .background(Color(Helpers.getColor(pokemonType: pokemon.types[0].type).0))
                        .cornerRadius(20)
                    }
                }
                .padding()
            }
            .navigationTitle("Pokemons")
            .background(Color.yellow)
            .onAppear {
                pokemonAPIClient.getPokemons()
            }
        }
        .searchable(text: $search)
    }
        
    func listPokemons() -> [PokemonFullInfoDataModel] {
        let values = pokemonAPIClient.pokemons.compactMap { $0.name.lowercased().hasPrefix(search.lowercased()) ? $0 : nil }
        print(values)
        return values
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
