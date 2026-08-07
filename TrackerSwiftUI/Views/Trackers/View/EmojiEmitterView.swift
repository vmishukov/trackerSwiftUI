//
//  EmojiEmitterView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 16.07.2026.
//

import SwiftUI
import UIKit

struct EmojiEmitterView: UIViewRepresentable {
    
    var emojis: [String]
    @Binding var emitCount: Int
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard emitCount > 0 else { return }
        
        let emitterLayer = CAEmitterLayer()
        // Смещаем точку старта чуть ниже, чтобы частицы вылетали прямо из центра кнопки
        emitterLayer.emitterPosition = CGPoint(x: uiView.bounds.midX, y: uiView.bounds.midY)
        emitterLayer.emitterSize = CGSize(width: 1, height: 1)
        emitterLayer.emitterShape = .point
        
        emitterLayer.emitterCells = emojis.compactMap { emoji in
            let cell = CAEmitterCell()
            cell.birthRate = 50
            cell.lifetime = 5.0 // Увеличили время жизни, чтобы они успели упасть вниз
            
            // Настройка физики движения
            cell.velocity = 350 // Сила начального толчка вверх
            cell.velocityRange = 200
            cell.alphaSpeed = -0.5
            
            emitterLayer.emitterShape = .sphere // Частицы генерируются из одного пикселя
            
            cell.emissionLongitude = 3 * .pi / 2 // Направление строго вверх
            cell.emissionRange = .pi / 1
            
            // Гравитация: положительное значение тянет частицы вниз по оси Y
            cell.yAcceleration = 10
            
            // Вращение частиц при полете
            cell.spin = 1
            cell.spinRange = 4
            
            cell.scale = 0.25
            cell.scaleRange = 0.2
            
            if let image = imageFromEmoji(emoji) {
                cell.contents = image.cgImage
            }
            return cell
        }
        
        uiView.layer.addSublayer(emitterLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            emitterLayer.birthRate = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            emitterLayer.removeFromSuperlayer()
        }
    }
    
    private func imageFromEmoji(_ emoji: String) -> UIImage? {
        let nsString = emoji as NSString
        let font = UIFont.systemFont(ofSize: 40)
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        nsString.draw(at: .zero, withAttributes: stringAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
