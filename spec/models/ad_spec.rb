require 'rails_helper'

RSpec.describe Ad, type: :model do
  describe '#resume' do
    subject { create(:ad, :paused) }

    context 'money' do
      it 'enough' do
        subject.manager.update(remaining_sum: 100)
        subject.resume
        expect(subject.status).to eq('eligible')
      end

      it 'not enough' do
        subject.manager.update(remaining_sum: 0)
        subject.resume
        expect(subject.status).to eq('limited_by_money')
      end

      it 'not enough' do
        subject.manager.update(remaining_sum: -1000)
        subject.resume
        expect(subject.status).to eq('limited_by_money')
      end
    end

    context 'time' do
      it 'eligible' do
        subject.resume
        expect(subject.status).to eq('eligible')
      end

      it 'pending' do
        subject.update(start_at: Time.current + 1.days)
        subject.resume
        expect(subject.status).to eq('pending')
      end
    end

    context 'eligible jid' do
      it 'start at jid nil' do
        subject.manager.update(remaining_sum: 100)
        subject.resume
        expect(subject.start_at_jid).to be_nil
      end

      it 'end at jid present' do
        subject.manager.update(remaining_sum: 100)
        subject.resume
        expect(subject.end_at_jid).to be_truthy
      end
    end

    context 'pending jid' do
      it 'start at jid present' do
        subject.manager.update(remaining_sum: 100)
        subject.update(start_at: Time.current + 1.days)
        subject.resume
        expect(subject.start_at_jid).to be_truthy
      end

      it 'end at jid present' do
        subject.manager.update(remaining_sum: 100)
        subject.resume
        expect(subject.status).to be_truthy
      end
    end

  end

  describe '#to_be_eligible' do
    subject { create(:ad, :pending) }

    context 'money' do
      it 'enough' do
        subject.manager.update(remaining_sum: 1000)
        subject.to_be_eligible
        expect(subject.status).to eq('eligible')
      end

      it 'not enough' do
        subject.manager.update(remaining_sum: 0)
        subject.to_be_eligible
        expect(subject.status).to eq('limited_by_money')
      end

      it 'not enough' do
        subject.manager.update(remaining_sum: -100)
        subject.to_be_eligible
        expect(subject.status).to eq('limited_by_money')
      end
    end
  end

  describe '#limit_by_money' do
    subject { create(:ad, :eligible) }
    context 'money' do
      it 'enough' do
        subject.manager.update(remaining_sum: 1000)
        status = subject.status
        subject.limit_by_money
        expect(subject.status).to eq(status)
      end

      it 'not enough' do
        subject.manager.update(remaining_sum: 0)
        subject.limit_by_money
        expect(subject.status).to eq('limited_by_money')
      end

      it 'not enough' do
        subject.manager.update(remaining_sum: -1000)
        subject.limit_by_money
        expect(subject.status).to eq('limited_by_money')
      end
    end
  end

  describe '#date_end' do
    subject { create(:ad, :eligible) }

    context 'eligible jid' do
      it 'start at jid nil' do
        subject.manager.update(remaining_sum: 100)
        subject.date_end
        expect(subject.start_at_jid).to be_nil
      end

      it 'end at jid nil' do
        subject.manager.update(remaining_sum: 100)
        subject.date_end
        expect(subject.end_at_jid).to be_nil
      end
    end
  end

end
