# Skaffer mine gems
require 'sinatra'
require "sinatra/namespace"
require 'mongoid'
require 'dotenv/load'

# DB conf.
Mongoid.load! "mongoid.config"

# Modellen for et firma muligt gennem Mongoid
class Firma
  include Mongoid::Document

  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :country, type: String
  field :email, type: String
  field :phone, type: String

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :email, presence: true
  validates :phone, presence: true


  index({ name: 'text' })

  scope :name, -> (name) { where(name: /^#{name}/) }
  scope :city, -> (city) { where(city: city) }
  scope :country, -> (country) { where(country: country) }
  scope :address, -> (address) { where(address: address) }
end

# Serializer så man selv kan strukturer dataen, da mongoid får id til at ligge som et object under et object
class FirmaSerializer

  def initialize(firma)
    @firma = firma
  end

  def as_json(*)
    data = {
      id:@firma.id.to_s,
      name:@firma.name,
      address:@firma.address,
      city:@firma.city,
      country:@firma.country,
      email:@firma.email,
      phone:@firma.phone,
    }
    data[:errors] = @firma.errors if@firma.errors.any?
    data
  end
end

#Routes begynder her
get '/' do
  'Adgang til sinatra API!'
end

#Namespace så jeg bedre kan styre mine api kald
namespace '/api' do

  before do
    content_type 'application/json'
  end
  
  #Helper som er med til, at give et tilbage kald, når der bliver kaldt på api'en
  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end

    def firma
      @firma ||= Firma.where(id: params[:id]).first
    end

    def halt_if_not_found!
      halt(404, { message: 'Firma ikke fundet'}.to_json) unless firma
    end

    def serialize(firma)
      FirmaSerializer.new(firma).to_json
    end
  end

  #Når denne route bliver kaldt, laves der en get, som skaffer alle firma'er som er i DB'en
  get '/firma' do
    firmaer = Firma.all

    [:name, :address, :city, :country, :email, :phone].each do |filter|
      firmaer = firmaer.send(filter, params[filter]) if params[filter]
    end

    firmaer.map { |firma| FirmaSerializer.new(firma) }.to_json
  end

  #Her laves en get, hvor vi skaffer et firma udfra ID'et, som vi skal bruge til, at give et Location nede i vores post. 
  get '/firma/:id' do |id|
    halt_if_not_found!
    serialize(firma)
  end

  #Her bliver der lavet en post, som opretter et nyt firma, når man kalder denne route
  post '/firma' do
    firma = Firma.new(json_params)
    halt 422, serialize(firma) unless firma.save
    #Her bruger vi vores get udfra ID, til at sende en Location tilbage, som bruges som en "redirect". 
    response.headers['Location'] = "#{base_url}/api/firma/#{firma.id}"
    status 201
  end

  #Her bliver der lavet en patch, som er når man skal opdatere et eksisterende firma udfra deres id
  patch '/firma/:id' do |id|
    halt_if_not_found!
    halt 422, serialize(firma) unless firma.update_attributes(json_params)
    serialize(firma)
  end

  #Her laves der en delete, som sletter et firma ud fra et id 
  delete '/firma/:id' do |id|
    firma.destroy if firma
    status 204
  end

end