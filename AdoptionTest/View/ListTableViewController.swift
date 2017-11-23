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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Common.jsonDatasFromCoreData!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.jsonDatasFromCoreData![section].prefecture!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell")
        }
        cell.setCells(indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ListTableViewCell.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Common.jsonDatasFromCoreData![section].name
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seletedSection = indexPath.section
        self.performSegue(withIdentifier: Common.SegueName.segueToMemoVC.rawValue, sender: indexPath)
        if let selectedSection = seletedSection {
            MemoViewController.id = Common.jsonDatasFromCoreData![selectedSection].id
            MemoViewController.url = Common().stringToURL(string: Common.jsonDatasFromCoreData![selectedSection].url)
            MemoViewController.name = Common.jsonDatasFromCoreData![selectedSection].name
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListTableViewCell.height
    }
 
    //MARK: Activies
    
    @IBAction func unwindToListVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == Common.SegueName.segueToMemoVC.rawValue {
            print("unwind for 'segue_to_memoVC'")
        }
    }

}
