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
        ListTableViewCell().setCells(indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name:"Futura", size: 17)
        header.textLabel?.frame = CGRect.init(x: 5, y: 0, width: tableView.bounds.size.width, height: 30)
        header.textLabel?.text = Common.jsonDatas![section]["name"] as? String
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seletedSection = indexPath.section
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListTableViewCell.height
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextPage = MemoViewController.self
        nextPage.id = Common.jsonDatas![seletedSection!]["id"] as? Int16
        nextPage.url = Common().stringToURL(string: Common.jsonDatas![seletedSection!]["url"] as? String)
    }
    
    //MARK: Activies
    
    @IBAction func unwindToListVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == "segue_to_memoVC" {
            print("unwind for 'segue_to_memoVC'")
        }
    }

}
