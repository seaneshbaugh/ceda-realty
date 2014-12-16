require 'spec_helper'

describe ApplicationController do
  let(:controller) { ApplicationController.new }

  describe '#abilities' do
    context 'when not signed in' do
      it 'should return a Six ability object' do
        expect(controller.send(:abilities)).to be_a(Six)
      end
    end

    context 'when signed in as a read_only user' do
      let(:user) { create(:user) }

      it 'should create a Six ability object' do
        allow(controller).to receive(:current_user) { user }

        expect(controller.send(:abilities)).to be_a(Six)
      end
    end
  end
end
