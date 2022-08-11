//
//  AddTutorVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 11/08/22.
//

import UIKit

class AddTutorVC: UIViewController {
    static let identifier = "AddTutorVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        self.navigationItem.title = "Add Tutor"
    }
    



}
