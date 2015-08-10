
enable :sessions
#INDEX

get '/' do
  # Look in app/views/index.erb
  erb :index
end

#------------------------------------------------------------------------------


#LOG IN

post '/login' do
  @user = User.find_by(name: params[:name])
    if @user
      redirect to "/user/#{@user.id}"
    else
      redirect to "/"
  end
end

#------------------------------------------------------------------------------


#NEW USER

post '/user' do
  @user = User.new(params[:user])
  if @user.save
    redirect to "/user/#{@user.id}"
  else
    redirect to "/"
  end
end

get '/user/:id' do
  @user = User.find(params[:id])
  session[:id] = @user.id
  @surveys = @user.surveys
  erb :"survey/view"
end

#--------------------------------------------------------------------------------


#NEW SURVEY

post '/survey' do
  @user = User.find(session['user_id'])
  @survey = Survey.new(params[:survey])
  if @survey.save
    @user.surveys << @survey
    redirect to "/survey/#{@survey.id}"
  else
    redirect to "/user/#{@user.id}"
  end
end

get '/survey/:survey_id' do
  @user = User.find(session['user_id'])
  @surveys = @user.surveys
  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  erb :"survey/new"
end

#-------------------------------------------------------------------------------

#NEW QUESTION

post '/survey/:id/question' do
  @user = User.find(session['user_id'])
  @survey = Survey.find(params[:id])
  @question = @survey.questions.new(params[:question])
  if @question.save
    redirect to "/survey/#{@survey.id}"
  else
    redirect to "/survey/#{@survey}"
  end
end


#------------------------------------------------------------------------------