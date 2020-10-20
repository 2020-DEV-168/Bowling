//
//  Game.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 19/10/2020.
//

class Game {

    private var frames = [Frame]()

    init(rolls: String) {
        let allRolls = rolls
            .split(separator: Constants.rollsSeparator)

        let firstFrames = allRolls[0...8].map { Frame(scores: String($0)) }
        let lastFrame = Frame(scores: allRolls[9...].joined(), isLastFrame: true)

        frames.append(contentsOf: firstFrames)
        frames.append(lastFrame)
    }

    func totalScore() -> Int {
        var total: Int = 0

        for index in 0...frames.count - 1 {
            total += computeFrameScore(at: index)
        }

        return total
    }
}

private extension Game {

    func computeFrameScore(at index: Int) -> Int {
        let frame = frames[index]

        if frame.isLastFrame {
            return frame.pinCount
        } else {
            if isSpare(frame) {
                return computeSpareScore(at: index)
            }
            if isStrike(frame) {
                return computeStrikeScore(at: index)
            }
            return frame.pinCount
        }
    }

    func isSpare(_ frame: Frame) -> Bool {
        return frame.secondRoll?.symbol == Constants.spare
    }

    func isStrike(_ frame: Frame) -> Bool {
        return frame.firstRoll.symbol == Constants.strike
    }

    func computeSpareScore(at index: Int) -> Int {
        var frameScore = Constants.bonusScore

        if let nextFrame = nextFrame(after: index) {
            frameScore += nextFrame.firstRoll.pinCount
        }

        return frameScore
    }

    func computeStrikeScore(at index: Int) -> Int {
        var frameScore = Constants.bonusScore

        if let nextFrame = nextFrame(after: index) {
            switch nextFrame.firstRoll.symbol {
            case Constants.strike:
                if let overFrame = self.nextFrame(after: index + 1) {
                    frameScore += nextFrame.pinCount + overFrame.pinCount
                } else {
                    frameScore += nextFrame.pinCount
                }
            case Constants.spare:
                frameScore += nextFrame.firstRoll.pinCount
            default:
                frameScore += nextFrame.pinCount
            }
        }

        return min(frameScore, Constants.maximumScorePerFrame)
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

    static let rollsSeparator: Character = " "
    static let bonusScore = 10
    static let maximumScorePerFrame = 30
}
