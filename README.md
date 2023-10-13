# Analytica Procurement Solution

Analytica Procurement Solution is a powerful procurement platform designed to streamline the procurement process, featuring four key modules: Reverse Auction, Request for Quotations (RFQ) Board, Tender Board, and a Logistics Solution (coming soon).

## Table of Contents

- [Introduction](#analytica-procurement-solution)
- [Modules](#modules)
    - [Reverse Auction](#reverse-auction)
    - [Request for Quotations (RFQ) Board](#request-for-quotationsrfq)
    - [Tender Board](#tender-board)
    - [Logistics](#logistics)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Modules

### Reverse Auction

The Reverse Auction module is a stand-alone system, accessible to users with accounts and subscriptions. Companies can subscribe as either suppliers or buyers. Key features include:

- Buyers can host auctions with start dates and deadlines.
- Suppliers can submit bids for lots/products in the auction, including at least four pictures of the items.
- The winning bid is the one with the lowest price.
- Suppliers can bid only on lots in their region, indicating local delivery.
- Users can save lots they wish to bid for.
- Live and expired auctions are separated.

### Request for Quotations (RFQ) Board [In progress]

The RFQ Board showcases requests for quotations by individuals and companies. These requests are added by the super admin, and every request must be listed by Analytica from an admin perspective.

### Tender Board [In progress]

The Tender Board displays tenders listed by Analytica, and they become unlisted as soon as the tender period expires. These tenders are listed by Analytica from an admin perspective.

### Logistics

[Coming Soon]

## Tech Stack

- **Databases:** PostgreSQL
- **Backend:** Ruby on Rails
- **Testing:** RSpec and FactoryBot
- **Languages:** Ruby and JavaScript
- **Frontend:** Bootstrap and JavaScript
- **Version Control:** Git
- **CI/CD:** GitHub Actions and Render
- **Project Management:** Trello

## Getting Started

To set up the Analytica Procurement Solution, follow these steps:

### Prerequisites

Before you begin, ensure you have the following installed on your system:

- Ruby 3.1.0
- Ruby on Rails 7.0.5
- Imagemagick
- Node.js
- Yarn
- PostgreSQL
- Bundler 2.4.13

### Environment Variables

Create an `.env` file and set the following environment variables:

- `DB_USERNAME` for the database username
- `DB_PASSWORD` for the database password

### Installation

1. Run the following command to manage Ruby dependencies:

   ```bash
   bundle install
   ```
2. Next, install JavaScript dependencies with Yarn:

  ```bash
     yarn install
   ```
3.  Create and migrate the database with:

  ```bash
    rails db:create
    rails db:migrate
   ```

### Running the application

1. To start the application locally, use:

   ```bash
    bin/dev
   ```
   Then open your browser and visit `http://localhost:3000`

3. For debugging purposes if you wish to use debug or byebug, use:

  ```bash
     rails server
   ```
## Contributing

We welcome contributions to the Analytica Procurement Solution! Whether you want to report a bug, propose an enhancement, or contribute to the codebase, here's how you can get involved:

### Opening an Issue

If you encounter a bug, have a feature request, or want to discuss any aspect of the project, please open an issue. Be sure to include the following details to help us understand the problem or your proposal:

- A clear and concise title.
- A detailed description of the issue or feature.
- Any relevant context, such as operating system, browser, or dependencies.
- Steps to reproduce the issue (if it's a bug).

### Creating a Pull Request

If you'd like to contribute code or improvements, follow these steps:

1. Fork the repository to your GitHub account.
2. Create a new branch for your work with a descriptive name.
3. Make your changes or additions, and be sure to explain your changes clearly in the commit messages.
4. Test your changes to ensure they work as expected.
5. Push your changes to your branch on your forked repository.
6. Create a pull request to the main repository, detailing what you've done and why it's important.

### Code of Conduct

Please note that we follow a Code of Conduct in all interactions related to this project. Be respectful and considerate of other contributors.

All contributions will be reviewed by the project maintainers before being merged. We appreciate your efforts in making Analytica Procurement Solution better for everyone!

Thank you for your interest and support.

## License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details.

---

[![Build Status](https://img.shields.io/github/workflow/status/brolinr/Analytica/CI)](https://github.com/brolinr/Analytica/actions)
[![Contributors](https://img.shields.io/github/contributors/brolinr/Analytica)](https://github.com/brolinr/Analytica/graphs/contributors)
[![GitHub Stars](https://img.shields.io/github/stars/brolinr/Analytica)](https://github.com/brolinr/Analytica/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/brolinr/Analytica)](https://github.com/brolinr/Analytica/network/members)
