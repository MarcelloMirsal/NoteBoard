//
//  UIFontsView.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 02/07/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class UIFontsView : UIView {
    
    let contentsView : UIView = {
        let contentsView = UIView()
        contentsView.backgroundColor = UIColor(displayP3Red: 210/255, green: 212/255, blue: 218/255, alpha: 0.5)
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        return contentsView
    }()
    
    weak var boardToolsViewDelegate : UIBoardToolsView?
    let fontCellId = "fontCell"
    
    
    
    lazy var  dismissButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize+10)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismissKeyboard(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var  boldStyleButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("B", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = [.layerMinXMinYCorner , .layerMinXMaxYCorner]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize+10)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFontStyleSelection(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var  italicStyleButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Italic", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFontStyleSelection(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var  normalStyleButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("normal", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFontStyleSelection(sender:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
        return button
    }()
    
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .white
        
        addSubview(contentsView)
        contentsView.addSubview(dismissButton)
        
        
        // MARK:- Constraint
        // contentsView Constraint
        contentsView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentsView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentsView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentsView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        // dismiss button constraint
        dismissButton.topAnchor.constraint(equalTo: contentsView.safeAreaLayoutGuide.topAnchor , constant: 16).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: contentsView.safeAreaLayoutGuide.rightAnchor , constant: -16).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        // font styles button using stackView
        
        let fontStylesStackView = UIStackView(arrangedSubviews: [boldStyleButton , italicStyleButton , normalStyleButton])
        fontStylesStackView.translatesAutoresizingMaskIntoConstraints = false
        fontStylesStackView.distribution = .fillEqually
        fontStylesStackView.spacing = 16
        contentsView.addSubview(fontStylesStackView)
        
        fontStylesStackView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 16).isActive = true
        fontStylesStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        fontStylesStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        fontStylesStackView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        

        
        self.layoutIfNeeded()
        contentsView.center.y += frame.height * 2
        UIView.animate(withDuration: 0.25) {
            self.contentsView.center.y -= self.frame.height * 2
        }
        
    }
    
    // MARK:- methods
    func configSelectedStyle(button : UIButton) {
        let buttonTitle = button.title(for: .normal)
        if button.backgroundColor == .white {
            button.backgroundColor = .lightGray
            boardToolsViewDelegate?.nextTypingAttributes.removeAll()
            // append attribute
            if  buttonTitle == "B" {
                italicStyleButton.backgroundColor = .white
                normalStyleButton.backgroundColor = .white
                boardToolsViewDelegate?.nextTypingAttributes[NSAttributedStringKey.font.rawValue] = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize+10)
            } else if buttonTitle == "Italic" {
                boldStyleButton.backgroundColor = .white
                normalStyleButton.backgroundColor = .white
                boardToolsViewDelegate?.nextTypingAttributes[NSAttributedStringKey.font.rawValue] = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
            } else if buttonTitle == "normal" {
                boldStyleButton.backgroundColor = .white
                italicStyleButton.backgroundColor = .white
                boardToolsViewDelegate?.nextTypingAttributes[NSAttributedStringKey.font.rawValue] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            }
        } else {
            button.backgroundColor = .white
            boardToolsViewDelegate?.nextTypingAttributes.removeAll()
        }
    }
    
    
    // MARK:- action handlers
    @objc
    func handleDismissKeyboard(sender : UIButton) {
        boardToolsViewDelegate?.textView?.endEditing(true)
        boardToolsViewDelegate?.textView?.inputAccessoryView = boardToolsViewDelegate
        boardToolsViewDelegate?.textView?.inputView = nil
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
            self.boardToolsViewDelegate?.textView?.becomeFirstResponder()
        }
    }
    
    @objc
    func handleFontStyleSelection(sender: UIButton) {
        let buttonTitle = sender.title(for: .normal)
        if  buttonTitle == "B" {
            configSelectedStyle(button: sender)
        } else if buttonTitle == "Italic" {
            configSelectedStyle(button: sender)
        } else if buttonTitle == "normal" {
            configSelectedStyle(button: sender)
        }
    }

    
}

