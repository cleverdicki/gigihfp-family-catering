require 'rails_helper'

RSpec.describe OrderMenu, type: :model do
  it { should belong_to(:order) }

  it { should belong_to(:menu) }
end
