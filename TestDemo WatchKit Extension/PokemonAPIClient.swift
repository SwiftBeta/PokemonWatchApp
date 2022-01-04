//
//  PokemonAPIClient.swift
//  SwiftBetaPokemon
//
//  Created by Home on 25/6/21.
//

import Foundation
import UIKit

struct PokemonResponseDataModel: Decodable {
    let count: Int
    let next: String
    let results: [PokemonBasicInfoDataModel]
}

struct PokemonBasicInfoDataModel: Decodable {
    let name: String
    let url: String
}

struct PokemonTypeDataModel: Equatable, Decodable, Identifiable {
    var id = UUID().uuidString
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
    }
    
    init(id: String, type: String) {
        self.id = id
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)

        self.type = try type.decode(String.self, forKey: .name)
    }
}

struct PokemonFullInfoDataModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let imageURL: String?
    let types: [PokemonTypeDataModel]
    
    var url: URL {
        URL(string: imageURL ?? "http://www.google.com")!
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites
        case other
        case officialArtwork = "official-artwork"
        case frontDefault = "front_default"
        case types
    }
    
    init(id: Int, name: String, imageURL: String?, types: [PokemonTypeDataModel]) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.types = types
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        let sprites = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        let other = try sprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let officialArtwork = try other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        self.imageURL = try officialArtwork.decode(String.self, forKey: .frontDefault)
        self.types = try container.decode([PokemonTypeDataModel].self, forKey: .types)
    }
}

final class PokemonAPIClient: ObservableObject {
    
    @Published var pokemons: [PokemonFullInfoDataModel] = []
    
    func getPokemons() {
        var allPokemons: [PokemonFullInfoDataModel] = []
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151")!
        
        let getListOfPokemonsTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                let pokemons = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                
                for pokemon in pokemons.results {
                    let pokemonInfoURL = URL(string: pokemon.url)!
                    URLSession.shared.dataTask(with: pokemonInfoURL) { data, response, error in
                        if let data = data, error == nil {
                            let pokemon = try! JSONDecoder().decode(PokemonFullInfoDataModel.self, from: data)
                            print("Pokemon \(pokemon)")
                            allPokemons.append(pokemon)
                            
                            DispatchQueue.main.async {
                                self.pokemons = allPokemons.sorted(by: { $0.id < $1.id })
                            }
                        }
                    }.resume()
                }
            }
        }
        
        getListOfPokemonsTask.resume()
    }
}
