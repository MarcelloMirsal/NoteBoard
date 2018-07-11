//
//  UIBoardToolsView.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 01/07/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class UIBoardToolsView: UIView {
    
    // MARK:- Properties
    var nextTypingAttributes = [String:Any]()
    
    lazy var fontButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Aa", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize+5)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleFontButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    let fontsView = UIFontsView()
    
    weak var textView : UITextView?
    
    // MARK:- inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- Methods
    func setupViews(){
        let stackView = UIStackView(arrangedSubviews: [fontButton])
        self.backgroundColor = UIColor(displayP3Red: 210/255, green: 212/255, blue: 218/255, alpha: 1)
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    // MARK:- actions
    @objc
    func handleFontButton(sender : UIButton) {
        textView?.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.fontsView.boardToolsViewDelegate = self
            self.fontsView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 240)
            self.textView?.inputAccessoryView = nil
            self.textView?.inputView = self.fontsView
            self.textView?.becomeFirstResponder()
        }

    }
    
}
