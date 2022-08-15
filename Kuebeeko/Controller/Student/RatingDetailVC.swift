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
        txtView.text = rating.comment
        txtView.isScrollEnabled = true
    }
    
    fileprivate func getAllComments(){
        
    }
    
    
    //MARK: IBActions
    @IBAction func sendPressed(_ sender: UIButton) {
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
