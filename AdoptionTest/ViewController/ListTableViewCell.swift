//
//  ListTableViewCell.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var urlImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    
    static let identifier = "ListCell"
    static let height: CGFloat = 65.0
    static let headerHeight: CGFloat = 30.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //Set cell content
    
    func setCells(object: JsonDatas, row: Int) {
        Common().imageFromStringURL(imageView: urlImageView, string: object.image)
        nameLabel.text = object.hiragana
        prefectureLabel.text = object.prefecture?[row]
    }
}
