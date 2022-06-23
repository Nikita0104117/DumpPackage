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
            var border: UIColor?
            var title: UIColor?
            var cornerRadius: CGFloat?
            let font: UIFont?
            var contentEdgeInsets: UIEdgeInsets?
            var image: UIImage?
            var selectedImage: UIImage?

            init(
                background: UIColor? = nil,
                border: UIColor? = nil,
                title: UIColor? = nil,
                font: UIFont? = nil,
                cornerRadius: CGFloat? = nil,
                contentEdgeInsets: UIEdgeInsets? = nil,
                image: UIImage? = nil,
                selectedImage: UIImage? = nil
            ) {
                self.background = background
                self.border = border
                self.title = title
                self.cornerRadius = cornerRadius
                self.font = font
                self.contentEdgeInsets = contentEdgeInsets
                self.image = image
                self.selectedImage = selectedImage
            }

            public func apply(_ object: UIButton) {
                object.layer.masksToBounds = true

                if let background = background {
                    object.backgroundColor = background
                }

                if let border = border {
                    object.layer.borderWidth = 1
                    object.layer.borderColor = border.cgColor
                }

                if let title = title {
                    object.setTitleColor(title, for: .normal)
                    object.setTitleColor(title.withAlphaComponent(0.5), for: .disabled)
                    object.setTitleColor(title.withAlphaComponent(0.7), for: .highlighted)
                    object.setTitleColor(title.withAlphaComponent(0.7), for: .selected)
                }

                if let cornerRadius = cornerRadius {
                    object.layer.cornerRadius = cornerRadius
                }

                if let contentEdgeInsets = contentEdgeInsets {
                    object.contentEdgeInsets = contentEdgeInsets
                }

                if let image = image {
                    object.setImage(image, for: .normal)
                }

                if let selectedImage = selectedImage {
                    object.setImage(selectedImage, for: .selected)
                }

                if let font = font {
                object.titleLabel?.font = font
                }
            }
        }
    }

    public enum Margins {
        public static let defaultInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        public static let zeroInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    public enum CornerRadius {
        public static let `default` = 10.0
        public static let normal = 20.0
    }
}
