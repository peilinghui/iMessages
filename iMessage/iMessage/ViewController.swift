//
//  ViewController.swift
//  iMessage
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    //定义tableview
    let tableView:UITableView = UITableView(frame:CGRectMake(0, 30, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.height-64-30) , style: UITableViewStyle.Plain)
    //添加搜索框
    let searchBar = UISearchBar(frame: CGRectMake(0,64,UIScreen.mainScreen().bounds.size.width,30))
    
    //设置背景视图，
    let bgView = UIView(frame: CGRectMake(0,64,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height-64))
    //name，date,content的数组。
    var nameArray:Array<String>?
    var dateArray:Array<String>?
    var contentArray:Array<String>?
    var isEdit:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "信息"
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.creatData();
        tableView.reloadData()
        
        //设置背景视图的颜色
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.view.addSubview(bgView)
        bgView.hidden = true
        
        
        //设置搜索栏的风格和代理。
        searchBar.searchBarStyle = UISearchBarStyle.Default
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        //设置导航左侧
        let itemL = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: Selector("allEdit"))
        self.navigationItem.leftBarButtonItem = itemL
        
        //设置导航右侧
        let itemR = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("newMessage"))
        self.navigationItem.rightBarButtonItem = itemR
        
    }
    
    //点击导航左侧edit,切换编辑模式
    func allEdit(){
        if isEdit {
            tableView.editing = false
            isEdit = false
        }else{
            tableView.editing = true
            isEdit = true
        }
    }
    
    //点击导航右侧edit,切换编辑模式
    func newMessage(){
        let newMessageController = NSBundle.mainBundle().loadNibNamed("NewMessageViewController", owner: nil, options: nil).first as! NewMessageViewController
        self.navigationController?.pushViewController(newMessageController, animated: true)
    }
    
    //searchBar代理方法-搜索框进入编辑状态
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        bgView.hidden = false
        return true
    }
    
    //搜索框结束编辑状态
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        bgView.hidden = true
        return true
    }
    //让键盘收起来，取消第一响应
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    //tableview是否允许编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    //tableview提交编辑
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            dateArray?.removeAtIndex(indexPath.row)
            //删除动画，从左侧划出
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
    }
    //设置删除按钮的标题
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    //创建cell的数据，
    func creatData(){
        nameArray = Array()
        nameArray?.append("张三")
        nameArray?.append("李四")
        nameArray?.append("王五")
        
        dateArray = Array()
        dateArray?.append("2015/11/24")
        dateArray?.append("2016/1/1")
        dateArray?.append("2016/2/14")
        
        contentArray = Array()
        contentArray?.append("你好，明天可以一起吃个饭么？之后在一起看个电影怎么样？")
        contentArray?.append("你好，明天可以一起吃个饭么？之后在一起看个电影怎么样？")
        contentArray?.append("你好，明天可以一起吃个饭么？之后在一起看个电影怎么样？")
    }
    
    //实现numberOfRowsInSection
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray!.count
    }
    //实现cellForRowAtIndexPath
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MessageRootTableViewCell? = tableView.dequeueReusableCellWithIdentifier("MessageRootTableViewCell") as? MessageRootTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("MessageRootTableViewCell", owner: nil, options: nil).last as? MessageRootTableViewCell
        }
        cell?.titleTestLabel.text = nameArray?[indexPath.row]
        cell?.dateLabel.text = dateArray?[indexPath.row]
        cell?.contentLabel.text = contentArray?[indexPath.row]
        return cell!
    }
    //实现heightForRowAtIndexPath
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 111.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

