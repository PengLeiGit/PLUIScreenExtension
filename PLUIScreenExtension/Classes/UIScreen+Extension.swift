//
//  UIScreen+Extension.swift
//  PLUIScreenExtension
//
//  Created by 彭磊 on 2020/7/13.
//

import UIKit

public extension UIScreen {
    enum Device {
        case unknown
        case iPhone4
        case iPhone5
        case iPhoneX
        case iPhoneXr
        case iPhoneXSMax
    }
    
    static var mainSize: CGSize {
        if UIScreen.main.bounds.size.height <  UIScreen.main.bounds.size.width {
            return CGSize(width: UIScreen.main.bounds.size.height, height: UIScreen.main.bounds.size.width)
        }
        return UIScreen.main.bounds.size
    }
    
    static var screenSize: CGSize {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return CGSize(width: UIScreen.mainSize.height, height: UIScreen.mainSize.width)
        }
        return UIScreen.mainSize
    }
    
    /// 判断是否是 iPhone Xx 系列
    static var isXSeries: Bool {
        var iPhoneXSer = false
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return iPhoneXSer
        }
        
        let mainWindow = UIApplication.shared.delegate?.window
        guard let window = mainWindow else {
            return iPhoneXSer
        }
        if #available(iOS 11.0, *) {
            if window!.safeAreaInsets.bottom > CGFloat(0.0) {
                iPhoneXSer = true
            }
        }
        return iPhoneXSer
    }
    
    /// 是否是plus系列
    static var isPlusSeries: Bool {
        return CGSize(width: 414, height: 736) == UIScreen.mainSize
    }
    
    /// 6 7 8 系列
    static var isNormalSeries: Bool {
        return CGSize(width: 375, height: 667) == UIScreen.mainSize
    }
    
    static var navBarHeight: CGFloat {
        return isXSeries ? 88.0 : 64.0
    }
    
    /// 字体缩放比
    static var fontScale: CGFloat {
        return CGFloat.maximum(widthScale, 1)
    }
    
    /// 屏幕宽度缩放比
    static var widthScale: CGFloat {
        return UIScreen.mainSize.width / 375
    }
    
    /// 屏幕高度缩放比
    static var heightScale: CGFloat {
        return UIScreen.mainSize.height / 667
    }
    
    /// 6, 7, 8屏幕高度缩放比
    static var heightScale2X: CGFloat {
        return UIScreen.mainSize.height / 1334
    }
    
    /// 设备类型
    static var device: Device {
        if CGSize(width: 320, height: 480) == UIScreen.mainSize {
            return .iPhone4
        }
        if CGSize(width: 320, height: 568) == UIScreen.mainSize {
            return .iPhone5
        }
        if CGSize(width: 375, height: 812) == UIScreen.mainSize {
            return .iPhoneX
        }
        if CGSize(width: 414, height: 896) == UIScreen.mainSize && UIScreen.main.scale == 2 {
            return .iPhoneXr
        }
        if CGSize(width: 414, height: 896) == UIScreen.mainSize && UIScreen.main.scale == 3 {
            return .iPhoneXSMax
        }
        return .unknown
    }
    
    /// UI适配
    static func adaptor<T>(with value: T, plusValue: T) -> T {
        if UIScreen.main.bounds.size.width > 375 {
            return plusValue
        }
        return value
    }
    
    ///  UI适配
    static func adaptor<T>(with value: T, xValue: T) -> T {
        if isXSeries {
            return xValue
        }
        return value
    }
}
