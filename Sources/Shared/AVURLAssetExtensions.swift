//
//  AVURLAssetExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/16/17.
//
//

import Foundation
import AVFoundation
import DinoDNA

extension AVURLAsset{
    public func thumbnailImage() -> UIImage?{
        do{
            let imgGenerator = AVAssetImageGenerator(asset: self)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        }
        catch{
            debugLog("Error: \(error.localizedDescription)")
        }
        return nil
    }

    public static func thumbnailImageForVideo(at url: URL) -> UIImage?{
        let asset = AVURLAsset(url: url)
        return asset.thumbnailImage()
    }

    public static func resolutionSizeForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))

    }
}

extension URL{
    public func videoThumbnailImageAsync(imageResult: @escaping ParameterizedClosure<UIImage>, errorClosure: ErrorClosure?){
            let asset = AVAsset(url: self)
            let durationSeconds = CMTimeGetSeconds(asset.duration)
            let generator = AVAssetImageGenerator(asset: asset)
            
            generator.appliesPreferredTrackTransform = true
            
            let time = CMTimeMakeWithSeconds(durationSeconds/3.0, preferredTimescale: 600)            
            generator.generateCGImagesAsynchronously(forTimes: [NSValue.init(time: time)]) { (reqTime, image, actualTime, generatorResult, error) in
                guard let image = image else{
                    errorClosure?(error ?? BasicError(.unknown, "Unable to fetch image."))
                    return
                }
                imageResult(UIImage(cgImage: image))
        }
        
    }
}
