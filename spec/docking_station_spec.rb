require 'docking_station'

RSpec.describe DockingStation do

  it {is_expected.to respond_to :release_bike}

  # it 'releases working bikes' do
  #   bike = subject.release_bike
  #   expect(bike).to be_working
  # end

  it { is_expected.to respond_to(:dock).with(1).argument }

  it {is_expected.to respond_to(:bikes)}
  
  # it "docks something" do
  #   bike = Bike.new
  #   expect(subject.dock(bike)).to eq bike
  # end

  # it "returns docked bikes" do
  #    bike = Bike.new
  #    subject.dock(bike)
  #    expect(subject.bikes).to eq bike
  #  end   

  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end
  end

  describe '#release_bike' do
    it 'raises an error if no bikes are available' do
      expect { subject.release_bike }.to raise_error "No bikes available"
    end
  end

  describe '#dock' do
    it "raises an error when dock is full" do
      20.times { subject.dock Bike.new }
      #p @bikes
      expect { subject.dock Bike.new }.to raise_error "Docking station full"
    end
  end
end