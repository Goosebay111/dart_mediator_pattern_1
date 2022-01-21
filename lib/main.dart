// ignore_for_file: avoid_print
// imagine this as a silent auction, where the buyers don't know what the others are bidding or if the others have
// withdrawn their bids or won the auction.
// The buyers hold an instance of the mediator, which they use notify to send an instance of themselves and an action.
// The mediator has the ability to change the state of the auction, and the buyers has the ability to notify the mediator
// of their intentions.
// importantly, the mediator has the ability to review the details of all of the buyers to make a
// comparative decision about the outcome of the auction (so it knows about the bidders intents).

void main() {
  AuctionMediator mediator = AuctionMediator();
  Buyer buyer1 = AuctionBuyer(mediator, "buyer1");
  Buyer buyer2 = AuctionBuyer(mediator, "buyer2");
  Buyer buyer3 = AuctionBuyer(mediator, "buyer3");
  // Create and add buyers
  mediator.addBuyer(buyer1);
  mediator.addBuyer(buyer2);
  mediator.addBuyer(buyer3);
  print('Welcome to the auction, Tonight!');
  print('We are selling a vacation to Las Vegas.');
  print('Please bid on our vacation home.');
  print('-------------------------------------');
  print('Waiting for the buyer\'s offers...');
  // Make bids
  buyer1.setBid(1800);
  buyer2.setBid(2200);
  buyer3.setBid(780);
  print('-------------------------------------');
  print('All of the bids are in...');
  mediator.findHighestBidder();
  buyer2.cancelBid();
  print('${buyer2.name} has cancelled their bid.');
  print('in that case');
  mediator.findHighestBidder();
}

abstract class Mediator {
  void addBuyer(Buyer buyer);
  void findHighestBidder();
  void notify(Buyer buyer, String event);
}

/*holds a list of buyers*/
/*AuctionMediator calls functions to compare values of the different classes*/
class AuctionMediator implements Mediator {
  List<Buyer> buyers = [];

  @override
  void addBuyer(Buyer buyer) {
    buyers.add(buyer);
    print('${buyer.name} added to auction');
  }

  @override
  void findHighestBidder() {
    buyers.sort((a, b) => a.bid.compareTo(b.bid));
    print('Highest bid is ${buyers.last.bid}');
  }

  @override
  void notify(Buyer buyer, String event) {
    if (event == 'bid') {
      buyers.where((e) => e == buyer).toList();
    } else if (event == 'cancel') {
      buyers.where((e) => e == buyer).toList();
    }
  }
}

abstract class Buyer {
  Mediator mediator;
  String name;
  int? price;

  Buyer(this.mediator, this.name);

  get bid => price;
  setBid(int _price) {
    price = _price;
    mediator.notify(this, 'bid');
  }

  void cancelBid();
}

class AuctionBuyer extends Buyer {
  AuctionBuyer(Mediator mediator, String name) : super(mediator, name);

  @override
  void cancelBid() {
    price = 0;
    mediator.notify(this, 'cancel');
  }
}
