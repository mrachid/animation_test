//
//  TodayDetailCollectionViewCell.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

final class TodayDetailCollectionViewCell: UICollectionViewCell, Nibable {
    
    @IBOutlet weak var principalImage: UIImageView!
    
    func configure(url: String?) {
        if let url = url {
            principalImage.loadData(url: URL(string: url)!) { (data, error) in
                if (error == nil) {
                    DispatchQueue.main.async {
                        self.principalImage.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyle()
    }
}

extension TodayDetailCollectionViewCell {
    func configureStyle() {
        principalImage.clipsToBounds = true
        principalImage.contentMode = .scaleAspectFill
    }
}
