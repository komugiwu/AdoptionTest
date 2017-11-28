//
//  ListTableViewController.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var seletedSection: Int?

    lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<JsonDatas> in
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest: NSFetchRequest<JsonDatas> = JsonDatas.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: "name",
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Common().checkNetworkStatus(sender: self)
        getJSONData()
    }

    //MARK: core data
    func getJSONData() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects![section].prefecture?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListTableViewCell")
        }
        cell.setCells(fetchedResultsController: fetchedResultsController, indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ListTableViewCell.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController.sections![section].name
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seletedSection = indexPath.section
        self.performSegue(withIdentifier: Common.SegueName.segueToMemoVC, sender: indexPath)
        if let selectedSection = seletedSection {

            MemoViewController.id = fetchedResultsController.fetchedObjects![selectedSection].id
            MemoViewController.url = Common().stringToURL(string: fetchedResultsController.fetchedObjects![selectedSection].url)
            MemoViewController.name = fetchedResultsController.fetchedObjects![selectedSection].name
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListTableViewCell.height
    }
 
    //MARK: Activies
    
    @IBAction func unwindToListVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == Common.SegueName.segueToMemoVC {
            print("unwind for 'segue_to_memoVC'")
        }
    }

}