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

class ZENotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    // Internal annotation array to handle annotations aggregation
    var annotations: [ZENotation]?
    var info: [String: String]?
    var title: String?

    override init() {
        self.coordinate = CLLocationCoordinate2D()
        super.init()
    }
}
