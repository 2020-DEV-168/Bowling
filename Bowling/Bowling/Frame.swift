//
//  Frame.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 20/10/2020.
//

import Foundation

struct Roll {

    let pinCount: Int
    let symbol: Character
}

struct Frame {

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

    var rolls = [Roll]()

    init(scores: String) {
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
        rolls.append(Roll(pinCount: firstPinCount, symbol: scores.symbol(at: 0)))

        let secondSymbol = scores.symbol(at: 1)
        if secondSymbol == "/" {
            rolls.append(Roll(pinCount: 10 - firstPinCount, symbol: secondSymbol))
        } else {
            rolls.append(Roll(pinCount: pinCount(for: secondSymbol), symbol: secondSymbol))
        }

        return rolls
    }

    func createTripleRolls(with scores: String) -> [Roll] {
        var rolls = [Roll]()

        let firstPinCount = pinCount(for: scores.first!)
        rolls.append(Roll(pinCount: firstPinCount, symbol: scores.symbol(at: 0)))

        let secondSymbol = scores.symbol(at: 1)
        switch secondSymbol {
        case "/":
            rolls.append(Roll(pinCount: 10 - firstPinCount, symbol: secondSymbol))
        case "X":
            rolls.append(Roll(pinCount: 10, symbol: secondSymbol))
        default:
            rolls.append(Roll(pinCount: pinCount(for: secondSymbol), symbol: secondSymbol))
        }

        let thirdSymbol = scores.symbol(at: 2)
        switch thirdSymbol {
        case "/":
            let secondPinCount = pinCount(for: scores.symbol(at: 1))
            rolls.append(Roll(pinCount: 10 - secondPinCount, symbol: thirdSymbol))
        case "X":
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
        case "X":
            return 10
        default:
            return 0
        }
    }
}

private extension String {

    func symbol(at position: Int) -> Character {
        guard position < count else { return Character("") }

        let index = self.index(startIndex, offsetBy: position)
        return self[index]
    }
}
