//
//  Tool.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/29.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit

class Tool: NSObject {
   
     static let shareInstance = Tool()
//     private override init() {}
     
       func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText: NSString = textStr as NSString
        let size = CGSize.init(width: width, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.height
    }
}
