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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    //Set cell
    func setCells(fetchedResultsController: NSFetchedResultsController<JsonDatas>, indexPath: IndexPath) {
        Common().imageFromStringURL(imageView: urlImageView, string: fetchedResultsController.fetchedObjects![indexPath.section].image)
        nameLabel.text = fetchedResultsController.fetchedObjects![indexPath.section].hiragana
        prefectureLabel.text = fetchedResultsController.fetchedObjects![indexPath.section].prefecture?[indexPath.row]
    }
}
