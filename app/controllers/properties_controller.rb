class PropertiesController < ApplicationController
  def index
    outcome = ListProperties.run(params)

    if outcome.valid?
      result = outcome.result

      render json: {
        results: result.as_json(except: :id),
        status: response_status(result)
      }
    else
      render json: {
        errors: outcome.errors.messages.map { |k, v| "#{k} #{v.join(', ')}" }
      }, status: 422
    end
  end

  private

  def response_status(result)
    result.present? ? "#{result.count} results found." : "No results found."
  end
end
