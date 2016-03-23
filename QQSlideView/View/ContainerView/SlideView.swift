//
//  SideView.swift
//  QQSliderView
//
//  Created by chenjunpu on 16/3/8.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

protocol SlideTableViewDelegate: NSObjectProtocol{
    
    func didSelectItem(title: String)
    func didSelectHeadBtn(title: String)
}

private let JCCellID = "CellID"

class SlideView: UIView {

    //MARK: - propertise
    weak var delegate: SlideTableViewDelegate?
    
    lazy private var arrayDatas: [String] = {
        let array = ["我的商城", "QQ钱包", "个性装扮", "我的收藏", "我的相册", "我的文件"]
        return array
    }()
    
    lazy private var imageDatas: [String] = {
        let array = ["business", "purse", "decoration", "favorit", "album", "file"]
        return array
    }()
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - headBtn method
    func changeToUserInfo(){
        
        delegate?.didSelectHeadBtn("个人信息")
    }
    
}

//MARK: - UI method
extension SlideView{
    
    private func setupUI(){
        
//        head button
        let bx: CGFloat = 30
        let by: CGFloat  = 100
        let bw: CGFloat = 270
        let bh: CGFloat  = 60
        let headBtn = UIButton(frame: CGRect(x: bx, y: by, width: bw, height: bh))
        headBtn.addTarget(self, action: #selector(SlideView.changeToUserInfo), forControlEvents: .TouchUpInside)
        
//        user icon
        let ix: CGFloat = 0
        let iy: CGFloat = 0
        let iw: CGFloat = headBtn.bounds.size.height
        let ih: CGFloat = headBtn.bounds.size.height
        let headImage: UIImageView = UIImageView(image: UIImage(named: "0015"))
        headImage.frame = CGRectMake(ix, iy, iw, ih)
        headImage.layer.cornerRadius = headBtn.bounds.size.height * 0.5
        headImage.layer.masksToBounds = true
        
//        user name
        let lx: CGFloat = iw + 10
        let ly: CGFloat = iy
        let lw: CGFloat = bw - iw
        let lh: CGFloat = iw * 0.5
        let headLabel = UILabel()
        headLabel.frame = CGRect(x: lx, y: ly, width: lw, height: lh)
        headLabel.text = "JunChen"
        
//        list tableView
        let sTableView = UITableView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height * 0.4, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height * 0.6 - 48), style: .Plain)
        sTableView.delegate = self
        sTableView.dataSource = self
        sTableView.rowHeight = 50
        sTableView.separatorStyle = .None
        sTableView.backgroundColor = UIColor.clearColor()
        
        sTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: JCCellID)
        
//        setting button
        let setBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 48 * 2, height: 48))
        setBtn.setTitle("设置", forState: .Normal)
        setBtn.setImage(UIImage(named: "sidebar_setting"), forState: .Normal)
        
//        foot View
        let footView = UIView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 48, UIScreen.mainScreen().bounds.size.width, 48))
        footView.backgroundColor = UIColor.clearColor()
        
//        add subView
        footView.addSubview(setBtn)
        
        headBtn.addSubview(headLabel)
        headBtn.addSubview(headImage)
        
        addSubview(headBtn)
        addSubview(footView)
        addSubview(sTableView)
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SlideView: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return arrayDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let dataModel = arrayDatas[indexPath.row]
        let imageModel = imageDatas[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(JCCellID, forIndexPath: indexPath)
        
        cell.imageView?.image = UIImage(named: "sidebar_\(imageModel)")
        cell.textLabel?.text = dataModel
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        delegate?.didSelectItem(arrayDatas[indexPath.row])
    }
}