//
//  AddTutorVC.swift
//  Kuebeeko
//
//  Created by Hitesh on 11/08/22.
//

import UIKit

class AddTutorVC: UIViewController {
    static let identifier = "AddTutorVC"
    @IBOutlet weak var imgTutor: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfSubject: UITextField!
    var tutor:TutorModel? // if present means its in edit mode
    fileprivate let subjectPicker = UIPickerView()
    fileprivate var arrSubjects = [SubjectModel]()
    var selectedSubject:SubjectModel?
    var uploadedImageLink:String?
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getAllSubjects()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func getAllSubjects(){
        Utility.showLoader(on: self)
        Webservices.instance.get(url: API_BASE_URL+"subjects", params: nil) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                if let subjects = response as? NSArray {
                    for i in 0..<subjects.count {
                        if let sub = subjects[i] as? NSDictionary {
                            let objSub = SubjectModel(_id: sub["_id"] as? String ?? "", name: sub["name"] as? String ?? "")
                            self.arrSubjects.append(objSub)
                        }
                    }
                    self.subjectPicker.reloadAllComponents()
                } else {
                    Utility.showAlert(with: Messages.noTutors, on: self)
                }
            } else {
                Utility.showAlert(with: error ?? Messages.commonError, on: self)
            }
        }
    }
    
    fileprivate func setupUI(){
        self.navigationItem.title = "Add Tutor"
        tfSubject.inputView = subjectPicker
        subjectPicker.delegate = self
        subjectPicker.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        tfSubject.inputAccessoryView = toolBar
        
        // set image selection
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImage(_:)))
        imgTutor.addGestureRecognizer(tap)
    }
    
    //MARK: IBActions
    @IBAction func createPressed(_ sender: UIButton) {
        // validations
        if let name = tfName.text, let email = tfEmail.text, let phone = tfPhone.text, let subjectId = selectedSubject?._id, let image = uploadedImageLink {
            if name == "" || email == "" || !Validations.isValidEmail(email) || phone == "" || subjectId == "" {
                Utility.showAlert(with: Messages.invalidInput, on: self)
            } else {
                // validated successfully
                let params = ["name":name,"email":email,"phone":phone.int64Value ?? 0,"image":image,"userType":1,"overallRating":0.0,"subjectId":subjectId,"bio":""] as [String : Any]
                Utility.showLoader(on: self)
                Webservices.instance.post(url: API_BASE_URL+"tutor/create", params: params) { success, response, err in
                    if success {
                        // create in firebase auth
                        let pwd = email.substring(to: 6)
                        print("pwd : \(pwd)")
                        FirebaseHandler.createUserInAuth(email, password: pwd) { user, errorFir in
                            Utility.hideLoader(from: self)
                            if errorFir == nil {
                                Utility.showAlert(with: "Tutor created with password : \(pwd)", on: self)
                            } else {
                                Utility.showAlert(with: errorFir ?? Messages.commonError, on: self)
                            }
                        }
                    } else {
                        Utility.hideLoader(from: self)
                        Utility.showAlert(with: err ?? Messages.commonError, on: self)
                    }
                }
            }
        } else {
            Utility.showAlert(with: Messages.invalidInput, on: self)
        }
    }
    @IBAction func donePressed(_ sender:UIBarButtonItem){
        tfSubject.endEditing(true)
    }
    @IBAction func selectImage(_ sender:UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }


}


extension AddTutorVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrSubjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrSubjects[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfSubject.text = arrSubjects[row].name
        selectedSubject = arrSubjects[row]
    }
    
}

extension AddTutorVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imgTutor.image = image
            // upload on firebase and get url
            Utility.showLoader(on: self)
            FirebaseHandler.uploadImage("/images/", image: image) { uploadedFileLink in
                Utility.hideLoader(from: self)
                self.uploadedImageLink = uploadedFileLink
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
