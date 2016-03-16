import UIKit


public class IndexController: UIViewController {
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    
    override public func viewWillTransitionToSize(
        size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator
    ) {
        view.subviews.forEach({ v in
            v.frame = CGRectMake(0, 0, size.width, size.height)
        })
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubview( IndexView() )
    }
    
}