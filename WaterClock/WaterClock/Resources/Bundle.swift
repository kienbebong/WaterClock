import Foundation

private var bundleKey: UInt8 = 0

extension Bundle {
    private static var onLanguageChange: ((String) -> Void)?

    static func setLanguage(_ language: String) {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("Ngôn ngữ không tồn tại: \(language)")
            return
        }

        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        onLanguageChange?(language)
    }

    var current: Bundle {
        return objc_getAssociatedObject(Bundle.main, &bundleKey) as? Bundle ?? Bundle.main
    }

    static func observeLanguageChange(callback: @escaping (String) -> Void) {
        onLanguageChange = callback
    }
}

extension String {
    /// Hàm lấy localized string từ bundle hiện tại
    var localized: String {
        return Bundle.main.current.localizedString(forKey: self, value: nil, table: nil)
    }
}
