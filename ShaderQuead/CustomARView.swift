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
        createBuffer()
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupQuad() {
        let device: MTLDevice = MTLCreateSystemDefaultDevice()!
        let library: MTLLibrary = device.makeDefaultLibrary()!
        let geometryModifier = CustomMaterial.GeometryModifier(named: "twoGeometry",
                                                               in: library)
        let surfaceShader = CustomMaterial.SurfaceShader(named: "twoSurface",
                                                         in: library)
        var customMaterial: CustomMaterial
        do {
            try customMaterial = CustomMaterial(surfaceShader: surfaceShader,
                                                geometryModifier: geometryModifier,
                                                lightingModel: .lit)
            customMaterial.custom.value = simd_make_float4(0, 1, 0, 1)
            customMaterial.custom.collection += [SIMD4<Float>(1.0,0.5,0.5,0.0)]
            customMaterial.custom.collection += [SIMD4<Float>(0.3,0.7,0.9,1.0)]
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
    
    private func createBuffer() {
        let device = MTLCreateSystemDefaultDevice()!
        let library = device.makeDefaultLibrary()!
        guard let kernel = library.makeFunction(name: "send_uniform") else { return }
        guard let pipelineState = try? device.makeComputePipelineState(function: kernel) else { return }
        let width = pipelineState.threadExecutionWidth
        let height = pipelineState.maxTotalThreadsPerThreadgroup / width
        let threadsPerThreadgroup = MTLSizeMake(width, height, 1)
        let threadsPerGrid = MTLSizeMake(width, 1, 1)
        let commandQueue = device.makeCommandQueue()!
        let commandBuffer = commandQueue.makeCommandBuffer()!
        let computeEncoder = commandBuffer.makeComputeCommandEncoder()!
        let length = MemoryLayout<Float>.stride
        let mtlBuffer = device.makeBuffer(length: length)!
        mtlBuffer.label = "uniforms_buffer"
        var a: Float = 1
        mtlBuffer.contents().copyMemory(from: &a,
                                        byteCount: MemoryLayout<Float>.stride)
        computeEncoder.setBuffer(mtlBuffer, offset: 0, index: 0)
        computeEncoder.setComputePipelineState(pipelineState)
        
//        computeEncoder.dispatchThreads(threadsPerGrid,
//                                       threadsPerThreadgroup: threadsPerThreadgroup)
        
        computeEncoder.endEncoding()
    }
}

extension CustomARView: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let currentCameraTransform = frame.camera.transform
    }
}

extension CustomMaterial.Custom {
    struct Keeper {
        static var computedPty: [SIMD4<Float>] = []
    }
    var collection: [SIMD4<Float>] {
        get { return Keeper.computedPty }
        set { Keeper.computedPty = newValue }
    }
}
