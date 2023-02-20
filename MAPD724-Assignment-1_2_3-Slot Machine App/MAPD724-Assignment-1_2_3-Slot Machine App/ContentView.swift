//
//  ContentView.swift
//  MAPD724-Assignment-1_2_3-Slot Machine App
//
//  Created by Sankjay Nithyanandalingam on 2023-01-24.
//
//  Authors & Student ID: Sankjay Nithyanandalingam (301296000), Victor Quezada (301286477)
//  File Name - MAPD724-Assignment-1_2_3-Slot Machine App
//  Created on: 2023-01-23
//  Modified last: 2023-01-05
//  Description - A Slot Machine App that provides a mini game experience where players can use virtual credits to bet and win agains randomly generated images that provide winnings when appeared in a particular order.
//
//  Version v1.0 - 2023-01-23
//  Version v1.1 - 2023-02-05
//

import SwiftUI

struct ContentView: View {
    
    //Declaring the variables
    @State private var credits = 1000
    @State private var winnings = 0
    @State private var globalJackpot = 0
    
    @State private var isSelected10 = Bool(false)
    @State private var isSelected50 = Bool(false)
    @State private var isSelected100 = Bool(false)
    @State private var isSelected500 = Bool(false)
    @State private var betAmount = 0
    
    //Decalring array of images
    private var symbols = ["slot_cherry_image", "slot_lemon_image", "slot_7_image"]
    @State private var numbers = [0, 1, 2]
    
    //The reset function
    private func reset ()
    {
        credits = 1000
        winnings = 0
        isSelected10 = false
        isSelected50 = false
        isSelected100 = false
        isSelected500 = false
        betAmount = 0
        
        //Just printing the reset values
        print("10 selection: " + String(isSelected10))
        print("50 selection: " + String(isSelected50))
        print("100 selection: " + String(isSelected100))
        print("500 selection: " + String(isSelected500))
    }
    
    //Reset bet selection
    private func resetBetSelection ()
    {
        isSelected10 = false
        isSelected50 = false
        isSelected100 = false
        isSelected500 = false
        betAmount = 0
    }
    
    //Function to win jackpot
    private func winJackpot ()
    {
        //Check for jackpot conditions
        if self.numbers[0] == 0 && self.numbers[1] == 1 && self.numbers[2] == 2
        {
            self.winnings += globalJackpot + (betAmount * 2)
            self.credits += betAmount
            globalJackpot = 0
            print("Amazing!! You Won the Jackpot!!")
            
        }
        //Otherwise just check win conditions
        else{
            
            winConditions ()
            
        }
        print(numbers)
        
    }
    
    //Function to check winnings
    private func winConditions ()
    {
        //Win bet
        if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2]
        {
            
            self.winnings += betAmount * 2
            self.credits += betAmount
            print("Congratulations!! You got lucky.. Keep Going!!")
            
        }
        
