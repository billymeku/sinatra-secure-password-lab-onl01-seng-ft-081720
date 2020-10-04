require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #your code here
    # # user = User.new(:username => params[:username], :password => params[:password])
    # user = params[:username]
    # pass = params[:password]
    # if session[:user_id]
    #   user = User.new(:username => params[:username], :password => params[:password])
    #   redirect "/login"
    # else !!session[:user_id]
    #   redirect "/failure"
      
    # end
    if params[:username] == "" || params[:password] == ""
      redirect to "/failure"
    else
    user = User.create(:username => params[:username], :password => params[:password])

      erb :login
    end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    ##your code here
    # user = User.find_by(:username => params[:username])
   
    if current_user
      redirect "/account"
    else
      redirect "/failure"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
