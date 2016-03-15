import Bond
import BrightFutures
import Cartography
import Foundation
import JASON
import SwiftOverlays
import UIKit


class IndexView: UIView {
    
    let elements = defineElements(
        ("urlLabel", UILabel()),
        ("urlText", UITextField()),
        ("viewButton", UIButton(type: UIButtonType.System)),
        ("notesText", UITextView())
    )
    

    convenience init() {
        self.init(frame: UIScreen.mainScreen().bounds)
        
        render()
    }
    
    
    //
    // Render
    //
    func render() {
        self.backgroundColor = .whiteColor()
        
        elements.forEach { e in
            self.style(e.0, element: e.1)
            self.addSubview(e.1 as! UIView)
        }
        
        // auto layout
        // -> urlLabel & urlText
        constrain(
            el(elements, idx: 0) as! UILabel,
            el(elements, idx: 1) as! UITextField
        ) { urlLabel, urlText in
            let s = urlLabel.superview!
            
            urlLabel.top == s.topMargin + 35
            urlLabel.left == s.left + 8
            
            urlText.top == urlLabel.bottom + 7
            urlText.leadingMargin == s.leadingMargin + 8
            urlText.trailingMargin == s.trailingMargin - 8
        }
        
        // -> viewButton
        constrain(
            el(elements, idx: 1) as! UITextField,
            el(elements, idx: 2) as! UIButton
            ) { urlText, viewButton in
                let s = viewButton.superview!
                
                viewButton.top == urlText.bottom + 9
                viewButton.trailingMargin == s.trailingMargin - 8
        }
        
        // -> notesText
        constrain(
            el(elements, idx: 2) as! UIButton,
            el(elements, idx: 3) as! UITextView
            ) { viewButton, notesText in
                let s = notesText.superview!
                
                notesText.top == viewButton.bottom + 24
                notesText.bottom == s.bottom - 24
                notesText.leadingMargin == s.leadingMargin + 8
                notesText.trailingMargin == s.trailingMargin - 8
        }
        
        // event handlers
        let viewButton = el(elements, key: "viewButton") as! UIButton
        viewButton.bnd_tap.observe(viewClickHandler)
    }
    
    
    //
    // Styles
    //
    func style<T>(key: String, element: T) -> Void {
        switch key {
            case "urlLabel":
                let e = element as! UILabel
                e.font = UIFont.systemFontOfSize(12, weight: UIFontWeightMedium)
                e.text = "JSON File URL"
            
            case "urlText":
                let e = element as! UITextField
                e.font = UIFont.systemFontOfSize(14)
                e.borderStyle = UITextBorderStyle.RoundedRect
                e.placeholder = "http://example.com/data.json"
            
            case "viewButton":
                let e = element as! UIButton
                e.setTitle("View", forState: UIControlState.Normal)
            
            case "notesText":
                let e = element as! UITextView
                e.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
                e.textColor = UIColor.lightGrayColor()
                e.text =
                    "The response of the request sent to the given URL" +
                    "must have the `application/json` content-type.\n\n" +
                    "Demo URL: http://keymaps-api.herokuapp.com/public/MS9xdW90ZXM="
            
            default: ()
        }
    }
    
    
    //
    // Events
    //
    func viewClickHandler() {
        let e = el(elements, key: "urlText") as! UITextField
        
        // check if url is given
        if e.text == nil || e.text!.characters.count == 0 {
            let overlay = SwiftOverlays.showBlockingTextOverlay("No URL given.")
            let tap = UITapGestureRecognizer(target: overlay, action: "removeOverlays")
            
            overlay.addGestureRecognizer(tap)
            
            return
        }
        
        // show 'loading' overlay
        SwiftOverlays.showBlockingWaitOverlayWithText("Please wait...")
        
        // make request
        let future = fetch(e.text!)
        
        future.onSuccess { result in
            SwiftOverlays.removeAllBlockingOverlays()
            
            let e = el(self.elements, key: "notesText") as! UITextView
            e.text = result.object as! String
        }
        
        future.onFailure { error in
            SwiftOverlays.removeAllBlockingOverlays()
            
            let overlay = SwiftOverlays.showBlockingTextOverlay("Could not parse the response from the given URL.")
            let tap = UITapGestureRecognizer(target: overlay, action: "removeOverlays")
            
            overlay.addGestureRecognizer(tap)
        }
    }
    
}