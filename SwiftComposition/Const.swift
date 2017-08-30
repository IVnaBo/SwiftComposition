//
//  Const.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/28.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit

let iPhone_W:CGFloat = UIScreen.main.bounds.size.width

let iPhone_H:CGFloat = UIScreen.main.bounds.size.height

let titleH:CGFloat  = 44

let navBarH:CGFloat = 64

let maxScale:CGFloat = 1.2

let kMargin:CGFloat = 10
// 宽 : 高 = 4 : 3 则 高 = 3宽 ／4
let imgRadio:CGFloat = 3 / 4
//设置图片间隔
let imgSpace:CGFloat = 10

//设置 3 - 9 张图片 时宽度
let imgWidth:CGFloat = (iPhone_W - 20 - 40)/3

let img1Width:CGFloat = iPhone_W - 20
let img1Height:CGFloat = img1Width * imgRadio

let img2Width:CGFloat = (iPhone_W - 20 - 30)/2
let img2Height:CGFloat = img2Width * imgRadio





let baseListURL = "http://v.juhe.cn/toutiao/index?key=d8edd44350a7dcf5f54ce7fdbd7699b3&type="
