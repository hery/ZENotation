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

extension Array where Element : ZENotation {
    // Extension method on generic type
    // Import ZENotation to have access to the array method
    // TODO: Improve collapsing heuristics
    func collapseAnnotations() -> ZENotation {
        if let first = self.first {
            return first
        }
        return ZENotation()
    }

    func collapseAllAnnotations() -> [ZENotation] {
        // Sort annotations by ln first
        let sortedAnnotations = self.sorted {
            (annotation1, annotation2) -> Bool in
                let mapPointCoordinates1 = MKMapPointForCoordinate(annotation1.coordinate)
                let mapPointCoordinates2 = MKMapPointForCoordinate(annotation2.coordinate)
                return
                    (mapPointCoordinates1.x < mapPointCoordinates2.x) &&
                    (mapPointCoordinates1.y < mapPointCoordinates2.y)
        }
        // Collapse sorted annotations linearly
        return [ZENotation.init()]
    }
}

class ZENotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    // Internal annotation array to handle annotations aggregation
    private var annotations: [ZENotation]?
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
