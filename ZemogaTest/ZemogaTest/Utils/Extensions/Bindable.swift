//
//  Bindable.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 18/01/22.
//

import Foundation

public class Bindable<T> {

    public typealias Listener = (T) -> ()
    private var listener: Listener?

    public func bind(listener: Listener?) {
        self.listener = listener
    }

    public func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

}
