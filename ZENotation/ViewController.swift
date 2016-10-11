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
        let deltaScale = CGFloat(125) // Arbitrary through trial and error
        for index in 1...10 {
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
//            annotation.title = String(index)
            self.mapView?.addAnnotation(annotation)
        }
    }

    // MARK: - MapViewDelegate

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // TODO: Optimize aggregations on adds
//        // Do we want to reaggregate all annotations everytime we add new ones?
//        // Is there a way to progressively reorganize annotations as we add new ones
//        print("mapView: MKMapView, viewFor annotation: MKAnnotation")
//        return ZENotationView()
//    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // Might be more appropriate than `mapViewDidFinishRenderingMap`to initially structure annotations
        print("mapViewDidFinishLoadingMap(): Aggregating annotations.")
//        let annotations = mapView.annotations
//        let first = annotations.first as! ZENotation
//        if let annotations = first.annotations {
//            if (annotations.count > 0) {
//                print("Annotations already aggregated. Returning.")
//                return
//            }
//        }
//        print("mapViewDidFinishLoadingMap(): Collapsing \(mapView.annotations)")
//        let aggregatedAnnotations = self.collapseAnnotations(annotations)
//        mapView.removeAnnotations(mapView.annotations)
//        mapView.addAnnotations(aggregatedAnnotations)
//        let subCount = aggregatedAnnotations.first?.annotations?.count
//        print("Added annotation with \(subCount) sub-annotations")
    }

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        // Putting the aggregation logic in `mapViewDidFinishRenderingMap` gives
        // the user some time to visually observe the aggregation
        print("mapViewDidFinishRenderingMap")
        let annotations = mapView.annotations
        let first = annotations.first as! ZENotation
        if let annotations = first.annotations {
            if (annotations.count > 0) {
                print("Annotations already aggregated. Returning.")
                return
            }
        }
        print("mapViewDidFinishLoadingMap(): Collapsing \(mapView.annotations)")
        let aggregatedAnnotations = self.collapseAnnotations(annotations)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(aggregatedAnnotations)
        let subCount = aggregatedAnnotations.first?.annotations?.count
        print("Added annotation with \(subCount) sub-annotations")
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("mapViewRegionDidChangeAnimated(): Should reaggregate annotations.")
    }

//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
//        print("mapView: MKMapView, didAdd views: [MKAnnotationView]")
//        for view in views {
//            let annotation = view.annotation as! ZENotation
//            print("View \(mapView) has \(annotation.annotations?.count) sub-annotations")
//        }
//    }

    // MARK: ZENotation Aggregation Methods

    func collapseAnnotations(_ annotations: [MKAnnotation]) -> [ZENotation] {
        // * coordinate: let's start by taking the coordinates of the first point
        //     we can then use more accurate triangulation heuristics
        // * annotations: the sub-annotations
        // * info: nil (only Single annotations have info)
        print("Collapsing annotations \(annotations)")
        let collapsedAnnotation = ZENotation()
        let firstAnnotation = annotations.first
        collapsedAnnotation.coordinate = firstAnnotation!.coordinate
        collapsedAnnotation.annotations = annotations as? [ZENotation]
//        collapsedAnnotation.title = String("\(collapsedAnnotation.annotations?.count) friends nearby")
        return [collapsedAnnotation]
    }

    func collapseAllAnnotations(_ annotations: [ZENotation]) {

    }
}

