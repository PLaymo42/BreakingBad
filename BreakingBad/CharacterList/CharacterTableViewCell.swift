//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    struct Model: Hashable {
        var name: String
        var image: UIImage?
        var imageURL: URL?
    }

    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var headshotImageView: UIImageView?

    func set(model: Model) {
        nameLabel?.text = model.name
        headshotImageView?.image = model.image
    }
    
}
