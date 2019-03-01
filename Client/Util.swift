import SecurityFoundation
import ServiceManagement

struct Util {
    
    static func askAuthorization() -> AuthorizationRef? {
        
        var auth: AuthorizationRef?
        let status: OSStatus = AuthorizationCreate(nil, nil, [], &auth)
        if status != errAuthorizationSuccess {
            NSLog("[SMJBS]: Authorization failed with status code \(status)")
            
            return nil
        }
        
        return auth
    }
    
    @discardableResult
    static func blessHelper(label: String, authorization: AuthorizationRef) -> Bool {
        
        var error: Unmanaged<CFError>?
        let blessStatus = SMJobBless(kSMDomainSystemLaunchd, label as CFString, authorization, &error)
        
        if !blessStatus {
            NSLog("[SMJBS]: Helper bless failed with error \(error!.takeUnretainedValue())")
        }
        
        return blessStatus
    }
}
