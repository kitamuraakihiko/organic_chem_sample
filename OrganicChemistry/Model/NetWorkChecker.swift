//
//  NetWorkChecker.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2022/01/02.
//

import Network

struct NetWorkChecker {

    static var shared = NetWorkChecker()
    private let monitor = NWPathMonitor()
    var delegate: NetWorkCheckerDelegate?
    
    func setUp() {
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                DispatchQueue.main.sync {
                    NetWorkChecker.shared.delegate?.netWorkSatisfied()
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func stop() {
        monitor.cancel()
    }
    
    func isOnline() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}

protocol NetWorkCheckerDelegate {
    func netWorkSatisfied()
}
