class CorporationsController < ApplicationController
  require "uri"
  require "json"
  def index
    conn = Faraday::Connection.new(:url => 'http://localhost:3001/api/offers').get
    @offers = JSON.parse(conn.body)
  end

  def login
  end

  def edit
  end

  def new
  end

  def create
    client = Faraday.new(:url => "http://localhost:3001/")
    res = client.post "/api/corporations", {name: params["name"],outline: params["outline"],password: params["pass"],
      email: params["email"], authenticity_token: params["authenticity_token"]}

    redirect_to :action =>"index", :status => 301
  end

  def new_bite
  end

  def create_bite
    client = Faraday.new(:url => "http://localhost:3001/")
    res = client.post "/api/offers", {title: params["title"],detail: params["detail"],corporation_id: params["corporation_id"],
      wanted: params["wanted"], limited_on: params["limited_on"],wanted: params["wanted"],
      category_id: params["category_id"],authenticity_token: params["authenticity_token"]}

    redirect_to :action =>"index", :status => 301
  end
end
