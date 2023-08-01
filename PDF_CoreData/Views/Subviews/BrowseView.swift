import SwiftUI
import PDFKit

struct BrowseView: View {
    // Creating a URL for the PDF and saving it in the pdfUrl variable
    let pdfUrl = Bundle.main.url(forResource: "data2vec", withExtension: "pdf")!
    
    var body: some View {
        VStack{
//            Text("PDF Viewer")
//                .foregroundColor(.accentColor)
            // Using the PDFKitView and passing the previously created pdfURL
            PDFKitView(url: pdfUrl)
//                .scaledToFit()
            
        }
    }
    
}






struct PDFKitView: UIViewRepresentable {
    let url: URL // new variable to get the URL of the document

    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        // Creating a new PDFVIew and adding a document to it
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        // we will leave this empty as we don't need to update the PDF
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
