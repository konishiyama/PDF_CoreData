import SwiftUI
import UniformTypeIdentifiers
import PDFKit
import MobileCoreServices

struct DocumentPickerView : UIViewControllerRepresentable {
    @Binding var fileUrl: URL?
    @Binding var localStoredUrl: URL?
    @Binding var fileTitle: String?
    @Binding var createdAt: Date?
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Environment(\.managedObjectContext) private var viewContext
        var parent: DocumentPickerView
        
        init(_ parent: DocumentPickerView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
            self.parent.fileUrl = url
            copyPDFToLocalStorage(pdfURL: url)
        }
        
        func copyPDFToLocalStorage(pdfURL: URL) {
            let destinationURL = getDocumentsDirectory().appendingPathComponent(pdfURL.lastPathComponent)

            do {
                try FileManager.default.copyItem(at: pdfURL, to: destinationURL)
                self.parent.localStoredUrl = destinationURL
                self.parent.fileTitle = destinationURL.lastPathComponent
                self.parent.createdAt = Date()
                
//                let newBook = Book(context: viewContext)
//                newBook.title = destinationURL.lastPathComponent
////                newBook.coverImageURL =
//                newBook.createdAt = Date()
            } catch {
//                print("Error copying PDF: \(error)")
            }
            
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
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
