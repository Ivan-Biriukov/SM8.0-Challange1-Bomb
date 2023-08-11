import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    
    // MARK: - Needed Data
    
    private let bgMusicArray : [String] = ["Шоу Бэнни Хила", "X-Files"]
    private let bombTikSoundsArray : [String] = ["Тиканье часов", "Маятник","Маятник с Эхо", "Электронный"]
    private let bombExplosionSoundArray : [String] = ["Взрыв 1", "Взрыв 2","Взырв 3", "Взрыв 4"]
    
    private var pickersSelectedRow = Int()
    private var player: AVAudioPlayer?
    private let defaults = UserDefaults.standard
    
    
    // MARK: -  UI Elements
    
    var toolBar = UIToolbar()
    var bgMusicPicker = UIPickerView()
    var bombTikPicker = UIPickerView()
    var bombExplosionPicker = UIPickerView()
    
    private lazy var backgroundImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: K.Images.background)
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 39
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var topStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var timeLabel = SettingsLabel(labelText: "Время игры")
    
    private lazy var firstButtonLineStack : UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .fill
        s.spacing = 5
        s.alignment = .trailing
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    private lazy var shortButton = SettingsButton(text: "Короткое",style: .framedSelected)
    private lazy var middleButton = SettingsButton(text: "Среднее", style: .framed)
    private let spaceContainer : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
    
    private lazy var secondButtonLineStack : UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .fill
        s.spacing = 5
        s.alignment = .trailing
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    private lazy var longButton = SettingsButton(text: "Длинное", style: .framed)
    private lazy var randomButton = SettingsButton(text: "Случайное", style: .framed)
    private let secondSpaceContainer : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
    
    private lazy var firstLine : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var gameWithTasksLabel = SettingsLabel(labelText: "Игра с Заданиями")
    private let gameWithTasksSwitch : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = .specialViolet
        sw.layer.borderColor = UIColor.specialViolet.cgColor
        sw.layer.borderWidth = 1
        sw.layer.cornerRadius = 16
        sw.isOn = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.gameWithTasksBool)
        return sw
    }()
    
    private lazy var secondLine : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var backgroundMusicEnabledLabel = SettingsLabel(labelText: "Фоновая Музыка")
    private let backgroundMusicSwitch : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = .specialViolet
        sw.layer.borderColor = UIColor.specialViolet.cgColor
        sw.layer.borderWidth = 1
        sw.layer.cornerRadius = 16
        sw.isOn = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.backgroundMusicBool)
        return sw
    }()
    
    private lazy var thirdLine : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var backgroundMusicMelodyLabel = SettingsLabel(labelText: "Фоновая музыка")
    private lazy var chooseBGMelodyButton  = SettingsButton(text: "Мелодия 1", style: .black)
    
    private lazy var fourthLine : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var bombTikLabel = SettingsLabel(labelText: "Тиканье Бомбы")
    private lazy var chooseBombTikButton = SettingsButton(text: "Вариант 1", style: .black)
    
    private lazy var fifthLine : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var bombExplosionLabel = SettingsLabel(labelText: "Взрыв Бомбы")
    private lazy var chooseBombExplButton = SettingsButton(text: "Взрыв 1", style: .black)
    
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomNavigationBar(title: "Настройки")
        addSubviews()
        setupConstraints()
        addButtonsTargets()
        addSwitchTargets()
        updateSoundsButtonsLabel()
        updateGameWithTaskSwitchValue()
        updateMusicSwitchValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDurationButtonUIFromUD()
    }
    
    // MARK: - Switch Methods
    
    @objc private func musicSwitchTaped(_ sender: UISwitch) {
        defaults.set(!defaults.bool(forKey: K.UserDefaultsKeys.backgroundMusicBool), forKey: K.UserDefaultsKeys.backgroundMusicBool)
        backgroundMusicSwitch.isOn = defaults.bool(forKey: K.UserDefaultsKeys.backgroundMusicBool)
    }
    
    @objc private func taskSwitchTaped(_ sender: UISwitch) {
        defaults.set(!defaults.bool(forKey: K.UserDefaultsKeys.gameWithTasksBool), forKey: K.UserDefaultsKeys.gameWithTasksBool)
        gameWithTasksSwitch.isOn = defaults.bool(forKey: K.UserDefaultsKeys.gameWithTasksBool)
    }
    
    // MARK: - Buttons Methods
    
    @objc private func durationButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            defaults.set(20, forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
            changeButtonUI(btn: sender, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([shortButton, longButton, randomButton])
        case 2:
            defaults.set(45, forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
            changeButtonUI(btn: sender, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([shortButton, middleButton, randomButton])
        case 3:
            var duration = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41,42, 43, 44]
            duration.shuffle()
            let shafled = duration.first
            defaults.set(shafled, forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
            changeButtonUI(btn: sender, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([shortButton, middleButton, longButton])
        default:
            defaults.set(10, forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
            changeButtonUI(btn: sender, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([middleButton, longButton, randomButton])
        }
    }
    
    @objc private func chooseBGMelodyTaped(_ sender: UIButton) {
        bgMusicPicker = UIPickerView.init()
        bgMusicPicker.delegate = self
        bgMusicPicker.dataSource = self
        bgMusicPicker.backgroundColor = UIColor.white
        bgMusicPicker.setValue(UIColor.black, forKey: "textColor")
        bgMusicPicker.autoresizingMask = .flexibleWidth
        bgMusicPicker.contentMode = .center
        bgMusicPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(bgMusicPicker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Выбрать", style: .done, target: self, action: #selector(choosebgMusicPickerTaped)), UIBarButtonItem.init(title: "Отмена", style: .plain, target: self, action: #selector(cancelMusicPickerTaped))]
        toolBar.barTintColor = .specialViolet
        toolBar.tintColor = .white
        self.view.addSubview(toolBar)
    }
    
    @objc private func chooseBombTikTaped (){
        bombTikPicker = UIPickerView.init()
        bombTikPicker.delegate = self
        bombTikPicker.dataSource = self
        bombTikPicker.backgroundColor = UIColor.white
        bombTikPicker.setValue(UIColor.black, forKey: "textColor")
        bombTikPicker.autoresizingMask = .flexibleWidth
        bombTikPicker.contentMode = .center
        bombTikPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(bombTikPicker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Выбрать", style: .done, target: self, action: #selector(chooseBombTikPickerTaped)), UIBarButtonItem.init(title: "Отмена", style: .plain, target: self, action: #selector(cancelBombTikPickerTaped))]
        toolBar.barTintColor = .specialViolet
        toolBar.tintColor = .white
        self.view.addSubview(toolBar)
    }
    
    @objc private func chooseExplosionTaped() {
        bombExplosionPicker = UIPickerView.init()
        bombExplosionPicker.delegate = self
        bombExplosionPicker.dataSource = self
        bombExplosionPicker.backgroundColor = UIColor.white
        bombExplosionPicker.setValue(UIColor.black, forKey: "textColor")
        bombExplosionPicker.autoresizingMask = .flexibleWidth
        bombExplosionPicker.contentMode = .center
        bombExplosionPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(bombExplosionPicker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Выбрать", style: .done, target: self, action: #selector(chooseExplosionPickerTaped)), UIBarButtonItem.init(title: "Отмена", style: .plain, target: self, action: #selector(cancelExplosionPickerTaped))]
        toolBar.barTintColor = .specialViolet
        toolBar.tintColor = .white
        self.view.addSubview(toolBar)
    }
    
    // bgMusicPicker buttons Methods
    @objc func cancelMusicPickerTaped() {
        toolBar.removeFromSuperview()
        bgMusicPicker.removeFromSuperview()
        player?.stop()
    }
    
    @objc func choosebgMusicPickerTaped() {
        self.chooseBGMelodyButton.setTitle(bgMusicArray[pickersSelectedRow], for: .normal)
        defaults.set(bgMusicArray[pickersSelectedRow], forKey: K.UserDefaultsKeys.bgMusicSavedValue)
        toolBar.removeFromSuperview()
        bgMusicPicker.removeFromSuperview()
        pickersSelectedRow = 0
        player?.stop()
    }
    
    // BombTickPicker buttons Methods
    @objc private func chooseBombTikPickerTaped() {
        self.chooseBombTikButton.setTitle(bombTikSoundsArray[pickersSelectedRow], for: .normal)
        defaults.set(bombTikSoundsArray[pickersSelectedRow], forKey: K.UserDefaultsKeys.bombTikSavedValue)
        toolBar.removeFromSuperview()
        bombTikPicker.removeFromSuperview()
        pickersSelectedRow = 0
        player?.stop()
    }
    
    @objc private func cancelBombTikPickerTaped() {
        toolBar.removeFromSuperview()
        bombTikPicker.removeFromSuperview()
        player?.stop()
    }
    
    //BombExplosionPicker buttons methods
    @objc private func chooseExplosionPickerTaped() {
        self.chooseBombExplButton.setTitle(bombExplosionSoundArray[pickersSelectedRow], for: .normal)
        defaults.set(bombExplosionSoundArray[pickersSelectedRow], forKey: K.UserDefaultsKeys.bombExplosionSaveValue)
        toolBar.removeFromSuperview()
        bombExplosionPicker.removeFromSuperview()
        pickersSelectedRow = 0
        player?.stop()
    }
    
    @objc private func cancelExplosionPickerTaped() {
        toolBar.removeFromSuperview()
        bombExplosionPicker.removeFromSuperview()
        player?.stop()
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(topStack)
        topStack.addArrangedSubview(timeLabel)
        topStack.addArrangedSubview(firstButtonLineStack)
        firstButtonLineStack.addArrangedSubview(spaceContainer)
        firstButtonLineStack.addArrangedSubview(shortButton)
        firstButtonLineStack.addArrangedSubview(middleButton)
        topStack.addArrangedSubview(secondButtonLineStack)
        secondButtonLineStack.addArrangedSubview(secondSpaceContainer)
        secondButtonLineStack.addArrangedSubview(longButton)
        secondButtonLineStack.addArrangedSubview(randomButton)
        
        contentStack.addArrangedSubview(firstLine)
        firstLine.addArrangedSubview(gameWithTasksLabel)
        firstLine.addArrangedSubview(gameWithTasksSwitch)
        
        contentStack.addArrangedSubview(secondLine)
        secondLine.addArrangedSubview(backgroundMusicEnabledLabel)
        secondLine.addArrangedSubview(backgroundMusicSwitch)
        contentStack.addArrangedSubview(thirdLine)
        thirdLine.addArrangedSubview(backgroundMusicMelodyLabel)
        thirdLine.addArrangedSubview(chooseBGMelodyButton)
        
        contentStack.addArrangedSubview(fourthLine)
        fourthLine.addArrangedSubview(bombTikLabel)
        fourthLine.addArrangedSubview(chooseBombTikButton)
        
        contentStack.addArrangedSubview(fifthLine)
        fifthLine.addArrangedSubview(bombExplosionLabel)
        fifthLine.addArrangedSubview(chooseBombExplButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            firstButtonLineStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            secondButtonLineStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            firstLine.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            secondLine.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            thirdLine.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            fourthLine.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            fifthLine.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
        ])
    }
    
    private func addButtonsTargets() {
        var tag : Int = 0
        for button in [shortButton, middleButton, longButton, randomButton] {
            button.addTarget(self, action: #selector(durationButtonPressed(_:)), for: .touchUpInside)
            button.tag = tag
            tag += 1
        }
        
        chooseBGMelodyButton.addTarget(self, action: #selector(chooseBGMelodyTaped(_:)), for: .touchUpInside)
        chooseBombTikButton.addTarget(self, action: #selector(chooseBombTikTaped), for: .touchUpInside)
        chooseBombExplButton.addTarget(self, action: #selector(chooseExplosionTaped), for: .touchUpInside)
    }
    
    private func addSwitchTargets() {
        backgroundMusicSwitch.addTarget(self, action: #selector(musicSwitchTaped(_:)), for: .touchUpInside)
        gameWithTasksSwitch.addTarget(self, action: #selector(taskSwitchTaped(_:)), for: .touchUpInside)
    }
    
    private func changeButtonUI(btn: UIButton, bgColor: UIColor, textColor: UIColor) {
        btn.setTitleColor(textColor, for: .normal)
        btn.backgroundColor = bgColor
    }
    
    private func restoreStandartButtonUI(_ buttons: [UIButton]) {
        for button in buttons {
            button.setTitleColor(.specialViolet, for: .normal)
            button.backgroundColor = .specialYellow
        }
    }
    
    private func updateMusicSwitchValue() {
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.backgroundMusicBool) {
            self.backgroundMusicSwitch.isOn = defaults.bool(forKey: K.UserDefaultsKeys.backgroundMusicBool)
        } else {
            self.backgroundMusicSwitch.isOn = true
            defaults.set(true, forKey: K.UserDefaultsKeys.backgroundMusicBool)
        }
    }
    
    private func updateGameWithTaskSwitchValue() {
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.gameWithTasksBool) {
            self.gameWithTasksSwitch.isOn = defaults.bool(forKey: K.UserDefaultsKeys.gameWithTasksBool)
        } else {
            self.gameWithTasksSwitch.isOn = true
            defaults.set(true, forKey: K.UserDefaultsKeys.gameWithTasksBool)
        }
    }
    
    private func updateSoundsButtonsLabel() {
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bgMusicSavedValue) {
            chooseBGMelodyButton.setTitle(defaults.string(forKey: K.UserDefaultsKeys.bgMusicSavedValue), for: .normal)
        } else {
            defaults.set(SoundsDataModel.backGroundMisuc["Шоу Бэнни Хила"], forKey: K.UserDefaultsKeys.bgMusicSavedValue)
            chooseBGMelodyButton.setTitle("Шоу Бэнни Хила", for: .normal)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bombTikSavedValue) {
            chooseBombTikButton.setTitle(defaults.string(forKey: K.UserDefaultsKeys.bombTikSavedValue), for: .normal)
        } else {
            defaults.set(SoundsDataModel.bombTikSound["Тиканье часов"], forKey: K.UserDefaultsKeys.bombTikSavedValue)
            chooseBombTikButton.setTitle("Тиканье часов", for: .normal)
        }
        
        if isKeyPresentInUserDefaults(key: K.UserDefaultsKeys.bombExplosionSaveValue) {
            chooseBombExplButton.setTitle(defaults.string(forKey: K.UserDefaultsKeys.bombExplosionSaveValue), for: .normal)
        } else {
            defaults.set(SoundsDataModel.bombExplosionSound["Взрыв 1"], forKey: K.UserDefaultsKeys.bombExplosionSaveValue)
            chooseBombExplButton.setTitle("Взрыв 1", for: .normal)
        }
    }
    
    private func updateDurationButtonUIFromUD() {
        let currentDuration = defaults.integer(forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
        switch currentDuration {
        case 10:
            changeButtonUI(btn: shortButton, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([middleButton, longButton, randomButton])
        case 20:
            changeButtonUI(btn: middleButton, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([shortButton, longButton, randomButton])
        case 45:
            changeButtonUI(btn: longButton, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([middleButton, shortButton, randomButton])
        default:
            changeButtonUI(btn: randomButton, bgColor: .specialViolet, textColor: .specialYellow)
            restoreStandartButtonUI([middleButton, longButton, shortButton])
        }
    }
    
    // MARK: - Player Section
    
    func playSound(resourceName: String) {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: ".mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - PickerView Delegate & DataSource

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        (pickerView == bgMusicPicker) ? bgMusicArray.count : ((pickerView == bombTikPicker) ? bombTikSoundsArray.count : bombExplosionSoundArray.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        (pickerView == bgMusicPicker) ? bgMusicArray[row] : ((pickerView == bombTikPicker) ? bombTikSoundsArray[row] : bombExplosionSoundArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickersSelectedRow = row
        
        switch pickerView {
        case bgMusicPicker:
            let songKey = bgMusicArray[row]
            playSound(resourceName: SoundsDataModel.backGroundMisuc[songKey]!)
        case bombTikPicker:
            let soundKey = bombTikSoundsArray[row]
            playSound(resourceName: SoundsDataModel.bombTikSound[soundKey]!)
        case bombExplosionPicker:
            let soundKey = bombExplosionSoundArray[row]
            playSound(resourceName: SoundsDataModel.bombExplosionSound[soundKey]!)
        default:
            print("can't be ")
        }
    }
}

