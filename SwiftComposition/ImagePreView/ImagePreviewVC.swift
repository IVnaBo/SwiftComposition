//
//  ImagePreviewVC.swift
//  hangge_1513
//
//  Created by hangge on 2017/1/11.
//  Copyright © 2017年 hangge.com. All rights reserved.
//

import UIKit
import Kingfisher
//图片浏览控制器
class ImagePreviewVC: UIViewController {
    
    //存储图片数组
    var images:[String]
    
    //默认显示的图片索引
    var index:Int
    
    //用来放置各个图片单元
    var collectionView:UICollectionView!
    
    //页控制器（小圆点）
    var pageControl : UIPageControl!
    ///默认是本地
    var netImg:Bool = false
    
    //初始化
    init(images:[String], index:Int = 0){
        self.images = images
        if self.images.count > 0 {
           
            netImg = self.images[0].isURL()
            
        }
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景设为黑色
        self.view.backgroundColor = UIColor.black
        
        //collectionView尺寸样式设置
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.view.bounds.size
        //横向滚动
        layout.scrollDirection = .horizontal
        //不自动调整内边距，确保全屏
        self.automaticallyAdjustsScrollViewInsets = false
        
        //collectionView初始化
        collectionView = UICollectionView(frame: self.view.bounds,
                                          collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        self.view.addSubview(collectionView)
        
        //将视图滚动到默认图片上
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        //设置页控制器
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 20)
        pageControl.numberOfPages = images.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
        view.addSubview(self.pageControl)
    }
    
    
    //视图显示时
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
 
    //视图消失时
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//ImagePreviewVC的CollectionView相关协议方法实现
extension ImagePreviewVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    //collectionView单元格创建
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                            for: indexPath) as! ImagePreviewCell
            if netImg{//需要加载网络数据获取图片
                
                let placeHoder = UIImage.init(named: "socute")
                cell.imageView.kf.setImage(with: URL.init(string: self.images[indexPath.row]), placeholder: placeHoder, options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                
                let image = UIImage(named: self.images[indexPath.row])
                cell.imageView.image = image
            }
            
        
        return cell
    }
    
    //collectionView单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    //collectionView将要显示
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImagePreviewCell{
            //由于单元格是复用的，所以要重置内部元素尺寸
            cell.resetSize()
            //设置页控制器当前页
            self.pageControl.currentPage = indexPath.item
        }
    }
}


extension String{
    
    public func isEmail() -> Bool {
        let emailRegEx: String = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return regExPredicate.evaluate(with: self.lowercased())
    }
    
    public func isURL() -> Bool{
        let urlRegEx:String = "[a-zA-z]+://.*"
        let regExPredicate: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", urlRegEx)
        
        return regExPredicate.evaluate(with:self.lowercased())
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
