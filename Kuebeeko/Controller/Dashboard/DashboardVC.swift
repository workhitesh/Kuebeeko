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
        getAllTutors()
    }
    
    
    //MARK: Fxns
    fileprivate func getAllTutors(){
        Utility.showLoader(on: self)
        arrTutorList.removeAll()
        Webservices.instance.get(url: API_BASE_URL+"tutor", params: nil) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                if let tutors = response as? NSArray {
                    for i in 0..<tutors.count {
                        if let tut = tutors[i] as? NSDictionary {
                            let objTut = TutorModel(_id: tut["_id"] as? String ?? "", name: tut["name"] as? String ?? "", email: tut["email"] as? String ?? "", phone: tut["phone"] as? Int64 ?? 0, image: tut["image"] as? String ?? "", userType: .tutor, overallRating: tut["overallRating"] as? Double ?? 0.0, subjectId: tut["subjectId"] as? String ?? "", bio: tut["bio"] as? String ?? "")
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
    
    fileprivate func setupUI(){
        Utility.setNavigationBar(self, leftImage: nil, rightImage: nil, title: "Dashboard")
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
            vc.tutor = self.arrTutorList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertVC.addAction(view)
        let edit = UIAlertAction(title: "Edit", style: .default) { editA in
            
        }
        alertVC.addAction(edit)
        let del = UIAlertAction(title: "Delete", style: .default) { delA in
            let alertDel = UIAlertController(title: APPNAME, message: Messages.delConfirmation, preferredStyle: .alert)
            let yesDel = UIAlertAction(title: "Delete", style: .destructive) { del in
                Webservices.instance.delete(url: API_BASE_URL+"tutor/\(self.arrTutorList[indexPath.row]._id)", params: nil) { success, error in
                    self.getAllTutors()
                }
            }
            alertDel.addAction(yesDel)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertDel.addAction(cancel)
            self.present(alertDel, animated: true, completion: nil)
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
