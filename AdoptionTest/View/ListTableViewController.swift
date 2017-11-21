//
//  ListTableViewController.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var seletedSection: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Common().setJsonDatas()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (Common.jsonDatas?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Common.jsonDatas?[section]["prefecture"]!.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell")
        }
        cell.setCells(indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Common.jsonDatas![section]["name"] as? String
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seletedSection = indexPath.section
        self.performSegue(withIdentifier: "segue_to_memoVC", sender: indexPath)
        if let selectedSection = seletedSection {
            let idValue = Common().stringToInt16(string: Common.jsonDatas![selectedSection]["id"] as? String)
            MemoViewController.id = idValue
            MemoViewController.url = Common().stringToURL(string: Common.jsonDatas![selectedSection]["url"] as? String)
            MemoViewController.name = Common.jsonDatas![selectedSection]["name"] as? String
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListTableViewCell.height
    }
 
    //MARK: Activies
    
    @IBAction func unwindToListVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == "segue_to_memoVC" {
            print("unwind for 'segue_to_memoVC'")
        }
    }

}
