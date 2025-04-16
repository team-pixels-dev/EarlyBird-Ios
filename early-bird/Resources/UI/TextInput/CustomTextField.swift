import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    var fontSize: CGFloat = 16
    var cornerRadius: CGFloat = 8
    var borderColor: Color = .secondary
    var placeholderColor: Color = .gray
    var width: CGFloat? = nil
    var height: CGFloat = 44

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .font(.custom("Pretendard-Regular", size: fontSize))
                    .padding(.leading, 8)
            }

            TextField("", text: $text)
                .font(.custom("Pretendard-Regular", size: fontSize))
                .padding(8)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor)
                )
        }
        .frame(width: width, height: height)
    }
}