        //Lose bet
        else {
            self.globalJackpot += betAmount
            print("total jackpot after spin: " + String(globalJackpot))
            print("Winnings after spin: " + String(winnings))
            print("Bet amount for spin: " + String(betAmount))
            
            if credits == 0
            {
                print("Game Over")
                    
            } else {
                print("Oops.. You Lost!! Better Luck Next Time")
            }
        }
    }
    
    private func getAlert() -> Alert {
        return Alert(
        title: Text("Main Title"),
        message: Text("Error Description"),
        primaryButton: .cancel(), secondaryButton: .cancel()
        )
    }
    
    var body: some View {
        VStack
        {
            GeometryReader
            { geo in
                ZStack
                {
                    //App Background
                    Image ("slot_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: 900, alignment: .center)
                    
                    
                    //Slot Machine Image
                    Image ("slot_machine_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 395)
                        .position(x: 195, y: 440)
                        .opacity(0.9)
                    
                    //Reel Images
                    Image (symbols[numbers[0]])
                        .resizable()
                        .frame(width: 70, height: 100)
                        .position(x: 100, y: 405)
                    
                    
                    Image (symbols[numbers[1]])
                        .resizable()
                        .frame(width: 70, height: 100)
                        .position(x: 200, y: 405)
                    
                    
                    Image (symbols[numbers[2]])
                        .resizable()
                        .frame(width: 70, height: 100)
                        .position(x: 300, y: 405)
                    
                    //Credits counter
                    Text("Credits")
                        .position(x:70, y:0)
                        .font(.title)
                    Text("$" + String(credits)) //Amount Placeholders
                        .foregroundColor(.black)
                        .bold()
                        .padding(.all,8)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(20)
                        .position(x:70, y:35)
                    
                    //Winnings counter
                    Text("Winnings")
                        .position(x:320, y:0)
                        .font(.title)
                    Text("$" + String(winnings)) //Amount Placeholders
                        .foregroundColor(.black)
                        .bold()
                        .padding(.all,8)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(20)
                        .position(x:320, y:35)
                    
                    //Bet Title
                    Text("Select Bet") //Amount Placeholders
                        .foregroundColor(.black)
                        .bold()
                        .padding(.all,8)
                        .background(Color.teal.opacity(0.9))
                        .cornerRadius(20)
                        .position(x:197, y:70)
                    
                }
                HStack
                {
                    //Bet Button 10
                    Button(action: {
                        
                        //Checking if credits available and setting the bet amount
                        if credits >= 10
                        {
                            if isSelected10 == true || betAmount > 0
                            {
                                print ("Bet already selected")
                                
                            } else {
                                self.credits -= 10
                                isSelected10 = true
                                betAmount = 10
                                print ("bet selection: " + String(isSelected10))
                                print ("Bet Amount: " + String(betAmount))
                            }
                            
                        }
                        else {
                            print ("Not Enough Credits")
                        }
                        print("10 Pressed")
                    }, label: {
                        Text("$10")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,6)
                            .padding([.leading, .trailing], 20)
                            .border(.black)
                            .background(Color.pink)
                            .cornerRadius(8)
                            .position(x:45,y:110)
                    })
                    
                    //Bet Button 50
                    Button(action: {
                        
                        //Checking if credits available and setting the bet amount
                        if credits >= 50
                        {
                            if isSelected50 == true || betAmount > 0
                            {
                                print ("Bet already selected")
                                
                            } else {
                                self.credits -= 50
                                isSelected50 = true
                                betAmount = 50
                                print ("bet selection: " + String(isSelected50))
                                print ("Bet Amount: " + String(betAmount))
                            }
                        }
                        else {
                            print ("Not Enough Credits")
                        }
                        print("50 Pressed")
                    }, label: {
                        Text("$50")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,6)
                            .padding([.leading, .trailing], 20)
                            .border(.black)
                            .background(Color.pink)
                            .cornerRadius(8)
                            .position(x:45,y:110)
                    })
                    
                    //Bet Button 100
                    Button(action: {
                        
                        //Checking if credits available and setting the bet amount
                        if credits >= 100
                        {
                            if isSelected100 == true || betAmount > 0
                            {
                                print ("Bet already selected")
                                
                            } else {
                                self.credits -= 100
                                isSelected100 = true
                                betAmount = 100
                                print ("bet selection: " + String(isSelected100))
                                print ("Bet Amount: " + String(betAmount))
                            }
                        }
                        else {
                            print ("Not Enough Credits")
                        }
                        print("100 Pressed")
                    }, label: {
                        Text("$100")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,6)
                            .padding([.leading, .trailing], 15)
                            .border(.black)
                            .background(Color.pink)
                            .cornerRadius(8)
                            .position(x:45,y:110)
                    })
                    
                    //Bet Button 500
                    Button(action: {
                        
                        //Checking if credits available and setting the bet amount
                        if credits >= 500
                        {
                            if isSelected500 == true || betAmount > 0
                            {
                                print ("Bet already selected")
                                
                            } else {
                                self.credits -= 500
                                isSelected500 = true
                                betAmount = 500
                                print ("bet selection: " + String(isSelected500))
                                print ("Bet Amount: " + String(betAmount))
                            }
                        }
                        else {
                            print ("Not Enough Credits")
                        }
                            print("500 Pressed")
                    }, label: {
                            Text("$500")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all,6)
                                .padding([.leading, .trailing], 13)
                                .border(.black)
                                .background(Color.pink)
                                .cornerRadius(8)
                                .position(x:45,y:110)
                    })
                    
                }
                
                VStack{
                    Text("Jackpot: $" + String(globalJackpot))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.all,8)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(20)
                        .position(x:198, y:20)
                }
            }
            
            //Spin Button
            Button (action: {
                
                print("Spin Pressed")
                
                if betAmount > 0 {
                    //Randomising the images
                    self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
                    
                    //We can dirrectly call win condition if we don't want Jackpot condition
                    //winConditions()
                    
                    //Do Jackpot Conditions
                    winJackpot ()
                    
                    //Reseting bet selection
                    resetBetSelection()
                    
                } else {
                    print ("Please Select Bet Amount")
                }
                
                
            }, label: {
                Text("Spin")
                    .bold()
                    .font(.largeTitle)
                .frame(height: 20)
                .frame(maxWidth: 150)
                .background(Color.pink)
            })
            .buttonStyle(.borderedProminent)
            .position(x:198,y:340)
            .controlSize(.large)
            
            Group
            {

                HStack
                {
                    //Reset Button
                    Button("Reset") {
                        
                        //Reseting all values
                        reset ()
                        print("Reset Pressed")
                        
                    } 
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .position(x:50,y:200)
                    

                    //Quit Button
                    Button("Quit") {
                        
                        exit(0)
                        
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .position(x:150,y:200)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
