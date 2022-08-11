# frozen_string_literal: true

class QueryFilter
  def self.call(collections, params)
    new(collections, params).filter
  end

  def initialize(collections, params)
    @collections = collections
    @params = params
  end

  def filter
    @params.each do |key, value|
      next if value.blank?

      case key.to_sym
      when :age
        @collections = @collections.where(age: value)
      when :published_at
        if value.scan(/\D/).empty? && value.size == 4
          date = Date.new(value.to_i, 0o1, 0o1)
          @collections = @collections.where('published_at between ? and ?', date, date.end_of_year)
        else
          next if (year, month, day = value.split('-')).size != 3

          @collections = @collections.where(published_at: Date.new(year.to_i, month.to_i, day.to_i))
        end
      else
        @collections = @collections.where("#{key} ILIKE ?", "%#{value}%")
      end
    end

    @collections
  end
end
