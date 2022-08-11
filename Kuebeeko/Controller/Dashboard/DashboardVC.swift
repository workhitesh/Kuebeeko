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
        tempMakeArr()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: Fxns
    fileprivate func tempMakeArr(){
        let tutor = TutorModel(id: "1", name: "Toni Kroos", email: "toni@tk.de", phone: "+49 11568668267", image: nil, userType: .tutor, overallRating: 3.4, subjectId: nil, bio:nil)
        let tutor1 = TutorModel(id: "2", name: "Luka Modric", email: "modric@lm.cr", phone: "+34 87646734", image: nil, userType: .tutor, overallRating: 4.0, subjectId: nil, bio:nil)
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
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: AddTutorVC.identifier) as? AddTutorVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
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
        let alertVC = UIAlertController(title: APPNAME, message: nil, preferredStyle: .actionSheet)
        let view = UIAlertAction(title: "View", style: .default) { viewA in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: TutorDetailVC.identifier) as? TutorDetailVC else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertVC.addAction(view)
        let edit = UIAlertAction(title: "Edit", style: .default) { editA in
            
        }
        alertVC.addAction(edit)
        let del = UIAlertAction(title: "Delete", style: .default) { delA in
            
        }
        alertVC.addAction(del)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
