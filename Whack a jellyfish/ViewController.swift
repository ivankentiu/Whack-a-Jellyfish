//
//  ViewController.swift
//  Whack a jellyfish
//
//  Created by Ivan Ken Tiu on 24/09/2017.
//  Copyright © 2017 Ivan Ken Tiu. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        
        // add a Tap Gesture Recognizer and use it!
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func play(_ sender: Any) {
        self.addNode()
    }
    
    @IBAction func reset(_ sender: Any) {
    }
    
    func addNode() {
        // use the jellyfish inside scene
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        
        // convert it to node (jellyfishchild of that particular rootnode)
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyFishNode?.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(jellyFishNode!)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        // TappedOn any SCN...
        let sceneViewTappedOn = sender.view as! SCNView
        
        // detect where the user tapped on
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        
        // if coordinates you touched correspond to the coordinates of an object thats inside scene tapped on (empty if no tap)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        
        // hitTest is array type
        if hitTest.isEmpty {
            print("didn't touch anything!")
        } else {
            // just get the [0] not the whole array! (unwrap since we know that we tapped!)
            let results = hitTest.first!
            // jush get the geometry info not all! (hitTest.debugDescription)
            let geometry = results.node.geometry!
            print(geometry)
        }
    }
    
}

