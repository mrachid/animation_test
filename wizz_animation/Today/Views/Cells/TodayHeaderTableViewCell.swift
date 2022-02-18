//
//  TodayHeaderTableViewCell.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

final class TodayHeaderTableViewCell: UITableViewCell, Nibable {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.text = formateDate()
    }
    
    private func formateDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE MMM d yyyy"
        
        return dateFormatterPrint.string(from: Date())
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
