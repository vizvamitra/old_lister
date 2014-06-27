require 'rails_helper'

RSpec.describe ListItem, :type => :model do
  
  let(:list_item) { ListItem.new }

  it 'validates precense of text' do
    expect(list_item).to be_invalid
    list_item.text = 'some text'
    expect(list_item).to be_valid
  end

  it 'by default orders list items by creation date descending' do
    list_items = create_pair(:list_item)
    expect(ListItem.all).to eq list_items.reverse
  end

  describe '#switch_done' do
    it 'switches done mark' do
      list_item.switch_done
      expect(list_item).to be_done
      list_item.switch_done
      expect(list_item).not_to be_done
    end
  end

end
