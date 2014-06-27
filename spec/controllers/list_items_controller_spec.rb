require 'rails_helper'

RSpec.describe ListItemsController, :type => :controller do

  before(:each) { create_pair(:list_item, id: [1,2]) } #[1,2] magicaly works as well as [] or {} do. 

  describe 'GET :index' do
    before(:each) { get :index }

    it 'assigns @list_items' do
      expect(assigns(:list_items)).to eq ListItem.all
    end

    it 'assigns @new_item' do
      expect(assigns(:new_item)).to be_a_new(ListItem)
    end

    it 'renders template :index' do
      expect( response ).to render_template :index
    end
  end


  describe 'POST :create, format: js' do
    context 'when params are correct' do
      before(:each) { post :create, format: :js, list_item: {text: 'buy eggs'} }

      it 'creates new ListItem' do
        expect( ListItem.find_by(text: "buy eggs") ).not_to be_nil
      end

      it 'renders js template :create' do
        expect( response ).to render_template :create
      end
    end

    context 'when params are incorrect' do
      it 'renders nothing' do
        post :create, format: :js, list_item: {text: ''}
        expect( response ).to render_nothing
      end
    end
  end


  describe 'PATCH :switch_done, format: js' do
    context 'when params are correct' do
      before(:each) { patch :switch_done, format: :js, id: 1 }

      it 'gets ListItem with given id' do
        expect(assigns(:list_item)).to eq ListItem.find(1)
      end

      it 'switches done state of given id' do
        expect(assigns(:list_item)).to be_done
      end

      it 'renders template :switch_done' do
        expect(response).to render_template :switch_done
      end
    end

    context 'when params are incorrect' do
      it 'renders nothing' do
        patch :switch_done, format: :js, id: 100
        expect( response ).to render_nothing
      end
    end
  end


  describe 'PATCH :update, format: js' do
    before(:each) { patch :update, format: :js, id: 1, list_item: {text: 'buy milk'} }

    it 'updates given ListItem' do
      expect( ListItem.find(1).text ).to eq 'buy milk'
    end

    it 'renders nothing' do
      expect( response ).to render_nothing
    end
  end


  describe 'DELETE :destroy, format: js' do
    before(:each) { delete :destroy, format: :js, id: 1 }

    it 'destroys list item with given id' do
      expect{ ListItem.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'renders :destroy template' do
      expect( response ).to render_template :destroy
    end
  end
end
