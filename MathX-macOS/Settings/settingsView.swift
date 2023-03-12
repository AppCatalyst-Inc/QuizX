import SwiftUI
import GoogleSignIn

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @AppStorage("exitedSignIn", store: .standard) var exitedSignIn = Bool()
    @AppStorage("isLoggedIn", store: .standard) var isLoggedIn = Bool()
    
    @AppStorage("notificationsEnabled", store: .standard) private var notificationsEnabled = Bool()
    
    @AppStorage("isDarkMode") var isDarkMode = 1
    
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser // retrieves user information
    }
    
    var body: some View {
        VStack {
            if let userProfile = user?.profile {
                Text("Settings")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.leading, 20)
                
                Form {
                    Section(header:
                                HStack {
                        Image(systemName: "person")
                        Text("Account")
                    }
                        .font(.title3)
                        .fontWeight(.bold)
                    ) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                HStack {
                                    UserProfileImageView(userProfile: userProfile)
                                        .frame(width: 64, height: 64)
                                        .padding(.leading)
                                    
                                    VStack(alignment: .leading) {
                                        Text(userProfile.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text(userProfile.email)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                    }
                                    .padding(.leading)
                                }
                                
                                Spacer()
                                
                                Button {
                                    authViewModel.signOut()
                                    isLoggedIn = false
                                    exitedSignIn = false
                                } label: {
                                    HStack {
                                        Image(systemName: "person.crop.circle.badge.xmark")
                                        Text("Log Out")
                                    }
                                    .foregroundColor(.red)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .modifier(FlatGlassView())
                                }
                                .buttonStyle(.plain)
                                .padding(.trailing)
                            }
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
                            Picker(selection: $isDarkMode, label: Text("Theme")) {
                                Text("Light").tag(1)
                                Text("Dark").tag(0)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .formStyle(.grouped)
            } else {
                Button {
                    authViewModel.signOut()
                    isLoggedIn = false
                    exitedSignIn = false
                } label: {
                    Text("An error occurred while trying to retrieve your account's information. Log out.")
                }
            }
        }
        .padding(.horizontal, 19)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
