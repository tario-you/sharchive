//
//  MenuViewController.swift
//  SHArchive
//
//  Created by Tario You on 2023/5/28.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var button1text: String = "Among Us Crewmate"
    var button2text: String = "Glass Model"
    var button3text: String = "Placeholder"

    override func viewDidLoad() {
        super.viewDidLoad()
        button1.setTitle(button1text, for: .normal)
        button2.setTitle(button2text, for: .normal)
        button3.setTitle(button3text, for: .normal)
        // Additional setup code if needed
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCameraLineUp", sender: sender)
    }
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCameraLineUp", sender: sender)
    }
    
    @IBAction func button3Pressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCameraLineUp", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCameraLineUp" {
            guard let cameraLineUpVC = segue.destination as? CameraLineUpViewController else {
                return
            }
            if let senderButton = sender as? UIButton {
                if senderButton == button1 {
                    cameraLineUpVC.descriptionText = button1text
                } else if senderButton == button2 {
                    cameraLineUpVC.descriptionText = button2text
                } else if senderButton == button3 {
                    cameraLineUpVC.descriptionText = button3text
                }
            }
        }
    }
}
