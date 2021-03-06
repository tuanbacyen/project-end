class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  before_action :configure_account_update_params, only: :update

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        cd = resource.confirmed_descriptions.build
        cd.school_id = params[:user][:confirmed_descriptions][:school_id]
        cd.infor_student = params[:user][:confirmed_descriptions][:infor_student]
        cd.save
        flash[:success] = t "devise.registrations.signed_up"
        sign_up(resource_name, resource)
      else
        set_flash_message! :notice,
          :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource,
          location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
    end
  end

  def update
    self.resource = resource_class
                    .to_adapter
                    .get!(send(:"current_#{resource_name}").to_key)
    resource_updated = update_resource resource, account_update_params
    yield resource if block_given?
    if resource_updated
      bypass_sign_in resource, scope: resource_name
      flash[:success] = t "devise.registrations.updated"
    else
      clean_up_passwords resource
      set_minimum_password_length
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :phone,
      :address, :identity_card, :birth, :gender])
  end

  def configure_account_update_params
    params[:user][:birth] = convert_date params[:user][:birth]
    devise_parameter_sanitizer
      .permit(:account_update, keys: [:name, :identity_card, :gender, :address, :birth, :avatar])
  end

  def update_resource user, user_params
    if params[:change_pass]
      user.update_with_password user_params
    else
      user.update_without_password user_params.except(:current_password)
    end
  end
end
