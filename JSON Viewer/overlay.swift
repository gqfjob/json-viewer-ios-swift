import SwiftOverlays
import UIKit


extension UIView {
    func removeOverlays() {
        SwiftOverlays.removeAllBlockingOverlays()
    }
}