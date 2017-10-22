/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Methods on the main view controller for handling virtual object loading and movement
*/

import UIKit
import SceneKit

extension ViewController: SearchTableViewControllerDelegate, VirtualObjectManagerDelegate {
    
    // MARK: - VirtualObjectManager delegate callbacks
    
    // TODO SPINNER STUFF
    func virtualObjectManager(_ manager: VirtualObjectManager, willLoad object: VirtualObject) {
        DispatchQueue.main.async {
            // Show progress indicator
            self.spinner = UIActivityIndicatorView()
//            self.spinner!.center = self.addObjectButton.center
//            self.spinner!.bounds.size = CGSize(width: self.addObjectButton.bounds.width - 5, height: self.addObjectButton.bounds.height - 5)
//            self.addObjectButton.setImage(#imageLiteral(resourceName: "buttonring"), for: [])
//            self.sceneView.addSubview(self.spinner!)
//            self.spinner!.startAnimating()
            
            self.isLoadingObject = true
        }
    }
    
    func virtualObjectManager(_ manager: VirtualObjectManager, didLoad object: VirtualObject) {
        DispatchQueue.main.async {
            self.isLoadingObject = false
            
            // Remove progress indicator
//            self.spinner?.removeFromSuperview()
//            self.addObjectButton.setImage(#imageLiteral(resourceName: "add"), for: [])
//            self.addObjectButton.setImage(#imageLiteral(resourceName: "addPressed"), for: [.highlighted])
        }
    }
    
    func virtualObjectManager(_ manager: VirtualObjectManager, couldNotPlace object: VirtualObject) {
        textManager.showMessage("CANNOT PLACE OBJECT\nTry moving left or right.")
    }
    
    // MARK: - VirtualObjectSelectionViewControllerDelegate
    
    func virtualObjectSelectionViewController(_: SearchTableViewController, didSelectObjectAt index: Int) {
        guard let cameraTransform = session.currentFrame?.camera.transform else {
            return
        }
        
        let product = (UIApplication.shared.delegate as! AppDelegate).searchResults[index]
        
        var findDefinition: VirtualObjectDefinition?
        
        // Search for def
        for def in VirtualObjectManager.availableObjects {
            if def.modelName == product.modelKey {
                findDefinition = def
                break
            }
        }
        
//        let definition = [index]
        guard let definition = findDefinition else {
            textManager.showAlert(title: "Uh oh", message: "Model not found")
            return
        }
        
        let object = VirtualObject(definition: definition)
        let position = focusSquare?.lastPosition ?? float3(0)
        virtualObjectManager.loadVirtualObject(object, to: position, cameraTransform: cameraTransform)
        
        object.addChildNode(self.getHud(product: product))
        //object.addChildNode(self.getMapView())
        object.name = product.modelKey
        if object.parent == nil {
            serialQueue.async {
                self.sceneView.scene.rootNode.addChildNode(object)
            }
        }
    }
    
    // I dont think this works anymore
    func virtualObjectSelectionViewController(_: SearchTableViewController, didDeselectObjectAt index: Int) {
        //virtualObjectManager.removeVirtualObject(at: index)
    }
    
}
