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
        // Generate array of random coordinates within a given
        // region to demonstrate the aggregation
//        let coordinates:[CLLocationCoordinate2D] = []
//        let notations = ZENotations.init(coordinates:coordinates)
        let annotation = MKPointAnnotation()
        annotation.coordinate = testLocation
        self.mapView?.addAnnotation(annotation)
    }

    // MARK: - MapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // TODO: Optimize aggregations on adds
        // Do we want to reaggregate all annotations everytime we add new ones?
        // Is there a way to progressively reorganize annotations as we add new ones
        print("mapView: MKMapView, viewFor annotation: MKAnnotation")
        return ZENotationView()
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // Might be more appropriate than `mapViewDidFinishRenderingMap`to initially structure annotations
        print("mapViewDidFinishLoadingMap(): Aggregating annotations.")
        let annotations = mapView.annotations as! [ZENotation]
        let aggregatedAnnotations = annotations.collapseAllAnnotations()
        mapView.removeAnnotations(annotations)
        mapView.addAnnotations(aggregatedAnnotations)
    }

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("mapViewDidFinishRenderingMap")
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("mapViewRegionDidChangeAnimated(): Reaggregating annotations.")
    }

    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        print("mapView: MKMapView, didAdd views: [MKAnnotationView]")
    }


}

