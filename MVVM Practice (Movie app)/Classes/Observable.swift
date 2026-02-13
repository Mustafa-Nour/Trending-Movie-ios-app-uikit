//
//  Observable.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 22/02/2025.
//

import Foundation
class observable <T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    init ( _ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
