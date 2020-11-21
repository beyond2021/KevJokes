//
//  EmojiView.swift
//  KevJokes
//
//  Created by KEEVIN MITCHELL on 11/17/20.
//

import SwiftUI

struct EmojiView: View {
    var rating: String
    var body: some View {
        // Could have used enumd but they dont play well with CoreData
        // what to show depending on the rating
        switch rating {
        case "Sob":
            return Text("😭")
        case "Sigh":
            return Text("😔")
        case "Smirk":
            return Text("😏")
        default:
            return Text("😐")
        }
    }
    //Custom init although we get an init from the struct
    init(for rating: String) {
        self.rating = rating
    }
}

struct EmojiView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiView(for: "Sob")
    }
}
