class TokensController < ApplicationController

  before_filter :get_user

  def get_user
    @user = User.find(params[:user])
  end

  # GET /tokens
  # GET /tokens.json
  def index    
    @tokens = @user.tokens
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tokens }
    end
  end

  # GET /tokens/1
  # GET /tokens/1.json
  def show    
    @token = @user.tokens.find(params[:id])    
      if ((Time.new - @token.hora_ini.to_time)>300)
        @user.tokens.delete_if { |token| token.id == @token.id}
        @user.save
        @token = Token.new
        @token.status ="inactivo"
        @token.mensaje = 'El Token Se ha vencido'
        respond_to do |format|
          /format.html # show.html.erb/
          format.json { render json: @token }
          format.xml { render xml: @token }
        end
      else
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @token }
          format.xml { render xml: @token }
        end
      end
    rescue Exception=>e
      @token = Token.new
      @token.id = params[:id]
      @token.mensaje = "El token Indicado no existe"      
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @token }
          format.xml { render xml: @token }
        end    
  end


  # GET /tokens/1/edit
  def edit
    @token = @user.tokens.find(params[:id])
  end

  # POST /tokens
  # POST /tokens.json
 

  def solicitar_token
    @user = params[:user]
    @mitoken = Token.new
    @mitoken.status = 'activo'
    @mitoken.hora_ini = Time.new.to_s
    @mitoken.ip = request.remote_ip
    flag = true
    @tokenout = Token.new
    for token in @user.tokens
      /si la dif es menor retorno el token activo correspondiente a la ip/
      if ((@mitoken.hora_ini.to_time - token.hora_ini.to_time)<300)
        if (@mitoken.ip == token.ip)
          @tokenout = token
          flag = false
        end
      else
        if (@mitoken.ip == token.ip)
          @user.tokens.delete_if { |tokenin| tokenin.id == token.id}
          @user.save
        end
      end
    end

    if flag == true
      @user.tokens.push(@mitoken)
      @tokenout = @mitoken
      @tokenout.mensaje = "El token solicitado es:"+ @tokenout.id
      @user.save
    end

    respond_to do |format|
      /format.html # show.html.erb/
      format.json { render json: @tokenout }
      format.xml { render xml: @tokenout }
    end
    rescue Exception=>e
      @token = Token.new
      @token.mensaje="El id de usuario es invalido"
      respond_to do |format|
        format.json { render json: @token }
        format.xml { render xml: @token }
      end
  end

  # PUT /tokens/1
  # PUT /tokens/1.json
  def update
    @token = @user.tokens.find(params[:id])

    respond_to do |format|
      if @token.update_attributes(params[:token])
        format.html { redirect_to [@user,@token], notice: 'Token was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /tokens/i
  def validarToken

  end

  # DELETE /tokens/1
  # DELETE /tokens/1.json
  def destroy
    @token = @user.tokens.find(params[:id])
    @user.tokens.delete(@token)
    @user.save

    respond_to do |format|
      format.html { redirect_to user_tokens_url }
      format.json { head :no_content }
    end
  end
end
