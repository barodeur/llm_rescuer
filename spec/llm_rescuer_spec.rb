# frozen_string_literal: true

RSpec.describe LlmRescuer do
  it { expect { nil.oops }.to raise_error(NoMethodError) }
  it { expect(nil.oops).to eq(nil) }
  it { expect(nil.oops).to eq(42) }
end
