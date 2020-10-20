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

    func computeLastFrameScore() -> Int {
        let frame = frames[frames.count - 1]

        return frame.map { character in
            switch character {
            case Constants.spare, Constants.strike:
                return Constants.bonusScore
            default:
                return Int(String(character)) ?? 0
            }
        }.reduce(0, +)
    }

    func isSpare(_ frame: String) -> Bool {
        return frame.contains(Constants.spare)
    }

    func computeSpareScore(at index: Int) -> Int {
        var frameScore = Constants.bonusScore
        if let nextFrame = nextFrame(after: index) {
            frameScore += nextFrame.intValue(at: 0)
        }
        return frameScore
    }

    func nextFrame(after index: Int) -> String? {
        if index < frames.count - 1 {
            return frames[index + 1]
        } else {
            return nil
        }
    }
}

private enum Constants {

    static let framesSeparator: Character = " "
    static let spare: Character = "/"
    static let strike: Character = "X"
    static let bonusScore: Int = 10
}

private extension String {

    func intValue(at index: Int) -> Int {
        let position = self.index(startIndex, offsetBy: index + 1)
        let character = self[position]
        switch character {
        case "1"..."9":
            return Int(String(character))!
        case Constants.strike:
            return 10
        default:
            return 0
        }
    }
}
