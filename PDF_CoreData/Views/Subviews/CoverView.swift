import SwiftUI

struct CoverView: View {
    var image: Image
    var title: String
    
    var body: some View {
        VStack(alignment: .center, spacing:0, content: {
            //MARK: Image
            image
                .resizable()
                .scaledToFit()
            //MARK: Footer
            HStack(alignment: .center, spacing: 20, content: {
                Text(title)
                    .font(.system(size: 10))
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.system(size: 10))
            })
            .padding(.all, 6)
        })
    }
}


struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView(image: Image("bookcover1"), title:("Harry Potter"))
    }
}
