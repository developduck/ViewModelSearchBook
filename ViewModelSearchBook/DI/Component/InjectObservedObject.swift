//
//  InjectObservedObject.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/21.
//  Copyright © 2020 example. All rights reserved.
//

import SwiftUI
import DIKit

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct InjectObservedObject<Component: ObservableObject>: DynamicProperty {
    @ObservedObject public var wrappedValue: Component
    
    public var projectedValue: ObservedObject<Component>.Wrapper {
        return self._wrappedValue.projectedValue
    }

    public init() {
        self.wrappedValue = resolve()
    }

    public init(tag: AnyHashable? = nil) {
        self.wrappedValue = resolve(tag: tag)
    }
}
