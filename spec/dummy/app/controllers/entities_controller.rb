class EntitiesController < ApplicationController
  # GET /entities
  # GET /entities.xml
  def index
    @entities = Entity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
    end
  end

  # GET /entities/1
  # GET /entities/1.xml
  def show
    @entity = Entity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entity }
    end
  end

  # GET /entities/new
  # GET /entities/new.xml
  def new
    @entity = Entity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entity }
    end
  end

  # GET /entities/1/edit
  def edit
    @entity = Entity.find(params[:id])
  end

  # POST /entities
  # POST /entities.xml
  def create
    @entity = Entity.new(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to(@entity, :notice => 'Entity was successfully created.') }
        format.xml  { render :xml => @entity, :status => :created, :location => @entity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entities/1
  # PUT /entities/1.xml
  def update
    @entity = Entity.find(params[:id])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to(@entity, :notice => 'Entity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1
  # DELETE /entities/1.xml
  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to(entities_url) }
      format.xml  { head :ok }
    end
  end
end
