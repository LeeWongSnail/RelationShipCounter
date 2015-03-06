//
//  ViewController.swift
//  RelationShipCounter
//
//  Created by LeeWong on 15/3/4.
//  Copyright (c) 2015年 LeeWong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var inputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        inputLabel.text = "我"
        
        loadData()
        loadDataDict()
    }

    @IBAction func optionClick(sender: UIButton){
        //点击了关系选择按钮
        //判断答案label中是否为空
        if answerLabel.text == "" {
            //如果是空
            inputLabel.text = sender.titleLabel!.text!
        }else
        {
            if inputLabel.text == "" {
                inputLabel.text = sender.titleLabel!.text!
            }else
            {
                //如果answerlabel不为空 则说明已经点击了  “的”
                //直接把 这次点击的值赋给answerlabel
                answerLabel.text = sender.titleLabel!.text!

            }
        }
        
    }

   //点击了   “的”
    @IBAction func separateClick(sender: UIButton) {
        //如果点击了  的  
        //1、把inputlabel中的内容赋给answerlabel中
        answerLabel.text = inputLabel!.text! + "的"
        
        //2、把inputlabel清空
        inputLabel.text = ""
    }
    

    @IBAction func resultClick(sender: UIButton) {
        //计算关系husband
        //取出关系的前者
        let str = answerLabel.text!
        let range = str.rangeOfString("的")
        
        
        
        let subStr = str.substringToIndex(range!.startIndex)
        let ques = ChineseToEnglish(inputLabel.text!)
        println(dictArray!.count)
        for i in 0..<dictArray!.count {
            let elem:NSDictionary = dictArray![i] as! NSDictionary
            if elem["name"] as! String == subStr {
                
                let answer = elem[ques] as? String
                
                //给答案label赋值
                answerLabel.text = answer
                //将输入栏清空
//                inputLabel.text = ""
                //得到正确答案之后不再遍历
                return
            }
            
        }
    }
    
    @IBAction func clearClick(sender: UIButton) {
        inputLabel.text = "我"
        answerLabel.text = ""
    }
    
    //一个存放模型的数组
    var modelArray:[Relation]? = []
    
    //一个存放字典的数组
    var dictArray:NSMutableArray?
    func loadDataDict() {
        //加载plist文件
        let path = NSBundle.mainBundle().pathForResource("relation", ofType: "plist")
        
        //存放到数组中
        dictArray = NSMutableArray(contentsOfFile: path!)

    }
    
    
    func loadData() {
        //加载plist文件
        let path = NSBundle.mainBundle().pathForResource("relation", ofType: "plist")
        
        //存放到数组中
        let arrayM:NSMutableArray = NSMutableArray(contentsOfFile: path!)!
        
        
//        println(arrayM["姐"]) 
        for i in 0..<arrayM.count {
            //取出数组的一个元素 这个元素 是一个字典
            let dict = arrayM[i] as! NSDictionary
            
            //定义一个模型用来存放这个字典模型
            let obj = Relation()
            
            //给这个模型赋值
            obj.name = dict["name"] as? String
            obj.father = dict["father"] as? String
            obj.mother = dict["mother"] as? String
            obj.son = dict["son"] as? String
            obj.daughter = dict["daughter"] as? String
            obj.elderbrother = dict["elderbrother"] as? String
            obj.littlebrother = dict["littlebrother"] as? String
            obj.eldersister = dict["eldersister"] as? String
            obj.littlesister = dict["littlesister"] as? String
            obj.wife = dict["wife"] as? String
            obj.husband = dict["husband"] as? String
            
//            modelArray.addObject(obj)
            modelArray?.append(obj)
        }

    }
    
    //根据汉字获取英语
    func ChineseToEnglish(chi:String) ->String{
        
    switch chi {
        case "父":
                return "father"
        case "母":
            return "mother"
        case "儿":
            return "son"
        case "女":
            return "daughter"
        case "兄":
            return "elderbrother"
        case "弟":
            return "littlebrother"
        case "姐":
            return "eldersister"
        case "妹":
            return "littlesister"
        case "妻":
            return "wife"
        case "夫":
            return "husband"
    default:
            return "null"
    }
        
       
    }
    
    
}

