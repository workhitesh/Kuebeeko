//
//  RatingDetailVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 14/08/22.
//

import UIKit

class RatingDetailVC: UIViewController {
    static let identifier = "RatingDetailVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var imgMainReviewer: DesignableImageView!
    @IBOutlet weak var lblNameMReviewer: UILabel!
    @IBOutlet weak var viewMRating: CosmosView!
    @IBOutlet weak var viewMComment: UITextView!
    @IBOutlet weak var viewTxtBox: UIView!
    @IBOutlet weak var heightTxtBox: NSLayoutConstraint!
    @IBOutlet weak var bottomTextBox: NSLayoutConstraint!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var tblComments: UITableView!
    var rating:RatingModel!
    fileprivate var arrComments = [CommentModel]() {
        didSet {
            tblComments.reloadData()
        }
    }
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presetUI()
        getAllComments()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        self.navigationItem.title = nil
        tblComments.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellReuseIdentifier: CommentCell.identifier)
    }
    
    fileprivate func presetUI(){
        lblNameMReviewer.text = rating.reviewedByName
        imgMainReviewer.loadImageWithIndicator(rating.reviewedByImage, placeholder: .profilePlaceholder)
        viewMRating.rating = rating.rating
        txtView.text = nil
        viewMComment.isScrollEnabled = true
        viewMComment.text = rating.comment
    }
    
    fileprivate func getAllComments(){
        Utility.showLoader(on: self)
        Webservices.instance.get(url: API_BASE_URL+"comment/\(rating._id)", params: nil) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                if let comments = response as? NSArray {
                    self.arrComments.removeAll()
                    for i in 0..<comments.count {
                        if let dict = comments[i] as? NSDictionary {
                            let objTut = CommentModel(_id: dict["_id"] as! String, ratingId: dict["ratingId"] as! String, commentedById: dict["commentedById"] as! String, commentedByImage: dict["commentedByImage"] as? String ?? "", commentedByName: dict["commentedByName"] as? String ?? "", comment: dict["comment"] as! String, timestamp: dict["timestamp"] as! Int64)
                            self.arrComments.append(objTut)
                        }
                    }
                    self.arrComments = self.arrComments.sorted(by: {$0.timestamp < $1.timestamp})
                    if self.arrComments.count > 0 {
                        self.tblComments.scrollToRow(at: IndexPath(row: self.arrComments.count - 1, section: 0), at: .bottom, animated: true)
                    }
                } else {
                    Utility.showAlert(with: Messages.noTutors, on: self)
                }
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
    }
    
    
    //MARK: IBActions
    @IBAction func sendPressed(_ sender: UIButton) {
        if let text = txtView.text, text != "" {
            // add comment api
            Utility.showLoader(on: self)
            let params = ["ratingId":self.rating._id,"commentedById":Utility.getUD(UserDefaultKeys.userId) as! String, "commentedByImage":Utility.getUD(UserDefaultKeys.image) as! String, "commentedByName":Utility.getUD(UserDefaultKeys.name) as! String,"comment":text,"timestamp":Utility.currentTimestamp] as [String:Any]
            Webservices.instance.post(url: API_BASE_URL+"comment/addComment", params: params) { success, response, error in
                Utility.hideLoader(from: self)
                if success {
                    print("added comment, refresh now")
                    self.view.endEditing(true)
                    self.txtView.text = ""
                    self.getAllComments()
                } else {
                    Utility.showAlert(with: error ?? Messages.commonError, on: self)
                }
            }
        } else {
            view.endEditing(true)
        }
    }
    
}

extension RatingDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier) as? CommentCell else {
            tableView.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellReuseIdentifier: CommentCell.identifier)
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.comment = arrComments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
