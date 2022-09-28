//
//  MKMapView+RegionWidth.swift
//  GiftAMeal
//
//  Created by Brian Strobach on 8/20/20.
//

#if canImport(MapKit)
import MapKit

public extension MKMapView {
  func regionWidth() -> CLLocationDistance {
    let eastMapPoint = MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.midY)
    let westMapPoint = MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.midY)
    return eastMapPoint.distance(to: westMapPoint)
  }
}
#endif
