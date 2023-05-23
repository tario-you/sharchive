//
//  ContentView.swift
//  Aaron
//
//  Created by Tario You on 2023/4/14.
//

import SwiftUI
import UIKit
import RealityKit
import ARKit
import AVFoundation

//struct ContentView: View {
//    @State private var isARViewActive = false
//
//    var body: some View {
//        ZStack {
//            if isARViewActive {
//                ARViewContainer().edgesIgnoringSafeArea(.all)
//                    .edgesIgnoringSafeArea(.all)
//                    .statusBar(hidden: true)
//            } else {
//                Button(action: {
//                    isARViewActive = true
//                }) {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.red)
//                        .frame(width: 100, height: 100)
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//        }
//    }
//}

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraViewController

    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
    }
}

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium

        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Unable to access the back camera")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
}

struct ContentView: View {
    @State private var isARViewActive = false

    var body: some View {
        ZStack {
            if isARViewActive {
                ARViewContainer()
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true)
            } else {
                CameraView()
                    .edgesIgnoringSafeArea(.all)
                OverlayImageView()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isARViewActive = true
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red)
                                .frame(width: 100, height: 100)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct OverlayImageView: View {
    var body: some View {
        Image("overlay.png")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}
//
//struct ARViewContainer: UIViewControllerRepresentable {
//    typealias UIViewControllerType = ARViewController
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: ARViewContainer
//
//        init(_ parent: ARViewContainer) {
//            self.parent = parent
//        }
//    }
//
//    func makeUIViewController(context: Context) -> ARViewController {
//        return ARViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
//    }
//}

struct ARViewContainer: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: ARViewContainer

        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
    }

    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
    }
}
//
//class ARViewController: UIViewController, ARSessionDelegate {
//    var arView: ARView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        arView = ARView(frame: view.bounds)
//        view.addSubview(arView)
//        arView.session.delegate = self
//        setUpARConfiguration()
//        load3DModel()
//    }
//
//    private func setUpARConfiguration() {
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.planeDetection = .horizontal
//        arView.session.run(configuration)
//    }
//
//    private func load3DModel() {
//        // Replace "model.usdz" with the file name of your 3D model
//        let modelFileName = "tabletest.usdz"
//
//        guard let modelEntity = try? Entity.load(named: modelFileName) else {
//            print("Failed to load the 3D model")
//            return
//        }
//
//        let anchor = AnchorEntity(plane: .horizontal)
//        anchor.addChild(modelEntity)
//        arView.scene.addAnchor(anchor)
//    }
//}
class ARViewController: UIViewController {
    var arView: ARView!

    override func viewDidLoad() {
        super.viewDidLoad()
        arView = ARView(frame: view.bounds)
        view.addSubview(arView)
        setUpARConfiguration()
        load3DModel()
    }

    private func setUpARConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
    }

    private func load3DModel() {
        // Replace "model.usdz" with the file name of your 3D model
        let modelFileName = "tabletest.usdz"

        guard let modelEntity = try? Entity.load(named: modelFileName) else {
            print("Failed to load the 3D model")
            return
        }

        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)
    }
}

//struct ARViewContainer: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ARView {
//
//        let arView = ARView(frame: .zero)
//
//        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
//
//
//        // 3d model
////        let sphere = MeshResource.generateSphere(radius: 0.05)
////        let material = SimpleMaterial(color: .red, roughness:0,isMetallic: true)
////        let sphereEntity = ModelEntity(mesh: sphere, materials:[material])
//
//        // create anchor
////        let sphereAnchor = AnchorEntity(world: SIMD3(x:0, y:0, z:0))
////        sphereAnchor.addChild(sphereEntity)
//
//        // add anchor to scene
////        arView.scene.addAnchor(sphereAnchor)
////
////        let amongusScene = SCNScene(named: "crewmate.dae")
////        mesh.resource.
//
//        return arView
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
