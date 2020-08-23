
import SwiftUI

struct LoadingView: View {

    @State var putar: Bool = false

    var body: some View {
        ZStack {
            Image("spinner").resizable().frame(width: 100, height: 100)
                .rotationEffect(.degrees(putar ? 0 : -360))
                .animation(Animation
                .linear(duration: 0.2)
                .repeatForever(autoreverses: false))
        }.onAppear { self.putar.toggle() }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
