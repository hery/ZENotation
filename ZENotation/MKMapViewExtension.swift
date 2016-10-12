//
//  MKMapViewExtension.swift
//  ZENotation
//
//  Created by Hery Ratsimihah on 10/12/16.
//  Copyright © 2016 Ratsimihah. All rights reserved.
//

import UIKit
import MapKit

/**
 TODO: Finish aggregation algorithm.
 Ideally we want to aggregate the annotations into as many annotations as we can
 so that the UI remain responsive and readable, instead of into a single annotation.
 */

extension MKMapView {
    /**
     Collapse an array of annotations into an array containing a single annotations
     that can be displayed as an aggregated annotation
     */
    func collapseAnnotations(_ annotations: [MKAnnotation]) -> [ZENotation] {
        // * coordinate: let's start by taking the coordinates of the first point
        //     we can then use more accurate aggregation heuristics
        //     e.g: take the center of the cluster
        // * annotations: the sub-annotations
        // * info: nil (only Single annotations (leaves) have info)
        print("Collapsing annotations \(annotations)")
        let collapsedAnnotation = ZENotation()
        let firstAnnotation = annotations.first
        collapsedAnnotation.coordinate = firstAnnotation!.coordinate
        collapsedAnnotation.annotations = annotations as? [ZENotation]
        return [collapsedAnnotation]
    }

    /**
    Collapse all the annotations on a map using the heuristics in `collapseAnnotations()`
     */
    func collapseAllAnnotations() {
        let annotations = self.annotations
        let first = annotations.first as! ZENotation
        if let annotations = first.annotations {
            if (annotations.count > 0) {
                print("Annotations already aggregated. Returning.")
                return
            }
        }
        let aggregatedAnnotations = self.collapseAnnotations(annotations)
        self.removeAnnotations(self.annotations)
        self.addAnnotations(aggregatedAnnotations)
        let subCount = aggregatedAnnotations.first?.annotations?.count
        print("Added annotation with \(subCount) sub-annotations")

    }
}
