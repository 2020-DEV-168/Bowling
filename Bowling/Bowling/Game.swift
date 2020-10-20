//
//  Game.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 19/10/2020.
//

import Foundation

class Game {

    private let frames: [Frame]

    init(rolls: String) {
        self.frames = rolls
            .split(separator: Constants.framesSeparator)
            .map { Frame(scores: String($0)) }
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
            return frame.pinCount
        }
    }

    func computeLastFrameScore() -> Int {
        return frames.last!.pinCount
    }

    func isSpare(_ frame: Frame) -> Bool {
        return frame.secondRoll?.symbol == Constants.spare
    }

    func computeSpareScore(at index: Int) -> Int {
        var frameScore = Constants.bonusScore
        if let nextFrame = nextFrame(after: index) {
            frameScore += nextFrame.firstRoll.pinCount
        }
        return frameScore
    }

    func nextFrame(after index: Int) -> Frame? {
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
