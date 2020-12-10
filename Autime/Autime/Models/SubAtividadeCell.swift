//
//  SubAtividadeCell.swift
//  Autime
//
//  Created by Victor Vieira on 09/12/20.
//

import UIKit

class SubAtividadeCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!{
        didSet{
            imageView.image = image
        }
    }
    
}
