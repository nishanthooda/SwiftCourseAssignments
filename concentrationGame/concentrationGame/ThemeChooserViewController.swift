//
//  ThemeChooserViewController.swift
//  FlipCard
//
//  Created by Nishant Hooda on 2018-01-06.
//  Copyright © 2018 Nishant Hooda. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    // MARK: - Navigation
    
    let themes = [
        "Sports":"⚽️🏀🏐🏉🎱🏸🏓🏏🏑🏹⛳️🥊",
        "Animals":"🐶🐰🐻🦁🐒🐧🐥🐝🐴🐣🐭🐱",
        "Faces":"😆😃😂😌😇😊😅🤩☹️😖"
    ]
    
    @IBAction func ChangeTheme(_ sender: Any) {
        if let flipCardTheme = keepCurrentGameViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                flipCardTheme.theme = theme
            }
        }else if let flipCardTheme = lastSegueView{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                flipCardTheme.theme = theme
            }
            navigationController?.pushViewController(flipCardTheme, animated: true)
        }
        else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    private  var keepCurrentGameViewController: FlipCardViewController? {
        return splitViewController?.viewControllers.last as? FlipCardViewController
    }
    
    private var lastSegueView: FlipCardViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Choose Theme"{
            
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let flipCardTheme = segue.destination as? FlipCardViewController{
                    flipCardTheme.theme = theme
                    lastSegueView = flipCardTheme
                }
            }
        }
    }
}

