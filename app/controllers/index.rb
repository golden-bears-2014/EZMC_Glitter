get '/' do
  # Look in app/views/index.erb
  erb :index
end

#user signup
post '/users/new' do
  new_user = User.create(params)
  session[:user_id] = new_user.id
  redirect '/surveys'
end

#user login
post '/sessions/new' do
  user = User.find_by_email(params[:email])
  if user
    if user.login(params[:password])
      session[:user_id] = user.id
      redirect '/surveys'
    else
      @error = "Invalid password"
    end
  else
    @error = "No user found"
  end
  erb :index
end


get '/users/:id' do
  @user = User.find(params[:id])
  if @user
    erb :profile
  else
    redirect '/'
  end
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :edit_profile
end

put '/users/:id' do
  @user = User.find(params[:id])
  @user.update_attributes(name: params[:name], email: params[:email])
  @user.update_password(params[:password])
  redirect "/users/#{@user.id}"
end


#user logout
delete '/sessions/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/surveys' do
  @surveys = Survey.all
  erb :survey_index
end

post '/surveys' do
  p params

  survey = Survey.create(title: params[:title])
  survey.user_id = session[:user_id]
  survey.save

  question_length = params.keys.last.chars.first.to_i

  1.upto(question_length) do |num|
    question_and_options = params.select {|key,value| key =~ /#{num}/ }
    question = question_and_options.select{|k,v| k.include?("question")}
    new_q = Question.create(prompt: params["#{num}question"])
    new_q.options << Option.create(text: params["#{num}optiona"])
    new_q.options << Option.create(text: params["#{num}optionb"])
    new_q.options << Option.create(text: params["#{num}optionc"])
    survey.questions << new_q
  end

  redirect '/surveys'
end

get '/surveys/new' do
  erb :survey_new
end

get '/surveys/:id/results' do
  @survey = Survey.find(params[:id])
  @questions = @survey.questions
  erb :survey_results
end

get '/surveys/:id' do
  @survey = Survey.find(params[:id])
  @questions = @survey.questions
  erb :response_new
end

post '/responses' do
  #taking a survey and submitting it posts to this route
  #params has particular option id for the key if it was on e.g. {65: "on", 33: "on"}
  seleted_option_ids = params.map{|k,v| k.to_i}

  seleted_option_ids.each do |option_id|
    Response.create(user_id: session[:user_id], option_id: option_id)
  end
  survey_id = Response.last.option.question.survey.id
  redirect  "/surveys/#{survey_id}/results"
end
