import Foundation

@objc protocol Installer {
    func install()
}

@objc public protocol InstallationClient {
    func installationDidReachProgress(_ progress: Double, description: String?)
}
