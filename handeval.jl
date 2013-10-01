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

HANDTYPES = {
             hash((4,)) => "fourofakind",
             hash((3, 2)) => "fullhouse",
             hash((3, 1, 1)) => "threeofakind",
             hash((2, 2, 1)) => "twopair",
             hash((2, 1, 1, 1)) => "onepair"
             }
             
HANDSPOINTS = {
               "straightflush" => 9,
               "fourofakind" => 8,
               "fullhouse" => 7,
               "flush" => 6,
               "straight" => 5,
               "threeofakind" => 4,
               "twopair" => 3,
               "onepair" => 2,
               "highcard" => 1
               }

function unpackhand(hand)
    [search("-23456789TJQKA", rank) for (rank, suit) in hand]
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

    return unzip(sort(groupedranks, by=getfirstelem, rev=true))
    
end

function getfirstelem(iter)
    return iter[1]
end


function evalhand(hand)
    
    # Unpack hand
    ranks = unpackhand(hand)
    
    # group counts and ranks
    counts, ranks = groupranks(ranks)

    # check for two hand types that the count hash won't give us
    isstraight = ( length(counts) == 5 ) && ( ranks[1] - ranks[5] == 4 )
    isflush = length(keys( {  s => s for (r, s) in hand } )) == 1
        
    handtype = hash(counts)
    
    if isstraight && isflush
        return HANDSPOINTS["straightflush"], ranks
        
    elseif isstraight
        return HANDSPOINTS["straight"], ranks
        
    elseif isflush
        return HANDSPOINTS["flush"], ranks
        
    elseif haskey(HANDTYPES, handtype)      
        return HANDSPOINTS[HANDTYPES[handtype]], ranks

    else
        return HANDSPOINTS["highcard"], ranks
    end
    
end
    
function unzip(groupedranks)
    return zip(groupedranks...)
end
        
hand = [('2', 'D'), ('2', 'S'), ('K', 'D'), ('K', 'H'), ('2', 'C')]
println(evalhand(hand))
