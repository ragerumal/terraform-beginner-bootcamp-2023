require 'sinatra'
require 'json'
require 'pry'
require 'active_model'

# We will mock having a state or data base for the server 
# by setting fglobal avriable. you never use global variable in prouduction server
$home = {}

# This is a ruby class that includes valaidation from Active records.
# this will represent our home resources as a ruby objects.
class Home
  #Active models is part of Ruby on rails.
  # it is used as an ORM , It has module within.
  # Active model that provides validations.
  # This production Terratowns serber is rails and uses
  # Very similar and in most cases identical validation
  # https://guides.rubyonrails.org/active_model_basics.html
  include ActiveModel::Validations
  
  #Create some virtual attributes to stored on this object
  # This will set a getter and setter
  # eg
  # home = new Home ()
  # home.town =`hello` #setter
  # home.town() #getter
  attr_accessor :town, :name, :description, :domain_name, :content_version

  # gamers-groto
  # cooker-cove
  validates :town, presence: true, inclusion: { in: [
    'cooker-cove',
    'video-valley',
    'melomaniac-mansion',
    'the-nomad-pad',
    'gamers-groto',
  ]}
  #visible to all users
  validates :name, presence: true
  #visible to all users
  validates :description, presence: true
  # We want to lock this down to only be from cloud front
  validates :domain_name, 
    format: { with: /\.cloudfront\.net\z/, message: "domain must be from .cloudfront.net" }
    # uniqueness: true, 

    #Content version has to be integer
    # we will amek sure it an incremental version in the controller
  validates :content_version, numericality: { only_integer: true }
end

# we are extending a class from sinatra::Base to 
#turn this generic class to utilize to sinatra web framework
class TerraTownsMockServer < Sinatra::Base

  def error code, message
    halt code, {'Content-Type' => 'application/json'}, {err: message}.to_json
  end

  def error_json json
    halt code, {'Content-Type' => 'application/json'}, json
  end

  def ensure_correct_headings
    unless request.env["CONTENT_TYPE"] == "application/json"
      error 415, "expected Content_type header to be application/json"
    end

    unless request.env["HTTP_ACCEPT"] == "application/json"
      error 406, "expected Accept header to be application/json"
    end
  end

  #Retunr an acces token, hardcoded.
  def x_access_code
    return '9b49b3fb-b8e9-483c-b703-97ba88eef8e0'
  end

  def x_user_uuid
    return 'e328f4ab-b99f-421c-84c9-4ccea042c7d1'
  end

  def find_user_by_bearer_token
    #https://en.wikipedia.org/wiki/HTTP_authentication
    auth_header = request.env["HTTP_AUTHORIZATION"]
    #check if bearer authorisation Header is blank/missing, if so throw an error .
    if auth_header.nil? || !auth_header.start_with?("Bearer ")
      error 401, "a1000 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
#Does the token match in one in our DB ?
# If we cant find it then return an error or if it doesnt match
# code = access_code = token
    code = auth_header.split("Bearer ")[1]
    if code != x_access_code
      error 401, "a1001 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    #Was there an User_uuid in the body payload json?
    if params['user_uuid'].nil?
      error 401, "a1002 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
    
    # the code and the user_uuid should be matching for user
    # in rails: user.find_by_acces_code : code, user_uuid: user_uuid
    unless code == x_access_code && params['user_uuid'] == x_user_uuid
      error 401, "a1003 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
  end

  # CREATE
  post '/api/u/:user_uuid/homes' do
    ensure_correct_headings()
    find_user_by_bearer_token()
    #Puts will print to the terminal simlar to a print or console log 
    puts "# create - POST /api/homes"

    # A begin resource is a try/catch if an error occurs, rescue it
    begin
      # sinatra does not automatically parse json body as params liek rails, so we need manually parse it
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end
    # assign the payload to variables
    # to make easier to work with the code.
    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]
    town = payload["town"]
    # Printing variables in to console to make easier to see or debug 
    # what we have inputted in to this end point..
    puts "name #{name}"
    puts "description #{description}"
    puts "domain_name #{domain_name}"
    puts "content_version #{content_version}"
    puts "town #{town}"

    # Create a new Home model and set the attributes
    home = Home.new
    home.town = town
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version
    
    # Ensure our validation check pass, otherwise return the error 
    unless home.valid?
      #return the error msgs backs as json
      error 422, home.errors.messages.to_json
    end
    
    # generating a uuid at random
    uuid = SecureRandom.uuid
    puts "uuid #{uuid}"
    # Will mock save data to our mock database
    # which just a global variable.
    $home = {
      uuid: uuid,
      name: name,
      town: town,
      description: description,
      domain_name: domain_name,
      content_version: content_version
    }
    # will just return uuid
    return { uuid: uuid }.to_json
  end

  # READ
  get '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# read - GET /api/homes/:uuid"

    # checks for house limit

    content_type :json
    # does the uuid for the home match the one in our mock database
    if params[:uuid] == $home[:uuid]
      return $home.to_json
    else
      error 404, "failed to find home with provided uuid and bearer token"
    end
  end

  # UPDATE
  # Very similar to Create Action
  put '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# update - PUT /api/homes/:uuid"
    begin
      # Parse JSON payload from the request body
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]

    unless params[:uuid] == $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    home = Home.new
    home.town = $home[:town]
    home.domain_name = $home[:domain_name]
    home.name = name
    home.description = description
    home.content_version = content_version

    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    return { uuid: params[:uuid] }.to_json
  end

  # DELETE

  delete '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# delete - DELETE /api/homes/:uuid"
    content_type :json

    if params[:uuid] != $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end
    #Delete from mock data base
    uuid = params[:uuid]
    $home = {}
    { uuid: params[:uuid] }.to_json
  end
end

# This is what will run the server
TerraTownsMockServer.run!