//import SwiftUI
//
//struct GridView: View {
//    let items: [String]
//
//    var body: some View {
//        ScrollView{
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
//                ForEach(items, id: \.self) { item in
//                    CoverView(image: Image("bookcover1"), title: "Harry Potter", url: "test")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .padding(15)
//                }
//            }
//        }
//    }
//}
//
//
//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView(items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"])
//    }
//}
