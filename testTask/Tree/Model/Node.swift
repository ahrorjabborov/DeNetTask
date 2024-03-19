//
//  Node.swift
//  testTask
//
//  Created by Ahror Jabborov on 3/19/24.
//

import Foundation
import RealmSwift

class Node: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var children = List<Node>()
    @Persisted(originProperty: "children") var parent: LinkingObjects<Node>

    convenience init(name: String) {
        self.init()
        self.name = name
    }

    static func generateRandomName() -> String {
        let bytes = (0..<20).map { _ in UInt8.random(in: 0...255) }
        return bytes.map { String(format: "%02x", $0) }.joined()
    }
}
