require 'spec_helper'

describe AController do

  describe "GET '404'" do
    it "should be successful" do
      get '404'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'layout'" do
    it "should be successful" do
      get 'layout'
      response.should be_success
    end
  end

  describe "GET 'people'" do
    it "should be successful" do
      get 'people'
      response.should be_success
    end
  end

  describe "GET 'work'" do
    it "should be successful" do
      get 'work'
      response.should be_success
    end
  end

end
