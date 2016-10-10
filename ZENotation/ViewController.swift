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
        // Generate array of random coordinates within a given
        // region to demonstrate the aggregation
        let coordinates:[CLLocationCoordinate2D] = []
        let notations = ZENotations.init(coordinates:coordinates)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var otherAnnotationView:ZENotationView?
        let dequeuedAnnotationView:ZENotationView? = mapView.dequeueReusableAnnotationView(withIdentifier:
            annotationOtherLocationReuseIdentifier) as! ZENotationView?
        if let view = dequeuedAnnotationView {
            otherAnnotationView = view
            print("Dequeued an annotation view!")
        } else {
            print("Couldn't dequeue an annotation view, creating a new one!")
            otherAnnotationView = ZENotationView(annotation: annotation,
                                                 reuseIdentifier: annotationOtherLocationReuseIdentifier)
        }
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        titleLabel.text = "HEY"
        otherAnnotationView?.leftCalloutAccessoryView?.addSubview(titleLabel)
        return otherAnnotationView
    }
}

