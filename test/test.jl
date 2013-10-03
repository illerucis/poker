using Poker
using FactCheck

function parseintohands(line)

    midway = int(length(line)/2)
    
    return Hand(strip(line[1:midway])), Hand(strip(line[midway:]))
    
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
    
    context("Test that solves Project Euler #54") do
        
        winners, losers = testeuler54()
        
        @fact winners => 376
        @fact losers => 624

    end

    context("Test evaluate()") do

        # high card ace kicker
        highcardAce = Hand("2D 3S 4H 5C AD")
        points, ranks = evaluate(highcardAce)
        @fact points => 1
        @fact ranks => (14, 5, 4, 3, 2)

        # one pair
        onepair = Hand("2D 2H 3H 4D AS")
        points, ranks = evaluate(onepair)
        @fact points => 2
        @fact ranks => (2, 14, 4, 3)

        # two pair
        twopair = Hand("5D 7C 5S 8D 7H")
        points, ranks = evaluate(twopair)
        @fact points => 3
        @fact ranks => (7, 5, 8)

        # three of a kind
        threeofakind = Hand("AD AH AS KD 4S")
        points, ranks = evaluate(threeofakind)
        @fact points => 4
        @fact ranks => (14, 13, 4)

        # straight
        straight = Hand("2D 3H 4S 5D 6H")
        points, ranks = evaluate(straight)
        @fact points => 5
        @fact ranks => (6, 5, 4, 3, 2)

        # flush
        flush = Hand("2D 5D 8D KD QD")
        points, ranks = evaluate(flush)
        @fact points => 6
        @fact ranks => (13, 12, 8, 5, 2)

        # full house
        fullhouse = Hand("5D KH 5S KD KC")
        points, ranks = evaluate(fullhouse)
        @fact points => 7
        @fact ranks => (13, 5)

        # four of a kind
        fourofakind = Hand("3D 3H 3S 3C AH")
        points, ranks = evaluate(fourofakind)
        @fact points => 8
        @fact ranks => (3, 14)

        # straight flush
        straightflush = Hand("8H 9H TH JH QH")
        points, ranks = evaluate(straightflush)
        @fact points => 11
        @fact ranks => (12, 11, 10, 9, 8)
        
    end

    context("Test isless and isequal") do

        # full house, 3 2's, 2 3's
        fullhouse1 = Hand("2D 3S 2C 2H 3D")

        # full house, 3 3's, 2 2's
        fullhouse2 = Hand("3D 2S 3C 3H 2D")
        
        @fact true => fullhouse1 < fullhouse2
        @fact true => fullhouse2 > fullhouse1
        @fact true => fullhouse2 != fullhouse1

        # high card ace kicker
        highcardAce = Hand("2D 3S 4H 5C AD")
        # high card king kicker
        highcardKing = Hand("2D 3S 4H 5C KD")
        
        @fact true => highcardKing < highcardAce
        @fact true => highcardAce > highcardKing
        @fact true => highcardAce != highcardKing

        # high card ace kicker
        highcardAce1 = Hand("2D 3S 4H 5C AD")
        highcardAce2 = Hand("AD 3S 5C 4H 2D")

        @fact true => highcardAce1 == highcardAce2
        
    end

    context("countrank(ranks) tests") do
    end
    
    
end
