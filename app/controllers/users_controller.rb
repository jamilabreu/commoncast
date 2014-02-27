class UsersController < Devise::RegistrationsController
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @post = Post.new
    @posts = Post.preload(:communities, :users, :user).joins(:users).where(users: { id: @user }).order("user_posts.created_at DESC")
  end

  def edit
  end

  def edit_communities
  end

  def create
    # Auto-generate password
    generated_password = Devise.friendly_token.first(8)
    params[:user][:password] = generated_password

    # Create user
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_up(:user, @user)

        # Email temporary password
        UserMailer.temporary_password(@user, generated_password).deliver

        format.html { redirect_to edit_user_communities_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @user }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :image, :image_cache, culture_ids: [], school_ids: [])
    end
end
