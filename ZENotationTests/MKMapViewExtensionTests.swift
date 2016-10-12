//
//  ZENotationTests.swift
//  ZENotationTests
//
//  Created by Hery Ratsimihah on 10/9/16.
//  Copyright © 2016 Ratsimihah. All rights reserved.
//

import XCTest
import MapKit
@testable import ZENotation

let testLocation = CLLocationCoordinate2D.init(latitude: 48.869890, longitude: 2.330495)

class MKMapViewExtensionTests: XCTestCase {

    var mapView:MKMapView?
    var firstAnnotation:ZENotation?
    var secondAnnotation:ZENotation?
    var thirdAnnotation:ZENotation?

    override func setUp() {
        super.setUp()
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 375.0, height: 667.0))
        firstAnnotation = ZENotation()
        firstAnnotation!.coordinate = testLocation
        secondAnnotation = ZENotation()
        secondAnnotation!.coordinate = testLocation
        thirdAnnotation = ZENotation()
        secondAnnotation!.coordinate = testLocation
        self.mapView?.addAnnotations([firstAnnotation!, secondAnnotation!, thirdAnnotation!])
    }

    func testcollapseAnnotations() {
        let annotations = self.mapView?.annotations
        let collapsedAnnotations = self.mapView?.collapseAnnotations(annotations!)
        let collapsedAnnotation = collapsedAnnotations?.first
        XCTAssertTrue(equalCoordinates(collapsedAnnotation!.coordinate, self.firstAnnotation!.coordinate))
        XCTAssertEqual(collapsedAnnotation?.annotations!.count, 3)
    }

    func testCollapseAllAnnotations() {
        self.mapView!.collapseAllAnnotations()
        XCTAssertEqual(self.mapView!.annotations.count, 1)
        let annotations = self.mapView!.annotations as! [ZENotation]
        let subAnnotations = annotations.first!.annotations
        XCTAssertEqual(subAnnotations!.count, 3)
        XCTAssertTrue(equalCoordinates(subAnnotations![0].coordinate, firstAnnotation!.coordinate))
        XCTAssertTrue(equalCoordinates(subAnnotations![1].coordinate, secondAnnotation!.coordinate))
        XCTAssertTrue(equalCoordinates(subAnnotations![2].coordinate, thirdAnnotation!.coordinate))

    }

    func equalCoordinates(_ coordinates1: CLLocationCoordinate2D, _ coordinates2: CLLocationCoordinate2D) -> Bool {
        return (coordinates1.latitude == coordinates2.latitude &&
                coordinates2.longitude == coordinates2.longitude)
    }



}
