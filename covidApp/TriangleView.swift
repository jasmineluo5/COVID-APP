//
//  TriangleView.swift
//  covidApp
//
//  Created by Mark Qiao on 6/26/21.
//

import UIKit

class TriangleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override func draw(_ rect: CGRect) {

            guard let context = UIGraphicsGetCurrentContext() else { return }
            UIColor(white: 1.0, alpha: 1).set()
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.closePath()

            context.setFillColor(red: 0.6, green: 0.674, blue: 0.8, alpha: 1.0)
            
            
            context.fillPath()
            
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.closePath()
            
            context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
            context.fillPath()
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.closePath()
            
            context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            context.fillPath()
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.closePath()
            
            context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            context.fillPath()
            
        }

}
