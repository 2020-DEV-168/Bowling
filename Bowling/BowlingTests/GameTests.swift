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

        XCTAssertEqual(game.totalScore, expectedTotal)
    }

    func testGameContainingOnlyGutters() {
        let scores = "-- -- -- -- -- -- -- -- -- --"
        let expectedTotal = 0

        let game = Game(scores: scores)

        XCTAssertEqual(game.totalScore, expectedTotal)
    }

    func testGameContainingNumbersAndGutters() {
        let scores = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-"
        let expectedTotal = 90

        let game = Game(scores: scores)

        XCTAssertEqual(game.totalScore, expectedTotal)
    }

    func testGameContainingSpares() {
        let scores = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5"
        let expectedTotal = 150

        let game = Game(scores: scores)

        XCTAssertEqual(game.totalScore, expectedTotal)
    }

    func testGameContainingOnlyStrikes() {
        let scores = "X X X X X X X X X X X X"
        let expectedTotal = 300

        let game = Game(scores: scores)

        XCTAssertEqual(game.totalScore, expectedTotal)
    }

    func testGameContainingMixedResults() {
        let scores = "12 X 7- 3/ 2- X X 71 2/ X X X"
        let expectedTotal = 144

        let game = Game(scores: scores)

        XCTAssertEqual(game.totalScore, expectedTotal)
    }
}
