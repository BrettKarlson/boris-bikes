require 'bike'

RSpec.describe Bike do
  it { is_expected.to respond_to :working? }
end