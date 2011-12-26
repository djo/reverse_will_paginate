require 'spec_helper'

describe CitiesController do

  before do
    City.stub(:per_page).and_return(2)

    @city1 = create_city "First"
    @city2 = create_city "Second"
    @city3 = create_city "Third"
    @city4 = create_city "Fourth"
    @city5 = create_city "Fifth"
  end

  describe "#index" do
    it "prepares the start page with the three last cities" do
      get :index
      assigns(:cities).should eq([@city5, @city4, @city3])
    end

    it "prepares the first page" do
      get :index, :page => 1
      assigns(:cities).should eq([@city2, @city1])
    end

    it "prepares the second page" do
      get :index, :page => 2
      assigns(:cities).should eq([@city5, @city4, @city3])
    end

    it "prepares correct will_paginate attributes on the start page" do
      get :index
      assigns(:cities).per_page.should eq(2)
      assigns(:cities).total_pages.should eq(2)
      assigns(:cities).total_entries.should eq(4)
    end

    it "prepares the start page with the two last cities in completed pages case" do
      city6 = create_city "Sixth"
      get :index
      assigns(:cities).should eq([city6, @city5])
    end
  end

  def create_city(name)
    City.create!(:name => name)
  end

end
