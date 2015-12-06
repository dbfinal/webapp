class ScoreController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # TODO: Sanitize inputs!!
    user = params[:uid]
    menu_item = params[:menu_item]
    score = UserScore.find_by(user_id: user, menu_item_id: menu_item)
    if score == nil
      render :json => {error: "Score not found for user #{user} on menu item #{menu_item}"}, status: 400
    else
      render :json => {success: true, data: score.as_json}
    end
  end

  def create
    # TODO: Sanitize inputs!!
    user = params[:uid]
    menu_item = params[:menu_item]
    score = params[:score]
    new_score = UserScore.find_by(user_id: user, menu_item_id: menu_item)
    if new_score == nil
      new_score = UserScore.new(score: score, user_id: user, menu_item_id: menu_item)
      render :json => {data: new_score.as_json}, status: 201 if new_score.save
    else
      render :json => {error: "Score already created for user #{user} on menu item #{menu_item}. Use POST to update"}, status: 409
    end
  end

  def update
    # TODO: Sanitize inputs!!
    user = params[:uid]
    menu_item = params[:menu_item]
    score = params[:score]
    new_score = UserScore.lock.find_by(user_id: user, menu_item_id: menu_item)
    if new_score != nil
      new_score[:score] = score
      render :json => {data: new_score.as_json}, status: 200 if new_score.save!
    else
      render :json => {error: "Score not found for user #{user} on menu item #{menu_item}. Use PUT to create"}, status: 404
    end
  end
end