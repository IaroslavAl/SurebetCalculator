import AnalyticsManager
import SDWebImageSwiftUI
import SwiftUI

struct BannerView: View {
    let link = "https://www.rebelbetting.com/valuebetting?x=surebet_profit&a_bid=c3ecdf4b"

    @State
    private var isPresented: Bool = true

    var body: some View {
        if isPresented {
            WebImage(url: .init(string: url))
                .resizable()
                .scaledToFit()
                .cornerRadius(cornerRadius)
                .onTapGesture {
                    openURL(link)
                    AnalyticsManager.log(name: "ClickingOnAnAdvertisement")
                }
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black.opacity(0.25))
                        .padding(8)
                        .contentShape(.rect)
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

    var url: String {
        if iPad {
            "https://affiliates.rebelbetting.com/accounts/default1/banners/1ab8d504.jpg"
        } else {
            "https://affiliates.rebelbetting.com/accounts/default1/banners/c3ecdf4b.gif"
        }
    }
}

#Preview {
    BannerView()
}
