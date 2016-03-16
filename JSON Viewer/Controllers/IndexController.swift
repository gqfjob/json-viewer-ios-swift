import UIKit


public class IndexController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil);
        view.addSubview( IndexView() );
    }
    
}