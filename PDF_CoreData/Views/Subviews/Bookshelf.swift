import SwiftUI

struct Bookshelf: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
       entity: Book.entity(),
       sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)],
       animation: .default
    ) var fetchedBookList: FetchedResults<Book>
    
//    @StateObject var reportsVM: ProjectReportViewModel
    @State var add = false
    @State var open = false
    @State var added = false
    @State var inCloud = false
    
    
    @State private var fileUrl: URL?
    @State private var localStoredUrl: URL?
    @State private var fileTitle: String?
    @State private var createdAt: Date?
    @State private var showingPicker = false
    
    var body: some View {
        NavigationView{
            ScrollView{
//                Button {
//                    let documentDirectoryUrl = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first!
//                    let fileUrl = documentDirectoryUrl.appendingPathComponent("snorlax.txt")
//                    try! "I Love Snorlax!".data(using: .utf8)!.write(to: fileUrl, options: .atomic)
//                } label: {
//                    Text("Save File to Document")
//                }
                Text("FileUrl: \(fileUrl?.description ?? "nil")")
                Text("Hello")
                Text("storedAt: \(localStoredUrl?.description ?? "nil")")
                Text("Hello")
                Text("Filetitle: \(fileTitle ?? "nil")")
                Text("Hello")
                Text("createdAt: \(dateFomatter(date: createdAt ?? Date()))")
                
                
                // Use LazyVGrid to create a grid with 2 columns
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(fetchedBookList, id: \.self) { book in
                        CoverView(image: Image("bookcover1"), title: book.title ?? "No Title")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(15)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Documents")
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
            DocumentPickerView(fileUrl: $fileUrl, localStoredUrl: $localStoredUrl, fileTitle: $fileTitle, createdAt: $createdAt)
//            DocumentPickerView(fileUrl: $fileUrl, localStoredUrl: $localStoredUrl, fileTitle: $fileTitle, createdAt: $createdAt, viewContext: viewContext)
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
