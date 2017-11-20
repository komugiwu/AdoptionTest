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
    
    static let identifier = "ListCell"
    static let height: CGFloat = 65.0
    
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
        
        let imageString = jsonData![indexPath.section]["image"] as? String
        let nameString = jsonData![indexPath.section]["hiragana"] as? String
        let prefectureArray = jsonData![indexPath.section]["prefecture"] as? NSArray
        
        print("urlImageVieww ; \(urlImageView)")
        Common().imageFromStringURL(imageView: urlImageView, string: imageString)
        Common().setValueToLabel(label: nameLabel, string: nameString)
        Common().setValueToLabel(label: prefectureLabel, string: prefectureArray?[indexPath.row] as? String)
    }
}
