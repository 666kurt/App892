import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack(spacing: 16) {
            
            Image("profilePerson")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.7)
                .scaledToFit()
                .ignoresSafeArea()
                .overlay(photoPicker, alignment: .bottom)
            
            nameTextField
            
            Spacer()
            Spacer()
            
            VStack(spacing: 12) {
                ProfileButtonsView(title: "Contact us",
                                   image: "bubble.fill",
                                   url: "https://www.termsfeed.com/live/368771ae-d435-4f3a-87ed-b86d40cb8278",
                                   isLink: true)
                ProfileButtonsView(title: "Terms of use",
                                   image: "list.bullet.rectangle.portrait",
                                   url: "https://www.termsfeed.com/live/368771ae-d435-4f3a-87ed-b86d40cb8278",
                                   isLink: true)
                ProfileButtonsView(title: "Privacy",
                                   image: "shield.fill",
                                   url: "https://www.termsfeed.com/live/777d1ea3-7bf4-4945-9756-b2da2221b1f5",
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
        .onTapGesture {
            hideKeyboard()
        }
        .ignoresSafeArea()
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
                    .scaledToFill()
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
        .offset(y: 68)
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
        .padding(.top, 68)
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(ProfileViewModel())
        .environmentObject(Router.shared)
}
