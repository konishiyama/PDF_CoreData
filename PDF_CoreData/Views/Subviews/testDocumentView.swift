//
//  testDocumentView.swift
//  PDF_CoreData
//
//  Created by KO NISHIYAMA on 2023/08/01.
//

import SwiftUI

struct testDocumentView: View {
    @State private var fileUrl: URL?
    @State private var showingPicker = false
    
    var body: some View {
        VStack {
            Button {
                let documentDirectoryUrl = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first!
                let fileUrl = documentDirectoryUrl.appendingPathComponent("snorlax.txt")
                try! "I Love Snorlax!".data(using: .utf8)!.write(to: fileUrl, options: .atomic)
            } label: {
                Text("Save File to Document")
            }
            
            Button {
                showingPicker = true
            } label: {
                Text("Show File Picker")
            }
            
            Text("FileUrl: \(fileUrl?.description ?? "nil")")
        }
        .sheet(isPresented: $showingPicker) {
            DocumentPickerView(fileUrl: $fileUrl)
        }
    }
}

struct testDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        testDocumentView()
    }
}
