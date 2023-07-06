//
//  SplashScreenViewController.swift
//  ARKitInteraction
//
//  Created by Tario You on 2023/6/18.
//  Copyright © 2023 Apple. All rights reserved.
//


import AVKit
import AVFoundation
import UIKit

class SplashScreenViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }

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
        guard let path = Bundle.main.path(forResource: "intro_3s", ofType: "mp4") else {
            debugPrint("splash.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        present(playerController, animated: false) {
            player.play()
        }
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method , video is finished ")
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "toInitialViewController") as! InitialViewController
//        self.present(nextViewController, animated:true, completion:nil)
        
//        performSegue(withIdentifier: "toInitialViewController", sender: self)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "toInitialViewController") as! InitialViewController

        playerController.dismiss(animated: false) {
            self.present(nextViewController, animated: false, completion: nil)
        }
    }
}

