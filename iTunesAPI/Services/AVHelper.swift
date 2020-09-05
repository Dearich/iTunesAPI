//
//  AVHelper.swift
//  iTunesAPI
//
//  Created by Азизбек on 04.09.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//
import UIKit
import AVFoundation

class AVHelper: NSObject {

  var player: AVAudioPlayer?
  var currentTrackIndex = 0
  var tracks = [Song]()

  init(tracks: [Song]) {
    self.tracks = tracks
  }

  func getTrack(with url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      guard let url = URL(string: url) else { return }
      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
        if let data = data {
          completion(.success(data))
          if let error = error {
            completion(.failure(error))
          }
        }
      })
      task.resume()
    }
  }

  func queueTrack(completion: @escaping () -> Void) {
    if (player != nil) {
      player = nil
    }
    getTrack(with: tracks[currentTrackIndex].previewURL ?? "") { [weak self] (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let data):
          do {
            self?.player =  try AVAudioPlayer(data: data)
            self?.player?.delegate = self
            self?.player?.prepareToPlay()
            completion()
          } catch let error {
            print(error.localizedDescription)
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }

  func play() {
    if player?.isPlaying == false {
      player?.play()
    }
  }

  func stop() {
    if player?.isPlaying == true {
      player?.stop()
      player?.currentTime = 0
    }
  }

  func pause() {
    if player?.isPlaying == true {
      player?.pause()
    }
  }

  func nextSong(songFinishedPlaying:Bool, comlition: @escaping () -> Void) {
    var playerWasPlaying = false
    if player?.isPlaying == true {
      player?.stop()
      playerWasPlaying = true
    }

    currentTrackIndex += 1
    if currentTrackIndex >= tracks.count {
      currentTrackIndex = 0
    }
    queueTrack {
      if playerWasPlaying || songFinishedPlaying {
        comlition()
      }
    }
  }

  func previousSong() {
    var playerWasPlaying = false
    if player?.isPlaying == true {
      player?.stop()
      playerWasPlaying = true
    }
    currentTrackIndex -= 1
    if currentTrackIndex < 0 {
      currentTrackIndex = tracks.count - 1
    }
    if playerWasPlaying {
      player?.play()
    }
  }

  func getCurrentTrackName() -> String {
    guard  let trackName = tracks[currentTrackIndex].trackName else { return String() }
      return trackName
  }

  func getCurrentTimeAsString() -> String {
    var seconds = 0
    var minutes = 0
    if let time = player?.currentTime {
      seconds = Int(time) % 60
      minutes = (Int(time) / 60) % 60
    }
    return String(format: "%0.2d:%0.2d",minutes,seconds)
  }

  func getProgress() -> Float {
    var theCurrentTime = 0.0
    var theCurrentDuration = 0.0
    if let currentTime = player?.currentTime, let duration = player?.duration {
      theCurrentTime = currentTime
      theCurrentDuration = duration
    }
    return Float(theCurrentTime / theCurrentDuration)
  }

  func setVolume(volume:Float) {
      player?.volume = volume
  }
}

extension AVHelper: AVAudioPlayerDelegate {

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if flag == true {
      nextSong(songFinishedPlaying: true, comlition: { [weak self] in
        self?.play()
      })
    }
  }
}
