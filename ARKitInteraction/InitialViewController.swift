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
    
    var once = true
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if once {
            playVideo()
            once = false
        }
    }

    let playerController = AVPlayerViewController()

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "input_video_2", ofType: "mp4") else {
            debugPrint("splash.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        present(playerController, animated: true) {
            player.play()
        }
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method , video is finished")
        playerController.dismiss(animated: false){}
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

