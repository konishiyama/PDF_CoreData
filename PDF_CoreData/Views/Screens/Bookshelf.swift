import SwiftUI

struct Bookshelf: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
       entity: Book.entity(),
       sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)],
       animation: .default
    ) var fetchedBookList: FetchedResults<Book>
    
    @State var add = false
    @State var open = false
    @State var added = false
    
    @State private var fileUrl: URL?
    @State private var showingPicker = false

    let pdfUrl = Bundle.main.url(forResource: "data2vec", withExtension: "pdf")!
    
    var body: some View {
        NavigationView{
            ScrollView{
                // Use LazyVGrid to create a grid with 2 columns
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
//                    ForEach(fetchedBookList, id: \.self) { book in
//                        CoverView(image: Image("bookcover1"), title: book.title ?? "No Title", url: book.url ?? pdfUrl)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .padding(15)
//                    }
//                }
                let fetchedLength: String = String(fetchedBookList.count)
                Text(fetchedLength)
//                ForEach(fetchedBookList, id: \.self) { book in
//                    Text(book.title ?? "not title")
//                }
                .navigationBarTitle("Bookshelf", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("")
                            .bold()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            add = true
                        } label: {
                            Image(systemName: "doc.badge.plus")
                        }
                    }
                }
                
            }
        }
        .sheet(isPresented: $add, content: {
            DocumentPickerView(viewContext: viewContext)
        })

    }
}

func dateFomatter(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

    return dateFormatter.string(from: date)
}

struct Bookshelf_Previews: PreviewProvider {
    static var previews: some View {
        Bookshelf().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
