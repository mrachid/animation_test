//
//  TodayDetailFooterCollectionViewCell.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

final class TodayDetailFooterCollectionViewCell: UICollectionReusableView, Nibable {
    
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    func configure(_ statistics: Statistics?) {
        viewsLabel.text = "\(statistics?.views?.total ?? 0)"
        downloadLabel.text = "\(statistics?.downloads?.total ?? 0)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
