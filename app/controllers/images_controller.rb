class ImagesController < ApplicationController
  # GET /images
  # GET /images.json
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render "weka_input", :layout => false}
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    @image.fg_color = Color.new
    @image.bg_color = Color.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    fname = params[:image][:image_name].original_filename
    fname = fname.slice(0..(fname.index('.'))).split("_")
    params[:image][:font_size] = fname[3].to_i
    fg_color = Color.color_from_string(fname[2])
    bg_color = Color.color_from_string(fname[4])
    #if params[:image][:fg_color_id].blank?
    #  fg_attr = params[:image][:fg_color_attributes]
    #  fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3(fg_attr[:color_type], fg_attr[:val1], fg_attr[:val2], fg_attr[:val3])
    #else
    #  fg_color = Color.find(params[:image][:fg_color_id])
    #end
    #
    #if params[:image][:bg_color_id].blank?
    #  bg_attr = params[:image][:bg_color_attributes]
    #  bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3(bg_attr[:color_type], bg_attr[:val1], bg_attr[:val2], bg_attr[:val3])
    #else
    #  bg_color = Color.find(params[:image][:bg_color_id])
    #end

    params[:image].delete :fg_color_attributes
    params[:image].delete :bg_color_attributes
    params[:image].delete :bg_color_id
    params[:image].delete :fg_color_id

    @image = Image.new(params[:image])
    @image.fg_color = fg_color
    @image.bg_color= bg_color


    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

end
