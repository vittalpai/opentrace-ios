//
//  PhoneNumberViewController.swift
//  OpenTrace

import UIKit
import IBMMobileFirstPlatformFoundation

class PhoneNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var getOTPButton: UIButton!
    let MIN_PHONE_LENGTH = 8
    let PHONE_NUMBER_LENGTH = 15
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumberField.addTarget(self, action: #selector(self.phoneNumberFieldDidChange), for: UIControl.Event.editingChanged)
        self.phoneNumberFieldDidChange()
        phoneNumberField.delegate = self
        dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.phoneNumberField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        getOTPButton.isEnabled = false
        verifyPhoneNumberAndProceed(self.phoneNumberField.text ?? "")
    }
    
    @objc
    func phoneNumberFieldDidChange() {
        self.getOTPButton.isEnabled = self.phoneNumberField.text?.count ?? 0 >= MIN_PHONE_LENGTH
        if self.phoneNumberField.text?.count == PHONE_NUMBER_LENGTH {
            self.phoneNumberField.resignFirstResponder()
        }
    }
    
    func verifyPhoneNumberAndProceed(_ mobileNumber: String) {
        activityIndicator.startAnimating()
        let resourseRequest = WLResourceRequest(url: NSURL(string:"/adapters/SMSOTP/phone/register/\(mobileNumber)")! as URL, method:"POST")
        resourseRequest?.send(completionHandler: { (response, error) -> Void in
            self.activityIndicator.stopAnimating()
            if error == nil {
                UserDefaults.standard.set(mobileNumber, forKey: "authVerificationID")
                UserDefaults.standard.set(mobileNumber, forKey: "mobileNumber")
                self.performSegue(withIdentifier: "segueFromNumberToOTP", sender: self)
            } else {
                self.alert (msg: "Oops, failed to register.")
            }
        })
    }
    
    private func alert (msg : String) {
        let alert = UIAlertController(title: "SMS OTP Login", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //  limit text field input to 15 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let maxLength = PHONE_NUMBER_LENGTH
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
