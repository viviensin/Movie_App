class MoviesController < ApplicationController

	def index
	# this queries the database for all the rows in the movies table
	# and returns them as an array
	# we stick that array in the @movies variable so we can use it in the view
	# @movies = Movie.all
		if params[:q].present?
			@movies = Movie.search_for(params[:q]).order("created_at DESC")
		else
			@movies = Movie.all.order("created_at DESC")
		end
	end

	def new 
	@movie = Movie.new
	end

	def edit
	@movie = Movie.find(params[:id])
	end

	def create
	#@movie = Movie.new( params.require(:movie).permit(:title, :description, :year_released))
	#@movie.save
	#redirect_to_root_path

	# params[:shirt] is a hash with all the fields for the shirt object
		# params[:shirt][:name] is just the name that the user submitted

		@movie = Movie.new( safe_movie_params )
		logger.info( "My movie object is: #{@movie.inspect}" )

		@movie.save
		redirect_to root_path
	end

	def show
	@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		@movie.update( safe_movie_params)

		redirect_to movie_path
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy

		redirect_to root_path
	end

	private
		def safe_movie_params
			return params.require(:movie).permit(:title, :description, :year_released)
		end

end
