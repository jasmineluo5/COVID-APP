//
//  WavyView.swift
//  covidApp
//
//  Created by Mark Qiao on 6/24/21.
//

import UIKit

class WavyView: UIView {
    
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
            let wave1 = wavyPath(rect: CGRect(x: 0, y: top1, width: frame.width, height: frame.height - top1), periods: 1.5, amplitude: 21, start: 0.55)
            UIColor(white: 1.0, alpha: 0.1).set()
            wave1.fill()

            // Add the second sine wave over the first
            let top2: CGFloat = 34.0
            let wave2 = wavyPath(rect: CGRect(x: 0, y: top2, width: frame.width, height: frame.height - top2), periods: 1.5, amplitude: 21, start: 0.9)
            UIColor(white: 1.0, alpha: 0.15).set()
            wave2.fill()

//            // Add the text
//            let paraAttrs = NSMutableParagraphStyle()
//            paraAttrs.alignment = .center
//            let textRect = CGRect(x: 0, y: frame.maxY - 64, width: frame.width, height: 24)
//            let textAttrs = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20), NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.9), NSParagraphStyleAttributeName: paraAttrs]
//            ("New user? Register here." as NSString).draw(in: textRect, withAttributes: textAttrs)
        }

        // This creates the desired sine wave bezier path
        // rect is the area to fill with the sine wave
        // periods is how may sine waves fit across the width of the frame
        // amplitude is the height in points of the sine wave
        // start is an offset in wavelengths for the left side of the sine wave
        func wavyPath(rect: CGRect, periods: Double, amplitude: Double, start: Double) -> UIBezierPath {
            let path = UIBezierPath()

            // start in the bottom left corner
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))

            let radsPerPoint = Double(rect.width) / periods / 2.0 / Double.pi
            let radOffset = start * 2 * Double.pi
            let xOffset = Double(rect.minX)
            let yOffset = Double(rect.minY) + amplitude
            // This loops through the width of the frame and calculates and draws each point along the size wave
            // Adjust the "by" value as needed. A smaller value gives smoother curve but takes longer to draw. A larger value is quicker but gives a rougher curve.
            for x in stride(from: 0, to: Double(rect.width), by: 6) {
                let rad = Double(x) / radsPerPoint + radOffset
                let y = sin(rad) * amplitude

                path.addLine(to: CGPoint(x: x + xOffset, y: y + yOffset))
            }

            // Add the last point on the sine wave at the right edge
            let rad = Double(rect.width) / radsPerPoint + radOffset
            let y = sin(rad) * amplitude

            path.addLine(to: CGPoint(x: Double(rect.maxX), y: y + yOffset))

            // Add line from the end of the sine wave to the bottom right corner
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            // Close the path
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
