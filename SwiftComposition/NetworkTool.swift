//
//  NetworkTool.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/28.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class NetworkTool: NSObject {
  
    static let shareInstance = NetworkTool()
    
    private  override init() {} //设置 init 方法私有。防止调用init 方法 破坏类的单一性
    
    func  loadNewsData( type:String, _finished:@escaping(_ models:[NewsModel]) -> ()) {
      let urlStr = baseListURL + type
      
      Alamofire.request(urlStr).responseJSON { (response) in
         var models = [NewsModel]()
        SVProgressHUD.show(withStatus: "加载中")
        guard response.result.isSuccess else{
            print("请求出错")
            SVProgressHUD.showError(withStatus: "请求出错")
            return
        }
        
        
        if let value = response.result.value{
            let json = JSON(value)
            let resultDic = json["result"].dictionaryValue
            let resultData = resultDic["data"]?.arrayValue
            for newsData in resultData!{

                let model = NewsModel.init(json: newsData)
                models.append(model)
                
            }
            SVProgressHUD.dismiss()
            _finished(models)
        }
        
        }
    }
    
}
