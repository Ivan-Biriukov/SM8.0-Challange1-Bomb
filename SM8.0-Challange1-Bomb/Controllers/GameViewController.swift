import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private var gameWithBackgroundMusicEnabled : Bool = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.backgroundMusicBool)
    
    private var questionsArray : [String] = []
    
    private var tikSoundToPlay = SoundsDataModel.bombTikSound[UserDefaults.standard.string(forKey: K.UserDefaultsKeys.bombTikSavedValue)!]
    
    private var explosionToPlay = SoundsDataModel.bombExplosionSound[UserDefaults.standard.string(forKey: K.UserDefaultsKeys.bombExplosionSaveValue)!]
    
    private var backgroundMusicToPlay = SoundsDataModel.backGroundMisuc[UserDefaults.standard.string(forKey: K.UserDefaultsKeys.bgMusicSavedValue)!]
    
    private var isGameInProgress = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.gameInProgress)

    // MARK: - Properties
    private let runLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите \"Запустить\", чтобы начать игру"
        label.font = .delaGothic28()
        label.textColor = .specialViolet
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bombImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.Images.bomb)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var runButton: UIButton = {
        let button = CustomButton(text: "Запустить", active: .enable)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(runButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var playPauseButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        btn.tintColor = .black
        btn.setTitle(nil, for: .normal)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        return btn
    }()
    
    private let navTitle : UILabel = {
        let lb = UILabel()
        lb.text = "Игра"
        lb.font = .delaGothic30()
        lb.textColor = .specialViolet
        lb.textAlignment = .center
        lb.backgroundColor = .clear
        return lb
    }()
    
    var tikPlayer: AVAudioPlayer!
    var backgroundPlayer: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var currentLabelText: String?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gradientColor()
        addSubviews()
        setupConstraints()
        playPauseButton.addTarget(self, action: #selector(playPauseButtonPressed), for: .touchUpInside)
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(navBackTaped(_:)))
        self.navigationItem.title = nil
        self.navigationItem.titleView = navTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateQuestions()
        updateUIIfGameInProgress()
        
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(runLabel)
        view.addSubview(bombImageView)
        view.addSubview(runButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            runLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            runLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            runLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            bombImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 11),
            bombImageView.widthAnchor.constraint(equalToConstant: 312),
            bombImageView.heightAnchor.constraint(equalToConstant: 352),
            bombImageView.bottomAnchor.constraint(equalTo: runButton.topAnchor, constant: -30),
            
            runButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            runButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ])
    }
    
    private func createGif() {
        
        guard let gifPath = Bundle.main.path(forResource: "bombGif", ofType: "gif") else {
            print("Failed to find the GIF image.")
            return
        }
        
        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            print("Failed to load the GIF image data.")
            return
        }
        
        guard let gifImage = UIImage.gifImageWithData(gifData) else {
            print("Failed to create the GIF image.")
            return
        }
        
        bombImageView.image = gifImage
    }
    
    private func playTikSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            tikPlayer = try AVAudioPlayer(contentsOf: url)
            tikPlayer.numberOfLoops = -1
            tikPlayer?.prepareToPlay()
        } catch {
            print("Ошибка при создании экземпляра AVAudioPlayer: \(error.localizedDescription)")
        }
        tikPlayer.play()
    }
    
    private func playBackgroundSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.prepareToPlay()
        } catch {
            print("Ошибка при создании экземпляра AVAudioPlayer: \(error.localizedDescription)")
        }
        backgroundPlayer.play()
    }
    
    // Остановка таймера
    func pauseTimer() {
        timer.invalidate()
    }
    
    // Продолжение таймера
    func resumeTimer() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    private func checkGameWithBackgroundMusic() {
        if gameWithBackgroundMusicEnabled {
            playBackgroundSound(soundName: self.backgroundMusicToPlay!)
        }
    }
    
    private func playBackgroundPlayer() {
        if gameWithBackgroundMusicEnabled {
            backgroundPlayer.play()
        }
    }
    
    private func pauseBackgroundPlayer() {
        if gameWithBackgroundMusicEnabled {
            backgroundPlayer.pause()
        }
    }
    
    private func stopBackgroundPlayer() {
        if gameWithBackgroundMusicEnabled && backgroundPlayer != nil {
            backgroundPlayer.stop()
        }
    }
    
    private func setupTitle() {
        self.navigationItem.title = nil
        self.navigationItem.titleView = navTitle
    }
    
    private func saveCurrentQuestion() {
        defaults.set(currentLabelText, forKey: K.UserDefaultsKeys.currentQuestionTextSaved)
    }
    
    private func saveSecondsPassedValue() {
        defaults.set(secondPassed, forKey: K.UserDefaultsKeys.secondPassedSavedValue)
    }
    
    private func updateUIIfGameInProgress() {
        if isGameInProgress {
            secondPassed = defaults.integer(forKey: K.UserDefaultsKeys.secondPassedSavedValue)
            currentLabelText = defaults.string(forKey: K.UserDefaultsKeys.currentQuestionTextSaved)
            addButtonToNavBar(playPauseButton)
            totalTime = defaults.integer(forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            createGif()
            runLabel.text = currentLabelText
            runButton.isHidden = true
        }
    }
}

