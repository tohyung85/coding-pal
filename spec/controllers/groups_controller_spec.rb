require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:profile) {FactoryGirl.create(:profile)}
  let(:group) {FactoryGirl.create(:group)}
  describe '#index' do
    render_views
    context 'user signed in or not' do
      it 'should allow user to view list of groups' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    render_views
    context 'user signed in or not' do
      it 'should allow user to view group details' do
        get :show, id: group.id
        expect(response).to have_http_status(:success)
      end
    end
  end  

  describe '#new' do
    render_views
    context 'user signed in' do
      it 'should allow user to access page to create group' do
      end
    end

    context 'user not signed in' do
      it 'should redirect user to sign in page' do
      end
    end
  end

  describe '#create' do
    render_views
    context 'user signed in' do
      it 'should allow user to create a group' do
      end

      it 'should not allow user to create a group' do
      end
    end
  end

  describe '#edit' do
    render_views
    context 'user signed in' do
      it 'should allow user to edit group if he is the owner' do
      end

      it 'should return unauthorized if user is not the owner of the group' do
      end
    end

    context 'user not signed in' do
      it 'should redirect user to sign in page' do
      end
    end
  end

  describe '#update' do
    render_views
    context 'user signed in' do
      it 'should allow user to update the group if he is the owner' do
      end

      it 'should not allow user to update the group if he is not the owner' do
      end
    end

    context 'user not signed in' do
      it 'should not allow user to update the group and redirect to sign in page' do
      end
    end
  end

  describe '#destroy' do
    render_views
    context 'user signed in' do
      it 'should allow user to delete group if he is the owner' do
      end

      it 'should not allow user to delete the group if he is not the owner' do
      end
    end

    context 'user not signed in' do
      it 'should not allow user to delete the group and redirect user to sign in page' do
      end
    end
  end

end
