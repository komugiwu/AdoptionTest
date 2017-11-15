//
//  ListTableViewCell.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var urlImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //Set cell
    func setCells(indexPath: IndexPath) {
        
        let jsonData = Common.jsonDatas
        
        Common().ImageFromURL(imageView: urlImageView, url: jsonData![indexPath.section]["image"] as! URL)
        nameLabel.text = jsonData![indexPath.section]["hiragana"] as? String
        prefectureLabel.text = jsonData![indexPath.section]["prefecture"] as? String
    }
    
}
