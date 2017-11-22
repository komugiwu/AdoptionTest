//
//  ViewController.swift
//  AdoptionTest
//
//  Created by Komugi on 2017/11/15.
//  Copyright © 2017年 Komugi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Common().setJsonDatas()
        JSONCoreData().setDatasToCoreData()
        Common.jsonDatasFromCoreData = JSONCoreData().getDatasFromCoreData()
        print(Common.jsonDatasFromCoreData![5].prefecture!.count)
    }
    
    //MARK: Activies
    @IBAction func unwindToVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == Common.SegueName.segueToListVC.rawValue {
            print("unwind for 'segue_vc_to_listvc'")
        }
    }
}

