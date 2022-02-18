//
//  TodayTableViewCell.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

final class TodayTableViewCell: UITableViewCell, Nibable {
    
    @IBOutlet weak var principalImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    func configure(photo: Photo?) {
        if let image = photo?.urls?.image {
            principalImage.loadData(url: URL(string: image)!) { (data, error) in
                if (error == nil) {
                    DispatchQueue.main.async {
                        self.principalImage.image = UIImage(data: data!)
                    }
                }
            }
        }
        
        if let image = photo?.user.profileImage?.image {
            userImage.loadData(url: URL(string: image)!) { (data, error) in
                if (error == nil) {
                    DispatchQueue.main.async {
                        self.userImage.image = UIImage(data: data!)
                    }
                }
            }
        }
        
        authorLabel.text = photo?.user.username
        likeLabel.text = "\(photo?.likes ?? 0) likes"
        topLabel.text = photo?.altDescription
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyle()
    }
}

extension TodayTableViewCell {
    func configureStyle() {
        self.selectionStyle = .none
        principalImage.contentMode = .scaleAspectFill
        principalImage.layer.cornerRadius = 12.0
        principalImage.layer.masksToBounds = true
        
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.masksToBounds = true
    }
}
