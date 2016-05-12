//
//  DetailViewController.swift
//  iMessage详细信息
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详细信息"
        //tableview的初始化
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        tableView?.delegate=self
        tableView?.dataSource=self
        self.view.addSubview(tableView!)
    }
    
    
    //设置分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    //第二个分区是2行，其他分区是1行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==1 {
            return 2
        }else{
            return 1
        }
    }
    //分区内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
            cell.imageView?.image = UIImage(named: "image")
            cell.textLabel?.text = "123456789"
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            return cell
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: "")
                cell.textLabel?.text = "发送我当前的位置"
                return cell
            }else{
                let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: "")
                cell.textLabel?.text = "共享我的位置"
                return cell
            }
        }else{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
            cell.textLabel?.text = "勿扰模式"
            cell.accessoryView = UISwitch()
            return cell
        }
    }
    //设置高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section==2 {
            return 40
        }else{
            return 20
        }
    }
    //设置第三个分区的尾视图
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2{
            let label = UILabel(frame: CGRectMake(20,0,self.view.frame.size.width-20,40))
            label.textColor = UIColor.grayColor()
            label.backgroundColor = UIColor.clearColor()
            label.text = "将此对话的通知设置为静音"
            label.font = UIFont.systemFontOfSize(13)
            return label
        }
        return nil
    }
    
    
    //设置头视图
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        }else{
            return 0
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            let label = UILabel(frame: CGRectMake(20,0,self.view.frame.size.width-20,40))
            label.textColor = UIColor.grayColor()
            label.backgroundColor = UIColor.clearColor()
            label.text = "位置"
            label.font = UIFont.systemFontOfSize(13)
            return label
        }
        return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
