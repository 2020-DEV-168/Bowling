//
//  Game.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 19/10/2020.
//

class Game {

    var frames = [Frame]()

    init(scores: String) {
        let allScores = scores.split(separator: Constants.scoresSeparator)

        let firstFrames = allScores[0...8].map { Frame(scores: String($0)) }
        let lastFrame = Frame(scores: allScores[9...].joined(), isLastFrame: true)

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

        switch frame.frameType {
        case .spare:
            return computeSpareScore(at: index)
        case .strike:
            return computeStrikeScore(at: index)
        case .normal, .lastFrame:
            return frame.pinCount
        }
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
            switch nextFrame.frameType {
            case .strike:
                if let overFrame = self.nextFrame(after: index + 1) {
                    frameScore += nextFrame.pinCount + overFrame.firstRoll.pinCount
                } else {
                    frameScore += nextFrame.pinCount
                }
            case .spare:
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

    static let scoresSeparator: Character = " "
    static let bonusScore = 10
    static let maximumScorePerFrame = 30
}
