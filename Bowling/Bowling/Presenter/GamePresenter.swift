//
//  GamePresenter.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 20/10/2020.
//

import Foundation

protocol GamePresenterDelegate: NSObjectProtocol {

    func display(game: Game)
}

class GamePresenter {

    weak var delegate: GamePresenterDelegate?

    func loadGame(with scores: String) {
        let newGame = Game(scores: scores)
        delegate?.display(game: newGame)
    }
}
