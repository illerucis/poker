#     hands something like [('2', 'D'), ('3', 'S'), ('4', 'D'), ('5', 'H'), ('6', 'C')]

#     straight flush - 9
#     four of a kind - 8
#     full house - 7
#     flush - 6
#     straight - 5
#     three of a kind - 4
#     two pair - 3
#     one pair - 2
#     high card - 1

#     group cards by numbers, separately test for flush


#     ((4, 1), (6, 2))

#     (4, 1) => 8


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

function evalhand(hand)

    handtypes = { hash((4,)) => "fourofakind", hash((3, 2)) => "fullhouse", hash((3, 1, 1)) => "threeofakind",
                  hash((2, 2, 1)) => "twopair", hash((2, 1, 1, 1)) => "onepair" }
             
    handspoints = { "straightflush" => 9, "fourofakind" => 8, "fullhouse" => 7, "flush" => 6,
                    "straight" => 5, "threeofakind" => 4, "twopair" => 3, "onepair" => 2, "highcard" => 1 }

    # Unpack hand
    ranks = [search("-23456789TJQKA", rank) for (rank, suit) in hand]
    
    # group counts and ranks
    counts, ranks = groupranks(ranks)
    
    # check for two hand types that the count hash won't give us
    isstraight = ( length(counts) == 5 ) && ( ranks[1] - ranks[5] == 4 )
    isflush = length(keys( {  s => s for (r, s) in hand } )) == 1

    handtype = hash(counts)
        
    if isstraight && isflush
        return handspoints["straightflush"], ranks
        
    elseif isstraight
        return handspoints["straight"], ranks
        
    elseif isflush
        return handspoints["flush"], ranks
        
    elseif haskey(handtypes, handtype)      
        return handspoints[handtypes[handtype]], ranks

    else
        return handspoints["highcard"], ranks
    end
    
end
