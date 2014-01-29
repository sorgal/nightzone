class ArticlesController < InheritedResources::Base
  skip_before_filter :authorize_admin

  def destroy
    super do |format|
      format.html { redirect_to root_url }
    end
  end

end
