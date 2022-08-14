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
    
    fileprivate func updateTutorOverAllRating(){
        let newRating = ((tutor.overallRating ?? 0.0) + viewMyRating.rating)/2
        Utility.showLoader(on: self)
        let params = ["name":tutor.name ?? "","email":tutor.email ?? "","phone":tutor.phone ?? 0,"image":tutor.image ?? "","userType":1,"overallRating":newRating,"subjectId":tutor.subjectId ?? "","bio":tutor?.bio ?? ""] as [String : Any]
        Webservices.instance.put(url: API_BASE_URL+"tutor/\(self.tutor?._id ?? "")", params: params) { success, error in
            Utility.hideLoader(from: self)
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
    }
    
    //MARK: IBActions
    @IBAction func addReviewPressed(_ sender: UIButton) {
        guard let comment = txtMyReview.text, comment.count > 0 else {
            Utility.showAlert(with: "Please add a comment", on: self)
            return
        }
        let rating = viewMyRating.rating
        let params = ["reviewedById":Utility.getUD(UserDefaultKeys.userId) as! String,"reviewedByName":Utility.getUD(UserDefaultKeys.name) as! String, "reviewedByImage":Utility.getUD(UserDefaultKeys.image) as! String,"tutorId":self.tutor._id,"comment":comment,"timestamp":Utility.currentTimestamp,"rating":rating] as [String:Any]
        Utility.showLoader(on: self)
        Webservices.instance.post(url: API_BASE_URL+"rating/add", params: params) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                Utility.showAlert(with: "Rating Added!", on: self)
                self.updateTutorOverAllRating()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.9) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
        
        
        
    }
    
}
