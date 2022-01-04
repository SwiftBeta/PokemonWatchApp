//
//  PokemonNameAndTypeView.swift
//  PokemonNameAndTypeView
//
//  Created by Home on 8/8/21.
//

import SwiftUI

struct PokemonNameAndTypeView: View {
    var pokemon: PokemonFullInfoDataModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                HStack {
                    Text(pokemon.name)
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .foregroundStyle(.primary)
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                }
                ForEach(pokemon.types) { type in
                    Text(Helpers.getType(pokemonType: type.type))
                        .font(.system(size: 14, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(Helpers.getColor(pokemonType: type.type).1))
                        .cornerRadius(20)
                        .padding(.horizontal, 12)
                }
            }
        }
    }
}
struct PokemonNameAndTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonNameAndTypeView(pokemon: PokemonFullInfoDataModel(id: 1, name: "SwiftBeta", imageURL: "", types: [PokemonTypeDataModel(id: UUID().uuidString, type: "grass")]))
            .previewLayout(.sizeThatFits)
    }
}
