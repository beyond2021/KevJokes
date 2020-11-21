//
//  ContentView.swift
//  KevJokes
//
//  Created by KEEVIN MITCHELL on 11/17/20.
//

import SwiftUI

//    struct Joke: Identifiable {
//        var id = UUID()
//        var setup: String
//        var punchline: String
//        var rating: String
//    }
    
//struct Joke {
//    var setup: String
//    var punchline: String
//    var rating: String
//}


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    
    //Give me some Data from CoreData please - NSFetchRequest - load jokes from CD
    @FetchRequest(entity: Joke.entity(), sortDescriptors: [
                    NSSortDescriptor(keyPath: \Joke.setup, ascending: true)
    ])var jokes: FetchedResults<Joke>
    //
    @State private var showingAddJoke = false // setting the flag for add joke button to false

    //Model
//    let jokes = [
//        Joke(setup: "Whats a cow's favorite place?", punchline: "A mooseum", rating: "Silence"),
//        Joke(setup: "Whats brown and sticky?", punchline: "A stick", rating: "Sigh"),
//        Joke(setup: "Whats orange and sounds like a parrot?", punchline: "A carrot.", rating: "Smirk")
//    ]
    
    
    
    var body: some View {
        //when a joke is added from Fetch body is automatically reloaded and the row is added
       
//        NavigationView {
//            List {
//                ForEach(jokes, id: \.setup) { joke in
//                    NavigationLink(destination: Text(joke.punchline)) {
//                        EmojiView(for: joke.rating)
//                        Text(joke.setup)
//                    }
//
//                }
//                // onDelete only works with ForEach not List
//                .onDelete(perform: removeJokes)
//            }
//            .navigationBarTitle("All Groan Up")
//            .navigationBarItems(leading: EditButton(), trailing:Button("Add") {
//                self.showingAddJoke.toggle()
//
//                })
            //like a model VC sheet
        ZStack(alignment: .top){
            
            LinearGradient(gradient: Gradient(colors: [Color("Start"), Color("Middle"), Color("End")]), startPoint: .top, endPoint: .bottom)
            // stack all the jokes in the database with ascrollView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:10){
                    ForEach(jokes, id: \.setup) { joke in
                        JokeCard(joke: joke)
                    }
                }.padding()
            }
            
            
            Button("Add Joke") {
                self.showingAddJoke.toggle()
            }
            //Style the button
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(Capsule())
            .foregroundColor(.white)
            // push button down
            .offset(y: 50)
            
            }
        .edgesIgnoringSafeArea(.all)
      
        // when to show button
        .sheet(isPresented: $showingAddJoke) {
                //when this true show whats in here
                AddView().environment(\.managedObjectContext, self.moc)
                
                //when dismiss it will set $showingAddJoke  to false again
            
        }
      
    }
    // remove vote
    func removeJokes(at offsets: IndexSet) {
        // loop over all the offsets
        for index in offsets {
            let joke = jokes[index]
            moc.delete(joke)  // find the joke at that position and delete it from moc
        }
        
        
        try? moc.save()
        //save the the moc
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
