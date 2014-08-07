require 'spec_helper'

describe Timetable do

  it { should belong_to(:garage) }

  it 'the closing time should be before the opening' do
    bad_timetable = {
      'mon_morning_open' => Time.now + 5,
      'mon_afternoon_close' => Time.now
    }

    Timetable.create(bad_timetable)
      .errors.full_messages
      .should include('The closing time should be before the opening')
  end

  it 'the morning close time should be before the opening' do
    bad_timetable = {
      'tue_morning_open' => Time.now + 5,
      'tue_morning_close' => Time.now
    }

    Timetable.create(bad_timetable)
      .errors.full_messages
      .should include('The closing time should be before the opening')
  end

  it 'the afternoon open time should be before the morning close' do
    bad_timetable = {
      'wed_morning_close' => Time.now + 5,
      'wed_afternoon_open' => Time.now
    }

    Timetable.create(bad_timetable)
      .errors.full_messages
      .should include('The closing time should be before the opening')
  end

  it 'the afternoon close time should be before the open' do
    bad_timetable = {
      'fri_afternoon_open' => Time.now + 5,
      'fri_afternoon_close' => Time.now
    }

    Timetable.create(bad_timetable)
      .errors.full_messages
      .should include('The closing time should be before the opening')
  end
end
