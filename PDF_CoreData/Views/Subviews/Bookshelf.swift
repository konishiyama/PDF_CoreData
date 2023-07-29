import SwiftUI

struct Bookshelf: View {
    @Environment(\.managedObjectContext) private var viewContext
       @FetchRequest(
           entity: Book.entity(),
           sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)],
           animation: .default
       ) var fetchedBookList: FetchedResults<Book>
    
    
    var body: some View {
        ScrollView{
            // Use LazyVGrid to create a grid with 2 columns
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(fetchedBookList, id: \.self) { book in
                    NavigationLink {
                        BrowseView()
                    } label: {
                        CoverView(image: Image("bookcover1"), title: book.title ?? "No Title")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(15)
                    }
                }
            }
        }
    }
}


struct Bookshelf_Previews: PreviewProvider {
    static var previews: some View {
        Bookshelf().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
