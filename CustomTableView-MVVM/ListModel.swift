//
//  MainModel.swift
//  TableView-MVVM
//
//  Created by mhlee on 2018. 5. 10..
//  Copyright © 2018년 mhlee. All rights reserved.
//

import Foundation
import RxSwift

class ListModel {
  lazy var strings: Variable<[String]> = {
    let strings = Variable([String]())
    return strings
  }()
  
  func add(_ string: String) {
    strings.value.append(string)
  }
  
  func removeFirst() {
    strings.value.removeFirst()
  }
}
