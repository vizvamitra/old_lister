require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ListItemsHelper. For example:
#
# describe ListItemsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ListItemsHelper, :type => :helper do
  describe '#list_item_div' do
    let(:list_item) { build(:list_item) }

    context 'when list item is not marked done' do
      it 'returns contenteditable div without "done" class' do
        expect( list_item_div(list_item) ).to match /^<div class='list_item_div' spellcheck='false' contenteditable='true'>/
      end
    end

    context 'when list item is marked done' do
      it 'returns noncontenteditable div with "done" class' do
        list_item.done = true
        expect( list_item_div(list_item) ).to match /^<div class='list_item_div done' spellcheck='false'>/
      end
    end
  end
end
