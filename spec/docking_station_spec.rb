require 'docking_station'
require 'bike'

RSpec.describe DockingStation do

  it {is_expected.to respond_to :release_bike}

  it { is_expected.to respond_to(:dock).with(1).argument } 

  it 'releases working bikes' do
    bike = double(:bike, broken?: false)
    subject.dock bike
    expect(subject.release_bike).to be bike
  end

  let(:bike) { double :bike }
  it 'releases working bikes' do
    allow(bike).to receive(:working?).and_return(true)
    subject.dock(bike)
    released_bike = subject.release_bike
    expect(released_bike).to be_working
  end

  describe '#release_bike' do
    it 'raises an error if no bikes are available' do
      expect { subject.release_bike }.to raise_error "No bikes available"
    end
  end

  it 'does not release broken bikes' do
    bike = double(:bike)
    allow(bike).to receive(:broken?).and_return(true)
    subject.dock bike
    expect {subject.release_bike}.to raise_error 'No bikes available'
  end

  describe '#dock' do
    it "raises an error when dock is full" do
      subject.capacity.times { subject.dock double :bike } 
      expect { subject.dock double :bike }.to raise_error "Docking station full"  
    end 
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'initialization' do
    subject { DockingStation.new }
    let(:bike) { Bike.new }
    it 'defaults capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect{ subject.dock(bike) }.to raise_error 'Docking station full'
    end
  end
end