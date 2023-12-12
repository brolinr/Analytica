#buyer
DatabaseCleaner.clean_with(:truncation)

buyer_company = Company.create(
  email: 'remunyangabrolin@gmail.com',
  password: 'password',
  name: 'Buyer Company',
  phone: '0771232345',
  location: 'Location A',
  address: '6705 southlea park',
  terms_and_conditions: true,
  buyer: true
) do |company|
  pdf_path = Rails.root.join('spec/factories/media/documents/test.pdf')

  company.tax_clearance.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.certificate_of_incorporation.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.cr5.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.cr6.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
end

buyer_company.confirm


#seller

seller_company = Company.create!(
  email: 'brolinremz@gmail.com',
  password: 'password',
  name: 'Seller Company',
  phone: '0771232445',
  address: '6705 southlea park',
  terms_and_conditions: true,
  location: 'Location A',
  seller: true,
) do |company|
  pdf_path = Rails.root.join('spec/factories/media/documents/test.pdf')

  company.tax_clearance.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.certificate_of_incorporation.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.cr5.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.cr6.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
end

seller_company.confirm

# Create auctions
auction1 = Auction.create!(
  title: 'Auction 1',
  location: 'Location A',
  company: buyer_company,
  description: 'This is a wider card with supporting text below as a natural
            lead-in to additional content. This content is a little bit longer.',
  start: Time.now,
  deadline: Time.now + 5.days
)

auction2 = Auction.create!(
  title: 'Auction 2',
  location: 'Location A',
  description: 'This is a wider card with supporting text below as a natural
            lead-in to additional content. This content is a little bit longer.',
  company: buyer_company,
  start: Time.now,
  deadline: Time.now + 5.days
)

# Create lots
lot1 = Lot.create!(
  title: 'Lot 1',
  quantity: 10,
  asking_price: 100,
  location: 'Location A',
  company: buyer_company,
  auction: auction1
)

lot2 = Lot.create!(
  title: 'Lot 2',
  quantity: 5,
  asking_price: 200,
  location: 'Location A',
  company: buyer_company,
  auction: auction2
)

# Create auction registrations
AuctionRegistration.create!(
  company: Company.last,
  auction: auction1,
  company_approved: true
)

AuctionRegistration.create!(
  company: Company.last,
  auction: auction2,
  company_approved: true
)

# Create bids
Bid.create!(
  amount: 90,
  location: 'Location A',
  company: Company.last,
  lot: lot1
)

Bid.create!(
  amount: 180,
  location: 'Location B',
  company: Company.last,
  lot: lot2
)

Category.create(title: 'Electronics')
Category.create(title: 'Clothing')
Category.create(title: 'Furniture')
Administrator.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)