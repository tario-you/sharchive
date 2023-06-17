//
//  InitialViewController.swift
//  ARKitInteraction
//
//  Created by Tario You on 2023/6/13.
//  Copyright © 2023 Apple. All rights reserved.
//

//
//  InitialViewController.swift
//  ARKitInteraction
//
//  Created by Tario You on 2023/6/13.
//  Copyright © 2023 Apple. All rights reserved.
//
import ARKit
import SceneKit
import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    var button1text: String = "Location 1"
    var button2text: String = "Location 2"
    var button3text: String = "Location 3"
    var button4text: String = "About Us"
    var button5text: String = "How to Use"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.setTitle(button1text, for: .normal)
        button2.setTitle(button2text, for: .normal)
        button3.setTitle(button3text, for: .normal)
        button4.setTitle(button4text, for: .normal)
        button5.setTitle(button5text, for: .normal)
        // Additional setup code if needed
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toViewController", sender: sender)
    }
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toViewController", sender: sender)
    }
    
    @IBAction func button3Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toViewController", sender: sender)
    }
    @IBAction func button4Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAboutUs", sender: sender)
    }
    @IBAction func button5Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toHowToUse", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController" {
            guard let nextVC = segue.destination as? ViewController else {
                return
            }
            if let senderButton = sender as? UIButton {
                if senderButton == button1 {
                    nextVC.locationText = button1text
                } else if senderButton == button2 {
                    nextVC.locationText = button2text
                } else if senderButton == button3 {
                    nextVC.locationText = button3text
                }
            }
        }
//        else if segue.identifier == "toAboutUs" {
//            guard let nextVC = segue.destination as? AboutUsViewController else {
//                return
//            }
//        }
//        else if segue.identifier == "toHowToUse" {
//            guard let nextVC = segue.destination as? HowToUseViewController else {
//                return
//            }
//        }
    }
}

