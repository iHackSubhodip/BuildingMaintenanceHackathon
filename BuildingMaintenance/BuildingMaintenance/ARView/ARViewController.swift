//
//  ARViewController.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import SceneKit
import MapKit
import ARCL
import CoreLocation
import CocoaLumberjack

let Altitude: CLLocationDistance = 870

@available(iOS 11.0, *)
class ARViewController: UIViewController {
    
    // TEMP TESTING VARIABLES
    let l1 = CLLocationCoordinate2D(latitude: 12.924664, longitude: 77.687450)
    let l2 = CLLocationCoordinate2D(latitude: 12.924770, longitude: 77.687454)
    let l3 = CLLocationCoordinate2D(latitude: 12.925173, longitude: 77.686271)
    let l4 = CLLocationCoordinate2D(latitude: 12.925075, longitude: 77.687447)
    let l5 = CLLocationCoordinate2D(latitude: 12.925723, longitude: 77.685772)
    let l6 = CLLocationCoordinate2D(latitude: 12.925134, longitude: 77.687151)
    let l7 = CLLocationCoordinate2D(latitude: 12.925137, longitude: 77.687003)
    let l8 = CLLocationCoordinate2D(latitude: 12.925140, longitude: 77.686895)
    let l9 = CLLocationCoordinate2D(latitude: 12.925155, longitude: 77.686677)
    let l10 = CLLocationCoordinate2D(latitude: 12.926300, longitude: 77.686800)
    let l11 = CLLocationCoordinate2D(latitude: 12.927000, longitude: 77.687000)
    
    let sc = CLLocationCoordinate2D(latitude: 12.924554, longitude: 77.687387)
    
    var sceneLocationView = SceneLocationView()
    
    let mapView = MKMapView()
    var userAnnotation: MKPointAnnotation?
    var locationEstimateAnnotation: MKPointAnnotation?
    var routeCoordinates = [CLLocationCoordinate2D]()
    // Distance between intermediate nodes between waypoint nodes
    let metersPerNode: CLLocationDistance = 5
    
    var updateUserLocationTimer: Timer?
    
    ///Whether to show a map view
    ///The initial value is respected
    var showMapView: Bool = false
    
    var centerMapOnUserLocation: Bool = true
    
    ///Whether to display some debugging data
    ///This currently displays the coordinate of the best location estimate
    ///The initial value is respected
    var displayDebugging = true
    
    var adjustNorthByTappingSidesOfScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set to true to display an arrow which points north.
        //Checkout the comments in the property description and on the readme on this.
        //        sceneLocationView.orientToTrueNorth = false
        
        //        sceneLocationView.locationEstimateMethod = .coreLocationDataOnly
        sceneLocationView.showAxesNode = true
        //DO
        //sceneLocationView.locationDelegate = self
        sceneLocationView.locationDelegate = self
        if displayDebugging {
            sceneLocationView.showFeaturePoints = true
        }
        
        self.plotARRoute()
        
        view.addSubview(sceneLocationView)
        
        
        if showMapView {
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.alpha = 0.8
            view.addSubview(mapView)

            updateUserLocationTimer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(ARViewController.updateUserLocation),
                userInfo: nil,
                repeats: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("run")
        sceneLocationView.run()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("pause")
        // Pause the view's session
        sceneLocationView.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height)
        
