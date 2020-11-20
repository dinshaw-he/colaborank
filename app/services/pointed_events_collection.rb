class PointedEventsCollection
  def initialize(params: {})
    @params = params
  end

  def q
    @q ||= PointedEvent.ransack(params_with_defaults)
  end

  private

  attr_reader :params

  def params_with_defaults
    unless params.has_key?('created_at_gteq')
      params['created_at_gteq'] = I18n.l(
        PointedEvent.minimum(:created_at).to_date,
        format: :daterange_picker
      )
    end

    unless params.has_key?('created_at_lteq')
      params['created_at_lteq'] = I18n.l(
        Date.today,
        format: :daterange_picker
      )
    end

    params
  end
end
