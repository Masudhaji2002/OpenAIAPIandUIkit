//
//  UIViewExt.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 20.01.2025.
//

import UIKit

extension UIView {
    static func config<T: UIView>(view: T, completion: (T) -> Void) -> T {
        view.translatesAutoresizingMaskIntoConstraints = false
        completion(view)
        return view
    }
}
