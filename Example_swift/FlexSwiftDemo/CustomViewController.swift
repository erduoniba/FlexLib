//
//  CustomViewController.swift
//  FlexSwiftDemo
//
//  Created by 邓立兵 on 2021/5/26.
//  Copyright © 2021 wbg. All rights reserved.
//

import UIKit
import FlexLib

class CustomViewController: UIViewController {
    private var rootView: FlexRootView!
    
//    private var _fText: UILabel?
//    @objc private var _sText: UILabel? {
//        willSet {
//
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView = FlexRootView.load(withNodeFile: "CustomViewController", owner: self)
        self.view.addSubview(rootView)
        
//        _fText?.text = "xx"
//        _sText?.text = "xx2"
        
//        for json in jsons {
//            self.value(forKey: json["name"]).setValue(json["value"])
//        }
        
        
        if let label = self.value(forKey: "fText") as? UILabel {
            debugPrint("label exist")
            label.setViewAttrStrings([
                "text","点击删除"
            ])
            
            label.setViewAttr("text", value: "点击我试试")
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
