//
//  Frame.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 20/10/2020.
//

struct Frame {

    enum FrameType {
        case normal, spare, strike
    }

    var frameType: FrameType {
        if isLastFrame {
            return .normal
        } else {
            switch rolls.count {
            case 1:
                return firstRoll.symbol == Constants.strike ? .strike : .normal
            case 2:
                return secondRoll?.symbol == Constants.spare ? .spare : .normal
            default:
                return .normal
            }
        }
    }

    var pinCount: Int {
        return rolls.map { $0.pinCount }.reduce(0, +)
    }

    var firstRoll: Roll {
        return rolls[0]
    }

    var secondRoll: Roll? {
        return rolls.count > 1 ? rolls[1] : nil
    }

    var thirdRoll: Roll? {
        return rolls.count == 3 ? rolls[2] : nil
    }

    var score = 0
    private var rolls = [Roll]()
    private let isLastFrame: Bool

    init(
        scores: String,
        isLastFrame: Bool = false) {
        self.isLastFrame = isLastFrame
        rolls = createRolls(with: scores)
    }
}

private extension Frame {

    func createRolls(with scores: String) -> [Roll] {
        var rolls = [Roll]()

        switch scores.count {
        case 1:
            rolls.append(Roll(pinCount: pinCount(for: Character(scores)), symbol: scores.first!))
        case 2:
            rolls.append(contentsOf: createDoubleRolls(with: scores))
        case 3:
            rolls.append(contentsOf: createTripleRolls(with: scores))
        default:
            assertionFailure("💥 Frames should have 1, 2 or 3 rolls.")
            break
        }

        return rolls
    }

    func createDoubleRolls(with scores: String) -> [Roll] {
        var rolls = [Roll]()

        let firstPinCount = pinCount(for: scores.first!)
        rolls.append(Roll(pinCount: firstPinCount, symbol: scores.character(at: 0)))

        let secondSymbol = scores.character(at: 1)
        if secondSymbol == Constants.spare {
            rolls.append(Roll(pinCount: 10 - firstPinCount, symbol: secondSymbol))
        } else {
            rolls.append(Roll(pinCount: pinCount(for: secondSymbol), symbol: secondSymbol))
        }

        return rolls
    }

    func createTripleRolls(with scores: String) -> [Roll] {
        var rolls = [Roll]()

        let firstPinCount = pinCount(for: scores.first!)
        rolls.append(Roll(pinCount: firstPinCount, symbol: scores.character(at: 0)))

        let secondSymbol = scores.character(at: 1)
        switch secondSymbol {
        case Constants.spare:
            rolls.append(Roll(pinCount: 10 - firstPinCount, symbol: secondSymbol))
        case Constants.strike:
            rolls.append(Roll(pinCount: 10, symbol: secondSymbol))
        default:
            rolls.append(Roll(pinCount: pinCount(for: secondSymbol), symbol: secondSymbol))
        }

        let thirdSymbol = scores.character(at: 2)
        switch thirdSymbol {
        case Constants.spare:
            let secondPinCount = pinCount(for: scores.character(at: 1))
            rolls.append(Roll(pinCount: 10 - secondPinCount, symbol: thirdSymbol))
        case Constants.strike:
            rolls.append(Roll(pinCount: 10, symbol: thirdSymbol))
        default:
            rolls.append(Roll(pinCount: pinCount(for: thirdSymbol), symbol: thirdSymbol))
        }

        return rolls
    }

    func pinCount(for score: Character) -> Int {
        switch score {
        case "1"..."9":
            return score.wholeNumberValue!
        case Constants.strike:
            return 10
        default:
            return 0
        }
    }
}

private extension String {

    func character(at position: Int) -> Character {
        guard position < count else { return Character("") }

        let index = self.index(startIndex, offsetBy: position)
        return self[index]
    }
}

private enum Constants {

    static let spare: Character = "/"
    static let strike: Character = "X"
}
