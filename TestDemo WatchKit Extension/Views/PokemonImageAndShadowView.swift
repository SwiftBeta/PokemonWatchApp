//
//  PokemonImageAndShadowView.swift
//  PokemonImageAndShadowView
//
//  Created by Home on 8/8/21.
//

import SwiftUI

struct PokemonImageAndShadowView: View {
    var pokemon: PokemonFullInfoDataModel
    
    var body: some View {
        HStack {
            ZStack {
                Color(Helpers.getColor(pokemonType: pokemon.types[0].type).1)
                    .cornerRadius(60)
                    .frame(width: 120, height: 120)
                    .offset(x: 10)
                AsyncImage(url: pokemon.url,
                           content: {
                        $0
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                }) { ProgressView() }
            }
        }
    }
}

struct PokemonImageAndShadowView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageAndShadowView(pokemon: PokemonFullInfoDataModel(id: 1, name: "SwiftBeta", imageURL: "", types: [PokemonTypeDataModel(id: UUID().uuidString, type: "grass")]))
            .previewLayout(.sizeThatFits)
    }
}
