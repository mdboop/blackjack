assert = chai.assert

describe "Natural Blackjack", ->

  it "should detect a dealer Blackjack hand", ->
    game = new GameView(model: new Game())
    dealer = game.model.get 'dealerHand'
    dealer.remove(dealer.at(0))
    dealer.remove(dealer.at(0))
    first = new Card(rank: 0, suit: 'spades')
    second = new Card(rank: 1, suit: 'spades')
    dealer.add(first)
    dealer.add(second)
    assert.strictEqual dealer.hasBlackJack(), true