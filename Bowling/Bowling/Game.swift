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

        for index in 0...frames.count - 1 {
            let frameScore = computeFrameScore(at: index)
            total += frameScore
            print("[\(total)] \(frameScore) for \(frames[index])")
        }

        return total
    }
}

private extension Game {

    func computeFrameScore(at index: Int) -> Int {
        let frame = frames[index]

        if isSpare(frame) {
            return computeSpareScore(at: index)
        } else {
            let firstThrow = Int(frame.dropLast()) ?? 0
            let secondThrow = Int(frame.dropFirst()) ?? 0
            return firstThrow + secondThrow
        }
    }

    func isSpare(_ frame: String) -> Bool {
        return frame.contains(Constants.spare)
    }

    func computeSpareScore(at index: Int) -> Int {
        return 0
    }

}

private enum Constants {

    static let framesSeparator: Character = " "
    static let spare: Character = "/"
}
