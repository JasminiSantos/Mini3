import SwiftUI
import UIKit

struct CameraCaptureView: View {
    struct Constants {
      static let AzulEscuro: Color = Color(red: 0, green: 0.21, blue:0.35)
      static let AzulClaro: Color = Color(red: 0.42, green: 0.6, blue: 0.77)
      static let Branco: Color = Color(red: 0.94, green: 0.95, blue: 0.95)

    }
    
    @State private var isShowingImagePicker = false
    @State private var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
                
                
                ZStack {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 170)
                        .cornerRadius(360)
                        .overlay(
                            RoundedRectangle(cornerRadius: 360)
                                .inset(by: -7)
                                .stroke(Constants.AzulClaro, lineWidth: 7)
                        )
                }
                .padding(.bottom, 60)
                .padding(.leading, 60)
                
                
                
            } else {
                ZStack {
                    //BOTÃO DE ADD IMAGEM
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 170)
                        .background(.white)
                        .cornerRadius(360)
                        .overlay(
                            RoundedRectangle(cornerRadius: 360)
                                .inset(by: -7)
                                .stroke(Constants.AzulClaro, lineWidth: 7)
                        )
                    
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(Color(red: 0.8, green: 0.86, blue: 0.92))
                    
                    Button(action: {
                        isShowingImagePicker.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Constants.Branco)
                            .frame(width: 60, height: 60)
                            .background(Constants.AzulClaro)
                            .cornerRadius(360)
                    }
                    .padding(.top, 130)
                    .padding(.trailing, 100)
                }
                .padding(.bottom, 60)
                .padding(.leading, 60)
            }

//            Button("Tirar Foto") {
//                isShowingImagePicker.toggle()
//            }
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            // A ação aqui é executada quando a folha é descartada.
        }) {
            ImagePicker(image: $image)
        }
    }
}

struct CameraCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        CameraCaptureView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            } else {
                parent.image = nil
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.image = nil
            
            picker.dismiss(animated: true)
        }
    }
}
