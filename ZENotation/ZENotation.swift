//
//  ZENotation.swift
//  ZENotation
//
//  Created by Hery Ratsimihah on 10/10/16.
//  Copyright © 2016 Ratsimihah. All rights reserved.
//

import UIKit
import MapKit

let clusterSize = 3

/** TODO: Figure out Array<Element> issue
extension Array where Element : MKAnnotation {
    // Extension method on generic type
    // Import ZENotation to have access to the array method
    // TODO: Improve collapsing heuristics
    func collapseAnnotations(annotations: [ZENotation]) -> ZENotation {
        // * coordinate: let's start by taking the coordinates of the first point
        //     we can then use more accurate triangulation heuristics
        // * annotations: the sub-annotations
        // * info: nil (only Single annotations have info)
        print("Collapsing annotations \(annotations)")
        let collapsedAnnotation = ZENotation()
        collapsedAnnotation.coordinate = (annotations.first?.coordinate)!
        collapsedAnnotation.annotations = annotations
        return collapsedAnnotation
    }

    func collapseAllAnnotations() -> [ZENotation] {
        // TODO: Create a custom Collection to enable sorting and slicings
        print("Collapsing: \(self)")
        // Collapse sorted annotations linearly
        var resultArray:[ZENotation] = []
        let annotations = self as Array<ZENotation>
        let collapsedAnnotation = collapseAnnotations(annotations: self)
        return resultArray
    }

    func sortAnnotations() -> [Element] {
        return self.sorted {
            (annotation1, annotation2) -> Bool in
            let mapPointCoordinates1 = MKMapPointForCoordinate(annotation1.coordinate)
            let mapPointCoordinates2 = MKMapPointForCoordinate(annotation2.coordinate)
            return
                (mapPointCoordinates1.x < mapPointCoordinates2.x) &&
                    (mapPointCoordinates1.y < mapPointCoordinates2.y)
        }
    }
}
 */

class ZENotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    // Internal annotation array to handle annotations aggregation
    var annotations: [ZENotation]?
    var info: [String: String]?

    override init() {
        self.coordinate = CLLocationCoordinate2D()
        super.init()
    }

    func expand() -> Array<ZENotation> {
        return [ZENotation()]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
