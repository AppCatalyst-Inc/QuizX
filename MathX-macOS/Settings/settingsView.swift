import SwiftUI

struct SettingsView: View {
    
    @AppStorage("notificationsEnabled", store: .standard) private var notificationsEnabled = Bool()
    @AppStorage("email", store: .standard) private var email = String()

    var body: some View {
        VStack {
            
            Text("Settings")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 30)
                .padding(.leading, 10)
            
            Form {
                Section(header:
                            HStack {
                    Image(systemName: "person")
                    Text("Account Settings")
                }
                    .font(.title3)
                    .fontWeight(.bold)
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                Section(header:
                            HStack {
                    Image(systemName: "app.badge")

                    Text("Notifications")
                }
                    .font(.title3)
                    .fontWeight(.bold)
                        
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle(isOn: $notificationsEnabled) {
                            Text("Enable Notifications")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                    }
                }
                
                Section(header: HStack {
                    Image(systemName: "light.max")
                    Text("Appearance")
                }
                    .font(.title3)
                    .fontWeight(.bold)
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        Picker(selection: .constant(0), label: Text("Theme")) {
                            Text("Light").tag(0)
                            Text("Dark").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Picker(selection: .constant(1), label: Text("Font Size")) {
                            Text("Small").tag(0)
                            Text("Medium").tag(1)
                            Text("Large").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section() {
                    Button(role: .destructive) {
                        // log out action
                    } label: {
                        Text("Log Out")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color(NSColor.windowBackgroundColor))
                            .cornerRadius(16)
                    }
                    .buttonStyle(.plain)
                }
                
            }
            .scrollContentBackground(.hidden)
            .formStyle(.grouped)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
