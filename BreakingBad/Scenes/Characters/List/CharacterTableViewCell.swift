//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    struct Model: Hashable {
        var id: Int
        var name: String
        var nickname: String
        var image: UIImage?
        var imageURL: URL?
    }

    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var nicknameLabel: UILabel?
    @IBOutlet private var headshotImageView: UIImageView?

    func set(model: Model) {
        nameLabel?.text = model.name
        nicknameLabel?.text = model.nickname
        headshotImageView?.image = model.image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        headshotImageView?.layer.cornerRadius = 4
    }
    
}