        mapView.frame = CGRect(
            x: 0,
            y: self.view.frame.size.height / 2,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height / 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func plotARRoute() {
        // First remove all AR nodes previously plotted
        //DO
        sceneLocationView.resetLocationNodes()
//        sceneLocationView.
        routeCoordinates.append(sc)
        routeCoordinates.append(l1)
        routeCoordinates.append(l2)
        routeCoordinates.append(l3)
//        routeCoordinates.append(l4)
//        routeCoordinates.append(l5)
//        routeCoordinates.append(l6)
        //routeCoordinates.append(l7)
//        routeCoordinates.append(l8)
//        routeCoordinates.append(l9)
        routeCoordinates.append(l10)
        //routeCoordinates.append(l11)
        
        // Add an AR annotation for every coordinate in routeCoordinates
        for coordinate in routeCoordinates {
            // TODO: Change altitude so that it is not hard coded
            let nodeLocation = CLLocation(coordinate: coordinate, altitude: Altitude)
            let locationAnnotation = LocationAnnotationNode(location: nodeLocation, image: UIImage(named: "pin")!)
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: locationAnnotation)
            
        }
        
        
        // Use Turf to find the total distance of the polyline
        let distance = Turf.distance(along: routeCoordinates)
        
        // Walk the route line and add a small AR node and map view annotation every metersPerNode
        for i in stride(from: 0, to: distance, by: metersPerNode) {
            // Use Turf to find the coordinate of each incremented distance along the polyline
            if let nextCoordinate = Turf.coordinate(at: i, fromStartOf: routeCoordinates) {
                let interpolatedStepLocation =                 CLLocation(coordinate: nextCoordinate, altitude: Altitude)
                
                // Add an AR node
                let locationAnnotation = LocationAnnotationNode(location: interpolatedStepLocation, image: UIImage(named: "middleNode")!)
                sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: locationAnnotation)
            }
        }
        
    }
    
    @objc func updateUserLocation() {
        if let currentLocation = sceneLocationView.currentLocation() {
            DispatchQueue.main.async {
                
                if let bestEstimate = self.sceneLocationView.bestLocationEstimate(),
                    let position = self.sceneLocationView.currentScenePosition() {
                    let translation = bestEstimate.translatedLocation(to: position)
                }
                
                if self.userAnnotation == nil {
                    self.userAnnotation = MKPointAnnotation()
                    self.mapView.addAnnotation(self.userAnnotation!)
                }
                
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    self.userAnnotation?.coordinate = currentLocation.coordinate
                }, completion: nil)
                
                if self.centerMapOnUserLocation {
                    UIView.animate(withDuration: 0.45, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                        self.mapView.setCenter(self.userAnnotation!.coordinate, animated: false)
                    }, completion: {
                        _ in
                        self.mapView.region.span = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
                    })
                }
                
                if self.displayDebugging {
                    let bestLocationEstimate = self.sceneLocationView.bestLocationEstimate()
                    
                    if bestLocationEstimate != nil {
                        if self.locationEstimateAnnotation == nil {
                            self.locationEstimateAnnotation = MKPointAnnotation()
                            self.mapView.addAnnotation(self.locationEstimateAnnotation!)
                        }
                        
                        self.locationEstimateAnnotation!.coordinate = bestLocationEstimate!.location.coordinate
                    } else {
                        if self.locationEstimateAnnotation != nil {
                            self.mapView.removeAnnotation(self.locationEstimateAnnotation!)
                            self.locationEstimateAnnotation = nil
                        }
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != nil {
                if (mapView == touch.view! ||
                    mapView.recursiveSubviews().contains(touch.view!)) {
                    centerMapOnUserLocation = false
                } else {
                    
                    let location = touch.location(in: self.view)
                    
                    if location.x <= 40 && adjustNorthByTappingSidesOfScreen {
                        print("left side of the screen")
                        sceneLocationView.moveSceneHeadingAntiClockwise()
                    } else if location.x >= view.frame.size.width - 40 && adjustNorthByTappingSidesOfScreen {
                        print("right side of the screen")
                        sceneLocationView.moveSceneHeadingClockwise()
                    } else {
                        let image = UIImage(named: "pin")!
                        let annotationNode = LocationAnnotationNode(location: nil, image: image)
                        annotationNode.scaleRelativeToDistance = true
                        sceneLocationView.addLocationNodeForCurrentPosition(locationNode: annotationNode)
                    }
                }
            }
        }
    }
}

//MARK: MKMapViewDelegate
extension ARViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if let pointAnnotation = annotation as? MKPointAnnotation {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            //DO
            if pointAnnotation == self.userAnnotation {
                marker.displayPriority = .required
                marker.glyphImage = UIImage(named: "user")
            } else {
                marker.displayPriority = .required
                marker.markerTintColor = UIColor(hue: 0.267, saturation: 0.67, brightness: 0.77, alpha: 1.0)
                marker.glyphImage = UIImage(named: "compass")
            }
            
            return marker
        }
        
        return nil
    }
}

//MARK: SceneLocationViewDelegate
extension ARViewController: SceneLocationViewDelegate {
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) { }
    
    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) { }
    
    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView, node: LocationNode) { }
    
    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView, sceneNode: SCNNode) { }
    
    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView, locationNode: LocationNode) { }
}

extension DispatchQueue {
    func asyncAfter(timeInterval: TimeInterval, execute: @escaping () -> Void) {
        self.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(timeInterval * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: execute)
    }
}

extension UIView {
    func recursiveSubviews() -> [UIView] {
        var recursiveSubviews = self.subviews
        
        for subview in subviews {
            recursiveSubviews.append(contentsOf: subview.recursiveSubviews())
        }
        
        return recursiveSubviews
    }
}
