import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack(spacing: 16) {
            
            Image("profilePerson")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .overlay(photoPicker, alignment: .bottom)
            
            nameTextField
            
            Spacer()
            Spacer()
            
            VStack(spacing: 12) {
                ProfileButtonsView(title: "Contact us",
                                   image: "bubble.fill",
                                   url: "https://google.com",
                                   isLink: true)
                ProfileButtonsView(title: "Terms of use",
                                   image: "list.bullet.rectangle.portrait",
                                   url: "https://google.com",
                                   isLink: true)
                ProfileButtonsView(title: "Privacy",
                                   image: "shield.fill",
                                   url: "https://google.com",
                                   isLink: true)
                
                ProfileButtonsView(title: "Settings",
                                   image: "gearshape.fill",
                                   url: "",
                                   isLink: false)
                
                Spacer()
            }
            .vstackModifier()
            
        }
        .sheet(item: $router.sheet) { sheet in
            router.build(sheet: sheet) { image in
                profileViewModel.profileImage = image
            }
        }
    }
}


extension ProfileScreen {
    
    private var photoPicker: some View {
        
        ZStack {
            Circle()
                .frame(width: 136, height: 136)
                .foregroundColor(.accentColor)
            
            if let image = profileViewModel.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 136, height: 136)
                    .clipShape(Circle())
            } else {
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 66, height: 53)
                    .foregroundColor(.theme.text.textWhite)
            }
            
        }
        .onTapGesture {
            router.present(sheet: .imagePicker)
        }
        
    }
    
    private var nameTextField: some View {
        VStack(spacing: 0) {
            
            TextField("Name", text: $profileViewModel.name)
                .frame(width: 146)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .font(.title3.weight(.semibold))
                .foregroundColor(.accentColor)
                .padding(.bottom, 16)
            
            
            
            Rectangle()
                .frame(width: 146, height: 1)
                .foregroundColor(.theme.background.bgMediumGray)
        }
    }
    
}

#Preview {
    ProfileScreen()
        .environmentObject(ProfileViewModel())
        .environmentObject(Router.shared)
}
