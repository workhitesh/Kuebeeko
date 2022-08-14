//
//  AddReviewVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 14/08/22.
//

import UIKit

class AddReviewVC: UIViewController {
    static let identifier = "AddReviewVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var imgTutor: DesignableImageView!
    @IBOutlet weak var lblTutorName: UILabel!
    @IBOutlet weak var lblTutDesc: UILabel!
    @IBOutlet weak var viewExRating: CosmosView!
    @IBOutlet weak var viewMyRating: CosmosView!
    @IBOutlet weak var txtMyReview: UITextView!
    var tutor:TutorModel!
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    //MARK: Fxns
    fileprivate func setupUI(){
        self.navigationItem.title = "Add Review"
        presetUI()
    }
    
    fileprivate func presetUI(){
        imgTutor.loadImageWithIndicator(tutor.image, placeholder: .profilePlaceholder)
        lblTutorName.text = tutor.name
        lblTutDesc.text = tutor.email
        viewExRating.rating = tutor.overallRating ?? 0.0
    }
    
    //MARK: IBActions
    @IBAction func addReviewPressed(_ sender: UIButton) {
        guard let comment = txtMyReview.text, comment.count > 0 else {
            Utility.showAlert(with: "Please add a comment", on: self)
            return
        }
        let rating = viewMyRating.rating
        let params = ["reviewedById":Utility.getUD(UserDefaultKeys.userId) as! String,"reviewedByName":Utility.getUD(UserDefaultKeys.name) as! String, "reviewedByImage":Utility.getUD(UserDefaultKeys.image) as! String,"tutorId":self.tutor._id,"comment":comment,"timestamp":Utility.currentTimestamp,"rating":rating] as [String:Any]
        print(params)
        print(API_BASE_URL+"rating/add")
        Utility.showLoader(on: self)
        Webservices.instance.post(url: API_BASE_URL+"rating/add", params: params) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                Utility.showAlert(with: "Rating Added!", on: self)
                //TODO: update individual rating on basis of this rating
                self.navigationController?.popViewController(animated: true)
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
        
        
        
    }
    
}
