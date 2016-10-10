//
//  ZENotation.swift
//  ZENotation
//
//  Created by Hery Ratsimihah on 10/10/16.
//  Copyright © 2016 Ratsimihah. All rights reserved.
//

import UIKit
import MapKit

extension Array where Element : ZENotation {
    // Extension method on generic type
    // Import ZENotation to have access to the array method
    func collapse() -> ZENotation {
        if let first = self.first {
            return first
        }
        return ZENotation()
    }
}

//extension Sequence where Iterator.Element : ZENotation {
//    // Protocol Extension
//    // Make class conform to the ZENotation protocol
//}

class ZENotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D

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
