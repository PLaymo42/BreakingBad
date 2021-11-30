//
//  CharacterDetailHeaderTableViewCell.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 29/11/2021.
//

import UIKit

class CharacterDetailHeaderTableViewCell: UITableViewCell {

    struct Model: Hashable {
        var nickname: String
        var birthday: String
        var playedBy: String
        var headshot: UIImage?
        var statusImage: UIImage?
        var statusImageColor: UIColor
    }

    @IBOutlet private var nicknameLabel: UILabel?
    @IBOutlet private var birthdayLabel: UILabel?
    @IBOutlet private var playedByLabel: UILabel?
    @IBOutlet private var headshotImageView: UIImageView?
    @IBOutlet private var statusImageView: UIImageView?

    func set(model: Model) {
        self.nicknameLabel?.text = model.nickname
        self.birthdayLabel?.text = model.birthday
        self.playedByLabel?.text = model.playedBy
        self.headshotImageView?.image = model.headshot
        self.statusImageView?.image = model.statusImage
        self.statusImageView?.tintColor = model.statusImageColor
    }
}
