//
//  TestModel.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/31.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit

class TestModel: NSObject {
    var dataArr:[String]?
    var imgV_H:CGFloat?
    var cell_H:CGFloat?
    init(data:[String]) {
        self.dataArr = [String]()
        
        self.dataArr = data
        
        
        if (self.dataArr?.count)! > 0 {
            switch dataArr!.count {
            case 1: imgV_H = img1Height
            case 2: imgV_H = img2Height
                //7 8 9
            case 7: imgV_H = (imgSpace + imgWidth * 4 / 3) * CGFloat(((self.dataArr?.count)! / 4  + 2))
            default:imgV_H = (imgSpace + imgWidth * 4 / 3) * CGFloat(((self.dataArr?.count)! / 4  + 1))
                
            }
            
        }
        cell_H = 25  + imgV_H! + 10 + 5

    }
}
