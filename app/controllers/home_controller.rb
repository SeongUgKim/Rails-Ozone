class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=30033&distance=0&API_KEY=113CE857-8AA6-44B8-A34E-D700880C4FD2'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    # check fof empty return result
    if @output.empty?
      @final_output = "Error"
    elsif !@output
      @final_output = "Error"
    else
      @final_output = @output[0]["AQI"]
    end
    if @final_output == "Error"
      @api_color = "gray"
    elsif @final_output <= 50
      @api_color = "green"
      @api_description = "Air quality is satisfactory, and air pollution poses little or no risk."
    elsif @final_output <= 100
      @api_color = "yellow"
      @api_description = "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
    elsif @final_output <= 150
      @api_color = "orange"
      @api_description = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
    elsif @final_output <= 200
      @api_color = "red"
      @api_description = "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
    elsif @final_output <= 300
      @api_color = "purple"
      @api_description = "Health alert: The risk of health effects is increased for everyone."
    elsif @final_output <= 500
      @api_color = "maroon"
      @api_description = "Health warning of emergency conditions: everyone is more likely to be affected."
    end
  end

  def zipcode
    @zip_query = params[:zipcode] 
    if params[:zipcode] == ""
      @zip_query = "Hey you forget to enter a zipcode"
    elsif params[:zipcode]
      require 'net/http'
      require 'json'

      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query + '&distance=25&API_KEY=113CE857-8AA6-44B8-A34E-D700880C4FD2'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
      # check fof empty return result
      if @output.empty?
        @final_output = "Error"
      elsif !@output
        @final_output = "Error"
      else
        @final_output = @output[0]["AQI"]
      end
      if @final_output == "Error"
        @api_color = "gray"
      elsif @final_output <= 50
        @api_color = "green"
        @api_description = "Air quality is satisfactory, and air pollution poses little or no risk."
      elsif @final_output <= 100
        @api_color = "yellow"
        @api_description = "Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
      elsif @final_output <= 150
        @api_color = "orange"
        @api_description = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
      elsif @final_output <= 200
        @api_color = "red"
        @api_description = "Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
      elsif @final_output <= 300
        @api_color = "purple"
        @api_description = "Health alert: The risk of health effects is increased for everyone."
      elsif @final_output <= 500
        @api_color = "maroon"
        @api_description = "Health warning of emergency conditions: everyone is more likely to be affected."
      end
    end  
  end

end
