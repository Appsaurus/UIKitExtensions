//
//  CLPlacemarkExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/11/17.
//
//

import Foundation
import CoreLocation
import Contacts
import Swiftest

extension CLPlacemark {
    public var _postalAddress: CNPostalAddress? {
        
        guard #available(iOS 11.0, *) else {
            guard let addressDictionary = addressDictionary else { return nil }
            let address = CNMutablePostalAddress()
            address.street = addressDictionary["Street"] as? String ?? ""
            address.state =? administrativeArea
            address.city =? locality
            address.country =? country
            address.postalCode =? postalCode
            address.isoCountryCode =? isoCountryCode
            
            if #available(iOS 10.3, *) {
                address.subLocality =? subLocality
                address.subAdministrativeArea =? subAdministrativeArea
            }
            return address
        }
        return self.postalAddress
    }
}
