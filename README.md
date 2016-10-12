# ZENotation

A MapKit annotation aggregation framwork

## Why

Displaying hundreds of annotations on a map yields low framerates.
By aggregating annotations into clusters, we can display less annotation and get higher framerates without loss of information.

## Usage

Create your annotations:

    let annotation = ZENotation()
    annotation.coordinate = CLLocationCoordinate2D.init(latitude: 48.869890, longitude: 2.330495)
    annotation.title = "Hello"
    self.mapView?.addAnnotation(annotation)

Aggregate them, for example, in your map view delegate:

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        mapView.collapseAllAnnotations()
    }

## Installation

For now clone the project and import the files in the `Framework` group into your project.
Carthage compatibility is on the way.

## Screenshots

![simulator screen shot oct 12 2016 5 33 22 pm](https://cloud.githubusercontent.com/assets/910954/19319141/d9bbd4b2-90ab-11e6-9657-67760abf05e7.png) ![simulator screen shot oct 12 2016 5 33 23 pm](https://cloud.githubusercontent.com/assets/910954/19319142/d9bdf53a-90ab-11e6-8ded-a62290c8e266.png)

