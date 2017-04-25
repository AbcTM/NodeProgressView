//
//  ViewController.swift
//  NodeProgressViewMaster
//
//  Created by feng on 2017/4/25.
//  Copyright © 2017年 tianlinchun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer!
    var progressView: NodeProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = NodeProgressView(frame: CGRect(x: 10, y: 64+20, width: view.bounds.width - 20, height: 80))
        progressView.backgroundColor = UIColor.red
        view.addSubview(progressView)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increase), userInfo: nil, repeats: true)
    }
    
    func increase() {
        let progress = progressView.progress+0.1
        progressView.zprogress(progress)
        
        if progress>1 {
            timer.invalidate()
            timer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

