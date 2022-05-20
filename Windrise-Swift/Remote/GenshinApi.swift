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

private let CHARACTERS = "characters"
private let WEAPONS = "weapons"
private let ELEMENTS = "elements"

private let GACHA_SPLASH = "gacha-splash"
private let ICON = "icon"

struct GenshinApi {
    private let url = URL(string: BASE_URL)
    
    // MARK: - Characters
    // Get all characters
    func getCharacters(completion: @escaping ([String]) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
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
    
    // Get character by name
    func getCharacter(name: String, completion: @escaping (Character) -> ()) {
        guard let url = url?.appendingPathComponent(CHARACTERS).appendingPathComponent(name) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
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

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
                return
            }

            do {
                DispatchQueue.main.async {
                    // TODO: Change default image
                    let image = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "turtlerock-featured"))
                    completion(image)
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

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
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

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
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

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
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

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
                return
            }

            do {
                DispatchQueue.main.async {
                    // TODO: Change default image
                    let image = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "turtlerock"))
                    completion(image)
                }
            }
        })
        .resume()
    }
}
