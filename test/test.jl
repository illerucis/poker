using Poker
using FactCheck

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

function testeuler54()
    
    pokerhandsfile = open("Poker/test/poker.txt")

    winners = 0
    losers = 0

    while(!eof(pokerhandsfile))
        
        player1hand, player2hand = parseintohands(readline(pokerhandsfile))
    
        if player1hand >= player2hand
            winners += 1
        else
            losers += 1
        end
    end

    close(pokerhandsfile)
    return winners, losers

end

facts("Test suite for Poker's hand evaluator") do
    
    context("Tests the full evaluator via Project Euler #54") do
        
        winners, losers = testeuler54()

        @fact winners => 376
        @fact losers => 624

    end
end
