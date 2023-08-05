//
//  ContentView.swift
//  PDF_CoreData
//
//  Created by KO NISHIYAMA on 2023/07/29.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
       @FetchRequest(
           entity: Book.entity(),
           sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)],
           animation: .default
       ) var fetchedBookList: FetchedResults<Book>

    var body: some View {
        let testUrl: URL = URL(string: "testUrl")!
        TabView {
            NavigationView{
                BrowseView(url: testUrl)
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("읽기")
                }
            NavigationView{
                Bookshelf()
            }
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("보관함")
                }

            Text("검색")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }

            Text("프로필")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




