require 'rails_helper'

describe Profile  do
  it {is_expected.to belong_to(:user)}
end