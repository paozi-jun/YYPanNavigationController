//
//  YYViewUtil.swift
//  mocha_swift
//
//  Created by 向文品 on 14-6-25.
//  Copyright (c) 2014年 向文品. All rights reserved.
//

import UIKit

class YYViewUtil: NSObject {
    
    class func imageWithColor(color:UIColor)->UIImage {
        var rect:CGRect = CGRectMake(0.0,0.0,1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
    
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
    
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return image
    }
}
