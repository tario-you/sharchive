//
//  CameraLineUpViewController.swift
//  SHArchive
//
//  Created by Tario You on 2023/5/28.
//

import UIKit
import AVFoundation

class CameraLineUpViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var whiteCircleButton: UIButton!
    
    var descriptionText: String?
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = descriptionText! + ": aligning model"
        whiteCircleButton.setTitle("", for: .normal)
        setupCaptureSession()
        
        // Add overlay image view
        let overlayImageView = UIImageView(image: UIImage(named: "wireframe.png")) // Replace "overlay.png" with the actual name of your overlay image file
        overlayImageView.frame = view.bounds
        overlayImageView.contentMode = .scaleAspectFill
        view.addSubview(overlayImageView)
//        view.sendSubviewToBack(overlayImageView)
    }
    
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = cameraView.bounds
            cameraView.layer.addSublayer(videoPreviewLayer)
            
            captureSession.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func whiteCircleButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toLoad3DModel", sender: self)
    }
}
