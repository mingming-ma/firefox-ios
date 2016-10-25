/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation

class GradientBackgroundView: UIView {
    private let gradient: CAGradientLayer

    init(alpha: Float = 0.1, startPoint: CGPoint = CGPoint(x: -0.2, y: 0), endPoint: CGPoint = CGPoint(x: 1.2, y: 1)) {
        gradient = CAGradientLayer()
        super.init(frame: CGRect.zero)

        backgroundColor = UIConstants.colors.gradientBackground
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        let gradients = [UIConstants.colors.gradientLeft, UIConstants.colors.gradientMiddle, UIConstants.colors.gradientRight]
        gradient.colors = gradients.map { $0.withAlphaComponent(CGFloat(alpha)).cgColor }
        layer.insertSublayer(gradient, at: 0)
    }

    init(gradient: CAGradientLayer) {
        self.gradient = gradient
        super.init(frame: CGRect.zero)

        backgroundColor = UIConstants.colors.gradientBackground
        layer.insertSublayer(gradient, at: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
