//
//  K.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2021/12/16.
//

import UIKit

struct K {
    struct Color {
        static let accent = UIColor(named: "AccentColor")!
        static let accentBrighter = UIColor(named: "AccentColorBrighter")!
    }
    
    struct Purchase {
        static let isPurchased = "isPurchased"
        static let productId = "XXXXX"
        static let sharedSecret = "XXXXX"
    }
    
    struct ListVC {
        static let cellId = "ListVCCell"
    }
    
    struct Segue {
        static let listVCtoOfferVC = "ListVCtoOfferVC"
        static let SettingVCtoOfferVC = "SettingVCtoOfferVC"
        static let StartVCtoTabBarController = "StartVCtoTabBarController"
        static let TabBarControllertoExplainVC = "TabBarControllertoExplainVC"
    }
    
    struct LinkStrings {
        static let appleEULA = "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"
        static let appSuppet = "https://sites.google.com/view/kchem/%E3%83%9B%E3%83%BC%E3%83%A0"
    }
    
    struct Informationtext {
        static let subscriptionExplainText = """
・サブスクリプションのキャンセルはAppleのサポートをご確認ください。いつでもキャンセルすることができます。

・自動更新サブスクリプションです。

・サブスクリプション登録期間中にこの画面が表示される場合は、設定のリストアをお試しください。

・利用規約とプライバシーポリシー。
"""
    }
}
