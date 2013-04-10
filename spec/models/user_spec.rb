require 'spec_helper'

describe User do
	
	before do 
		@user = User.new(name: "Example User", email: "example@user.com",
		password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) } 
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:admin)  }


	it { should be_valid } 
	it { should_not be_admin }

	describe "accessible attributes" do
		it "should not allow access to admin" do
			expect do
				User.new(admin: "1")
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "When user name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "When email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "When name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "When email format is invalid" do
		it "should be invalid" do
			 addresses = %w[user@example,com user.org user@example. example.user@com. foo@foo_bar.com foo@foo+bar.com]
			 addresses.each do |invalid_address|
			 	@user.email = invalid_address
			 	@user.should_not be_valid
			 end
		end
	end

	describe "When email format is valid" do
		it "should be valid" do 
			 addresses = %w[user@example.com user@example.org user.example@example.com A_USER@f.b.com a+b@baz.cn]
			 addresses.each do |valid_address|
			 	@user.email = valid_address
			 	@user.should  be_valid
			 end
		end
	end

	describe "When email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
	
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when password_confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "when password is too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should_not be_valid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }	

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid ") }
			it { should_not ==  user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "remember_token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

end
