//
//  TreeViewModel.swift
//  testTask
//
//  Created by Ahror Jabborov on 3/19/24.
//

import SwiftUI
import RealmSwift

class TreeViewModel: ObservableObject {
    private var realm: Realm?
    @Published var rootNode: Node?
    
    init() {
        do {
            let config = Realm.Configuration(schemaVersion: 4, 
                                             migrationBlock: { _, _ in },
                                             deleteRealmIfMigrationNeeded: true)
            
            Realm.Configuration.defaultConfiguration = config
            let realm = try Realm()
            self.realm = realm
        } catch {
            print("Realm initialization failed: \(error.localizedDescription)")
            self.realm = nil
        }
        
        loadTree()
    }
    
    private func loadTree() {
        guard let realm = self.realm else { return }
        if let root = realm.objects(Node.self).filter("parent.@count == 0").first {
            DispatchQueue.main.async {
                self.rootNode = root
            }
        } else {
            let newRootNode = Node(name: "Root")
            try? realm.write {
                realm.add(newRootNode)
            }
            DispatchQueue.main.async {
                self.rootNode = newRootNode
            }
        }
    }
    func addChild(to node: Node, name: String = Node.generateRandomName()) {
        guard let realm = self.realm else { return }
        let newNode = Node(name: name)
        
        try? realm.write {
            node.children.append(newNode)
        }
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func removeChildren(from node: Node, at offsets: IndexSet) {
        guard let realm = self.realm else { return }
        
        try? realm.write {
            offsets.forEach { index in
                if index < node.children.count {
                    let childToDelete = node.children[index]
                    realm.delete(childToDelete)
                }
            }
        }
    }
}
