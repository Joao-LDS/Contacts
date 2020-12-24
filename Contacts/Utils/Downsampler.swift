//
//  Downsampler.swift
//  Contacts
//
//  Created by João Luis Santos on 22/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

// Código compartilhado por Shubham Singh - github Shubham0812

class Downsampler {
    
    func downsampleImage(from url: URL, frameSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions) else { return nil }
        return downsample(imageSource: imageSource, frameSize: frameSize)
    }
    
    func downsampleImage(from data: Data, frameSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else { return nil }
        return downsample(imageSource: imageSource, frameSize: frameSize)
    }
    
    private func downsample(imageSource: CGImageSource, frameSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(frameSize.width, frameSize.height) * scale
        ] as CFDictionary
        
        guard let downsampleImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
        
        return UIImage(cgImage: downsampleImage)
    }
}
