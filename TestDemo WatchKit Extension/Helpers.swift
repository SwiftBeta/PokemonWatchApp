//
//  Helpers.swift
//  Helpers
//
//  Created by Home on 8/8/21.
//

import Foundation

struct Helpers {
    static func getColor(pokemonType: String) -> (String, String) {
        switch pokemonType {
        case "grass":
            return ("poke_green", "poke_lightgreen")
        case "fire":
            return ("poke_red", "poke_lightred")
        case "water":
            return ("poke_blue", "poke_lightblue")
        case "electric":
            return ("poke_yellow", "poke_lightyellow")
        case "normal":
            return ("poke_brown", "poke_lightbrown")
        case "poison":
            return ("poke_purple", "poke_lightpurple")
        case "bug":
            return ("poke_white", "poke_lightwhite")
        default:
            return ("", "")
        }
    }
    
    static func getType(pokemonType: String) -> String {
        switch pokemonType {
        case "grass":
            return "🍃 grass"
        case "fire":
            return "🔥 fire"
        case "water":
            return "💦 water"
        case "electric":
            return "⚡️ electric"
        case "normal":
            return "🐾 normal"
        case "poison":
            return "☠️ poison"
        case "bug":
            return "🐛 bug"
        case "flying":
            return "🌬 flying"
        case "fairy":
            return "🧚‍♀️ fairy"
        default:
            return pokemonType
        }
    }
}
