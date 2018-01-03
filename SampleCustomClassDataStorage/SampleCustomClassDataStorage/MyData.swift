//
//  MyData.swift
//  SampleCustomClassDataStorage
//
//  Created by 前俊輔 on 2018/01/03.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import Foundation

// NSCoderクラスのシリアライズ対象となるクラスはNSObjectクラスを継承する必要がある
class MyData: NSObject, NSCoding {
    var valueString: String?
    
    override init() {
        
    }

    required init?(coder aDecoder: NSCoder) {
        valueString = aDecoder.decodeObject(forKey: "valueString") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(valueString, forKey: "valueString")
    }
    
}
