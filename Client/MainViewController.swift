import AppKit

class MainViewController: NSViewController {
    
    var client = XPCClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let auth = Util.askAuthorization() else {
            fatalError("Authorization not acquired.")
        }
        
        Util.blessHelper(label: Constant.helperMachLabel, authorization: auth)
        
        client.start()
    }
}
