require("handeval.jl")

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
    
    return createtuplehand(strip(line[1:midway])), createtuplehand(strip(line[midway:]))
    
end

function player1wins(player1hand, player2hand)
    
    p1result = evalhand(player1hand)
    p2result = evalhand(player2hand)

    return ( p1result[1] > p2result[1] ) || ( p1result[1] == p2result[1] && p1result[2] >= p2result[2] )
    
end

pokerhandsfile = open("poker.txt")

winners = 0

while(!eof(pokerhandsfile))
    
    player1hand, player2hand = parseintohands(readline(pokerhandsfile))

    if player1wins(player1hand, player2hand)
        winners += 1
    end
    
end

println("Player 1 wins ", winners, " hands")
println("Player 2 wins ", 1000-winners, " hands")

close(pokerhandsfile)
