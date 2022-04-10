//
//  ViewController.swift
//  preViews
//
//  Created by Cameron Smith on 4/1/22.
//

import UIKit
import RealityKit
import SceneKit
import ARKit


class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var arView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.delegate = self
        
        // Load the "Box" scene from the "Experience" Reality File
        // Show statistics such as fps and timing information
        arView.showsStatistics=true
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed:"AR Resources",bundle:Bundle.main){
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
        }
        // Run the view's session
        arView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        arView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,height:imageAnchor.referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry:plane)
            planeNode.eulerAngles.x = -.pi/2
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name ==  "Chipotle" {
                if let modelScene = SCNScene(named:"SpaceUmbrellas.rcproject"){
                    if let modelNode = modelScene.rootNode.childNodes.first{
                        planeNode.addChildNode(modelNode)
                        modelNode.eulerAngles.x = .pi/2
                        
                       let innerSpaceSize: Float = 3.0 // [meters]
                        let innerSpaceMargin: Float = 0.02 // [meters]
                        let innerSpaceOcclusion: Float = 0.01 // [meters]
                        
                        // Add the box anchor to the scene
                        let portalAnchor = try! SpaceUmbrellas.loadScene()
                        //arView.scene.anchors.append(portalAnchor)
                        let boxSize: Float = innerSpaceSize + innerSpaceMargin
                        let boxMesh = MeshResource.generateBox(size: boxSize)
                        let material = OcclusionMaterial()
                        let occlusionBox = ModelEntity(mesh: boxMesh, materials: [material])
                        occlusionBox.position.y = boxSize / 2
                        occlusionBox.position.z = -(innerSpaceMargin + innerSpaceOcclusion)
                        
                        // make door using occlusion
                        portalAnchor.addChild(occlusionBox)
                       
        }
                }
            }
                    
        }
        return node
    }
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
