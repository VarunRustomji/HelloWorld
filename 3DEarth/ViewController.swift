//
//  ViewController.swift
//  3DEarth
//
//  Created by Varun Rustomji on 2019-01-24.
//  Copyright © 2019 Varun Rustomji. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creating a scene
        let scene = SCNScene()
        
        //Creating a camera node and positioning it
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 5)
        //Adding Camera as child node
        scene.rootNode.addChildNode(cameraNode)
        
        //Creating a light nodes, defining its type, position and then added it to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 2, 5)
        scene.rootNode.addChildNode(lightNode)
        
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = .ambient
        ambientLight.light?.intensity = 40
        scene.rootNode.addChildNode(ambientLight)
        
        //Initialized the stars and added them to the scene
        let stars = SCNParticleSystem(named: "StarsParticles.scnp", inDirectory: nil)!
        scene.rootNode.addParticleSystem(stars)
        
        //Initialized the earth node and added that to the scene
        let earthNode = EarthNode()
        scene.rootNode.addChildNode(earthNode)
        
        //Initializing scene view and adding the scene to it
        let sceneView = self.view as! SCNView
        sceneView.scene = scene
        
        //Modifying the properties of the node
        sceneView.showsStatistics = true
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        
        //Adding Text to scene
        let textGeometry = SCNText(string: "Hello", extrusionDepth: 0.5)
        textGeometry.font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 0.5)
        textGeometry.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        textGeometry.flatness = 0.1
        textGeometry.chamferRadius = 0.05

        let textNode = SCNNode(geometry: textGeometry)
        scene.rootNode.addChildNode(textNode)

        //Aligning the text
        let (minVec, maxVec) = textNode.boundingBox
        textNode.position = SCNVector3(x: ((minVec.x - maxVec.x) + 2.3) / 2, y: minVec.y - (maxVec.y - 1), z: 0)
        textNode.pivot = SCNMatrix4MakeTranslation((maxVec.x - minVec.x) / 2, 0, 0)
        scene.rootNode.addChildNode(textNode)
        
    }
    
    //TO hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

