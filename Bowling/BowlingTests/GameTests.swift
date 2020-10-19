//
//  GameTests.swift
//  GameTests
//
//  Created by 2020-DEV-168 on 19/10/2020.
//

import XCTest
@testable import Bowling

class GameTests: XCTestCase {

    func testGameContainingOnlyNumbers() {
        let scores = "17 23 81 23 44 51 61 71 25 61"
        let expectedTotal = 70

        let game = Game(scores: scores)

        XCTAssertEqual(game.totalScore(), expectedTotal)
    }
}
