//
//  FrameCell.swift
//  Bowling
//
//  Created by 2020-DEV-168 on 20/10/2020.
//

import UIKit

class FrameCell: UITableViewCell {

    @IBOutlet weak var frameCellBackgroundView: UIView!
    @IBOutlet weak var frameTitle: UILabel!
    @IBOutlet weak var firstSlot: UILabel!
    @IBOutlet weak var secondSlot: UILabel!
    @IBOutlet weak var thirdSlot: UILabel!
    @IBOutlet weak var score: UILabel!

    func update(with frame: Frame, frameNumber: Int) {
        frameTitle.text = "- \(frameNumber) -"
        score?.text = String(frame.score)
        updateSlot(firstSlot, with: frame.firstRoll.symbol)
        updateSlot(secondSlot, with: frame.secondRoll?.symbol)
        updateSlot(thirdSlot, with: frame.thirdRoll?.symbol)
        applyBackground(for: frameNumber)
    }
}

private extension FrameCell {

    func updateSlot(_ slot: UILabel?, with symbol: Character?) {
        if let symbol = symbol {
            slot?.text = String(symbol)
            slot?.superview?.isHidden = false
        } else {
            slot?.text = nil
            slot?.superview?.isHidden = true
        }
    }

    func applyBackground(for frameNumber: Int) {
        frameCellBackgroundView?.alpha = CGFloat(0.25)
        if frameNumber % 2 == 0 {
            frameCellBackgroundView.backgroundColor = .gray
        } else {
            frameCellBackgroundView.backgroundColor = .lightGray
        }
    }

}
