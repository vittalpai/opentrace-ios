//
//  SMSOTPChallengeHandler.swift
//  OpenTrace
//
//  Created by Vittal Pai on 21/05/20.
//  Copyright © 2020 OpenTrace. All rights reserved.
//

import Foundation
import IBMMobileFirstPlatformFoundation


public class SMSCodeChallengeHandler : SecurityCheckChallengeHandler {
    
    public static let securityCheck = "SMSOTP"
    
    override public func handleChallenge(_ challenge: [AnyHashable : Any]!) {
        OTPViewController.codeDialog(title: "SMS code", message: "Please provide your sms code",isCode: true) { (code, ok) -> Void in
            if ok {
                self.submitChallengeAnswer(["code": code])
            } else {
                self.cancel()
            }
        }
    }
}
