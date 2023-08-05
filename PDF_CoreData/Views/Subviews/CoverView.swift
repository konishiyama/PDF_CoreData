import SwiftUI

struct CoverView: View {
    var image: Image
    var title: String
    var url: URL
    
    var body: some View {
        VStack(alignment: .center, spacing:0, content: {
            //MARK: Image
            NavigationLink {
                BrowseView(url:url)
            } label: {
                image
                    .resizable()
                    .scaledToFit()
            }
            
            //MARK: Footer
            HStack(alignment: .center, spacing: 20, content: {
                Text(title)
                    .lineLimit(1) 
                    .font(.system(size: 15))
                    .padding(.top, 10)
                Spacer()
                Menu {
                    Button(action: shareBook) {
                        Label("PDF 공유", systemImage: "square.and.arrow.up")
                    }
                    Button(action: changeName) {
                        Label("이름 변경", systemImage: "pencil")
                    }
                    Button(action: likeBook) {
                        Label("찜한 책에 추가", systemImage: "star")
                    }
                    Button(role: .destructive, action: deleteBook) {
                        Label("제거", systemImage: "trash")
                    }
                                
                } label: {
                        Label("", systemImage: "ellipsis")
                            .font(.system(size: 15))
                    }
            })
//            .padding(.all, 6)
        })
    }
    
    func shareBook() { }
    func likeBook(){}
    func changeName() { }
    func deleteBook(){}
}


//struct CoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoverView(image: Image("bookcover1"), title:("Harry Potter"), url: )
//    }
//}


struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        if let pdfUrl = Bundle.main.url(forResource: "data2vec", withExtension: "pdf") {
            CoverView(image: Image("bookcover1"), title:("Harry Potter"), url: pdfUrl)
                .previewDevice("iPhone 12 Pro")
        } else {
            Text("PDF file not found")
        }
    }
}
