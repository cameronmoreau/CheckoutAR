/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Manages single finger gesture interactions with the AR scene.
*/

import ARKit
import SceneKit

class SingleFingerGesture: Gesture {
    
    // MARK: - Properties
    
    var initialTouchLocation = CGPoint()
    var latestTouchLocation = CGPoint()
    var firstTouchedObject: VirtualObject?

    let translationThreshold: CGFloat = 30
    var translationThresholdPassed = false
    var hasMovedObject = false
    
    var dragOffset = CGPoint()
    
    // MARK: - Initialization
    
    override init(_ touches: Set<UITouch>, _ sceneView: ARSCNView, _ lastUsedObject: VirtualObject?, _ objectManager: VirtualObjectManager) {
        super.init(touches, sceneView, lastUsedObject, objectManager)
        
        let touch = currentTouches.first!
        initialTouchLocation = touch.location(in: sceneView)
        latestTouchLocation = initialTouchLocation
        
        firstTouchedObject = virtualObject(at: initialTouchLocation)
    }
    
    // MARK: - Gesture Handling
    
    override func updateGesture() {
        super.updateGesture()
        
        guard let virtualObject = firstTouchedObject else {
            return
        }
        
        latestTouchLocation = currentTouches.first!.location(in: sceneView)
        
        do {
            let products = (UIApplication.shared.delegate as! AppDelegate).searchResults
            let targetProducts = products.filter { $0.modelKey == firstTouchedObject?.name }
            if !targetProducts.isEmpty {
                let cart = (UIApplication.shared.delegate as! AppDelegate).cart
                let targetProduct = targetProducts[0]
                if cart.isEmpty || cart.last!.modelKey != targetProduct.modelKey {
                    (UIApplication.shared.delegate as! AppDelegate).cart.append(targetProduct)
                    
                    
                    let text = SCNText(string: "In Cart" , extrusionDepth: 0.01)
                    text.font = UIFont.systemFont(ofSize: 0.11, weight: .semibold)
                    objectManager.cartDelegate?.cartUpdated()
                    
                    let n = SCNNode(geometry: text)
                    n.scale = SCNVector3Make(0.15, 0.15, 0.15)
                    n.position = SCNVector3(-0.085, 0.044, 0.005)
                    sceneView.scene.rootNode.childNode(withName: targetProduct.modelKey, recursively: false)?.addChildNode(n)
                }
            }
            
        } catch _ {
        }
        
        if !translationThresholdPassed {
            let initialLocationToCurrentLocation = latestTouchLocation - initialTouchLocation
            let distanceFromStartLocation = initialLocationToCurrentLocation.length()
            if distanceFromStartLocation >= translationThreshold {
                translationThresholdPassed = true
                
                let currentObjectLocation = CGPoint(sceneView.projectPoint(virtualObject.position))
                dragOffset = latestTouchLocation - currentObjectLocation
            }
        }
        
        // A single finger drag will occur if the drag started on the object and the threshold has been passed.
        if translationThresholdPassed {
            
            let offsetPos = latestTouchLocation - dragOffset
            objectManager.translate(virtualObject, in: sceneView, basedOn: offsetPos, instantly: false, infinitePlane: true)
            hasMovedObject = true
            lastUsedObject = virtualObject
        }
    }
    
    func finishGesture() {
        // Single finger touch allows teleporting the object or interacting with it.
        
        // Do not do anything if this gesture is being finished because
        // another finger has started touching the screen.
        if currentTouches.count > 1 {
            return
        }
        
        // Do not do anything either if the touch has dragged the object around.
        if hasMovedObject {
            return
        }
        
        if lastUsedObject != nil {
            // If this gesture hasn't moved the object then perform a hit test against
            // the geometry to check if the user has tapped the object itself.
            // - Note: If the object covers a significant
            // percentage of the screen then we should interpret the tap as repositioning
            // the object.
            let isObjectHit = virtualObject(at: latestTouchLocation) != nil
            
            if !isObjectHit {
                // Teleport the object to whereever the user touched the screen - as long as the
                // drag threshold has not been reached.
                if !translationThresholdPassed {
                    objectManager.translate(lastUsedObject!, in: sceneView, basedOn: latestTouchLocation, instantly: true, infinitePlane: false)
                }
            }
        }
    }
    
}
