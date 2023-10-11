# Analytica Procurement Solution
Is a procurement solution with four modules Reverse auction, Request for quotations board, Tender board and
a Logistics solution

## Reverse Auction
The reverse auction module is a system on its own. To use it users should have an account and a subscription. Companies subscribe 
for either a role as a supplier or as buyer.

Buyers have the ability to host an auction adding lots to it. Like a live auction an auction has a start date and a deadline.
During the period suppliers can come in with offers/bids for lots/products that in the auction. The bids supplied by suppliers
should have at least four pictures of the item requested. The lowest price offered is the one that wins

Suppliers can only bid for a lot that is in the auction in the supplier's region. Thus the transport offered suggests that 
a lot will be delivered within the city. The suppliers can save the lots that they wish to bid for. Theses lots can then be 
viewed in the collections page. There lots for expired auctions and lots for live auctions are seperated. Once an auction has expired 
no one can bid.

## Requests for quotations(RFQ)
A board that shows requests for quotations by individuals and companies. The Requests on the board are added by the super admin.
Hence every request must be listed by Analytica from an Admin perspective.

## Tender board
A board that consists of tenders listed by Analytica as soon as the period for the tenders expires they become unlisted 
on the board. Theses tenders are listed by Analytica from an Admin Perspective

## Logistics
Coming soon

## Tech stack
- Databases: PostgreSQL
- Backend: Ruby on rails
- Testing: Rspec and Factorybot
- Languages: Ruby and JavaScript
- Frontend: Bootstrap and JavaScript
- Version Control: Git
- CI/CD: Github actions, Render and Docker
- Project mgt: Trello