//
//  ViewController.swift
//  JuliasNumbers
//
//  Created by Sebastian Strus on 2018-06-13.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewWillAppear(_ animated: Bool) {
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10
            button.setShadow()
        }
        
        // ! quick fix - reading will be not delated
        readText(message: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons {
            let midX = button.center.x
            let midY = button.center.y
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.06
            //animation.repeatCount = 10
            animation.repeatDuration = .infinity
            animation.autoreverses = true
            animation.fromValue = CGPoint(x: midX - 3, y: midY)
            animation.toValue = CGPoint(x: midX + 3, y: midY)
            button.layer.add(animation, forKey: "position")
        }
        
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        //wibrate
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        //speech
        let tempText: String = (sender.titleLabel?.text)!
        //readText(message: "")
        readText(message: tempText)
        
        //animate button
        UIView.animate(withDuration: 0.3,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.3) {
                            sender.transform = CGAffineTransform.identity
                        }
        })
    }
    
    func readText(message: String) {
        //speech
        let utterance = AVSpeechUtterance(string: message)
        //Rutterance.voice = AVSpeechSynthesisVoice(language: "pl-PL")// en-US pl-PL
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}

extension UIButton {
    func setShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 5
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 15
    }
}
