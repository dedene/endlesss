class ShotsController < ApplicationController
  respond_to :html, :js
  
  def index
    if params[:site]
      s = Site.find_by_shortname(params[:site])
      if s
        f = s.feeds.first
        @site = s       
        @shots = f.shots.paginate :page => params[:page], :order => 'pubdate DESC'
      else
        redirect_to root_url, status => 404, :layout => true        
      end
    else
      redirect_to root_url, status => 404, :layout => true
    end
  end

  def show_by_feed
    if params[:site] && params[:feed]
      s = Site.find_by_shortname(params[:site])
      if s && f = s.feeds.find_by_shortname(params[:feed])
        @site = s
        @shots = f.shots.paginate :page => params[:page], :order => 'pubdate DESC'
      else
        redirect_to root_url, status => 404, :layout => true        
      end
    else
      redirect_to root_url, status => 404, :layout => true
    end    
  end

end
