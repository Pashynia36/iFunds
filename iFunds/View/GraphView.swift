//
//  GraphView.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/14/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class GraphView: UIView {
    
    private struct Constants {
        
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    // inspectable gradient(from,to) colors to change 'em in storyboard
    @IBInspectable var startColor: UIColor = .gray
    @IBInspectable var endColor: UIColor = .green
    
    var graphPoints = [0,0,0,0,0,0,0]
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners,                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        // setting the context for draw to know where to draw
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        // making the gradient with start/end colors and changing
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0.0, y: bounds.height)
        context?.drawLinearGradient(gradient,
                                    start: startPoint,
                                    end: endPoint,
                                    options: [])
        
        
        // calculate X point
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        // calculate Y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y // flip graph
        }
        // draw the line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        // clipping path for the gradient graph
        context?.saveGState()
        // copy of path to fill with gradient
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
        context?.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
        context?.restoreGState()
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        // data points
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
            circle.fill()
        }
        // horizontal lines
        let linePath = UIBezierPath()
        // top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        // center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        // bottom line
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }
}
