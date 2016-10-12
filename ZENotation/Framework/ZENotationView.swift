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

    override func draw(_ rect: CGRect) {
        switch self.type! {
        case .Aggregated:
            self.setUpAggregatedView()
        case .Single:
            self.setUpSingleView()
        }
    }

    private func setUpAggregatedView() {
        /**
         Set up a an aggregated view showing the images of every sub-annotations.
         One of the sub-annotation will show, e.g. "6+" annotations if there are
         more than 6 annotations.
         */
    }

    private func setUpSingleView() {
        /**
         Set up a single annotation showing an image or a title
         */
    }
}
