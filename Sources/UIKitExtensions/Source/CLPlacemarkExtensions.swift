//
//  CLPlacemarkExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/11/17.
//
//

#if canImport(Contacts)
import Foundation
import CoreLocation
import Contacts
import Swiftest

@available(iOS, obsoleted: 11.0, message: "Use apples implementation of postalAddress instead.")
@available(OSX, obsoleted: 10.13, message: "Use apples implementation of postalAddress instead.")
    extension CLPlacemark {
        
        public var postalAddress: CNPostalAddress? {

            let address = CNMutablePostalAddress()
            address.street =? thoroughfare
            address.state =? administrativeArea
            address.city =? locality
            address.country =? country
            address.postalCode =? postalCode
            address.isoCountryCode =? isoCountryCode
            
            if #available(iOS 10.3, OSX 10.12.4, *) {
                address.subLocality =? subLocality
                address.subAdministrativeArea =? subAdministrativeArea
            }
            return address
        }
    }
#endif
