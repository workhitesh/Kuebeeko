//
//  DashboardVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 09/08/22.
//

import UIKit

class DashboardVC: UIViewController {
    static let identifier = "DashboardVC"
    
    //MARK: IBOutlets
    @IBOutlet private weak var searchBar:UISearchBar!
    @IBOutlet private weak var tblView:UITableView!
    var arrTutorList = [TutorModel]()
    

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tempMakeArr()
    }
    
    
    //MARK: Fxns
    fileprivate func tempMakeArr(){
        let tutor = TutorModel(id: "1", name: "Toni Kroos", email: "toni@tk.de", phone: "+49 11568668267", image: nil, userType: .tutor)
        let tutor1 = TutorModel(id: "2", name: "Luka Modric", email: "modric@lm.cr", phone: "+34 87646734", image: nil, userType: .tutor)
        arrTutorList.append(tutor)
        arrTutorList.append(tutor1)
        tblView.reloadData()
    }
    
    fileprivate func setupUI(){
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Dashboard"
        tblView.register(UINib(nibName: TutorCell.identifier, bundle: nil), forCellReuseIdentifier: TutorCell.identifier)
    }
    
    
    //MARK: IBActions
    @IBAction func pressedAddAdmin(){
        
    }


}

extension DashboardVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTutorList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TutorCell.identifier) as? TutorCell else {
            return UITableViewCell()
        }
        cell.tutor = arrTutorList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
