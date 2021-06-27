//
//  DiagonalView.swift
//  covidApp
//
//  Created by Mark Qiao on 6/26/21.
//

import UIKit

class DiagonalView: UIView {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder aDecoder: NSCoder) {
            return nil // TODO
        }
    
    override func draw(_ rect: CGRect) {
        // Fill the whole background with the darkest blue color
        //UIColor(red: 0.329, green: 0.718, blue: 0.875, alpha: 1).set()
        UIColor(red: 0.6, green: 0.674, blue: 0.8, alpha: 1).set()
        let bg = UIBezierPath(rect: rect)
        bg.fill()

        // Add the first sine wave filled with a very transparent white
        let top1: CGFloat = 17.0
        let diagonal = DiagonalPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - top1))
        UIColor(white: 1.0, alpha: 1).set()
        diagonal.fill()


    }
    
    func DiagonalPath(rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()

        // start in the bottom left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.close()
        return path
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
