require 'spec_helper'

feature "User creates a contact" do
  scenario "user successfully creates a contact" do
    visit '/contacts/new'

    fill_in "First name", with: "Wizzzard"
    fill_in "Last name", with: "Shamsi"
    fill_in "Email", with: "faizaanthewizard@wizards.net"
    fill_in "Phone", with: "12037739912"
    fill_in "State", with: "MA"
    click_on "Create"

    expect(page).to have_content "Contact created successfully!"
  end

  scenario "user submits a blank contact form" do
    visit '/contacts/new'

    click_on "Create"

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Phone can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "There were some errors the provided information."
  end

  scenario "user submits a contact with a duplicate email" do
    Contact.create!(first_name: 'Helen',
      last_name: 'Sipnspills',
      email: 'hchood@danceparty.com',
      phone: '12927651234',
      state: 'MA')

    visit '/contacts/new'
    fill_in "Email", with: 'hchood@danceparty.com'
    click_on "Create"

    expect(page).to have_content "Email has already been taken"
  end

  scenario "user submits contact with invalid email address" do
    visit '/contacts/new'

    fill_in "Email", with: 'notarealemailaddress'
    click_on "Create"

    expect(page).to have_content "Email is invalid"
  end

  scenario "user submits contact with notes that are too long" do
    visit '/contacts/new'

    fill_in "Notes", with: ('x' * 501)
    click_on "Create"

    expect(page).to have_content "Notes are too long (max 500 characters)"
  end

  scenario "user submits contact with state that isn't real" do
    visit '/contacts/new'

    fill_in "State", with: 'AX'
    click_on "Create"

    expect(page).to have_content "State must be real"
  end
end
