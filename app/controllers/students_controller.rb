class StudentsController < ApplicationController
  require "uri"
  require "json"
  require "pp"

  #before_action :set_student, only: [:login, :edit, :create, :update, :destroy]
  # GET /students
  # GET /students.json
  #Faraday gem 使える？
  def index

#    if session[:login] = nil
#      redirect_to :action => "login"
#    end

    # バイト一覧の表示
    #Faraway gemでhttp://localhost:3000/api/offersをget

    conn = Faraday::Connection.new(:url => 'http://localhost:3001/api/offers').get
    @offers = JSON.parse(conn.body)
  end

  def login
    conn = Faraday::Connection.new(:url => 'http://localhost:3001/api/students').get
    @students = JSON.parse(conn.body)
    if params[:login_flag]
      if (@student.where(:email => params[:email], :password => params[:pass]).select(:name) != nil)
        session[:name] = 1
      end
    end
  end

  def logout
    session[:name] =nil
    redirect_to :action => "login", :status => 301
  end

  # GET /students/1
  # GET /students/1.json
  def show
    conn = Faraday::Connection.new(:url => 'http://localhost:3001/api/students').get
    @students = JSON.parse(conn.body)
  end

  # GET /students/new
  def new

  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create

    #フォームの内容をAPIで格納
    client = Faraday.new(:url => "http://localhost:3001/")
    res = client.post "/api/students", {name: params["name"],email: params["email"],password: params["pass"],
      skill: params["skill"], apeal: params["apeal"], authenticity_token: params["authenticity_token"]}

    redirect_to :action =>"index", :status => 301
=begin
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
=end
  end
=begin

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # skillカテゴリーの記述
  def test
  @other = Other.new
  @other.skillarray = ["php","ruby","R"]
  @other.save

  respond_to do |format|
    format.html
    format.json { render json: @other }
  end
end
=end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      conn = Faraday::Connection.new(:url => 'http://localhost:3001/api/students').get
      @students = JSON.parse(conn.body)
    end
=begin
    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :email, :password, :skill, :apeat)
    end
=end
end
