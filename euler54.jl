module Euler54
using PokerHand

function createtuplehand(line)

    hand = Array(Tuple, 5)
    
    i = 1
    for card in split(line, " ")
        hand[i] = (card[1], card[2])
        i += 1
    end

    return hand

end

function parseintohands(line)

    midway = int(length(line)/2)
    
    return Hand(createtuplehand(strip(line[1:midway]))), Hand(createtuplehand(strip(line[midway:])))
    
end

pokerhandsfile = open("poker.txt")

winners = 0

while(!eof(pokerhandsfile))
    
    player1hand, player2hand = parseintohands(readline(pokerhandsfile))
    
    if isgreater(player1hand, player2hand)
        winners += 1
    end
    
end

println("Player 1 wins ", winners, " hands")
println("Player 2 wins ", 1000-winners, " hands")

close(pokerhandsfile)
end
