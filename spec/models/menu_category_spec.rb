require 'rails_helper'

RSpec.describe MenuCategory, type: :model do
  it { should belong_to(:menu).optional }

  it { should belong_to(:category).optional }
end
