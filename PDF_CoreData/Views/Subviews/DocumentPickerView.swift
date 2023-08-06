import SwiftUI
import UniformTypeIdentifiers
import PDFKit
import MobileCoreServices
import CoreData


struct DocumentPickerView: UIViewControllerRepresentable {

    let viewContext: NSManagedObjectContext

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPickerView
        
        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }
        
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
            copyPDFToLocalStorage(pdfURL: url, context: self.parent.viewContext)
        }
        
        
        func copyPDFToLocalStorage(pdfURL: URL, context: NSManagedObjectContext) {
            let destinationURL = getDocumentsDirectory().appendingPathComponent(pdfURL.lastPathComponent)
            
            do {
                try FileManager.default.copyItem(at: pdfURL, to: destinationURL)
                let newBook = Book(context: context)
                newBook.title = destinationURL.lastPathComponent
                newBook.coverImageURL = "testURL"
                newBook.createdAt = Date()
                newBook.url = destinationURL
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
