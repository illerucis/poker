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


function unpackhand(hand)
    [ index("-23456789TJQKA", rank) for (rank, suit) in hand ]
end
    

function evalhand(hand)
    # unpack hands
    ranks = unpackhand(hand)
end
