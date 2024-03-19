//
//  TreeView.swift
//  testTask
//
//  Created by Ahror Jabborov on 3/19/24.
//

import SwiftUI
import RealmSwift

struct TreeView: View {
    @ObservedObject var viewModel: TreeViewModel
    var node: Node
    
    var body: some View {
        List {
            ForEach(node.children, id: \.id) { child in
                NavigationLink(destination: TreeView(viewModel: viewModel, node: child)) {
                    Text(child.name)
                }
            }
            .onDelete(perform: deleteChildren)
        }
        .navigationTitle(node.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.addChild(to: node)
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    private func deleteChildren(at offsets: IndexSet) {
        print(offsets)
        viewModel.removeChildren(from: node, at: offsets)
    }
}
