//
//  NewMessageViewController.swift
//  iMessage
//
//  Created by apple on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
//导入联系人页面
import AddressBookUI
//设置代理
class NewMessageViewController: UIViewController,UITextViewDelegate,ABPeoplePickerNavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {

    //控件的相关代理方法
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var ourTextField: UITextView!
    //尺寸改变
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    //设置变量数组存放数据模型---数据源
    var dataArray:Array<MessageModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新建信息"
        self.view.backgroundColor = UIColor.whiteColor()
        //通知事件监听方法实现，当键盘弹起时
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        ////通知事件监听方法实现，当键盘收起时
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillUnShow:"), name: UIKeyboardWillHideNotification, object: nil)
        ourTextField.delegate = self
        //数组初始化
        dataArray = Array()
        //详细信息的按钮
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self, action: Selector("detail"))
        self.navigationItem.rightBarButtonItem = item
       
    }
     //详细信息
    func detail(){
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    //将要弹起键盘时触发的监听方法
    func keyboardWillShow(noti:NSNotification){
        let info = noti.userInfo!
        let heightValue = info[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let height = heightValue.CGRectValue().height
        var time:NSTimeInterval = 0
        let timeValue = info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
        timeValue.getValue(&time)
        textViewBottom.constant = height
        //动画效果
        UIView.animateWithDuration(time) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    //键盘将要消失的时候时触发的监听方法
    func keyboardWillUnShow(noti:NSNotification){
        let info = noti.userInfo!
        var time:NSTimeInterval = 0
        let timeValue = info[UIKeyboardAnimationDurationUserInfoKey] as! NSValue
        timeValue.getValue(&time)
        textViewBottom.constant = 0
        UIView.animateWithDuration(time) { () -> Void in
            self.view.layoutIfNeeded()
        }

    }
    
    //当TextView改变的时候
    func textViewDidChange(textView: UITextView) {
        if ourTextField.contentSize.height <= 37 {
            textFieldHeight.constant = 37
            textViewHeight.constant = 53
        }else if ourTextField.contentSize.height<100 {
            //使得它内容高度自适应
            textFieldHeight.constant = ourTextField.contentSize.height
            textViewHeight.constant = ourTextField.contentSize.height+16
        }else{
            //如果高度超过100设为常数，使它
            textFieldHeight.constant = 100
            textViewHeight.constant = 116
        }
        
        //设置动画，使它平滑
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    //触摸进行收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        ourTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //添加图片
    @IBAction func addImage(sender: UIButton) {
        let imageController = UIImagePickerController()
        //设置代理协议
        imageController.delegate = self
        self.presentViewController(imageController, animated: true, completion: nil)
    
        
    }
    //添加联系人
    @IBAction func addContact(sender: UIButton) {
        let contactController = ABPeoplePickerNavigationController()
        contactController.peoplePickerDelegate = self
        self.presentViewController(contactController, animated: true, completion: nil)
    }
    
    
    
    //实现图片的控制器
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let model:MessageModel = MessageModel()
        model.contentImage = image
        dataArray?.append(model)
        //插入tableview，动画
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: dataArray!.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    //把联系人的信息传入textfield框
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        //取联系人电话
        let unmInfo = ABRecordCopyValue(person, kABPersonPhoneProperty)
        //
        let numRef:ABMultiValueRef = Unmanaged.fromOpaque(unmInfo.toOpaque()).takeUnretainedValue()
        //获取联系人电话转化为swift的对象
        let num = ABMultiValueCopyValueAtIndex(numRef, 1)
        let numStr = Unmanaged.fromOpaque(num.toOpaque()).takeUnretainedValue() as! AnyObject as! String
        //把数组添加到textfield框
        contactTextField.text = numStr
    }
    
    //设置tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataArray!.count
    }
    //设置tableview的cellForRowAtIndexPath
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //tableview的子cell
        var cell:SubTableViewCell? = tableView.dequeueReusableCellWithIdentifier("subCellId") as? SubTableViewCell
        //如果cell不存在，则创建一个
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("SubTableViewCell", owner: nil, options: nil).last as? SubTableViewCell
        }
        //从数组中取相应的数据模型
        let model = dataArray![indexPath.row]
        //如果模型是图片模型
        if model.contentText == nil {
            cell?.contentLabel.hidden = true
            cell?.contentImageView.hidden = false
            cell?.contentImageView.image = model.contentImage
        }else{
            //如果模型是文字模型
            cell?.contentLabel.hidden = false
            cell?.contentImageView.hidden = true
            cell?.contentLabel.text = model.contentText
        }
        return cell!
    }
    //设置tableview的heightForRowAtIndexPath，用于设置每一行的高度，通过数据模型来设置
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //先取Model，看是否是文字Model，
        let model:MessageModel = dataArray![indexPath.row]
        if model.contentText == nil {
            //不是文字模型
            return 150.0
        }else{
            //是文字模型
            var size:CGSize
            let sizeTmp = CGSize(width: UIScreen.mainScreen().bounds.size.width-29, height: 0)
            
            size = (model.contentText! as NSString).boundingRectWithSize(sizeTmp, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil).size
            return size.height+29
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ourTextField.resignFirstResponder()
    }
    @IBAction func sent(sender: UIButton) {
        if ourTextField.text.characters.count == 0 {
            return
        }else{
            let model:MessageModel = MessageModel()
            model.contentText = ourTextField.text
            ourTextField.text = ""
            dataArray?.append(model)
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: dataArray!.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        }
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
