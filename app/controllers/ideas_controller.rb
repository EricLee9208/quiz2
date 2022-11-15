class IdeasController < ApplicationController
    before_action :find_idea, only: [:edit, :update, :show, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

   


    def index
        @ideas = Idea.all.order(created_at: :desc)
      
    end

    def show
        @reviews = @idea.reviews.order(created_at: :desc)
        @review = Review.new
    end


    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(idea_params)
        @idea.user = current_user
        if @idea.save
            flash[:success] = "Idea successfully created"
            redirect_to @idea
        else
            flash[:error] = "Something went wrong"
            render 'new', status: 303
        end
    end

    def edit

    end

    def update
        if @idea.update(idea_params)
            flash[:success] = "Idea successfully updated"
            redirect_to @idea
        else
            flash[:error] = "Something went wrong"
            render :edit, status: 303
        end
    end

    def destroy
        @idea.destroy
        redirect_to ideas_path
    end
    



    private

    def find_idea
      @idea = Idea.find params[:id]
    end

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless can?(:crud, @idea)
        
    end

end
