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
    var game = Game(scores: Constants.allSpares)

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
    }

    @IBAction func didTapLoadButton(_ sender: Any) {
        presenter.loadGame(with: Constants.allStrikes) // TODO: change this
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
        updateCell(cell, with: frame, frameNumber: indexPath.row + 1)

        return cell
    }
}

extension GameViewController: GamePresenterDelegate {

    func display(game: Game) {
        self.game = game
        tableView.reloadData()
    }
}

private extension GameViewController {

    func updateCell(_ cell: FrameCell, with frame: Frame, frameNumber: Int) {
        cell.frameTitle.text = "- \(frameNumber) -"
        cell.score?.text = String(frame.score)
        updateSlot(cell.firstSlot, with: frame.firstRoll.symbol)
        updateSlot(cell.secondSlot, with: frame.secondRoll?.symbol)
        updateSlot(cell.thirdSlot, with: frame.thirdRoll?.symbol)
        applyBackground(in: cell, for: frameNumber)
    }

    func updateSlot(_ slot: UILabel?, with symbol: Character?) {
        if let symbol = symbol {
            slot?.text = String(symbol)
            slot?.superview?.isHidden = false
        } else {
            slot?.text = nil
            slot?.superview?.isHidden = true
        }
    }

    func applyBackground(in cell: FrameCell, for frameNumber: Int) {
        cell.frameCellBackgroundView?.alpha = CGFloat(0.25)
        if frameNumber % 2 == 0 {
            cell.frameCellBackgroundView.backgroundColor = .gray
        } else {
            cell.frameCellBackgroundView.backgroundColor = .lightGray
        }
    }
}

private enum Constants {

    static let allSpares = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5"
    static let allStrikes = "X X X X X X X X X X X X"
    static let allGutters = "-- -- -- -- -- -- -- -- -- --"
    static let rollLink = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
}
