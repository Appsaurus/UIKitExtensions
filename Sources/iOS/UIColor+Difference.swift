////
////  UIColor+Difference.swift
////  AppsaurusUIKit
////
////  Created by Brian Strobach on 3/8/18.
////
//
//import Foundation
//
//extension UIColor{
//
// MARK: Difference API
//    public enum ColorDifferenceAlgorithm{
//        case CIEDE2000
//        case CIE94
//    }
//
//    public func differenceFrom(color: UIColor, using algorithm: ColorDifferenceAlgorithm = .CIEDE2000) -> CGFloat {
//        return UIColor.differenceBetween(self, color, using: algorithm)
//    }
//
//    public class func differenceBetween(_ color1: UIColor, _ color2: UIColor, using algorithm: ColorDifferenceAlgorithm = .CIEDE2000) -> CGFloat {
//        switch algorithm{
//        case .CIEDE2000:
//            return color1.CIEDE2000(compare: color2)
//        case .CIE94:
//            return color1.CIE94(compare: color2)
//        }
//
//    }
//
// MARK: Closest Match API
//    public func closestMatch(in palette: [UIColor]) -> UIColor{
//        return UIColor.closestMatch(to: self, in: palette)
//    }
//
//    public class func closestMatch(to color: UIColor, in palette: [UIColor]) -> UIColor {
//        var palette = palette
//        guard var nearestColor: UIColor = palette.pop() else { return .clear}
//        var smallestDistance: CGFloat = differenceBetween(nearestColor, color)
//        palette.forEach { (candidateColor) in
//            let currentDistance = differenceBetween(color, candidateColor)
//            if currentDistance < smallestDistance {
//                smallestDistance = currentDistance
//                nearestColor = candidateColor
//            }
//        }
//        //Return the closest  color
//        return nearestColor
//    }
//
// MARK: Color distance algorithm implementations
//    /**
//    Detemine the distance between two colors based on the way humans perceive them.
//
//    - parameter compare color: A UIColor to compare.
//
//    - returns: A CGFloat representing the deltaE
//    */
//    func CIE94(compare color: UIColor) -> CGFloat {
//        // https://en.wikipedia.org/wiki/Color_difference#CIE94
//
//        let k_L:CGFloat = 1
//        let k_C:CGFloat = 1
//        let k_H:CGFloat = 1
//        let k_1:CGFloat = 0.045
//        let k_2:CGFloat = 0.015
//
//        let LAB1 = self.toLabComponents()
//        let L_1 = LAB1.L, a_1 = LAB1.a, b_1 = LAB1.b
//
//        let LAB2 = color.toLabComponents()
//        let L_2 = LAB2.L, a_2 = LAB2.a, b_2 = LAB2.b
//
//        let deltaL:CGFloat = L_1 - L_2
//        let deltaA:CGFloat = a_1 - a_2
//        let deltaB:CGFloat = b_1 - b_2
//
//        let C_1:CGFloat = sqrt(pow(a_1, 2) + pow(b_1, 2))
//        let C_2:CGFloat = sqrt(pow(a_2, 2) + pow(b_2, 2))
//        let deltaC_ab:CGFloat = C_1 - C_2
//
//        let deltaH_ab:CGFloat = sqrt(pow(deltaA, 2) + pow(deltaB, 2) - pow(deltaC_ab, 2))
//
//        let s_L:CGFloat = 1
//        let s_C:CGFloat = 1 + (k_1 * C_1)
//        let s_H:CGFloat = 1 + (k_2 * C_1)
//
//        // Calculate
//
//        let P1:CGFloat = pow(deltaL/(k_L * s_L), 2)
//        let P2:CGFloat = pow(deltaC_ab/(k_C * s_C), 2)
//        let P3:CGFloat = pow(deltaH_ab/(k_H * s_H), 2)
//
//        return sqrt((P1.isNaN ? 0:P1) + (P2.isNaN ? 0:P2) + (P3.isNaN ? 0:P3))
//    }
//
//
//
//    /**
//    Detemine the distance between two colors based on the way humans perceive them.
//    Uses the Sharma 2004 alteration of the CIEDE2000 algorithm.
//
//    - parameter compare color: A UIColor to compare.
//
//    - returns: A CGFloat representing the deltaE
//    */
//    func CIEDE2000(compare color: UIColor) -> CGFloat {
//        // CIEDE2000, Sharma 2004 -> http://www.ece.rochester.edu/~gsharma/ciede2000/ciede2000noteCRNA.pdf
//
//        func rad2deg(r: CGFloat) -> CGFloat {
//            return r * CGFloat(180/Double.pi)
//        }
//
//        func deg2rad(d: CGFloat) -> CGFloat {
//            return d * CGFloat(Double.pi/180)
//        }
//
//        let k_l = CGFloat(1), k_c = CGFloat(1), k_h = CGFloat(1)
//
//        let LAB1 = self.toLabComponents()
//        let L_1 = LAB1.L, a_1 = LAB1.a, b_1 = LAB1.b
//
//        let LAB2 = color.toLabComponents()
//        let L_2 = LAB2.L, a_2 = LAB2.a, b_2 = LAB2.b
//
//        let C_1ab = sqrt(pow(a_1, 2) + pow(b_1, 2))
//        let C_2ab = sqrt(pow(a_2, 2) + pow(b_2, 2))
//        let C_ab  = (C_1ab + C_2ab)/2
//
//        let G = 0.5 * (1 - sqrt(pow(C_ab, 7)/(pow(C_ab, 7) + pow(25, 7))))
//        let a_1_p = (1 + G) * a_1
//        let a_2_p = (1 + G) * a_2
//
//        let C_1_p = sqrt(pow(a_1_p, 2) + pow(b_1, 2))
//        let C_2_p = sqrt(pow(a_2_p, 2) + pow(b_2, 2))
//
//        // Read note 1 (page 23) for clarification on radians to hue degrees
//        let h_1_p = (b_1 == 0 && a_1_p == 0) ? 0 : (atan2(b_1, a_1_p) + CGFloat(2 * Double.pi)) * CGFloat(180/Double.pi)
//        let h_2_p = (b_2 == 0 && a_2_p == 0) ? 0 : (atan2(b_2, a_2_p) + CGFloat(2 * Double.pi)) * CGFloat(180/Double.pi)
//
//        let deltaL_p = L_2 - L_1
//        let deltaC_p = C_2_p - C_1_p
//
//        var h_p: CGFloat = 0
//        if (C_1_p * C_2_p) == 0 {
//            h_p = 0
//        } else if fabs(h_2_p - h_1_p) <= 180 {
//            h_p = h_2_p - h_1_p
//        } else if (h_2_p - h_1_p) > 180 {
//            h_p = h_2_p - h_1_p - 360
//        } else if (h_2_p - h_1_p) < -180 {
//            h_p = h_2_p - h_1_p + 360
//        }
//
//        let deltaH_p = 2 * sqrt(C_1_p * C_2_p) * sin(deg2rad(d: h_p/2))
//
//        let L_p = (L_1 + L_2)/2
//        let C_p = (C_1_p + C_2_p)/2
//
//        var h_p_bar: CGFloat = 0
//        if (h_1_p * h_2_p) == 0 {
//            h_p_bar = h_1_p + h_2_p
//        } else if fabs(h_1_p - h_2_p) <= 180 {
//            h_p_bar = (h_1_p + h_2_p)/2
//        } else if fabs(h_1_p - h_2_p) > 180 && (h_1_p + h_2_p) < 360 {
//            h_p_bar = (h_1_p + h_2_p + 360)/2
//        } else if fabs(h_1_p - h_2_p) > 180 && (h_1_p + h_2_p) >= 360 {
//            h_p_bar = (h_1_p + h_2_p - 360)/2
//        }
//
//        let T1 = cos(deg2rad(d: h_p_bar - 30))
//        let T2 = cos(deg2rad(d: 2 * h_p_bar))
//        let T3 = cos(deg2rad(d: (3 * h_p_bar) + 6))
//        let T4 = cos(deg2rad(d: (4 * h_p_bar) - 63))
//        let T = 1 - rad2deg(r: 0.17 * T1) + rad2deg(r: 0.24 * T2) - rad2deg(r: 0.32 * T3) + rad2deg(r: 0.20 * T4)
//
//        let deltaTheta = 30 * exp(-pow((h_p_bar - 275)/25, 2))
//        let R_c = 2 * sqrt(pow(C_p, 7)/(pow(C_p, 7) + pow(25, 7)))
//        let S_l =  1 + ((0.015 * pow(L_p - 50, 2))/sqrt(20 + pow(L_p - 50, 2)))
//        let S_c = 1 + (0.045 * C_p)
//        let S_h = 1 + (0.015 * C_p * T)
//        let R_t = -sin(deg2rad(d: 2 * deltaTheta)) * R_c
//
//        // Calculate total
//
//        let P1 = deltaL_p/(k_l * S_l)
//        let P2 = deltaC_p/(k_c * S_c)
//        let P3 = deltaH_p/(k_h * S_h)
//        let deltaE = sqrt(pow(P1, 2) + pow(P2, 2) + pow(P3, 2) + (R_t * P2 * P3))
//
//        return deltaE
//    }
//}
