//
//  HowItWorksViewController.swift
//  OpenTrace

import UIKit

class HowItWorksViewController: UIViewController {

    @IBAction func greatBtnOnClick(_ sender: UIButton) {

        OnboardingManager.shared.completedIWantToHelp = true

//        FIXME: VITTAL
//        if Auth.auth().currentUser == nil {
//            self.performSegue(withIdentifier: "iWantToHelpToPhoneSegue", sender: self)
//        } else {
//            self.performSegue(withIdentifier: "iWantToHelpToConsentSegue", sender: self)
//        }
          self.performSegue(withIdentifier: "iWantToHelpToConsentSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
