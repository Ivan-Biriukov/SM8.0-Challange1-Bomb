import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private var questionsArray : [String] = []
    
    private var tikSoundToPlay = SoundsDataModel.bombTikSound[UserDefaults.standard.string(forKey: K.UserDefaultsKeys.bombTikSavedValue)!]
    
    private var explosionToPlay = SoundsDataModel.bombExplosionSound[UserDefaults.standard.string(forKey: K.UserDefaultsKeys.bombExplosionSaveValue)!]
    
    private var backgroundMusicToPlay = SoundsDataModel.backGroundMisuc[UserDefaults.standard.string(forKey: K.UserDefaultsKeys.bgMusicSavedValue)!]

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
    
    var player: AVAudioPlayer!
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
        playSound(soundName: self.backgroundMusicToPlay!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateQuestions()
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
            bombImageView.bottomAnchor.constraint(equalTo: runButton.topAnchor, constant: -94),
            
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
        
        // Set the loaded GIF image to the UIImageView
        bombImageView.image = gifImage
    }
    
    private func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("Ошибка при создании экземпляра AVAudioPlayer: \(error.localizedDescription)")
        }
        player.play()
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
}

// MARK: - Target Actions
extension GameViewController {
    
    @objc func runButtonPressed(_ button: UIButton) {
        player.stop()
        playSound(soundName: self.tikSoundToPlay!)
        player.numberOfLoops = -1
        
        addButtonToNavBar(playPauseButton)
        
        if questionsArray.count == 0 {
            let alert = UIAlertController(title: "Невозможно начать игру", message: "Друг, похоже на то, что ты не выбрал ни одной категории вопросов. К сожалению, играть без вопросов - нельзя 😢. Перейди в раздел 'Категории', чтобы выбрать вопросы, и игра начнется!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Понятно!", style: .default)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        } else {
            print("runButtonPressed")
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
        print("playPauseButtonPressed")
        if player.isPlaying {
            player.pause()
            runLabel.text = "Пауза"
            playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            pauseTimer()
            bombImageView.image = UIImage(named: K.Images.bomb)
        } else {
            runLabel.text = currentLabelText
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            resumeTimer()
            createGif()
        }
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            self.secondPassed += 1
            let sec = totalTime - secondPassed
            print("Осталось \(sec) секунд")
        } else {
            timer.invalidate()
            self.playSound(soundName: self.explosionToPlay!)
            navigationController?.pushViewController(GameEndViewController(), animated: true)
        }
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
