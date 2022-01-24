# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    if params[:winner_list_addresses].present? && params[:owner_list_addresses].present?
      @result = []
      @winner_list_parsed = params[:winner_list_addresses].gsub(/\s/, ',').split(',,').map{ |str| remove_secret_character(str) }
      @owner_list_parsed = params[:owner_list_addresses].gsub(/\s/, ',').split(',,')
      @owner_list_parsed.each do |owner_address|
        @result << owner_address if @winner_list_parsed.include?(remove_secret_character(owner_address))
      end
      # binding.pry
      @result
    end
  end

  private

  def remove_secret_character(str)
    return str.last(5) unless str.last(5).include?('*')

    str.last(4)
  end
end
