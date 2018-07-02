//
//  BoardInputView.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 30/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class BoardInputView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func didMoveToWindow() {
        print("did move to window")
    }
    override func didMoveToSuperview() {
    }

    func setup(for mode : BoardMode){
        print("setup")
        if self.backgroundColor == .blue {
            self.backgroundColor = .red
        } else {
            self.backgroundColor = .blue
        }
    }
 

}
