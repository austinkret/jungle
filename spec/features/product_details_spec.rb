require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do@category = Category.create! name: 'Apparel'
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

  scenario "They navigate to the individual product page when they click on the product link" do
    # ACT
    visit root_path

    click_link("Details", match: :first)

    # VERIFY
    expect(page).to have_css 'section.products-show'
    
    # DEBUG
    save_screenshot 'products-info-page.png'

  end
end
