# Music Tempo with Heart Rate

An iOS application that allows users to dynamically adjust music playback tempo in real-time. This app is designed to synchronize music tempo with heart rate or user preferences, providing an adaptive audio experience perfect for workouts, running, or tempo-based activities.

## Project Overview

MusicTempoWithHR is an iOS app that:
- Plays audio files with adjustable playback speed
- Provides real-time tempo control via slider interface
- Supports multiple songs with seamless playback
- Uses AVAudioPlayer with rate adjustment capabilities
- Implements MVVM architecture with Presenter pattern

This app can be extended to integrate with heart rate sensors (Apple Watch, Bluetooth HR monitors) to automatically adjust music tempo based on the user's heart rate during exercise.

## Features

- 🎵 **Audio Playback** - Play songs with AVAudioPlayer
- ⚡ **Dynamic Tempo Adjustment** - Real-time speed control (0.5x - 2.0x)
- 🎚️ **Slider Control** - Intuitive interface for tempo changes
- 📱 **iOS Native** - Built with UIKit and Storyboards
- 🏗️ **MVVM Architecture** - Clean separation of concerns
- 🎯 **Presenter Pattern** - Coordinated business logic
- 💓 **HR Integration Ready** - Designed for heart rate sensor integration
- 🔄 **Playlist Support** - Manage multiple songs
- 🎨 **Custom UI** - Visual feedback for current song and tempo

## Technologies Used

### iOS Development
- **Swift** - Programming language
- **UIKit** - UI framework
- **AVFoundation** - Audio playback framework
- **Storyboards** - Interface design

### Architecture & Patterns
- **MVVM** (Model-View-ViewModel) - Architecture pattern
- **Presenter Pattern** - Business logic layer
- **Delegate Pattern** - Communication between layers
- **Data Source Pattern** - Data provision

### Development Tools
- **Xcode** - IDE
- **Interface Builder** - UI design
- **XCTest** - Testing framework

## Project Structure

```
MusicTempoWithHR/
├── MuiscTempoWithHR/                  # Main application
│   ├── AppDelegate.swift              # Application lifecycle
│   ├── SceneDelegate.swift            # Scene lifecycle
│   ├── ViewController.swift           # Base controller
│   ├── Info.plist                     # App configuration
│   │
│   ├── Modules/
│   │   ├── Master/                    # Main feature module
│   │   │   ├── MainViewController.swift      # Main UI controller
│   │   │   ├── MainViewController.storyboard # UI layout
│   │   │   ├── MainViewModel.swift           # View model
│   │   │   ├── MainPresenter.swift           # Presenter logic
│   │   │   └── AudioPlayer.swift             # Audio playback engine
│   │   │
│   │   └── songs/                     # Song files
│   │       └── [Audio files]
│   │
│   ├── Assets.xcassets/               # Images and icons
│   └── Base.lproj/                    # Base localization
│       ├── Main.storyboard
│       └── LaunchScreen.storyboard
│
├── MuiscTempoWithHRTests/             # Unit tests
└── MuiscTempoWithHRUITests/           # UI tests
```

## Installation

### Prerequisites

