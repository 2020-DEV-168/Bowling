//
//  Game.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 19/10/2020.
//

import Foundation

class Game {

    private let frames: [String]

    init(rolls: String) {
        self.frames = rolls
            .split(separator: Constants.framesSeparator)
            .map { String($0) }
    }

    func totalScore() -> Int {
        var total: Int = 0

        for frame in frames {
            let frameScore = computeFrameScore(for: frame)
            total += frameScore
            print("[\(total)] \(frameScore) for \(frame)")
        }

        return total
    }
}

private extension Game {

    func computeFrameScore(for frame: String) -> Int {
        let firstThrow = Int(frame.dropLast()) ?? 0
        let secondThrow = Int(frame.dropFirst()) ?? 0
        return firstThrow + secondThrow
    }
}

private enum Constants {

    static let framesSeparator: Character = " "
}
