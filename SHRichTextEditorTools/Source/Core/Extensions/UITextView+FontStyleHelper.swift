//
//  UITextView+FontStyleHelper.swift
//  SHRichTextEditorTools
//
//  Created by GAURAV NAYAK on 19/06/20.
//  Copyright © 2020 hsusmita. All rights reserved.
//

import Foundation
import UIKit


extension UITextView {
    
    func toggleFontStyle() {
        guard let index = currentCursorPosition else {
            return
        }
        
        if fontStyleHeadingOne(at: index) {
            updateToHeadingThree(at: index)
        } else if fontStyleHeadingTwo(at: index) {
            updateToHeadingThree(at: index)
        } else if fontStyleHeadingThree(at: index) {
            updateToDescription(at: index)
        } else if fontStyleDescription(at: index) {
            startOfLineIndex ?? 0 == 0 ? updateToHeadingOne(at: index) : updateToHeadingTwo(at: index)
        } else {
            updateToDescription(at: index)
        }
    }
    
    public func fontStyleHeadingOne(at index: Int) -> Bool {
        guard let startOfLineIndex = startOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return false
        }
        
        var range = NSRange(location: startOfLineIndex, length:  index - startOfLineIndex)
        let font = attributedText.attribute(NSAttributedString.Key.font, at: startOfLineIndex, longestEffectiveRange: &range, in: range) as? UIFont
        if font?.pointSize == StyleHeadingOne.pointSize {
            return true
        }
        return false
    }
    
    public func fontStyleHeadingTwo(at index: Int) -> Bool {
        guard let startOfLineIndex = startOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return false
        }
        
        var range = NSRange(location: startOfLineIndex, length:  index - startOfLineIndex)
        let font = attributedText.attribute(NSAttributedString.Key.font, at: startOfLineIndex, longestEffectiveRange: &range, in: range) as? UIFont
        if font?.pointSize == StyleHeadingTwo.pointSize {
            return true
        }
        return false
    }
    
    public func fontStyleHeadingThree(at index: Int) -> Bool {
        guard let startOfLineIndex = startOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return false
        }
        
        var range = NSRange(location: startOfLineIndex, length:  index - startOfLineIndex)
        let font = attributedText.attribute(NSAttributedString.Key.font, at: startOfLineIndex, longestEffectiveRange: &range, in: range) as? UIFont
        if font?.pointSize == StyleHeadingThree.pointSize && font?.isBold ?? false {
            return true
        }
        return false
    }
    
    public func fontStyleDescription(at index: Int) -> Bool {
        guard let startOfLineIndex = startOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return false
        }
        
        var range = NSRange(location: startOfLineIndex, length:  index - startOfLineIndex)
        let font = attributedText.attribute(NSAttributedString.Key.font, at: startOfLineIndex, longestEffectiveRange: &range, in: range) as? UIFont
        if font?.pointSize == StyleDescription.pointSize {
            return true
        }
        return false
    }
    
    public func updateToHeadingOne(at index: Int) {
        guard let startOfLineIndex = startOfLineIndex, let endOfLineIndex = endOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return
        }
        
        let range = NSRange(location: startOfLineIndex, length:  endOfLineIndex - startOfLineIndex)
        let mutableAttributedString = attributedText.mutableCopy() as! NSMutableAttributedString

        let newString = attributedText.attributedSubstring(from: range).string
        let newAttributes = [ NSAttributedString.Key.font: StyleHeadingOne ]
        let newAttributedString = NSMutableAttributedString(string: newString, attributes: newAttributes)

        mutableAttributedString.replaceCharacters(in: range, with: newAttributedString)
        attributedText = mutableAttributedString
        let arbitraryValue: Int = endOfLineIndex
        if let newPosition = self.position(from: beginningOfDocument, in: .right, offset: arbitraryValue) {
            selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
        self.delegate?.textViewDidChange?(self)
    }
    
    public func updateToHeadingTwo(at index: Int) {
        guard let startOfLineIndex = startOfLineIndex, let endOfLineIndex = endOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return
        }
        
        let range = NSRange(location: startOfLineIndex, length: endOfLineIndex - startOfLineIndex)
        let mutableAttributedString = attributedText.mutableCopy() as! NSMutableAttributedString

        let newString = attributedText.attributedSubstring(from: range).string
        let newAttributes = [ NSAttributedString.Key.font: StyleHeadingTwo ]
        let newAttributedString = NSMutableAttributedString(string: newString, attributes: newAttributes)

        mutableAttributedString.replaceCharacters(in: range, with: newAttributedString)
        attributedText = mutableAttributedString
        let arbitraryValue: Int = endOfLineIndex
        if let newPosition = self.position(from: beginningOfDocument, in: .right, offset: arbitraryValue) {
            selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
        self.delegate?.textViewDidChange?(self)
    }
    
    public func updateToHeadingThree(at index: Int) {
        guard let startOfLineIndex = startOfLineIndex, let endOfLineIndex = endOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return
        }
        
        let range = NSRange(location: startOfLineIndex, length:  endOfLineIndex - startOfLineIndex)
        let mutableAttributedString = attributedText.mutableCopy() as! NSMutableAttributedString

        let newString = attributedText.attributedSubstring(from: range).string
        let newAttributes = [ NSAttributedString.Key.font: StyleHeadingThree ]
        let newAttributedString = NSMutableAttributedString(string: newString, attributes: newAttributes)

        mutableAttributedString.replaceCharacters(in: range, with: newAttributedString)
        attributedText = mutableAttributedString
        let arbitraryValue: Int = endOfLineIndex
        if let newPosition = self.position(from: beginningOfDocument, in: .right, offset: arbitraryValue) {
            selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
        self.delegate?.textViewDidChange?(self)
    }
    
    public func updateToDescription(at index: Int) {
        guard let startOfLineIndex = startOfLineIndex, let endOfLineIndex = endOfLineIndex, index > startOfLineIndex, index <= text.count else {
            return
        }
        
        let range = NSRange(location: startOfLineIndex, length:  endOfLineIndex - startOfLineIndex)
        let mutableAttributedString = attributedText.mutableCopy() as! NSMutableAttributedString

        let newString = attributedText.attributedSubstring(from: range).string
        let newAttributes = [ NSAttributedString.Key.font: StyleDescription ]
        let newAttributedString = NSMutableAttributedString(string: newString, attributes: newAttributes)

        mutableAttributedString.replaceCharacters(in: range, with: newAttributedString)
        attributedText = mutableAttributedString
        let arbitraryValue: Int = endOfLineIndex
        if let newPosition = self.position(from: beginningOfDocument, in: .right, offset: arbitraryValue) {
            selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
        self.delegate?.textViewDidChange?(self)
    }
}
