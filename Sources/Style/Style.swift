//
//  Style.swift
//
//
//  Created by Nikita Omelchenko
//

import Foundation
import UIKit

public enum Style {
    public enum Font { }

    public enum Label {
        public struct ColoredLabel: Applicable {
            var titleColor: UIColor
            var font: UIFont
            var numberOfLines: Int = 0

            public init(titleColor: UIColor, font: UIFont, numberOfLines: Int = 0) {
                self.titleColor = titleColor
                self.font = font
                self.numberOfLines = numberOfLines
            }

            public func apply(_ object: UILabel) {
                            object.textColor = titleColor
                            object.font = font
                            object.numberOfLines = numberOfLines
                        }
        }
    }

    public enum TextView {
        public struct ColoredTextView: Applicable {
            var textColor: UIColor
            var font: UIFont

            public init(textColor: UIColor, font: UIFont) {
                self.textColor = textColor
                self.font = font
            }

            public func apply(_ object: UITextView) {
                object.textColor = textColor
                object.font = font
            }
        }
    }

    public enum Stack {
        public struct DefaulStack: Applicable {
            let spacing: CGFloat
            let axis: NSLayoutConstraint.Axis
            var alignment: UIStackView.Alignment = .fill
            var distribution: UIStackView.Distribution = .fill

            public init(
                spacing: CGFloat,
                axis: NSLayoutConstraint.Axis,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill
            ) {
                self.spacing = spacing
                self.axis = axis
                self.alignment = alignment
                self.distribution = distribution
            }

            public func apply(_ object: UIStackView) {
                object.spacing = spacing
                object.alignment = alignment
                object.distribution = distribution
                object.axis = axis
            }
        }

        public static let defaultHorizontalStack0 = DefaulStack(spacing: 0, axis: .horizontal)
        public static let defaultVerticalStack0 = DefaulStack(spacing: 0, axis: .vertical)
        public static let defaultHorizontalStack8 = DefaulStack(spacing: 8, axis: .horizontal)
        public static let defaultVerticalStack8 = DefaulStack(spacing: 8, axis: .vertical)
    }

    public enum TextField {
        public struct ColoredTextField: Applicable {
            let color: UIColor
            let font: UIFont
            var borderColor: UIColor?

            public init(color: UIColor, font: UIFont, borderColor: UIColor? = nil) {
                self.color = color
                self.font = font
                self.borderColor = borderColor
            }

            public func apply(_ object: UITextField) {
                object.borderStyle = .none
                object.textColor = color
                object.font = font

                if let borderColor = self.borderColor {
                    object.layer.borderColor = borderColor.cgColor
                    object.layer.borderWidth = 1
                }
            }
        }
    }

    public enum ImageView {
        public struct ImageView: Applicable {
            let contentMode: UIView.ContentMode
            let cornerRadius: CGFloat

            public init(contentMode: UIView.ContentMode, cornerRadius: CGFloat) {
                self.contentMode = contentMode
                self.cornerRadius = cornerRadius
            }

            public func apply(_ object: UIImageView) {
                object.contentMode = contentMode
                object.layer.cornerRadius = cornerRadius
                object.layer.masksToBounds = true
            }
        }
    }

    public enum Button {
        public struct ColoredButton: Applicable {
            var background: UIColor?

            var tintColor: UIColor?

            var titleColor: UIColor?
            var titleColorSelected: UIColor?
            var titleColorHighlighted: UIColor?
            var titleColorDisabled: UIColor?

            var image: UIImage?
            var imageSelected: UIImage?
            var imageHighlighted: UIImage?
            var imageDisabled: UIImage?

            var cornerRadius: CGFloat?

            let font: UIFont?

            var contentEdgeInsets: UIEdgeInsets?

            public init(
                background: UIColor? = nil,
                tintColor: UIColor? = nil,
                titleColor: UIColor? = nil,
                titleColorSelected: UIColor? = nil,
                titleColorHighlighted: UIColor? = nil,
                titleColorDisabled: UIColor? = nil,
                image: UIImage? = nil,
                imageSelected: UIImage? = nil,
                imageHighlighted: UIImage? = nil,
                imageDisabled: UIImage? = nil,
                cornerRadius: CGFloat? = nil,
                font: UIFont? = nil,
                contentEdgeInsets: UIEdgeInsets? = nil
            ) {
                self.background = background
                self.tintColor = tintColor
                self.titleColor = titleColor
                self.titleColorSelected = titleColorSelected
                self.titleColorHighlighted = titleColorHighlighted
                self.titleColorDisabled = titleColorDisabled
                self.image = image
                self.imageSelected = imageSelected
                self.imageHighlighted = imageHighlighted
                self.imageDisabled = imageDisabled
                self.cornerRadius = cornerRadius
                self.font = font
                self.contentEdgeInsets = contentEdgeInsets
            }

            public func apply(_ object: UIButton) {
                object.layer.masksToBounds = true

                if let background = background {
                    object.backgroundColor = background
                }

                if let tintColor = tintColor {
                    object.tintColor = tintColor
                }

                if let titleColor = titleColor {
                    object.setTitleColor(titleColor, for: .normal)
                    object.setTitleColor(titleColor.withAlphaComponent(0.4), for: .disabled)
                    object.setTitleColor(titleColor.withAlphaComponent(0.6), for: .highlighted)
                }
                if let titleColorSelected = titleColorSelected {
                    object.setTitleColor(titleColorSelected, for: .selected)
                }
                if let titleColorHighlighted = titleColorHighlighted {
                    object.setTitleColor(titleColorHighlighted, for: .highlighted)
                }
                if let titleColorDisabled = titleColorDisabled {
                    object.setTitleColor(titleColorDisabled, for: .disabled)
                }

                if let image = image {
                    object.setImage(image, for: .normal)
                }
                if let imageSelected = imageSelected {
                    object.setImage(imageSelected, for: .selected)
                }
                if let imageHighlighted = imageHighlighted {
                    object.setImage(imageHighlighted, for: .highlighted)
                }
                if let imageDisabled = imageDisabled {
                    object.setImage(imageDisabled, for: .disabled)
                }

                if let cornerRadius = cornerRadius {
                    object.layer.cornerRadius = cornerRadius
                }

                if let contentEdgeInsets = contentEdgeInsets {
                    object.contentEdgeInsets = contentEdgeInsets
                }

                if let font = font {
                    object.titleLabel?.font = font
                }
            }
        }
    }

    public enum Margins {
        public static let defaultInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        public static let defaultRoundInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        public static let zeroInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    public enum CornerRadius {
        public static let `default` = 10.0
        public static let normal = 20.0
    }
}
