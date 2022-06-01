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
private let ICON_BIG = "icon-big"
private let PORTRAIT = "portrait"

private let ALL = "all"

struct GenshinApi {
    private let url = URL(string: BASE_URL)
    
    // MARK: - Characters
    // Get characters' id
    func getCharacterIds(completion: @escaping ([String]) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS) else {
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
    func getCharacter(id: String, completion: @escaping (Character) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(id) else {
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
    func getCharacterGachaSplash(id: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(id).appendingPathComponent(GACHA_SPLASH) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response?.mimeType != WEBP_MIME_TYPE) {
                DispatchQueue.main.async {
                    getCharacterPortrait(id: id) { image in
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
    
    // Get character's icon
    func getCharacterIcon(id: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(id).appendingPathComponent(ICON) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response?.mimeType != WEBP_MIME_TYPE) {
                // TODO: Change default image
                let image = Image("turtlerock")

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
    
    // Get character's icon-big
    func getCharacterIconBig(id: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(id).appendingPathComponent(ICON_BIG) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response?.mimeType != WEBP_MIME_TYPE) {
                DispatchQueue.main.async {
                    getCharacterIcon(id: id) { image in
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
    func getCharacterPortrait(id: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(id).appendingPathComponent(PORTRAIT) else {
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
    // Get weapons' id
    func getWeaponIds(completion: @escaping ([String]) -> ()) {
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
    
    // Get weapons' detail
    func getWeapons(completion: @escaping ([Weapon]) -> ()) {
        guard let url = url?.appendingPathComponent(WEAPONS).appendingPathComponent(ALL) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode([Weapon].self, from: data)

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
    // Get elements' id
    func getElementIds(completion: @escaping ([String]) -> ()) {
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
