//Copyright 2018 Idealnaya rabota LLC
//Licensed under Multy.io license.
//See LICENSE for details

import UIKit
import Foundation
import SocketIO

class Socket: NSObject {
    static let shared = Socket()
    var scManager : SocketManager
    var socket : SocketIOClient
    
    var socketUrl = "ws://hack.multy.io"

    override init() {
        //dev:  6680
        //prod: 7780
        scManager = SocketManager(socketURL: URL(string: socketUrl)!, config: [.log(true), .compress, .forceWebsockets(true), .reconnectAttempts(3), .forcePolling(false), .secure(false)])
        socket = scManager.defaultSocket
    }
    
    
    func start() {
        //            let header = ["userID": account!.userID,
        //                          "deviceType": "\(account!.deviceType)",
        //                "jwtToken": account!.token]
        //
//        self.scManager = SocketManager(socketURL: URL(string: self.socketUrl)!, config: [.log(true), .compress, .forceWebsockets(true), .reconnectAttempts(3), .forcePolling(false), .extraHeaders(nil), .secure(false)])
        
        self.scManager = SocketManager(socketURL: URL(string: self.socketUrl)!)
        
        self.socket = self.scManager.defaultSocket
        
        //        let socket = manager.defaultSocket
        
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.getExchangeReq()
        }
        
//        self.socket.on("exchangeAll") {data, ack in
//            //                print("-----exchangeAll: \(data)")
//        }
//        //"exchangeUpdate"
//        self.socket.on("exchangePoloniex") {data, ack in
//            //                print("-----exchangeUpdate: \(data)")
//            if !(data is NSNull) {
//                //MARK: uncomment
//                //                    let course = ((data[0] as! NSDictionary)["btc_usd"] as! NSNumber).doubleValue
//                //                    if course > 0 {
//                //                        exchangeCourse = course
//                //                    }
//            }//"BTCtoUSD"
//        }
//
//        self.socket.on("btcTransactionUpdate") { data, ack in
//            print("-----btcTransactionUpdate: \(data)")
//
//            NotificationCenter.default.post(name: NSNotification.Name("transactionUpdated"), object: nil)
//        }
        
//        self.socket.on("currentAmount") {data, ack in
//            guard let cur = data[0] as? Double else { return }
//
//            self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
//                self.socket.emit("update", ["amount": cur + 2.50])
//            }
//
//            ack.with("Got your currentAmount", "dude")
//        }
        
        self.socket.connect()
    }
    
    func getExchangeReq() {
        let abc = NSDictionary(dictionary: ["From": "USD",
                                            "To": "BTC"]).socketRepresentation()
        
        socket.emitWithAck("/getExchangeReq", abc).timingOut(after: 0) { (data) in
            //            print("\n\n\n\n\n\n\n")
            //            print(data)
            //            print("\n\n\n\n\n\n\n")
        }
    }
    
}
