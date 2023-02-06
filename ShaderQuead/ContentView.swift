//
//  ContentView.swift
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/29.
//

import SwiftUI
import RealityKit
import MetalKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = CustomARView
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        return arView
    }
    func updateUIView(_ uiView: CustomARView, context: Context) {}
}

