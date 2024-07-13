import UIKit

/// Экран чтения
final class BookViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: UIColor = .white
        static let backGroundNightModeColor: UIColor = .black
        static let bookText = Book()
        static let textColor: [UIColor] = [.black, .green, .orange, .cyan]
        static let fontsArray = ["Arial", "Chalkboard SE", "Phosphate", "Futura"]
    }
    
    private enum textColor {
        case black
        case blue
        case red
        case orange
        case green
    }
    
    private var textView = UITextView()
    private var textSizeSlider = UISlider()
    private var blackTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private var blueTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private var redTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private var orangeTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private var greenTextColorImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    private var nightModSwitch = UISwitch()
    private var fontPickerView = UIPickerView()
    private var activityViewController : UIActivityViewController? = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        setupForNavBar()
        setupForTextView()
        setupTextSize()
        setupForBlackColorText()
        setupForBlueColorText()
        setupForRedColorText()
        setupForOrangeColorText()
        setupForGreenColorText()
        setupForNightModeSwitch()
        setupForFontPicker()
    }
    
    // MARK: - Private Methods
    private func setupForNavBar() {
        navigationItem.title = "IBook"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(shareButtonPressed))
    }
    
    private func setupForTextView() {
        textView.frame = CGRect(x: 0, y: 100, width: 400, height: 300)
        textView.center.x = view.center.x
        textView.layer.cornerRadius = 10
        textView.backgroundColor = .placeholderText
        textView.isEditable = false
        textView.text = Constants.bookText.text
        textView.textAlignment = .justified
        textView.font = UIFont(name: "Arial", size: 20)
        view.addSubview(textView)
    }
    
    private func setupTextSize() {
        textSizeSlider.frame = CGRect(x: 0, y: 450, width: 300, height: 50)
        textSizeSlider.center.x = view.center.x
        textSizeSlider.minimumValue = 1
        textSizeSlider.maximumValue = 50
        textSizeSlider.value = 20
        textSizeSlider.minimumValueImage = UIImage(systemName: "1.circle")
        textSizeSlider.maximumValueImage = UIImage(systemName: "50.circle")
        textSizeSlider.tintColor = .lightGray
        view.addSubview(textSizeSlider)
        textSizeSlider.addTarget(self, action: #selector(valueChange), for: .valueChanged)
    }
    
    private func setupForBlackColorText() {
        blackTextColorImageView.frame = CGRect(x: 50, y: 550, width: 50, height: 50)
        blackTextColorImageView.tintColor = .black
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackTextColorPressed))
        blackTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        blackTextColorImageView.isUserInteractionEnabled = true
        view.addSubview(blackTextColorImageView)
    }
    
    private func setupForBlueColorText() {
        blueTextColorImageView.frame = CGRect(x: 110, y: 550, width: 50, height: 50)
        blueTextColorImageView.tintColor = .blue
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blueTextColorPressed))
        blueTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        blueTextColorImageView.isUserInteractionEnabled = true
        view.addSubview(blueTextColorImageView)
    }
    
    private func setupForRedColorText() {
        redTextColorImageView.frame = CGRect(x: 170, y: 550, width: 50, height: 50)
        redTextColorImageView.tintColor = .red
        redTextColorImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(redTextColorPressed))
        redTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(redTextColorImageView)
    }
    
    private func setupForOrangeColorText() {
        orangeTextColorImageView.frame = CGRect(x: 230, y: 550, width: 50, height: 50)
        orangeTextColorImageView.tintColor = .orange
        orangeTextColorImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(orangeTextColorPressed))
        orangeTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(orangeTextColorImageView)
    }
    
    private func setupForGreenColorText() {
        greenTextColorImageView.frame = CGRect(x: 290, y: 550, width: 50, height: 50)
        greenTextColorImageView.tintColor = .green
        greenTextColorImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(greenTextColorPressed))
        greenTextColorImageView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(greenTextColorImageView)
    }
    
    private func setupForNightModeSwitch() {
        nightModSwitch.frame = CGRect(x: 50, y: 650, width: 50, height: 30)
        nightModSwitch.isOn = false
        view.addSubview(nightModSwitch)
        nightModSwitch.addTarget(self, action: #selector(nightMode), for: .valueChanged)
    }
    
    private func setupForFontPicker() {
        fontPickerView.delegate = self
        fontPickerView.dataSource = self
        fontPickerView.frame = CGRect(x: 250, y: 620, width: 150, height: 100)
        view.addSubview(fontPickerView)
    }
    
    private func chooseTextColor(color: textColor) {
        switch color {
        case .black: textView.textColor = .black
        case .blue: textView.textColor = .blue
        case .red: textView.textColor = .red
        case .orange: textView.textColor = .orange
        case .green: textView.textColor = .green
        }
    }
    
    @objc private func nightMode() {
        if nightModSwitch.isOn {
            view.backgroundColor = Constants.backGroundNightModeColor
            textView.textColor = .white
            fontPickerView.backgroundColor = .white
        } else {
            view.backgroundColor = Constants.backgroundColor
            textView.textColor = .black
        }
    }
    
    @objc private func valueChange(sender: UISlider) {
        textView.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
    }
    
    
    @objc private func blackTextColorPressed(){
        chooseTextColor(color: .black)
    }
    
    @objc private func blueTextColorPressed() {
        chooseTextColor(color: .blue)
    }
    
    @objc private func redTextColorPressed() {
        chooseTextColor(color: .red)
    }
    
    @objc private func orangeTextColorPressed() {
        chooseTextColor(color: .orange)
    }
    
    @objc private func greenTextColorPressed() {
        chooseTextColor(color: .green)
    }
    
    @objc private func shareButtonPressed() {
        activityViewController = UIActivityViewController(activityItems: [textView.text ?? ""], applicationActivities: nil)
        guard let shareButton = activityViewController else { return }
        present(shareButton, animated: true)
    }
}

/// UIPickerViewDelegate, UIPickerDataSource
extension BookViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.fontsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.fontsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch Constants.fontsArray[row] {
        case Constants.fontsArray[0]: textView.font = UIFont(name: "Arial", size: CGFloat(textSizeSlider.value))
        case Constants.fontsArray[1]: textView.font = UIFont(name: "Chalkboard SE", size: CGFloat(textSizeSlider.value))
        case Constants.fontsArray[2]: textView.font = UIFont(name: "Phosphate", size: CGFloat(textSizeSlider.value))
        case Constants.fontsArray[3]: textView.font = UIFont(name: "Futura", size: CGFloat(textSizeSlider.value))
        default: break
        }
    }
}
