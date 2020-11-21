//
//  AddView.swift
//  KevJokes
//
//  Created by KEEVIN MITCHELL on 11/17/20.
//

import SwiftUI

struct AddView: View {
    //This view needes to read the managedObjectContext. do urworkthen save the context
    //read our manobcon from the environment so we can use it locally
    @Environment(\.managedObjectContext) var  moc
    
    //
    @Environment(\.presentationMode) var presentationMode // to didmiss sheet // isthe screen presented or not // hide screen
    
    
    //handle the data for our joke
    @State private var setup = ""
    @State private var punchline = ""
    @State private var rating = "Silence"
    // the rest of the ratingsn to be shown in the picker
    let ratings = ["Sob", "Sigh", "Silence", "Smirk"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Setup", text: $setup)//show the setup text in this textfield
                    TextField("Punchline", text: $punchline)//show the setup text in this textfield
                    Picker("Rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                }
                
                Button("Add Joke") {
                    //create a new joke instance - not a struct anymore
                    let newJoke = Joke(context: self.moc)
                    // copy all our properties into newJoke
                    newJoke.setup = self.setup
                    newJoke.punchline = self.punchline
                    newJoke.rating = self.rating
                    // all copied into moc
                    
                    //save
                    do {
                        try self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Whoops! \(error.localizedDescription)")
                    }
                    
                }
            }.navigationBarTitle("New Joke")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
