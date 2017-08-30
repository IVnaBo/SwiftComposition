//
//  NewsViewCell.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/29.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

protocol NewsViewCellDelegate {
    
    /// 单元格中图片点击事件
    ///
    /// - Parameters:
    ///   - index: 点击的图片索引
    ///   - imgArr: 图片数组,传递的是urlStr
    func NewsViewCellImgClick(index:Int,imgArr:[String])
}
class NewsViewCell: UITableViewCell {
    
    var contentLab:UILabel?
    var middleView:UIView?
    var dateLab:UILabel?
    var author_nameLab:UILabel?
    ///代理设置属性
    var delegate:NewsViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
//        self.contentView.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创建UI界面
    func setupUI()  {
        
        contentLab = UILabel.init()
        contentLab?.font = UIFont.systemFont(ofSize: 15.0)
        contentLab?.numberOfLines = 3
       
        self.contentView.addSubview(contentLab!)
        
        middleView = UIView.init()
        middleView?.backgroundColor = UIColor.white
        self.contentView.addSubview(middleView!)
        
        dateLab  = UILabel.init()
        dateLab?.font = UIFont.systemFont(ofSize: 15.0)
        dateLab?.textColor = UIColor.init(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0)
        self.contentView.addSubview(dateLab!)
        
        
       author_nameLab = UILabel.init()
       author_nameLab?.textColor = UIColor.init(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0)
       author_nameLab?.font = UIFont.systemFont(ofSize: 15.0)
       self.contentView.addSubview(author_nameLab!)
        //makeConstraints
        
       contentLab?.snp.makeConstraints({ (make) in
        // 右 +  左 - 上 - 下 +
          make.left.equalTo(self.contentView).offset(10)
          make.right.equalTo(self.contentView).offset(-10)
          make.top.equalTo(self.contentView)
          make.height.equalTo(30)
       })
        middleView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo((contentLab?.snp.bottom)!).offset(5)
            //20
            make.height.equalTo(20)
        })
        
        author_nameLab?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.width.equalTo(125)
            make.top.equalTo((middleView?.snp.bottom)!)
            make.height.equalTo(25)
        })
        
        dateLab?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView).offset(-5)
            make.width.equalTo(100)
            make.top.equalTo(author_nameLab!)
            make.height.equalTo(25)
        })
    }
   
    var newsModel:NewsModel?{
//        set方法 赋值
        didSet{
           contentLab?.text = newsModel?.title
           author_nameLab?.text = newsModel?.author_name
           dateLab?.text = newsModel?.date
           let text_H = Tool.shareInstance.getTextHeigh(textStr: (newsModel?.title)!, font: UIFont.systemFont(ofSize: 15.0), width: iPhone_W - 20)
            //更新约束
          contentLab?.snp.remakeConstraints({ (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView)
            make.height.equalTo(text_H)
          })
          // 3 6 9 图片
            if (newsModel?.imgArr?.count)! > 0 {//如果图片存在 ，添加图片视图
//                make.height.equalTo((iPhone_W - kMargin * 2 - 12) / 3 * 3)
                //图片宽高比 4  :  3
                for index in 0 ..< newsModel!.imgArr!.count{
                    
                    let imgV = UIImageView.init()
                    
                    switch newsModel!.imgArr!.count {
                    case 1: imgV.frame = CGRect.init(x: 0, y: 0, width: img1Width, height: img1Height)
                    case 2: imgV.frame = CGRect.init(x: (img2Width + imgSpace) * CGFloat(index) + imgSpace, y: 0, width: img2Width, height: img2Height)
                    default:imgV.frame = CGRect.init(x: (imgSpace + imgWidth) * CGFloat((index) % 3) + imgSpace, y: (imgSpace + imgWidth) *  CGFloat( index / 3), width: imgWidth, height: imgWidth * 4 / 3 )
    
                    }
                    imgV.kf.setImage(with: URL.init(string: (newsModel?.imgArr?[index])!))
                    imgV.tag = 10 + index
                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(imgTapAction))
                    //打开用户交互
                    imgV.isUserInteractionEnabled = true
                    imgV.addGestureRecognizer(tap)
                    
                    self.middleView? .addSubview(imgV)
            }
                if (newsModel?.imgArr?.count)! > 0 {
                    
                    if newsModel?.imgArr?.count == 1 {
                        middleView?.snp.remakeConstraints({ (make) in
                            make.left.equalTo(self.contentView).offset(10)
                            make.right.equalTo(self.contentView).offset(-10)
                            make.top.equalTo((contentLab?.snp.bottom)!).offset(5)
                            //
                            make.height.equalTo(img1Height)
                        })
                    }else if(newsModel?.imgArr?.count == 2 ){
                        middleView?.snp.remakeConstraints({ (make) in
                            make.left.equalTo(self.contentView).offset(10)
                            make.right.equalTo(self.contentView).offset(-10)
                            make.top.equalTo((contentLab?.snp.bottom)!).offset(5)
                            //
                            make.height.equalTo(img2Height)
                        })
                    }else{
                        middleView?.snp.remakeConstraints({ (make) in
                            make.left.equalTo(self.contentView).offset(10)
                            make.right.equalTo(self.contentView).offset(-10)
                            make.top.equalTo((contentLab?.snp.bottom)!).offset(5)
                            //
                            make.height.equalTo((imgSpace + imgWidth * 4 / 3) * CGFloat(((newsModel?.imgArr?.count)! / 4  + 1)))
                        })
                    }
                }
                
           self.contentView.layoutIfNeeded()
        }
    }
  }
    
    func imgTapAction(tap:UITapGestureRecognizer) {
        let  index = (tap.view?.tag)!  - 10 //获取当前点击的图片索引....
        ///调用代理方法
        self.delegate?.NewsViewCellImgClick(index: index, imgArr: (newsModel?.imgArr)!)
        
    }
    
////    MARK: 懒加载 图片九宫格
//    private lazy var imgCollectionView:UICollectionView = {
//        
//        let flowLayout = UICollectionViewFlowLayout.init()
//    
//        var collectionV = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
//        collectionV.delegate = self
//        collectionV.dataSource  = self
//        collectionV.backgroundColor = UIColor.clear
//        let reuseID = "IMG"
//        ///注册单元格
//        collectionV.register(NewsImgvCell.classForCoder(), forCellWithReuseIdentifier: reuseID)
//        return collectionV
//    }()

}

//extension NewsViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return (self.newsModel?.imgArr?.count)!
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let reuseID = "IMG"
//        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as? NewsImgvCell
//        
//       
//        cell?.newsImgv?.kf.setImage(with: URL.init(string: (self.newsModel?.imgArr?[indexPath.row])!))
//        
//        
//
//        return cell!
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        
//        let imageH = (iPhone_W - kMargin * 2 - 12) / 3
//        let collectionW = (iPhone_W - 20)
//    
//        
//        
//        if (self.newsModel?.imgArr?.count)! > 0 {
//            switch self.newsModel!.imgArr!.count {
//            case 1:return CGSize.init(width: iPhone_W * 0.7, height: imageH)
//            case 2:return CGSize.init(width: collectionW / 2, height: imageH)
//            default:return CGSize.init(width: collectionW / 3, height: collectionW / 3)
//            
//        }
//    }
//        return CGSize.zero
//    
//    }
//    
//    
//}