1. **macOS** (Monterey or later)
2. **Xcode 14+** - [Download from App Store](https://apps.apple.com/us/app/xcode/id497799835)
3. **iOS 15.0+** deployment target
4. **Swift 5.5+**

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/zchalmers/MusicTempoWithHR.git
   cd MusicTempoWithHR
   ```

2. **Open in Xcode**
   ```bash
   open MusicTempoWithHR.xcodeproj
   ```
   Or double-click `MusicTempoWithHR.xcodeproj` in Finder

3. **Add Audio Files** (if not included)
   - Drag and drop audio files into `Modules/songs/` directory
   - Ensure files are added to target membership
   - Supported formats: MP3, M4A, WAV

4. **Select Target Device**
   - Choose a simulator (iPhone 14 Pro recommended)
   - Or connect a physical iOS device

5. **Build and Run**
   - Press `Cmd + R` or click the Run button
   - Wait for build to complete
   - App will launch with music player interface

## Usage

### Basic Playback

1. **Launch the App** - Opens to the main music player interface
2. **View Current Song** - Song name and artwork displayed
3. **Play/Pause** - Tap play button (if implemented)

### Adjusting Tempo

1. **Use the Slider** - Drag the tempo slider left or right
   - **Left (0.5x)**: Slower playback (50% speed)
   - **Center (1.0x)**: Normal playback speed
   - **Right (2.0x)**: Faster playback (200% speed)

2. **View Current Tempo** - Tempo label updates in real-time

### Tempo Use Cases

- **Slower (0.5x - 0.8x)**: 
  - Learning new songs
  - Practicing complex rhythms
  - Relaxation or meditation

- **Normal (1.0x)**:
  - Standard listening
  - Original song tempo

- **Faster (1.2x - 2.0x)**:
  - High-intensity workouts
  - Matching faster heart rates
  - Quick learning/review

## Architecture

### MVVM with Presenter

```
┌─────────────────┐
│  MainViewController │  ← View Layer
│  (MainView)        │
└────────┬──────────┘
         │ Delegate & DataSource
         ↓
┌─────────────────┐
│  MainPresenter  │  ← Presenter Layer
└────────┬──────────┘
         │
         ↓
┌─────────────────┐
│  MainViewModel  │  ← ViewModel Layer
└────────┬──────────┘
         │
         ↓
┌─────────────────┐
│  AudioPlayer    │  ← Service Layer
└────────┬──────────┘
         │
         ↓
  AVAudioPlayer
```

### Components

**MainViewController**
- Manages UI presentation
- Handles user interactions (slider)
- Implements `MainView` protocol
- Updates UI based on data source

**MainPresenter**
- Coordinates between View and ViewModel
- Implements business logic
- Manages `MainDelegate` protocol

**MainViewModel**
- Stores presentation state
- Prepares data for display
- Implements `MainDataSource` protocol

**AudioPlayer**
- Handles audio playback
- Manages song queue
- Controls playback rate
- Implements `AVAudioPlayerDelegate`

## Extending for Heart Rate Integration

### Adding HealthKit Support

1. **Enable HealthKit Capability** in Xcode
2. **Add Privacy Usage** to Info.plist:
   ```xml
   <key>NSHealthShareUsageDescription</key>
   <string>We need access to your heart rate to adjust music tempo</string>
   ```

3. **Import HealthKit**:
   ```swift
   import HealthKit
   ```

4. **Request Authorization**:
   ```swift
   let healthStore = HKHealthStore()
   let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
   healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { success, error in
       // Handle authorization
   }
   ```

5. **Query Heart Rate**:
   ```swift
   func startHeartRateQuery() {
       let heartRateQuery = HKAnchoredObjectQuery(...)
       // Process heart rate data
       // Adjust tempo based on BPM
   }
   ```

### Heart Rate to Tempo Mapping

Example algorithm:
```swift
func calculateTempo(heartRate: Double) -> Float {
    // Map HR zones to tempo multipliers
    switch heartRate {
    case 60...100:  return 0.8  // Resting
    case 100...130: return 1.0  // Light activity
    case 130...160: return 1.3  // Moderate
    case 160...190: return 1.6  // Intense
    default:        return 1.0  // Default
    }
}
```

### Apple Watch Integration

For real-time heart rate during workouts:
1. Create WatchOS companion app
2. Use `HKWorkoutSession` for continuous HR monitoring
3. Send HR data to iPhone via `WatchConnectivity`
4. Adjust tempo in real-time

## Audio Player API

### Key Methods

```swift
class AudioPlayer {
    // Initialize with song URLs
    init(songURLs: [URL])
    
    // Playback controls
    func playSong()
    func pauseSong()
    func stopSong()
    
    // Tempo adjustment (0.5 - 2.0)
    func setTempo(tempo: Float)
    
    // Song management
    func nextSong()
    func previousSong()
    func setSongURLs(urls: [URL])
}
```

### Tempo Range

- **Minimum**: 0.5x (50% speed)
- **Maximum**: 2.0x (200% speed)
- **Default**: 1.0x (normal speed)

## Testing

### Running Unit Tests

1. **In Xcode**: `Cmd + U`
2. **View Test Navigator**: `Cmd + 6`
3. **Run specific test**: Click diamond next to test name

### Running UI Tests

1. Select UI test target
2. Press `Cmd + U`
3. Watch simulator execute automated UI tests

## Troubleshooting

### Common Issues

**Audio Not Playing**
- Verify audio files are in project bundle
- Check file formats (MP3, M4A supported)
- Ensure files are added to target membership
- Check device volume/mute switch

**Slider Not Responding**
- Verify outlet connections in Storyboard
- Check `sliderValueChanged` target-action
- Ensure `dataSource` is set

**Tempo Not Changing**
- Verify `player?.enableRate = true` is set
- Check tempo range (0.5 - 2.0)
- Ensure audio file supports rate changes

**Build Errors**
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`
- Check Swift version compatibility

**Storyboard Issues**
- Verify `MainViewController.storyboard` exists
- Check storyboard ID matches code
- Rebuild Interface Builder cache

## Development

### Adding New Songs

1. Drag audio files into `Modules/songs/`
2. Check "Copy items if needed"
3. Add to target
4. Update `songURLs` array in initialization

### Customizing UI

Edit `MainViewController.storyboard`:
- Modify slider appearance
- Add play/pause buttons
- Customize labels and fonts
- Add album artwork

### Extending Features

**Suggestions**:
- Add playlist management
- Implement equalizer
- Add song search
- Support streaming audio
- Add favorites/bookmarks
- Implement shuffle/repeat
- Add lyrics display

## Future Enhancements

- [ ] Heart rate sensor integration (HealthKit)
- [ ] Apple Watch companion app
- [ ] Automatic tempo adjustment based on HR zones
- [ ] Custom tempo curves for different activities
- [ ] Playlist creation and management
- [ ] Music library integration
- [ ] Bluetooth HR monitor support
- [ ] Workout tracking and history
- [ ] Spotify/Apple Music integration
- [ ] Social features (share workouts)
- [ ] Dark mode support
- [ ] iPad support

## Requirements

- **Deployment Target**: iOS 15.0+
- **Development**: macOS with Xcode 14+
- **Language**: Swift 5.5+
- **Devices**: iPhone (iPad compatible)

## Performance Notes

- Audio playback uses minimal CPU
- Tempo changes are real-time with no latency
- Supports background audio (with proper configuration)
- Battery efficient for workout sessions

## Contributing

This is a personal project, but suggestions and improvements are welcome!
- Report bugs via Issues
- Suggest features
- Submit pull requests

## License

This project is available for educational purposes.

## Contact

- **GitHub**: [@zchalmers](https://github.com/zchalmers)

## Acknowledgments

- Built with AVFoundation framework
- Designed for fitness and tempo-based activities
- Inspired by workout music apps
- Sample songs for demonstration purposes

## Related Projects

If you enjoyed this project, check out:
- [LearnSwift](https://github.com/zchalmers/LearnSwift) - iOS Food Recipe App
- [StockSimulation](https://github.com/zchalmers/StockSimulation) - Stock market simulator
