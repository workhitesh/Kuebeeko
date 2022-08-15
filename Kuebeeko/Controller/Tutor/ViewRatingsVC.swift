//
//  ViewRatingsVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 11/08/22.
//

import UIKit

class ViewRatingsVC: UIViewController {
    static let identifier = "ViewRatingsVC"
    var arrRatings = [RatingModel]()
    
    //MARK: IBOutlets
    @IBOutlet weak var sgmntSort:UISegmentedControl!
    @IBOutlet weak var tblView:UITableView!
    var tutor:TutorModel!

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getAllReviews()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func getAllReviews(){
        Utility.showLoader(on: self)
        let url = API_BASE_URL+"rating/\(self.tutor._id)/view"
        Webservices.instance.get(url: url, params: nil) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                guard let ratings = response as? NSArray else {
                    return
                }
                self.arrRatings.removeAll()
                for i in 0..<ratings.count {
                    if let dict = ratings[i] as? NSDictionary {
                        let ratingM = RatingModel(_id: dict["_id"] as! String, reviewedById: dict["reviewedById"] as! String, reviewedByName: dict["reviewedByName"] as! String, reviewedByImage: dict["reviewedByImage"] as? String ?? "", tutorId: dict["tutorId"] as! String, rating: dict["rating"] as! Double, comment: dict["comment"] as! String, timestamp: dict["timestamp"] as! Int64)
                        self.arrRatings.append(ratingM)
                    }
                }
                self.tblView.reloadData()
                
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
    }
    
    fileprivate func setupUI(){
        tblView.register(UINib(nibName: RatingsCell.identifier, bundle:     nil), forCellReuseIdentifier: RatingsCell.identifier)
        self.navigationItem.title = nil
    }
    
    //MARK: IBActions
    @IBAction func sgmntValChanged(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            arrRatings = arrRatings.sorted(by: {$0.rating < $1.rating})
            tblView.reloadData()
        case 1:
            arrRatings = arrRatings.sorted(by: {$0.rating > $1.rating})
            tblView.reloadData()
        case 2:
            arrRatings = arrRatings.sorted(by: {$0.timestamp > $1.timestamp})
            tblView.reloadData()
        default:
            break
        }
    }
    

}


extension ViewRatingsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingsCell.identifier) as? RatingsCell else {
            return UITableViewCell()
        }
        cell.rating = arrRatings[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: RatingDetailVC.identifier) as? RatingDetailVC else {
            return
        }
        vc.rating = self.arrRatings[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
