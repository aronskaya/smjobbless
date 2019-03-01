import Foundation

class InstallerImpl: NSObject, Installer {
    
    var client: InstallationClient?
    
    func install() {
       NSLog("[SMJBS]: \(#function)")
        client?.installationDidReachProgress(1, description: "Finished!")
    }
}
