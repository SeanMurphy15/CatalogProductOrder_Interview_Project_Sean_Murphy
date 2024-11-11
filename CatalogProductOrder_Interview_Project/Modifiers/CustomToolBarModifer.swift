//
//  CustomToolBarModifer.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/11/24.
//

import Foundation
import SwiftUI

struct CustomToolbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

extension View {
    func customToolbar() -> some View {
        self.modifier(CustomToolbarModifier())
    }
}
