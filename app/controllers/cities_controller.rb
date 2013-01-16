require 'reverse_link_renderer'

class CitiesController < ApplicationController

  def index
    @cities = reverse_paginate(City)
  end

  def create
    @city = City.new(params[:city])

    if @city.save
      flash[:notice] = "#{@city.name} city was added."
    else
      flash[:alert] = @city.errors.full_messages.join(". ")
    end

    redirect_to cities_url
  end

  private

  # Prepares the collection in the reverse order with dynamic limit for the start page
  # to keep immutable pages expect the start page.
  #
  # For 11 entities with per page 3 will be the next pages: 11..7 (3), 6..4 (2), 3..1 (1), and
  # for 12 entities: 12..10 (4), 9..7 (3), 6..4 (2), 3..1 (1).
  def reverse_paginate(scope)
    per_page = City.per_page
    total_count = scope.count
    rest_count = total_count > per_page ? (total_count % per_page) : 0
    num_pages = total_count > per_page ? (total_count / per_page) : 1
    current_page = params[:page].blank? ? num_pages : params[:page].to_i

    # Paginate by completed pages
    opts = { :page => current_page, :per_page => per_page, :total_entries => (total_count - rest_count) }
    scope = scope.order("created_at ASC").paginate(opts)

    # Increase limit for the strat page to include rest entities
    if current_page == num_pages
      new_limit = (total_count % per_page) + per_page
      new_offset = (num_pages - 1) * per_page
      scope = scope.limit(new_limit).offset(new_offset)
    end

    # Reverse the collection and return predetermined per_page number (if limit was increased)
    collection = scope.reverse
    collection.instance_variable_set(:"@per_page", per_page)
    collection
  end
end
