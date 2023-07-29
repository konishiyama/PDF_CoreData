import SwiftUI

struct GridView: View {
    let items: [String] // Replace [String] with the type of data you want to display in the grid

    var body: some View {
        // Use LazyVGrid to create a grid with 2 columns
//        Text("hello")
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(items, id: \.self) { item in
                    // Replace this with the view representing each item in the grid
                    // For example, if items is [String], you can use Text(item) to display the text
                    CoverView(image: Image("bookcover1"), title: "Harry Potter")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(15)
                }
            }
        }
    }
}


struct GridView_Previews: PreviewProvider {
//    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8"]
    
    static var previews: some View {
        GridView(items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"])
    }
}
