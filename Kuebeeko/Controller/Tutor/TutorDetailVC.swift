//
//  TutorDetailVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 11/08/22.
//

import UIKit
import Messages
import MessageUI

class TutorDetailVC: UIViewController {
    static let identifier = "TutorDetailVC"
    
    //MARK: IBOutlets
    

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        self.navigationItem.title = nil
    }
    
    //MARK:IBActions
    @IBAction func emailTutor(_ sender:UIButton){
        Utility.openEmailComposer("kroos@tk.de?subject=Kuebeeko")
    }
    @IBAction func callTextTutor(_ sender:UIButton){
        let alertVC = UIAlertController(title: APPNAME, message: nil, preferredStyle: .actionSheet)
        let text = UIAlertAction(title: "Send a text message", style: .default) { msg in
            if !MFMessageComposeViewController.canSendText() {
                Utility.showAlert(with: "SMS services are not available", on: self)
            } else {
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                composeVC.recipients = ["+494937433434"]
                composeVC.body = "Hello from Kuebeeko,\n"
                self.present(composeVC, animated: true, completion: nil)
            }
        }
        alertVC.addAction(text)
        let call = UIAlertAction(title: "Call", style: .default) { call in
            Utility.callNumber("+494937433434")
        }
        alertVC.addAction(call)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    @IBAction func viewReviewsPressed(_ sender:UIButton){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewRatingsVC.identifier) as? ViewRatingsVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension TutorDetailVC : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
