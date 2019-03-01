import Foundation

class XPCServer: NSObject {
    
    internal static let shared = XPCServer()
    
    private var listener: NSXPCListener?
    
    internal func start() {
        listener = NSXPCListener(machServiceName: Constant.helperMachLabel)
        listener?.delegate = self
        listener?.resume()
    }
    
    private func connetionInterruptionHandler() {
        NSLog("[SMJBS]: \(#function)")
    }
    
    private func connectionInvalidationHandler() {
        NSLog("[SMJBS]: \(#function)")
    }
}

extension XPCServer: NSXPCListenerDelegate {
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        NSLog("[SMJBS]: \(#function)")
        
        let installer = InstallerImpl()
        
        newConnection.exportedInterface = NSXPCInterface(with: Installer.self)
        newConnection.exportedObject = installer
        
        newConnection.remoteObjectInterface = NSXPCInterface(with: InstallationClient.self)
        
        newConnection.interruptionHandler = connetionInterruptionHandler
        newConnection.invalidationHandler = connectionInvalidationHandler
        
        newConnection.resume()
        
        installer.client = newConnection.remoteObjectProxy as? InstallationClient
        
        return true
    }
}
