class <%= controller_class_name %>Controller < ApplicationController
  respond_to :html

<% unless options[:singleton] -%>
  def index
    @q = <%= class_name %>.search(params[:q])
    @<%= table_name %> = @q.result.page(params[:page])
    respond_to do |format|
      format.html
      format.xlsx {render xlsx: "index", filename: xlsx_filename(<%= class_name %>)}
    end
  end
<% end -%>

  def show
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with(@<%= file_name %>)
  end

  def new
    @<%= file_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= file_name %>)
  end

  def edit
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with(@<%= file_name %>)
  end

  def create
    @<%= file_name %> = <%= orm_class.build(class_name, "params[:#{file_name}]") %>
    @<%= orm_instance.save %>
    respond_with(@<%= file_name %>)
  end

  def update
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.update_attributes("params[:#{file_name}]") %>
    respond_with(@<%= file_name %>)
  end

  def destroy
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
    respond_with(@<%= file_name %>)
  end

  def destroy_multiple
    <%= class_name %>.destroy(params[:ids]) if params[:ids] 
    redirect_to(<%= table_name %>_path, notice: t(:'flash.actions.destroy_multiple.notice'))
  end
end
