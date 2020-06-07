import Foundation

@objc protocol Installer {
    func install()
    func uninstall()
}

@objc public protocol InstallationClient {
    func installationDidReachProgress(_ progress: Double, description: String?)
}
