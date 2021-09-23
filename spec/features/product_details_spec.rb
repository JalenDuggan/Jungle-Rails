
require 'rails_helper'

RSpec.feature "Visitor goes to Product Details", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Just one product details is should to the user" do
    visit root_path

    expect(page).to have_link href: '/products/1'
    visit '/products/1'

    # the main container for content exists
    within("h1") { expect(page).to have_content("Apparel » ")}

    expect(page).to have_content("$64.99")
  end

end 