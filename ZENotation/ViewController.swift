//
//  ViewController.swift
//  ZENotation
//
//  Created by Hery Ratsimihah on 10/9/16.
//  Copyright © 2016 Ratsimihah. All rights reserved.
//

import UIKit
import MapKit

/**
 A MapView to experiment with our annotations.
 */

let testLocation = CLLocationCoordinate2D.init(latitude: 48.869890, longitude: 2.330495)
let annotationCurrentLocationReuseIdentifier = "currentLocation"
let annotationOtherLocationReuseIdentifier = "otherLocation"

class ViewController: UIViewController, MKMapViewDelegate {

    var mapView:MKMapView?

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Loaded ViewController")
        self.setUpMapView()
        self.setUpDemoAnnotations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UI + Map Logic

    func setUpMapView() {
        self.mapView = MKMapView(frame: self.view.frame)
        self.mapView!.setRegion(
            MKCoordinateRegion.init(
                center: testLocation,
                span: MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)),
            animated: true)
        self.mapView?.delegate = self
        self.view.addSubview(self.mapView!)

    }

    func setUpDemoAnnotations() {
        // Generate array of random coordinates within a given region
        let deltaScale = CGFloat(125) // arbitrary distribution through trial and error
        for _ in 1...10 {
            let annotation = ZENotation()
            let signArray = [1, -1]
            let randomIndex = Int(arc4random_uniform(UInt32(signArray.count)))
            let sign = CGFloat(signArray[randomIndex])
            let latDelta = CGFloat(Float(arc4random()) / Float(UINT32_MAX))/deltaScale*sign
            let longDelta = CGFloat(Float(arc4random()) / Float(UINT32_MAX))/deltaScale*sign
            let lat = Double(CGFloat(testLocation.latitude) + latDelta)
            let long = Double(CGFloat(testLocation.longitude) + longDelta)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            annotation.coordinate = coordinate
            annotation.title = String("\(index)")
            self.mapView?.addAnnotation(annotation)
        }
    }

    // MARK: - MapViewDelegate

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        /**
        Putting the aggregation logic in `mapViewDidFinishRenderingMap` gives
        the user some time to visually observe the aggregation, as opposed to
        mapViewDidFinishLoadingMap, which happens directly.
        */
        mapView.collapseAllAnnotations()
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /**
        Ideally we want to re-aggregate the annotations in the new region here
         */
    }
}

