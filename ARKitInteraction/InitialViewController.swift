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
import AVKit
import AVFoundation

class InitialViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var shanghaiLabel: UILabel!
    @IBOutlet weak var arLabel: UILabel!
    @IBOutlet weak var chiveLabel: UILabel!
    
    var button1text: String = "Launch"
    var button2text: String = "Demo"
    var button3text: String = "About Us"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.setTitle(button1text, for: .normal)
        button2.setTitle(button2text, for: .normal)
        button3.setTitle(button3text, for: .normal)
        
        button1.setTitleColor(UIColor.white, for: .normal)
        button2.setTitleColor(UIColor.white, for: .normal)
        button3.setTitleColor(UIColor.white, for: .normal)
        
        button1.setTitleColor(UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), for: .highlighted)
        button2.setTitleColor(UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), for: .highlighted)
        button3.setTitleColor(UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), for: .highlighted)
        
//        if #available(iOS 15.0, *) {
//            button1.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
//                var outgoing = incoming
//                outgoing.font = UIFont.systemFont(ofSize: 30)
//                outgoing.font = UIFont(name:"LeagueSpartan",size: 60)
//                return outgoing
//            }
//        } else {
//            button1.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
//        }
        button1.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        button2.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button3.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        
//        shanghaiLabel.font = UIFont(name: shanghaiLabel.font.fontName, size: 40)
//        arLabel.font = UIFont(name: arLabel.font.fontName, size: 40)
//        chiveLabel.font = UIFont(name: chiveLabel.font.fontName, size: 40)
        // Additional setup code if needed
        
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isTranslucent = false

    }
    
//    @IBAction func button1Pressed(_ sender: UIButton) {
//            performSegue(withIdentifier: "toLocPicker", sender: sender)
//        }


        //@IBAction func button2Pressed(_ sender: UIButton) {
        //    performSegue(withIdentifier: "toHowToUse", sender: sender)
        //}
        
        //@IBAction func button3Pressed(_ sender: UIButton) {
        //    performSegue(withIdentifier: "toAboutUs", sender: sender)
        //}
    
    
    var once = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if once {
            playVideo()
            once = false
        }
    }

    let playerController = AVPlayerViewController()

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "intro_3s", ofType: "mp4") else {
            debugPrint("intro_3s.mp4 not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        
        present(playerController, animated: true) {
            player.play()
            
            // Schedule a fade-out animation
            DispatchQueue.main.asyncAfter(deadline: .now() + player.currentItem!.duration.seconds - 1.0) {
                // Create a fade-out animation
                let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
                fadeOutAnimation.fromValue = 1.0
                fadeOutAnimation.toValue = 0.0
                fadeOutAnimation.duration = 1.0 // Adjust the duration as needed
                
                // Apply the fade-out animation to the playerController's view layer
                self.playerController.view.layer.add(fadeOutAnimation, forKey: "fadeOut")
                
                // Dismiss the playerController after the fade-out animation completes
                DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutAnimation.duration-0.5) {
                    self.playerController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method , video is finished")
        playerController.dismiss(animated: false){}
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toViewController" {
//            guard let nextVC = segue.destination as? ViewController else {
//                return
//            }
//            if let senderButton = sender as? UIButton {
//                if senderButton == button1 {
//                    nextVC.locationText = button1text
//                } else if senderButton == button2 {
//                    nextVC.locationText = button2text
//                } else if senderButton == button3 {
//                    nextVC.locationText = button3text
//                }
//            }
//        }
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
//    }
}

