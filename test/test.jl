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
    
    context("Full evaluator run solves Project Euler #54") do
        
        winners, losers = testeuler54()

        @fact winners => 376
        @fact losers => 624

    end

    context("The Hand type's isless and isequal functions") do

        # full house, 3 2's, 2 3's
        fullhouse1 = Hand([("2", "D"), ("3", "S"), ("2", "C"), ("2", "H"), ("3", "D")])

        # full house, 3 3's, 2 2's
        fullhouse2 = Hand([("3", "D"), ("2", "S"), ("3", "C"), ("3", "H"), ("2", "D")])

        @fact true => fullhouse1 < fullhouse2
        @fact false => fullhouse2 <= fullhouse1
        @fact false => fullhouse1 == fullhouse2
        @fact false => fullhouse1 > fullhouse2
        @fact false => fullhouse1 >= fullhouse2

    end

end
