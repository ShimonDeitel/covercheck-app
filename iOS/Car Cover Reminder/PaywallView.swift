import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 48))
                        .foregroundStyle(Theme.accent)
                    Text("Car Cover Reminder Pro")
                        .font(Theme.titleFont)
                        .foregroundStyle(Theme.textPrimary)
                    Text("Weather-based reminder scheduling and storage checklist")
                        .font(Theme.bodyFont)
                        .foregroundStyle(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    Button {
                        Task {
                            await purchases.purchase()
                            if purchases.isPro { dismiss() }
                        }
                    } label: {
                        Text(purchases.product != nil ? "Unlock for \(purchases.product!.displayPrice)" : "Unlock Pro")
                            .font(Theme.headlineFont)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accent)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .accessibilityIdentifier("unlockProButton")
                    .padding(.horizontal)

                    Button("Not now") { dismiss() }
                        .accessibilityIdentifier("dismissPaywallButton")
                        .foregroundStyle(Theme.textSecondary)
                }
                .padding()
            }
        }
    }
}
