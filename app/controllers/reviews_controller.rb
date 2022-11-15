class ReviewsController < ApplicationController
    before_action :find_idea
    before_action :authenticate_user!
    def create
        @review = Review.new(review_params)
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            flash[:success] = "Answer successfully created"
            redirect_to @idea
         else
            @reviews = @idea.reviews.order(created_at: :desc)
            render '/ideas/show', status: 303
        end
    end

    def destroy
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@review.idea)
            flash[:success] = "Answer deleted"
        else
            redirect_to @idea, alert: "Not authorized"
        end
    end

    private

    def find_idea
        @idea = Idea.find params[:idea_id]
    end

    def review_params
        params.require(:review).permit(:body)
    end
end
