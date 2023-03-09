import SwiftUI

struct settingsView: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Settings") // title
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.vertical, 30)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                  
                    // settings view here
                    
                }
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct settingsView_Previews: PreviewProvider {
    static var previews: some View {
        settingsView()
    }
}
