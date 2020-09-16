//
//  View+loading.swift
//  BCWallet
//
//  Created by Miroslav Djukic on 20/07/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    public func loading(isLoading: Binding<Bool>) -> some View {
        return LoadingView(isShowing: isLoading) {
            self
        }
    }
    
    public func imageLoading(isLoading: Binding<Bool>) -> some View {
        return ImageLoadingView(isShowing: isLoading) {
            self
        }
    }
}

