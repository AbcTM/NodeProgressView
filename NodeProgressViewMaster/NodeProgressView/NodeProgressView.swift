
//
//  NodeProgressView.swift
//  NodeProgressBar
//
//  Created by feng on 2017/4/25.
//  Copyright © 2017年 tianlinchun. All rights reserved.
//

import UIKit

let lineNodeWidth: CGFloat = 50          // 线长
let circleNodeWidth: CGFloat = 15        // 圆的直径
let nodeGapWidth: CGFloat = 5           // 线与圆的间隔宽度
let lineNodeHeight: CGFloat = 5
let headImageWidth: CGFloat = 40
let labelHeight: CGFloat = 15


/// 进度节点
class NodeProgressView: UIView {
    
    var nodeNumber: UInt = 4
    var bgLayer: CAShapeLayer!
    var pgLayer: CAShapeLayer!
    
    private(set) var progress: CGFloat = 0
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    fileprivate func setSubViews()
    {
        let translucentView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        translucentView.backgroundColor = UIColor.white
        translucentView.alpha = 1
        addSubview(translucentView)
        
        let a = (self.bounds.width - (30+headImageWidth+(CGFloat(nodeNumber)-1)*2*nodeGapWidth+(CGFloat(nodeNumber)-1)*circleNodeWidth))/(CGFloat(nodeNumber)-1) //线宽
        let b = 2*nodeGapWidth + circleNodeWidth // 间隔
        
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
//        path.addArc(withCenter: CGPoint.init(x: 25, y: self.bounds.midY), radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
        path.usesEvenOddFillRule = true
        
        let titleArr: Array<String> = ["处理", "确认", "领赏"]
        for index in 0..<3 {
            
            let linex = 50+nodeGapWidth+(a+b)*CGFloat(index)
            let liney = self.bounds.midY-lineNodeHeight/2
            let lineframe = CGRect(x: linex, y: liney, width: a, height: lineNodeHeight)
            
            let circlex = 50 + CGFloat(index)*circleNodeWidth + circleNodeWidth/2 + CGFloat(index+1)*(2*nodeGapWidth+a)
            let circley = self.bounds.midY
            let linePath = UIBezierPath(roundedRect: lineframe, cornerRadius: 2.5)
            let circlePath = UIBezierPath(arcCenter: CGPoint.init(x: circlex, y: circley), radius: circleNodeWidth/2, startAngle: 0, endAngle: .pi*2, clockwise: false)
            
            path.append(linePath.reversing())
            path.append(circlePath)
            
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: labelHeight))
            label.center = CGPoint(x: circlex, y: circley-circleNodeWidth/2-5-labelHeight/2)
            label.text = titleArr[index]
            label.font = UIFont.systemFont(ofSize: 11)
            label.textAlignment = .center
            label.textColor = UIColor.gray
            addSubview(label)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        
        translucentView.layer.mask = shapeLayer
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        context?.addRect(CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        context?.setLineWidth(self.bounds.height)
        UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.00).setStroke()
        context?.strokePath()
        
        context?.move(to: CGPoint(x: 0, y: self.bounds.midY))
        context?.addLine(to: CGPoint(x: (self.bounds.width-headImageWidth)*progress+headImageWidth, y: self.bounds.midY))
        UIColor(red:0.99, green:0.62, blue:0.16, alpha:1.00).setStroke()
        context?.strokePath()
    }
    
    // 0-1
    func zprogress(_ progress: CGFloat) {
        if progress>1 || progress < 0 {
            return
        }
        self.progress = progress
        setNeedsDisplay()
    }

}
