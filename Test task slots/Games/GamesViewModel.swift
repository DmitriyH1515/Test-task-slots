//
//  GamesViewModel.swift
//  Test task slots
//
//  Created by Dmitriy Havrylenko on 19.06.2022.
//

import Foundation

struct Game {
    var image: String
}

class GamesViewModel {
    let allGames: [Game] = [
        Game(image: "Image-1"),
        Game(image: "Image-2"),
        Game(image: "Image-3")
    ]
    let popularGames: [Game] = [
        Game(image: "Image-1")
    ]
}
