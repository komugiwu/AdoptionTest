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
        JSONCoreData().setDatas()
    }
    
    //MARK: Activies
    @IBAction func unwindToVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if unwindSegue.identifier == Common.SegueName.segueToListVC {
            print("unwind for 'segue_vc_to_listvc'")
        }
    }
}

