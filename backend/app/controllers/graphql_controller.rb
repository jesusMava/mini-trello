# frozen_string_literal: true

class GraphQLController < ApplicationController

  def execute
    result = ProjectFlowSchema.execute(
          params[:query],
          variables: prepare_variables(params[:variables]),
          context: {
            current_user: current_user
          },
          operation_name: params[:operationName]
        )

    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def current_user
    token = bearer_token

    return nil if token.blank?

    Identity::Infrastructure::Authentication::CurrentUser.call(token)
  end

  def bearer_token
    authorization = request.headers["Authorization"]

    return nil if authorization.blank?

    authorization.split(" ").last
  end

  # # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
