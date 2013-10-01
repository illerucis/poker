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

function unpackhand(hand)
    [ search("-23456789TJQKA", rank) for (rank, suit) in hand ]
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
    groupedranks = sort(groupedranks, by=getfirstelem, rev=true)
    println(groupedranks)
end

function getfirstelem(iter)
    return iter[1]
end

function evalhand(hand)
    # Unpack hands
    ranks = unpackhand(hand)
    grouped = groupranks(ranks)
end

hand = [('2', 'D'), ('3', 'S'), ('K', 'D'), ('K', 'H'), ('6', 'C')]
evalhand(hand)
