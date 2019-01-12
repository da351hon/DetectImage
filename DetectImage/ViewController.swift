//
//  ViewController.swift
//  DetectImage
//
//  Created by 本多俊之 on 2019/01/12.
//  Copyright © 2019年 da351hon. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // デバッグ用に特徴点を表示
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // ライトを追加
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // 画像認識の参照用画像をアセットから取得
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages =
            ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)!
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // 画像検出時に呼び出される
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor:
        ARAnchor) {
        // 検出をバイブで通知
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
        var displayText = "硬貨"
        if let imageAnchor = anchor as? ARImageAnchor {
            if let name = imageAnchor.referenceImage.name {
                switch name {
                case "yen1":
                    displayText = "1円"
                case "yen5":
                    displayText = "5円"
                case "yen10":
                    displayText = "10円"
                case "yen50":
                    displayText = "50円"
                default:
                    displayText = "？"
                }
            }
        }
        
        let text = SCNText(string: displayText, extrusionDepth: 0.2)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.firstMaterial?.diffuse.contents = UIColor.red
        let textNode = SCNNode(geometry: text)
        
        let (min, max) = (textNode.boundingBox)
        let w = Float(max.x - min.x)
        let ratio = 0.02 / w
        textNode.scale = SCNVector3(ratio, ratio, ratio)
        textNode.pivot = SCNMatrix4Rotate(textNode.pivot, Float.pi, 0, 1, 0)
        
        // テキストをカメラ方向固定にする
        let constraint = SCNLookAtConstraint(target: sceneView.pointOfView)
        constraint.isGimbalLockEnabled = true
        textNode.constraints = [constraint]
        
        node.addChildNode(textNode)
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
