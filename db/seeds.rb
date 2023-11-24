DatabaseCleaner.clean_with(:truncation)

if Rails.env.development?
  buyer_company = Company.create(
    email: 'buyer@example.com',
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

  seller_company = Company.create!(
    email: 'seller@example.com',
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
else
  buyer_company = Company.create(
  email: 'remunyangabrolin@gmail.com',
  password: 'password',
  name: 'Buyer Company',
  phone: '0771232345',
  location: 'Harare',
  address: '6705 southlea park',
  terms_and_conditions: true,
  buyer: true
) do |company|
  pdf_path = Rails.root.join('spec/factories/media/documents/test.pdf')

  company.tax_clearance.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.certificate_of_incorporation.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.cr5.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')
  company.cr6.attach(io: File.open(pdf_path), filename: 'test.pdf', content_type: 'application/pdf')

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
end

buyer_company.confirm
end

# Create auctions

3.times do
  FactoryBot.create(:auction, company: Company.first)
end


# Create lots
Auction.all.each do |auction|
  25.times do
    FactoryBot.create(:lot, auction: auction, company: Company.first)
  end
end