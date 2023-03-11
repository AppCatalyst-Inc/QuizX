import SwiftUI

struct SettingsView: View {
    
    @State private var notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    @State private var email = UserDefaults.standard.string(forKey: "email") ?? ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Notification Settings")
                    .font(.headline)
                Toggle(isOn: $notificationsEnabled) {
                    Text("Enable Notifications")
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Account Settings")
                    .font(.headline)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Appearance")
                    .font(.headline)
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
            
            Button(action: {
                saveSettings()
            }) {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 400)
        .onAppear {
            NSApp.windows.first?.backgroundColor = NSColor.controlBackgroundColor
        }
    }
    
    private func saveSettings() {
        UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
        UserDefaults.standard.set(email, forKey: "email")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
