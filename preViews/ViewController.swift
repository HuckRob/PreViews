//
//  ViewController.swift
//  preViews
//
//  Created by Cameron Smith on 4/1/22.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        
        let innerSpaceSize: Float = 3.0 // [meters]
        let innerSpaceMargin: Float = 0.02 // [meters]
        let innerSpaceOcclusion: Float = 0.01 // [meters]
        // Add the box anchor to the scene
        let portalAnchor = try! SpaceUmbrellas.loadScene()
        arView.scene.anchors.append(portalAnchor)
        let boxSize: Float = innerSpaceSize + innerSpaceMargin
        let boxMesh = MeshResource.generateBox(size: boxSize)
        let material = OcclusionMaterial()
        let occlusionBox = ModelEntity(mesh: boxMesh, materials: [material])
        occlusionBox.position.y = boxSize / 2
        occlusionBox.position.z = -(innerSpaceMargin + innerSpaceOcclusion) // make door using occlusion
        portalAnchor.addChild(occlusionBox)

        
    }
}
