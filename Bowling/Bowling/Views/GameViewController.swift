//
//  GameViewController.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 19/10/2020.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!

    let presenter = GamePresenter()
    var game = Game(scores: Constants.onlySpares)

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
    }

    @IBAction func didTapLoadButton(_ sender: Any) {
        presenter.loadGame(with: Constants.onlyStrikes) // TODO: change this
    }

    @IBAction func didTapRollinButton(_ sender: Any) {
        if let link = URL(string: Constants.rollLink) {
            UIApplication.shared.open(link)
        }
    }
}

extension GameViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.frames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrameCell", for: indexPath) as! FrameCell

        totalLabel?.text = "Total: \(game.totalScore)"
        let frame = game.frames[indexPath.row]
        cell.update(with: frame, frameNumber: indexPath.row + 1)
        return cell
    }
}

extension GameViewController: GamePresenterDelegate {

    func display(game: Game) {
        self.game = game
        tableView.reloadData()
    }
}

private enum Constants {

    static let onlySpares = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5"
    static let onlyStrikes = "X X X X X X X X X X X X"
    static let onlyGutters = "-- -- -- -- -- -- -- -- -- --"
    static let onlyNines = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-"
    static let onlyNumbers = "17 23 81 23 44 51 61 71 25 61"
    static let mixed = "12 X 7- 3/ 2- X X 71 2/ X X X"
    static let rollLink = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
}
