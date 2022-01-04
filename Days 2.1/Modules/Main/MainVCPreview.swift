//
//  MainVCPreview.swift
//  Days 2.1
//
//  Created by Олег Еременко on 04.01.2022.
//  Copyright © 2022 Oleg Eremenko. All rights reserved.
//

import SwiftUI

struct NavControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

struct MainVCPreview: PreviewProvider {
    static var previews: some View {
        Group {
            NavControllerRepresentable()
                .preferredColorScheme(.dark)
        }
    }
}
