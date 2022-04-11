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


class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    
   // let boxAnchor = try! SpaceUmbrellas.Umbrellas()
    //var imageAnchorToEnitity: [ARImageAnchor: AnchorEntity] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //arView.delegate = self
       // arView.scene.addAnchor(boxAnchor)
       // arView.session.delegate = self
        // Load the "Box" scene from the "Experience" Reality File
        // Show statistics such as fps and timing information
        let innerSpaceSize: Float = 3.0 // [meters]
          let innerSpaceMargin: Float = 0.02 // [meters]
          let innerSpaceOcclusion: Float = 0.01 // [meters]
          
          // Add the box anchor to the scene
          let portalAnchor = try! Experience.loadScene()
          arView.scene.anchors.append(portalAnchor)
          let boxSize: Float = innerSpaceSize + innerSpaceMargin
          let boxMesh = MeshResource.generateBox(size: boxSize)
          let material = OcclusionMaterial()
          let occlusionBox = ModelEntity(mesh: boxMesh, materials: [material])
          occlusionBox.position.y = boxSize / 2
          occlusionBox.position.z = -(innerSpaceMargin + innerSpaceOcclusion)
          
          // make door using occlusion
          portalAnchor.addChild(occlusionBox)
        
        
        
        
    }
   /* func session(_session:ARSession, didAdd anchors: [ARAnchor]){
        anchors.compactMap {$0 as? ARImageAnchor}.forEach{
            let anchorEntity = AnchorEntity()
            let modelEntity = boxAnchor.!
            anchorEntity.addChild(modelEntity)
            arView.scene.addAnchor(anchorEntity)
            anchorEntity.transform.matrix = $0.transform
            imageAnchorToEnitity[$0] = anchorEntity
        }
    }*/
   
                        
                      /*
                       */
       
    
   
        
        
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
