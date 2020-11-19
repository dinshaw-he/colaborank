class ScopedI18n
  def initialize(scope:, i18n: I18n)
    @scope = scope
    @i18n = i18n
  end

  def call(key, **kwargs)
    i18n.t(key, scope: scope, **kwargs)
  end

  private

  attr_reader :scope, :i18n
end
