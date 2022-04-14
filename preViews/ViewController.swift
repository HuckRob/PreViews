//
//  ViewController.swift
//  preViews
//
//  Created by Cameron Smith on 4/1/22.
//

import SwiftUI
import RealityKit
import ARKit


struct ARPortalView: UIViewRepresentable {
    
    
  
    
   
    
    func makeUIView(context: Context) -> ARView {
        let innerSpaceSize: Float = 3.0 // [meters]
        let innerSpaceMargin: Float = 0.02 // [meters]
        let innerSpaceOcclusion: Float = 0.01 // [meters] for to create a door inside the inner space

        let arView = ARView(frame: .zero)

        // load one of bundled rcprojects as an inner space
        let portalAnchor = try! SpaceUmbrellas.loadUmbrellas()
       // let portalAnchor =try! Experience.loadLibrary()
        // Portal 1: Umbrellas
        

        arView.scene.anchors.append(portalAnchor)

        // make an occlusion box that surrounds the inner space.
        let boxSize: Float = innerSpaceSize + innerSpaceMargin
        let boxMesh = MeshResource.generateBox(size: boxSize)
        let material = OcclusionMaterial()
        let occlusionBox = ModelEntity(mesh: boxMesh, materials: [material])
        occlusionBox.position.y = boxSize / 2
        occlusionBox.position.z = -(innerSpaceMargin + innerSpaceOcclusion) // make door using occlusion
        portalAnchor.addChild(occlusionBox)

        // start the AR session.
      //declares reference images as the assete AR Resources
       /* guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }*/
       // arView.session.run(config)
       // let config = ARWorldTrackingConfiguration()
        //config.detectionImages = referenceImages// your images here
       // config.maximumNumberOfTrackedImages = 1 // or up to 4
        // also set other options like plane detection and environment texture if you want
        //arView.session.run(config)
       /* let config = ARWorldTrackingConfiguration()
        config.detectionImages = referenceImages
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])*/

        return arView
    }
    

    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
