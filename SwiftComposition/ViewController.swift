//
//  ViewController.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/28.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIScrollViewDelegate{
   
    var titleScrollV:UIScrollView?
    var contentScrollV:UIScrollView?
    var tempBtn:UIButton?  ///中转按钮
    var BtnArr:[UIButton]?
    var contentFileArr:[[String:String]]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "新闻"
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        let path = Bundle.main.path(forResource: "TitleList", ofType: "plist")
        
        contentFileArr = NSArray.init(contentsOf: URL.init(fileURLWithPath: path!)) as? [[String : String]]
       
    
        setupContentScrollV()
        setupTitleScrollView()
        addChildVc(count: (contentFileArr?.count)!)
        setupTitleBtn()
        
        
        
        // Do any additional setup after loading the view.
    }
  
    func setupTitleScrollView() {
        let y = (self.navigationController != nil) ? navBarH : 0
        let titleRect = CGRect.init(x: 0, y: y, width: iPhone_W, height: titleH)
        
        titleScrollV = UIScrollView.init(frame: titleRect)
        titleScrollV?.backgroundColor = UIColor.white
        titleScrollV?.showsVerticalScrollIndicator = false
        titleScrollV?.showsHorizontalScrollIndicator = false
        self.view.addSubview(titleScrollV!)
        
    }
    
    func setupContentScrollV()  {
        let y = (self.navigationController != nil) ? navBarH : 0
        
        let content_Y = y + titleH
        
        let rect = CGRect.init(x: 0, y: content_Y, width: iPhone_W, height: iPhone_H - navBarH)
        
        contentScrollV = UIScrollView.init(frame: rect)
        contentScrollV?.isPagingEnabled = true // 整页效果
        contentScrollV?.showsVerticalScrollIndicator = false
        contentScrollV?.showsHorizontalScrollIndicator = false
        contentScrollV?.delegate = self
        ///内容区域大小
        contentScrollV?.contentSize = CGSize.init(width: CGFloat((contentFileArr?.count)!) * iPhone_W, height: 0)
        
        self.view.addSubview(contentScrollV!)
        
    }
    
    /// 添加子控制器
    ///
    /// - Parameter count: 子控制器的个数
    func addChildVc(count:Int)  {

        
        let topVc = TopViewController()
        let shehuiVc = ShehuiViewController()
        let guoneiVc = GuoneiViewController()
        let guojiVc =  GuojiViewController()
        let yuleVc = YuleViewController()
        let tiyuVc = TiyuViewController()
        let junshiVc = JunshiViewController()
        let kejiVc = KejiViewController()
        let caijingVc = CaijingViewController()
        let shishangVc = ShishangViewController()
        
        self.addChildViewController(topVc)
        self.addChildViewController(shehuiVc)
        self.addChildViewController(guoneiVc)
        self.addChildViewController(guojiVc)
        self.addChildViewController(yuleVc)
        self.addChildViewController(tiyuVc)
        self.addChildViewController(junshiVc)
        self.addChildViewController(kejiVc)
        self.addChildViewController(caijingVc)
        self.addChildViewController(shishangVc)
        
    }
    
    /// 添加滚动视图的按钮
    func setupTitleBtn()  {
        ///子视图控制器的个数
        let count  = self.childViewControllers.count
        var x = 0
        let w = 75
        let h = titleH
        ///标题栏的内容大小
        titleScrollV?.contentSize = CGSize.init(width: CGFloat(count * w), height: 0)
        BtnArr = [UIButton]()
        for i in 0 ..< count{
            let btn = UIButton.init(type: .custom)
            x = i * w
            btn.frame = CGRect.init(x: CGFloat(x), y: 0, width: CGFloat(w), height: h)
            btn.setTitle(contentFileArr?[i]["CN"], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            btn.tag = 10 + i
            //添加到数组对象中
            BtnArr?.append(btn)
            //添加到标题视图上
            self.titleScrollV?.addSubview(btn)
            
            if i == 0 {///第一个
                ///默认选中
                btnClick(sender: btn)
            }
            
        }
        
        
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter sender: btn
    func btnClick(sender:UIButton)  {
        
        tempBtn?.setTitleColor(UIColor.black, for: .normal)
        ///恢复原状
        tempBtn?.transform = CGAffineTransform.identity
        sender.setTitleColor(UIColor.red, for: .normal)
        ///放大效果
        sender.transform = CGAffineTransform(scaleX: maxScale,y: maxScale)
        tempBtn = sender
        self.addchildView(index: sender.tag - 10)
        
        let  scroll_W = CGFloat((sender.tag - 10)) * iPhone_W
        ///设置内容区域滚动
        self.contentScrollV?.setContentOffset(CGPoint.init(x: scroll_W, y: 0), animated: true)
        
        titleScrollvScroll(btn: sender)
        
    }
    
    /// 标题视图跟着滚动
    ///
    /// - Parameter btn: 当前点击的按钮
    func titleScrollvScroll(btn:UIButton) {
       
        var offset = btn.center.x - iPhone_W * 0.5
        if offset < 0 {
            offset = 0
        }
        let maxoffset = (self.titleScrollV?.contentSize.width)! - iPhone_W
        if offset > maxoffset {
            offset = maxoffset
        }
        self.titleScrollV?.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
    }
    
    /// 添加子视图到内容视图上
    ///
    /// - Parameter index:  指定的索引
    func addchildView(index:Int){
        
        let x = CGFloat(index) * iPhone_W
        
        let vc = self.childViewControllers[index]
        
        if vc.view.superview != nil{//说明已经加载到视图上了 不必重复添加
            return
        }
        
        vc.view.frame = CGRect.init(x: x, y: 0, width: iPhone_W, height: (contentScrollV?.frame.size.height)!)
        
        self.contentScrollV?.addSubview(vc.view)
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    //滚动视图停止拖拽
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / iPhone_W
        
        let btn = self.BtnArr?[Int(index)]
        btnClick(sender: btn!)
        addchildView(index: Int(index))
        
    }
    
}
