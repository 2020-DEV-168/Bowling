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
        let rolls = "17 23 81 23 44 51 61 71 25 61"
        let expectedTotal = 70

        let game = Game(rolls: rolls)

        XCTAssertEqual(game.totalScore(), expectedTotal)
    }

    func testGameContainingOnlyGutters() {
        let rolls = "-- -- -- -- -- -- -- -- -- --"
        let expectedTotal = 0

        let game = Game(rolls: rolls)

        XCTAssertEqual(game.totalScore(), expectedTotal)
    }

    func testGameContainingNumbersAndGutters() {
        let rolls = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-"
        let expectedTotal = 90

        let game = Game(rolls: rolls)

        XCTAssertEqual(game.totalScore(), expectedTotal)
    }

    func testGameContainingSpares() {
        let rolls = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5"
        let expectedTotal = 150

        let game = Game(rolls: rolls)

        XCTAssertEqual(game.totalScore(), expectedTotal)
    }
}
