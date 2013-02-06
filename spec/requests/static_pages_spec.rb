require 'spec_helper'

describe "Static pages" do
	
	describe "Home page" do
		it "Should have the content 'Sample App'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text=>'Sample App')
		end
		it "Should have the base title" do
			visit '/static_pages/home'
			page.should have_selector('title', 
				:text=>'Ruby on Rails Tutorial Sample App')
		end
		it "Should not have a custom page title" do
			visit '/static_pages/home'
			page.should_not have_selector('title', :text => '| Home')
		end
	end

	describe "Help page" do
		it "Should have the content 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text=>'Help')
		end
		it "Should have the base title" do
			visit '/static_pages/help'
			page.should have_selector('title', 
				:text=>'Ruby on Rails Tutorial Sample App')
		end
		it "Should have a custom page title" do
			visit '/static_pages/help'
			page.should have_selector('title',:text => '| Help')
		end
	end

	describe "About Us" do
		it "Should have the content 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('h1',:text=>'About Us')
		end
		it "Should have the base title" do
			visit '/static_pages/about'
			page.should have_selector('title', 
				:text=>'Ruby on Rails Tutorial Sample App')
		end
		it "Should have a custom page title" do
			visit '/static_pages/about'
			page.should have_selector('title',:text => '| About')
		end
	end

	describe "Contact Us" do
		it "Should have the content 'Contact Us'" do
			visit '/static_pages/contact'
			page.should have_selector('h1',:text=>'Contact Us')
		end
		it "Should have the base title" do
			visit '/static_pages/contact'
			page.should have_selector('title', 
				:text=>'Ruby on Rails Tutorial Sample App')
		end
		it "Should have a custom page title" do
			visit '/static_pages/contact'
			page.should have_selector('title',:text => '| Contact')
		end
	end


end
