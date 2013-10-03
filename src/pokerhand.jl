# hands something like [('2', 'D'), ('3', 'S'), ('4', 'D'), ('5', 'H'), ('6', 'C')]
#
# straight flush - 11
# four of a kind - 8
# full house - 7
# flush - 6
# straight - 5
# three of a kind - 4
# two pair - 3
# one pair - 2
# high card - 1
#
# group cards by numbers, separately test for flush and straight
# ((4, 1), (6, 2)) = (counts, ranks)
# reads like "there are four cards of rank 6, 1 card of rank 2"

# (4, 1) implies four of a kind 

type Hand

    cards::ASCIIString
    hand::Array

    function Hand(cards::ASCIIString)

        hand = Array(Tuple, 5)
        i = 1
        for card in split(cards, " ")
            hand[i] = (card[1], card[2])
            i += 1
        end

        new(cards, hand)
    end
end

function Base.isless(myhand::Hand, otherhand::Hand)
    
    myresult = evaluate(myhand)
    otherresult = evaluate(otherhand)

    return ( myresult[1] < otherresult[1] )  || ( myresult[1] == otherresult[1] && myresult[2] < otherresult[2] )

end

function Base.isequal(myhand::Hand, otherhand::Hand)

    myresult = evaluate(myhand)
    otherresult = evaluate(otherhand)

    return ( myresult[1] == otherresult[1] ) && ( myresult[2] == otherresult[2] )
end

function countranks(ranks)

    counts = Dict{Integer, Integer}()

    for rank in ranks

        if haskey(counts, rank)
            counts[rank] += 1
        else
            counts[rank] = 1
        end
    end

    return counts
end

function groupranks(ranks)

    # dictionary of rank to counts
    rankcounts = countranks(ranks)
    
    groupedranks = Array(Tuple, length(keys(rankcounts)))

    i = 1
    for rank in keys(rankcounts)
        groupedranks[i] = (rankcounts[rank], rank)
        i += 1
    end

    return zip(sort(groupedranks, rev=true)...)

end

function evaluate(h::Hand)
    
    handspoints = {(4, 1) => 8,
                   (3, 2) => 7,
                   (3, 1, 1) => 4,
                   (2, 2, 1) => 3,
                   (2, 1, 1, 1) => 2,
                   (1, 1, 1, 1, 1) => 1}
             
    # Unpack hand
    ranks = [search("-23456789TJQKA", rank) for (rank, suit) in h.hand]
    
    # group counts and ranks
    counts, ranks = groupranks(ranks)

    # check for two hand types that the count hash won't give us
    isstraight = ( length(counts) == 5 ) && ( ranks[1] - ranks[5] == 4 )
    isflush = length(keys( {  s => s for (r, s) in h.hand } )) == 1

    return max(handspoints[counts], 6*isflush + 5*isstraight), ranks
end