// MARK: - Target Actions
extension GameViewController {
    
    @objc func runButtonPressed(_ button: UIButton) {
        checkGameWithBackgroundMusic()
        playTikSound(soundName: self.tikSoundToPlay!)
        
        addButtonToNavBar(playPauseButton)
        
        if questionsArray.count == 0 {
            let alert = UIAlertController(title: "Невозможно начать игру", message: "Друг, похоже на то, что ты не выбрал ни одной категории вопросов. К сожалению, играть без вопросов - нельзя 😢. Перейди в раздел 'Категории', чтобы выбрать вопросы, и игра начнется!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Понятно!", style: .default)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        } else {
            pauseTimer()
            
            totalTime = defaults.integer(forKey: K.UserDefaultsKeys.roundTimeDurationInSeconds)
            secondPassed = 0
            
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            createGif()
            
            currentLabelText = questionsArray.randomElement()
            runLabel.text = currentLabelText
            runButton.isHidden = true
            defaults.set(true, forKey: K.UserDefaultsKeys.gameInProgress)
        }
    }
    
    @objc func playPauseButtonPressed(_ button: UIButton) {
        if tikPlayer.isPlaying {
            tikPlayer.pause()
            pauseBackgroundPlayer()
            runLabel.text = "Пауза"
            playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            pauseTimer()
            bombImageView.image = UIImage(named: K.Images.bomb)
            saveCurrentQuestion()
            saveSecondsPassedValue()
        } else {
            runLabel.text = currentLabelText
            tikPlayer.play()
            playBackgroundPlayer()
            playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            resumeTimer()
            createGif()
        }
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            self.secondPassed += 1
        } else {
            timer.invalidate()
            tikPlayer.stop()
            stopBackgroundPlayer()
            self.playBackgroundSound(soundName: self.explosionToPlay!)
            defaults.set(false, forKey: K.UserDefaultsKeys.gameInProgress)
            navigationController?.pushViewController(GameEndViewController(), animated: true)
        }
    }
    
    @objc func navBackTaped(_ sender: UIBarButtonItem) {
        if tikPlayer != nil {
            tikPlayer.stop()
        }
        stopBackgroundPlayer()
        saveCurrentQuestion()
        saveSecondsPassedValue()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Load Question Logic

extension GameViewController {
    
    private func updateQuestions() {
        self.questionsArray = []
        
        if defaults.bool(forKey: K.UserDefaultsKeys.aboutAllCategoryChoosen) == true {
            questionsArray += QuestionsDataModel.miscellaneous
        }
        
        if defaults.bool(forKey: K.UserDefaultsKeys.sportAndHobbyCathegoryChoosen) == true {
            questionsArray += QuestionsDataModel.sportAndHobby
        }
        
        if defaults.bool(forKey: K.UserDefaultsKeys.lifeCategoryChoosen) == true {
            questionsArray += QuestionsDataModel.aboutLife
        }
        
        if defaults.bool(forKey: K.UserDefaultsKeys.fameosCategoryChoosen) == true {
            questionsArray += QuestionsDataModel.fameos
        }
        
        if defaults.bool(forKey: K.UserDefaultsKeys.artAndCinemaCategoryChoosen) == true {
            questionsArray += QuestionsDataModel.artAndCinema
        }
        
        if defaults.bool(forKey: K.UserDefaultsKeys.natureCategoryChoosen) == true {
            questionsArray += QuestionsDataModel.nature
        }
    }
    
}
