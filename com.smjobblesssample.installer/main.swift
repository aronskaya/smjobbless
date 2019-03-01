import Foundation

NSLog("[SMJBS]: Privileged Helper has started")

XPCServer.shared.start()

CFRunLoopRun()
