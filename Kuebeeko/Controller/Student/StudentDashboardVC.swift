//
//  StudentDashboardVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 13/08/22.
//

import UIKit

class StudentDashboardVC: UIViewController {
    static let identifier = "StudentDashboardVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var sgmtCtrl: UISegmentedControl!
    @IBOutlet weak var tblView: UITableView!
    var arrTutorList = [TutorModel]()
    fileprivate var sortedSearchTutorList = [TutorModel]()
    fileprivate var isSortingOrSearching = false
    @IBOutlet private weak var searchBar:UISearchBar!
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllTutors()
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        Utility.setNavigationBar(self, leftImage: nil, rightImage: UIImage(named: "logout-icon"), title: "Dashboard")
        tblView.register(UINib(nibName: TutorCell.identifier, bundle: nil), forCellReuseIdentifier: TutorCell.identifier)
    }
    
    fileprivate func getAllTutors(){
        Utility.showLoader(on: self)
        arrTutorList.removeAll()
        Webservices.instance.get(url: API_BASE_URL+"tutor", params: nil) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                if let tutors = response as? NSArray {
                    for i in 0..<tutors.count {
                        if let tut = tutors[i] as? NSDictionary {
                            let objTut = TutorModel(_id: tut["_id"] as? String ?? "", name: tut["name"] as? String ?? "", email: tut["email"] as? String ?? "", phone: tut["phone"] as? Int64 ?? 0, image: tut["image"] as? String ?? "", userType: .tutor, overallRating: tut["overallRating"] as? Double ?? 0.0, subjectId: tut["subjectId"] as? String ?? "", bio: tut["bio"] as? String ?? "", hrlyRate: tut["hrlyRate"] as? Double ?? 0.0)
                            self.arrTutorList.append(objTut)
                        }
                    }
                    self.tblView.reloadData()
                } else {
                    Utility.showAlert(with: Messages.noTutors, on: self)
                }
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
    }
    
    fileprivate func sortOnBasisofSubject(){
        let sortedSubjs = arrSubjects.sorted(by: {$0.name < $1.name})
        var finalSortedArr = [TutorModel]()
        for i in 0..<sortedSubjs.count {
            let _id = sortedSubjs[i]._id
            let arr = arrTutorList.filter({$0.subjectId == _id})
            finalSortedArr.append(contentsOf: arr)
        }
        isSortingOrSearching = true
        sortedSearchTutorList = finalSortedArr
        tblView.reloadData()
    }
    
    //MARK:IBActions
    @IBAction func sgmntPressed(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            isSortingOrSearching = true
            sortedSearchTutorList = arrTutorList.sorted(by: {$0.hrlyRate ?? 0.0 < $1.hrlyRate ?? 0.0})
            tblView.reloadData()
        case 1:
            isSortingOrSearching = true
            sortedSearchTutorList = arrTutorList.sorted(by: {$0.overallRating ?? 0.0 > $1.hrlyRate ?? 0.0})
            tblView.reloadData()
        case 2:
            sortOnBasisofSubject()
        case 3:
            isSortingOrSearching = false
            sortedSearchTutorList.removeAll()
            tblView.reloadData()
        default:break
        }
    }
    
    
    @IBAction func rightBarPressed(_ sender:UIBarButtonItem){
        let logAlert = UIAlertController(title: APPNAME, message: Messages.logoutConfirmation, preferredStyle: .alert)
        let logout = UIAlertAction(title: "Logout", style: .destructive) { logA in
            Utility.removeUD(UserDefaultKeys.isLogin)
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDel.setHomeVC()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetHome"), object: nil)
        }
        logAlert.addAction(logout)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logAlert.addAction(cancel)
        present(logAlert, animated: true, completion: nil)
    }
    

}


extension StudentDashboardVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSortingOrSearching ? sortedSearchTutorList.count : arrTutorList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TutorCell.identifier) as? TutorCell else {
            return UITableViewCell()
        }
        cell.tutor = isSortingOrSearching ? sortedSearchTutorList[indexPath.row] : arrTutorList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: TutorDetailVC.identifier) as? TutorDetailVC else {
            return
        }
        vc.tutor = isSortingOrSearching ? self.sortedSearchTutorList[indexPath.row] : self.arrTutorList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension StudentDashboardVC:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        isSortingOrSearching = false
        sortedSearchTutorList.removeAll()
        tblView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSortingOrSearching = true
            self.sortedSearchTutorList =  arrTutorList.filter { (model) -> Bool in
                        return  (model.email?.lowercased().contains(searchText.lowercased())) ?? false ||  (model.name?.lowercased().contains(searchText.lowercased())) ?? false
                            }
            tblView.reloadData()
        } else {
            view.endEditing(true)
            isSortingOrSearching = false
            sortedSearchTutorList.removeAll()
            tblView.reloadData()
        }
    }
}
