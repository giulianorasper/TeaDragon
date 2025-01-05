//
//  PrivacyPolicyView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 05.01.25.
//
import SwiftUI
import WebKit
import Foundation

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Privacy Policy for the \"Tea Dragon\" App")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Text("Effective: January 2025")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                SectionHeader("1. Data Controller")
                Text("""
                The data controller as defined by the GDPR for the processing of personal data is:

                \(AppConstants.developerName)
                Email: \(AppConstants.contactEmail)
                """)

                SectionHeader("2. Data Processing in the App")
                Text("""
                a. Tea Configurations
                The \"Tea Dragon\" app allows you to save tea configurations (such as types of tea, steeping times, temperatures) locally on your device. These data are stored offline and remain on your device. There is no transmission, processing, or storage of these data on external servers or by us as the app provider.

                b. Crash Reports
                In the event of crashes or technical issues, automatically generated crash reports may be sent from your device to Apple. These reports may include information such as device type, operating system version, and app state at the time of the crash. These data are processed by Apple and are subject to their privacy policy.
                [More information: Apple Privacy Policy](https://www.apple.com/privacy/)
                """)

                SectionHeader("3. Data Sharing")
                Text("""
                Your data is not shared with third parties by us as the app provider. All data stored locally remains exclusively on your device.
                """)

                SectionHeader("4. Legal Basis for Data Processing")
                Text("""
                The storage of tea configurations is carried out exclusively on your device and does not require consent under the GDPR, as no personal data are processed. Crash reports are processed under Article 6(1)(f) GDPR, as they are necessary for error analysis and app improvement.
                """)

                SectionHeader("5. Your Rights")
                Text("""
                Under the GDPR, you have the right to:
                - Access information about the data stored about you (Article 15 GDPR),
                - Rectify inaccurate data (Article 16 GDPR),
                - Erase your data (Article 17 GDPR),
                - Restrict processing (Article 18 GDPR),
                - Object to data processing (Article 21 GDPR).

                Since the app does not store personal data, these rights are generally not applicable. However, if you have questions regarding your rights, feel free to contact us.
                """)

                SectionHeader("6. Data Security")
                Text("""
                We implement technical and organizational measures to ensure the security of the app and your locally stored data. Nevertheless, we recommend regularly backing up your data and ensuring that your devices are protected by passwords or other security mechanisms.
                """)

                SectionHeader("7. Changes to the Privacy Policy")
                Text("""
                We reserve the right to adjust this privacy policy in the event of changes to the app or applicable legal requirements. The current version can be found in the app settings.
                """)

                Text("""
                If you have any further questions about data protection in the \"Tea Dragon\" app, please contact us at the email address provided above.
                
                Thank you for trusting our app!
                """)
                .italic()
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct SectionHeader: View {
    private var key: LocalizedStringKey
    
    init(_ key: LocalizedStringKey) {
        self.key = key
    }
    
    var body: some View {
        Text(key)
            .font(.headline)
            .foregroundColor(.accentColor)
            .padding(.vertical, 4)
    }
}


#Preview {
    PrivacyPolicyView()
}
