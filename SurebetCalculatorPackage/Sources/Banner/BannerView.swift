import AnalyticsManager
import SDWebImageSwiftUI
import SwiftUI

struct BannerView: View {
    let imageUrl = "https://breaking-bet.com/banners/en/gif/BreakingBet_banner1_600x200_en.gif"
    let link = "https://breaking-bet.com/?r=85294"

    @State
    private var isPresented: Bool = true

    var body: some View {
        if isPresented {
            WebImage(url: .init(string: imageUrl))
                .resizable()
                .scaledToFit()
                .cornerRadius(cornerRadius)
                .onTapGesture {
                    openURL(link)
                    AnalyticsManager.log(name: "ClickingOnAnAdvertisement")
                }
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray.opacity(0.25))
                        .padding(8)
                        .onTapGesture {
                            isPresented = false
                            AnalyticsManager.log(name: "CloseBanner")
                        }
                }
        }
    }
}

private extension BannerView {
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var cornerRadius: CGFloat { iPad ? 15 : 10 }

    func openURL(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    BannerView()
}
