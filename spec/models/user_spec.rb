require 'spec_helper'

describe User do
  describe 'Associations' do
  end

  describe 'Validations' do
    it { should allow_value('aaa').for(:username) }

    it { should allow_value('a1234').for(:username) }

    it { should allow_value('1234a').for(:username) }

    it { should allow_value('zxcvb_qwerty').for(:username) }

    it { should allow_value('1234_5678').for(:username) }

    it { should allow_value('PLMNJK123').for(:username) }

    it { should allow_value('1.2.3').for(:username) }

    it { should_not allow_value('_aa').for(:username) }

    it { should_not allow_value('aa_').for(:username) }

    it { should_not allow_value('.aa').for(:username) }

    it { should_not allow_value('aa.').for(:username) }

    it { should_not allow_value('abc__def').for(:username) }

    it { should_not allow_value('qwerty!!!!!').for(:username) }

    it { should_not allow_value('!@#$%^&*()').for(:username) }

    it { should ensure_length_of(:username).is_at_least(3).is_at_most(255) }

    it { should validate_presence_of(:username) }

    it { should validate_uniqueness_of(:username) }

    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email) }

    describe 'email' do
      it 'accepts info@example.com' do
        user = build(:user, email: 'info@example.com')

        expect(user).to be_valid
      end

      it 'accepts info+test@example.com' do
        user = build(:user, email: 'info+test@example.com')

        expect(user).to be_valid
      end

      it "accepts o'reilly@example.com" do
        user = build(:user, email: "o'reilly@example.com")

        expect(user).to be_valid
      end

      it 'rejects test@test@example.com' do
        user = build(:user, email: 'test@test@example.com')

        expect(user).to be_invalid
      end

      it 'rejects mailto:test@example.com' do
        user = build(:user, email: 'mailto:test@example.com')

        expect(user).to be_invalid
      end

      it "rejects lol!'+=?><#$%^&*()@gmail.com" do
        user = build(:user, email: "lol!'+=?><#$%^&*()@gmail.com")

        expect(user).to be_invalid
      end
    end

    it { should validate_confirmation_of(:password) }

    it { should ensure_length_of(:password).is_at_least(6).is_at_most(255) }

    context 'password not required' do
      before do
        allow(subject).to receive_messages(password: '1234567890', password_confirmation: '1234567890')

        subject.save
      end

      it { expect(subject).to_not ensure_length_of(:password).is_at_least(6).is_at_most(255) }
    end

    it { should validate_presence_of(:password) }

    it { should ensure_inclusion_of(:role).in_array(%w(read_only agent admin sysadmin)) }

    it { should validate_presence_of(:role) }

    it { should ensure_length_of(:first_name).is_at_most(255) }

    it { should validate_presence_of(:first_name) }

    it { should ensure_length_of(:last_name).is_at_most(255) }

    it { should validate_presence_of(:last_name) }
  end

  describe 'Respond to' do
    it { should respond_to(:full_name) }

    it { should respond_to(:short_name) }

    it { should respond_to(:valid_roles) }
  end
end
