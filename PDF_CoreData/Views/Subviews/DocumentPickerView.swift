import SwiftUI
import UniformTypeIdentifiers
import PDFKit
import MobileCoreServices
import CoreData

//一度viewContextの受け渡し更新をなくしてみたが、なぜかError1が起きるのでどこかが間違ってる。もともとはファイルのコピーまではできていたはずだから見直してみる。


struct DocumentPickerView: UIViewControllerRepresentable {
//    @Environment(\.managedObjectContext) private var viewContext
    @Binding var fileUrl: URL?
    @Binding var localStoredUrl: URL?
    @Binding var fileTitle: String?
    @Binding var createdAt: Date?
    
//    let viewContext: NSManagedObjectContext

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        // ... other code ...
        var parent: DocumentPickerView
        
        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }
        
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
            self.parent.fileUrl = url
            copyPDFToLocalStorage(pdfURL: url) // Pass the managed object context here
//            copyPDFToLocalStorage(pdfURL: url, context: self.parent.viewContext)
        }

//        func copyPDFToLocalStorage(pdfURL: URL, context: NSManagedObjectContext) { // Add context as a parameter
        func copyPDFToLocalStorage(pdfURL: URL) { // Add context as a parameter

            let destinationURL = getDocumentsDirectory().appendingPathComponent(pdfURL.lastPathComponent)
            
            do {
                try FileManager.default.copyItem(at: pdfURL, to: destinationURL)
//                self.parent.localStoredUrl = destinationURL
//                self.parent.fileTitle = destinationURL.lastPathComponent
//                self.parent.createdAt = Date()
                self.parent.localStoredUrl = nil
                self.parent.fileTitle = "noError"
                self.parent.createdAt = nil

//                let newBook = Book(context: context) // Use the passed context here
//                newBook.title = destinationURL.lastPathComponent
//                newBook.coverImageURL = "testURL"
//                newBook.createdAt = Date()
                
                // ... your existing code ...
            } catch {
                self.parent.localStoredUrl = nil
                self.parent.fileTitle = "error1"
                self.parent.createdAt = nil
                // ... your existing code ...
            }

//            do {
//                try context.save()
//            } catch {
//                // ... your existing code ...
//                self.parent.localStoredUrl = nil
//                self.parent.fileTitle = "error2"
//                self.parent.createdAt = nil
//            }
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        // ... other code ...
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPickerViewController =  UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        documentPickerViewController.delegate = context.coordinator
        return documentPickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

//struct DocumentPickerView : UIViewControllerRepresentable {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Binding var fileUrl: URL?
//    @Binding var localStoredUrl: URL?
//    @Binding var fileTitle: String?
//    @Binding var createdAt: Date?
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var parent: DocumentPickerView
//
//        init(_ parent: DocumentPickerView) {
//            self.parent = parent
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//            self.parent.fileUrl = url
//            copyPDFToLocalStorage(pdfURL: url, context: self.parent.viewContext)
//        }
//
//        func copyPDFToLocalStorage(pdfURL: URL, context: NSManagedObjectContext) {
//            var context = self.parent.viewContext
//            let destinationURL = getDocumentsDirectory().appendingPathComponent(pdfURL.lastPathComponent)
//
//            do {
//                try FileManager.default.copyItem(at: pdfURL, to: destinationURL)
//                self.parent.localStoredUrl = destinationURL
//                self.parent.fileTitle = destinationURL.lastPathComponent
//                self.parent.createdAt = Date()
//
////                @Published var updateItem : SampleData!
//
//                let newBook = Book(context: context)
//                newBook.title = destinationURL.lastPathComponent
//                newBook.coverImageURL = "testURL"
//                newBook.createdAt = Date()
//
//            } catch {
//                self.parent.localStoredUrl = nil
//                self.parent.fileTitle = "error1"
//                self.parent.createdAt = nil
//            }
//
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
////                let nsError = error as NSError
////                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                self.parent.localStoredUrl = nil
//                self.parent.fileTitle = "error2"
//                self.parent.createdAt = nil
//            }
//        }
//
//        func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            return paths[0]
//        }
//
//    }
//
//
//
//    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
//        let documentPickerViewController =  UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
//        documentPickerViewController.delegate = context.coordinator
//        return documentPickerViewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//}
//
//
//
//
//
//
//
