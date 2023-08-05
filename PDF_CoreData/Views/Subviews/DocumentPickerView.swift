import SwiftUI
import UniformTypeIdentifiers
import PDFKit
import MobileCoreServices
import CoreData


struct DocumentPickerView: UIViewControllerRepresentable {
//    @Binding var fileUrl: URL?
//    @Binding var localStoredUrl: URL?
//    @Binding var fileTitle: String?
//    @Binding var createdAt: Date?
    
    let viewContext: NSManagedObjectContext

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPickerView
        
        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }
        
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//            self.parent.fileUrl = url
            copyPDFToLocalStorage(pdfURL: url, context: self.parent.viewContext)
        }
        
        
        func copyPDFToLocalStorage(pdfURL: URL, context: NSManagedObjectContext) {
            let destinationURL = getDocumentsDirectory().appendingPathComponent(pdfURL.lastPathComponent)
            
            do {
                try FileManager.default.copyItem(at: pdfURL, to: destinationURL)
//                self.parent.localStoredUrl = destinationURL
//                self.parent.fileTitle = destinationURL.lastPathComponent
//                self.parent.createdAt = Date()

                let newBook = Book(context: context)
                newBook.title = destinationURL.lastPathComponent
                newBook.coverImageURL = "testURL"
                newBook.createdAt = Date()
                newBook.url = destinationURL
                
            } catch {
//                self.parent.localStoredUrl = nil
//                self.parent.fileTitle = "error1"
//                self.parent.createdAt = nil
            }

            do {
                try context.save()
            } catch {
//                self.parent.localStoredUrl = nil
//                self.parent.fileTitle = "error2"
//                self.parent.createdAt = nil
            }
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
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
