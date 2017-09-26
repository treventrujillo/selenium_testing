require 'rails_helper'

feature 'Bank Accounts Show', js: true do
  login_js
  
  context 'bank account exists' do
    before(:each) do
      @bank_account = FactoryGirl.create(:bank_account, user: @user)
      visit bank_account_path(@bank_account)
    end

    scenario 'goes to correct route' do 
      expect(page).to have_current_path(bank_account_path(@bank_account))
    end 

    scenario 'displays bank institution' do 
      expect(page).to have_selector('.bank-institution')
      expect(page).to have_content(@bank_account.institution) 
    end 

    scenario 'displays bank description' do
      expect(page).to have_selector('.bank-description')
      expect(page).to have_content(@bank_account.description)
    end
    
    scenario 'displays current balance' do 
      expect(page).to have_selector('.current-balance')
      amount = number_to_currency(@bank_account.amount)
      expect(page).to have_content(amount)
    end 
  end
end