//
//  BaseViewController.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/28.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController,NewsViewCellDelegate {
    var newsModel:[NewsModel]?
    var newsType:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        ///初始化数组
        newsModel = [NewsModel]()
        print("标志符为" + newsType!)
        
        setupUI()
        
        
        setData()
       

        // Do any additional setup after loading the view.
    }
    
    
    /// 设置内置的TableView 属性
    func setupUI() {
        
        self.tableView.separatorStyle = .none
        self.tableView.register(NewsViewCell.classForCoder(), forCellReuseIdentifier: newsType!)
        
        
    }
    /// 请求数据
    func setData()  {
        NetworkTool.shareInstance.loadNewsData(type: newsType!) { (models) in
            
            self.newsModel = models
            
            self.tableView.reloadData()
        }
    }
//    MARK: - tableViewdel/ dat
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.newsModel?.count)!
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: newsType!, for: indexPath) as! NewsViewCell
        cell.selectionStyle = .none
        while cell.middleView?.subviews.last != nil {//删除重用的cell的所有子视图
            cell.middleView?.subviews.last?.removeFromSuperview()
        }
        cell.delegate = self
        cell.newsModel = self.newsModel?[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.newsModel?[indexPath.row]
        return (model?.cell_H!)!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = DetailVc()
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: cellImgDelegate
    func NewsViewCellImgClick(index:Int,imgArr:[String]){
        print(imgArr)
        let imgPreviewVc = ImagePreviewVC.init(images: imgArr, index: index)
        self.navigationController?.pushViewController(imgPreviewVc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
