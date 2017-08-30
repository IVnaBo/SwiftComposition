//
//  NewsModel.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/28.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit
import SwiftyJSON
class NewsModel: NSObject {

    
    
    var title:String?
    var date :String?
    var category:String?
    var author_name:String?
    var url:String?
    var thumbnail_pic_s:String?
    var thumbnail_pic_s02:String?
    var thumbnail_pic_s03:String?
    var imgArr:[String]?
    var cell_H:CGFloat?
    var imgV_H:CGFloat?
    var newsDate:Date?
    
    init(json:JSON){
        imgArr = [String]()
        title = json["title"].stringValue
//        date  = json["date"].stringValue
        category = json["category"].stringValue
        author_name = json["author_name"].stringValue
        url  = json["url"].stringValue
        thumbnail_pic_s = json["thumbnail_pic_s"].stringValue
        thumbnail_pic_s02 = json["thumbnail_pic_s02"].stringValue
        thumbnail_pic_s03 = json["thumbnail_pic_s03"].stringValue
        
        if !(thumbnail_pic_s?.isEmpty)! {
            imgArr?.append(thumbnail_pic_s!)
        }

        if !(thumbnail_pic_s02?.isEmpty)!  {

            imgArr?.append(thumbnail_pic_s02!)
        }
        if !(thumbnail_pic_s03?.isEmpty)!  {
            imgArr?.append(thumbnail_pic_s03!)
        }
        //
         let dateFormater = DateFormatter.init()
         dateFormater.dateFormat = "YYYY-MM-dd mm:ss"
         newsDate = dateFormater.date(from: json["date"].stringValue)

         date  = newsDate?.timePassed()
        
        
        let tool = Tool()
        ///根据文本内容获取文本高度
        let textH = tool.getTextHeigh(textStr: title!, font: UIFont.systemFont(ofSize: 15), width: iPhone_W - 20)
        
        if (imgArr?.count)! > 0 {
            switch imgArr!.count {
            case 1: imgV_H = img1Height
            case 2: imgV_H = img2Height
            default:imgV_H = (imgSpace + imgWidth * 4 / 3) * CGFloat(((imgArr?.count)! / 4  + 1))
                
            }
           
        }
        cell_H = 25 + textH + imgV_H! + 10 + 5

        
    }
    
    
}
