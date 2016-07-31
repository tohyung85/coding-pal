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

      it 'should show a 404 error if incorrect id is given' do
        get :show, id: 'woot'
        expect(response).to have_http_status(:not_found)
      end

    end
  end  

  describe '#new' do
    render_views
    context 'user signed in' do
      it 'should allow user to access page to create group' do
        sign_in user
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'user not signed in' do
      it 'should redirect user to sign in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    render_views
    context 'user signed in' do
      before do
        sign_in user
      end
      it 'should allow user to create a group' do
        expect{post :create, group: {
          name: 'Test group',
          remote: true,
          course: 'Firehose',
          commitment_hours: 10
          }}.to change{Group.count}.by(1)
        expect(Group.last.user_id).to eq(user.id)
        expect(response).to redirect_to group_path(Group.last.id)
      end

      it 'should validate inputs' do
        expect{post :create, group: {
          name: '',
          remote: true,
          course: 'Firehose',
          commitment_hours: 10
          }}.not_to change{Group.count}
        expect(response).to render_template(:new)
      end
    end

    context 'user not signed in' do
      it 'should not allow user to create a group' do
        expect{post :create, group: {
          name: 'Test Group',
          remote: true,
          course: 'Firehose',
          commitment_hours: 10
          }}.not_to change{Group.count}

        expect(response).to redirect_to new_user_session_path
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
