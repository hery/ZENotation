//
//  ZENotationView.swift
//  ZENotation
//
//  Created by Hery Ratsimihah on 10/10/16.
//  Copyright © 2016 Ratsimihah. All rights reserved.
//

import UIKit
import MapKit

enum ZENotationViewType {
    case Aggregated
    case Single
}

class ZENotationView: MKAnnotationView {

    var imageView:UIImageView?
    var titleLabel:UILabel?
    var type:ZENotationViewType?

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        switch self.type! {
        case .Aggregated:
            self.setUpAggregatedView()
        case .Single:
            self.setUpSingleView()
        }
    }

    private func setUpAggregatedView() {

    }

    private func setUpSingleView() {

    }
}
