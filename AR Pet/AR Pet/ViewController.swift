//
//  ViewController.swift
//  AR Pet
//
//  Created by Spence on 7/10/19.
//  Copyright © 2019 Jessica. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else{
            
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultsWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultsWithFeaturePoints.worldTransform.translation
                addPet(x: translation.x, y: translation.y, z: translation.z)
            }

            return }
        node.removeFromParentNode()
    }
    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    var petNode: SCNNode!
    let petNodeName = "shiba"
    
    func addPet(x: Float = 0, y: Float = 0, z: Float = -0.2) { //update in Part 5
        let petScene = SCNScene(named: "Animals/ShibaInu.scn")!
        petNode = petScene.rootNode.childNode(withName: petNodeName, recursively: true)
        petNode.scale = SCNVector3(0.1, 0.1, 0.1)
        petNode.position = SCNVector3(x, y, z) //update in Part 5
        sceneView.scene.rootNode.addChildNode(petNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,   ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(config)
        addPet()
    }


}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}


