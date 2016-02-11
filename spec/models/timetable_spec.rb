require 'spec_helper'

describe Timetable do

  it { is_expected.to belong_to(:garage) }

  it 'the closing time should be later the opening' do
    bad_timetable = {
      'mon_morning_open' => Time.now + 5,
      'mon_afternoon_close' => Time.now
    }

    expect(Timetable.create(bad_timetable)
      .errors.full_messages)
      .to include(I18n.t('The closing time should be later the opening'))
  end

  it 'the morning close time should be later the opening' do
    bad_timetable = {
      'tue_morning_open' => Time.now + 5,
      'tue_morning_close' => Time.now
    }

    expect(Timetable.create(bad_timetable)
      .errors.full_messages)
      .to include(I18n.t('The closing time should be later the opening'))
  end

  it 'the afternoon open time should be later the morning close' do
    bad_timetable = {
      'wed_morning_close' => Time.now + 5,
      'wed_afternoon_open' => Time.now
    }

    expect(Timetable.create(bad_timetable)
      .errors.full_messages)
      .to include(I18n.t('The closing time should be later the opening'))
  end

  it 'the afternoon close time should be later the open' do
    bad_timetable = {
      'fri_afternoon_open' => Time.now + 5,
      'fri_afternoon_close' => Time.now
    }

    expect(Timetable.create(bad_timetable)
      .errors.full_messages)
      .to include(I18n.t('The closing time should be later the opening'))
  end
end
