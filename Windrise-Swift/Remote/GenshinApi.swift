//
//  API.swift
//  Windrise-Swift
//
//  Created by user on 14/05/22.
//

import Foundation
import UIKit
import SwiftUI

private let BASE_URL = "https://api.genshin.dev/"

private let WEBP_MIME_TYPE = "image/webp"

private let CHARACTERS = "characters"
private let WEAPONS = "weapons"
private let ELEMENTS = "elements"

private let GACHA_SPLASH = "gacha-splash"
private let ICON = "icon"
private let PORTRAIT = "portrait"

private let ALL = "all"

struct GenshinApi {
    private let url = URL(string: BASE_URL)
    
    // MARK: - Characters
    // Get characters' name
    func getCharactersName(completion: @escaping ([String]) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                // FIXME: Possible crash issue when failed to connect to the API
                return
            }

            do {
                let response = try JSONDecoder().decode([String].self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // Get characters' detail
    func getCharacters(completion: @escaping ([Character]) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(ALL) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode([Character].self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // Get character by name
    func getCharacter(name: String, completion: @escaping (Character) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(name) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode(Character.self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // Get character's gacha splash
    func getCharacterGachaSplash(name: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(name).appendingPathComponent(GACHA_SPLASH) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response?.mimeType != WEBP_MIME_TYPE) {
                DispatchQueue.main.async {
                    getCharacterPortrait(name: name) { image in
                        completion(image)
                    }
                }
            } else {
                do {
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        })
        .resume()
    }
    
    // Get character's portrait
    func getCharacterPortrait(name: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(name).appendingPathComponent(PORTRAIT) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response?.mimeType != WEBP_MIME_TYPE) {
                // TODO: Change default image
                let image = Image("turtlerock_feature")

                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do {
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        })
        .resume()
    }
    
    // MARK: - Weapons
    // Get all weapons
    func getWeapons(completion: @escaping ([String]) -> ()) {
        guard let url = url?.appendingPathComponent(WEAPONS) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode([String].self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // MARK: - Elements
    // Get all elements
    func getElements(completion: @escaping ([String]) -> ()) {
        guard let url = url?.appendingPathComponent(ELEMENTS) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode([String].self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // Get an element
    func getElement(element: String, completion: @escaping (Element) -> ()) {
        let element = element.lowercased()
        
        guard let url = url?.appendingPathComponent(ELEMENTS).appendingPathComponent(element) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode(Element.self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // Get element's icon
    func getElementIcon(element: String, completion: @escaping (Image) -> ()) {
        let element = element.lowercased()
        
        guard let url = url?.appendingPathComponent(ELEMENTS).appendingPathComponent(element).appendingPathComponent(ICON) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                
                let image = Image(uiImage: uiImage)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        })
        .resume()
    }
}
