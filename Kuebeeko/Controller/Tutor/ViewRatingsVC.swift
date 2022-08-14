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

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeTempArr()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func makeTempArr(){
        let r1 = RatingModel(_id: "1", reviewedById: "2", reviewedByName: "James", reviewedByImage: "", tutorId: "1", rating: 5, comment: "Really helped me understand how to dribble the ball. Precision is must for me and there's no one who could do it better rather than someone with more than 90% pass accuracy.", timestamp: 837648374)
        let r2 = RatingModel(_id: "1", reviewedById: "2", reviewedByName: "Michelle", reviewedByImage: "", tutorId: "1", rating: 3, comment: "Good teacher", timestamp: 837648374)
        arrRatings.append(r1)
        arrRatings.append(r2)
        tblView.reloadData()
    }
    
    fileprivate func setupUI(){
        tblView.register(UINib(nibName: RatingsCell.identifier, bundle:     nil), forCellReuseIdentifier: RatingsCell.identifier)
        self.navigationItem.title = nil
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
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
