//
//  JokeCard.swift
//  KevJokes
//
//  Created by KEEVIN MITCHELL on 11/19/20.
//
import CoreData
import SwiftUI

struct JokeCard: View {
    // to remove Core Data objects - delete
    @Environment(\.managedObjectContext) var moc
    
    
    
    @State private var showingPunchline = false
    // The joke thats showing
    
    //Take random out of body so its not called when State showing punchline reloads on toggle. this value is made once
    @State private var randomNumber = Int.random(in: 1...5)
    
    // To delete cards
    @State private var dragAmount = CGSize.zero
    
    var joke: Joke
    
    
    var body: some View {
       
        VStack {
            GeometryReader { geo in
            
                VStack {
                    //images - every card has an image showing a dad pic
                    Image("image\(self.randomNumber)")
                        .resizable()
                        .frame(width: 300, height: 100) // size for the space we have
                        .aspectRatio(contentMode: .fit)
                    
                    
                    
                    Text(self.joke.setup)
                        .font(.largeTitle)
                        .lineLimit(10) // for resizing text
                        .padding([.horizontal])
                        .foregroundColor(.black)
                    
                    
                    Text(self.joke.punchline)
                        .font(.title)
                        .lineLimit(10)
                        .padding([.horizontal, .bottom])
                        .foregroundColor(.black)
                    // hiding the punchline
                        .blur(radius: self.showingPunchline ? 0 : 6)
                        .opacity(self.showingPunchline ? 1 : 0.25)
                    
                    
                    
                }
                .multilineTextAlignment(.center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .black, radius: 5, x: 0, y: 0)
                )
                .onTapGesture {
                    // when the card is tapped I want to toggle showing punchline
    //                self.showingPunchline.toggle()
                    // lets toggle the boolean with animation animate any ui changes
                    
                    withAnimation {
                        self.showingPunchline.toggle()
                    }
                }
       
                .padding(.top, 300)
                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global) .minX) / 10), axis: (x: 0, y: 1, z:0))
//                .padding(.bottom, 64)
//
          }
            //outer V Stack
            EmojiView(for: joke.rating)
                .font(.system(size: 72))
        }
        //modifiers for outer VStack
        .frame(minHeight: 0, maxHeight: .infinity) // take up from zero to as much space as it needs
        .frame(width: 300)
        // drag the view
        .offset(y: dragAmount.height)
        .gesture(
            DragGesture()
                .onChanged{ self.dragAmount = $0.translation} // drag data
                .onEnded{ value in
                    if self.dragAmount.height < -200 {
                        // Delete this thing
                        withAnimation{
                            //1: move our view way off screen
                            self.dragAmount = CGSize(width: 0, height: -1000)
                        }
                        
                        
                    } else {
                        // it was an error, put it back to the starting point again
                        self.dragAmount = .zero
                        //delete
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.moc.delete(self.joke)
                            try? self.moc.save()
                        }
                    }
                }
        )
        // give the whole card an animation
        .animation(.spring())
    }
}


//This code do not go to the app store
struct JokeCard_Previews: PreviewProvider {
    static var previews: some View {
        // for coreData
        let joke = Joke(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        joke.setup = "What do you call a hen that counts her eggs?"
        joke.punchline = "A Mathemachicken"
        joke.rating = "Sigh"
        return JokeCard(joke: joke)
    }
}
