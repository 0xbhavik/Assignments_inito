class KeysController < ApplicationController
  before_action :set_key, except: %i[index generate show_random_unblocked]
  after_action :change_block_status, only: [:show_random_unblocked], if: -> { @random_unblocked_key.present? }

  def index
    @api_keys = AccessToken.order(:id).paginate(page: params[:page], per_page: 10)
  end

  def generate
    generated_api_key_name = AccessToken.generate_api_key
    @new_api_key = AccessToken.new(name: generated_api_key_name)
    if @new_api_key.save
      flash[:notice] = 'Key generated'
    else
      flash[:error] = 'Failed to generate and save the API key.'
    end
    redirect_to keys_path
  end

  def show_random_unblocked
    @random_unblocked_key = AccessToken.fetch_random_unblocked_key
    if @random_unblocked_key
      @random_unblocked_key
    else
      flash[:error] = 'Failed to show the API key.'
      redirect_to keys_path
    end
  end

  def unblock
    if !@api_key.is_blocked
      flash[:error] = 'Your key is already unblocked'
    elsif @api_key.unblock_key
      flash[:notice] = 'unblocked API key.'
    else
      flash[:error] = 'Failed to unblock the API key.'
    end
    redirect_to keys_path
  end

  def destroy
    if @api_key.destroy
      flash[:notice] = 'deleted API key.'
    else
      flash[:error] = 'Failed to delete the API key.'
    end
    redirect_to keys_path
  end

  def preserve
    if @api_key.preserve_key
      flash[:notice] = 'preserved API key.'
    else
      flash[:error] = 'Failed to preserve the API key.'
    end
    redirect_to keys_path
  end

  private

  def set_key
    @api_key = AccessToken.find_by(id: params[:id])
    not_found unless @api_key
    @api_key
  end

  def change_block_status
    @random_unblocked_key.is_blocked = true
    @random_unblocked_key.time_when_blocked = Time.now
    @random_unblocked_key.save
  end
end
