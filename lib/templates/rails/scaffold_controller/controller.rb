<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    authorize @<%= plural_table_name %>
  end

  def show
    authorize @<%= singular_table_name %>
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    authorize @<%= singular_table_name %>
  end

  def edit
    authorize @<%= singular_table_name %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    authorize @<%= singular_table_name %>
    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>
    else
      render :new
    end
  end

  def update
    authorize @<%= singular_table_name %>
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>
    else
      render :edit
    end
  end

  def destroy
    authorize @<%= singular_table_name %>
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url
  end

  private
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
