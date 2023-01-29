//
//  CustomARView.swift
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/29.
//

import RealityKit
import ARKit
import SceneKit

final class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        session.delegate = self
        setupQuad()
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupQuad() {
        let device: MTLDevice = MTLCreateSystemDefaultDevice()!
        let library: MTLLibrary = device.makeDefaultLibrary()!
        let geometryModifier = CustomMaterial.GeometryModifier(named: "waveMotion",
                                                               in: library)
        let surfaceShader = CustomMaterial.SurfaceShader(named: "waveSurface",
                                                         in: library)
        let customMaterial: CustomMaterial
        do {
            try customMaterial = CustomMaterial(surfaceShader: surfaceShader,
                                                geometryModifier: geometryModifier,
                                                lightingModel: .unlit)
        } catch {
            fatalError()
        }
        let quad = MeshResource.generateBox(width: 0.5, height: 0.5, depth: 0.1)
        let modelEntity = ModelEntity(mesh: quad, materials: [customMaterial])
        let anchorEntity = AnchorEntity()
        let position = simd_make_float3(0, -0.2, -0.5)
        anchorEntity.look(at: cameraTransform.translation,
                          from: position,
                          relativeTo: nil)
        anchorEntity.addChild(modelEntity)
        scene.anchors.append(anchorEntity)
    }
}

extension CustomARView: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let currentCameraTransform = frame.camera.transform
    }
}
