//
//  Load3DModelViewController.swift
//  SHArchive
//
//  Created by Tario You on 2023/5/28.
//

import SwiftUI
import UIKit
import RealityKit
import ARKit
import AVFoundation

class Load3DModelViewController: UIViewController {

    @IBOutlet weak var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpARConfiguration()
        load3DModel()
    }

    func setUpARConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
    }

    func load3DModel() {
        // Replace "model.usdz" with the file name of your 3D model
        let modelFileName = "glass3.usdz"

        guard let modelEntity = try? Entity.load(named: modelFileName) else {
            print("Failed to load the 3D model")
            return
        }

        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)
    }
}
