require 'spec_helper'

describe Timetable do
  it { is_expected.to belong_to(:garage) }
end
