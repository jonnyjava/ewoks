class TimetableValidator < ActiveModel::Validator
  def validate(record)
    %w(mon tue wed thu fri sat sun).each do |day|
      message = 'The closing time should be before the opening'
      return record.errors[:base] << message unless interval_valid?(day, record)
    end
  end

  private

  def interval_valid?(day, record)
    morning_open = record.send("#{day}_morning_open")
    morning_close = record.send("#{day}_morning_close")
    afternoon_open = record.send("#{day}_afternoon_open")
    afternoon_close = record.send("#{day}_afternoon_close")

    if morning_open.present? && morning_close.blank?
      return morning_open.to_i < afternoon_close.to_i
    end

    if morning_close.present? || afternoon_open.present?
      return morning_open.to_i < morning_close.to_i &&
             morning_close.to_i < afternoon_open.to_i &&
             afternoon_open.to_i < afternoon_close.to_i
    end

    true
  end
end
