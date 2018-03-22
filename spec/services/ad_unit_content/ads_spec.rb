require 'rails_helper'

def fetch_data_size
  [described_class.new(signage_ad_unit).fetch].flatten.compact.size
end

RSpec.describe AdUnitContent::Ads do

  describe '#fetch' do
    context 'specific' do
      let(:signage_ad_unit) { create(:signage_ad_unit, :script) }

       it 'eligible / materials complete / budget_enough ' do
         signage_ad_unit.ads << create_list(:ad, 2, :file_complete, :eligible, :budget_enough)
         expect(fetch_data_size).to eq(2)
       end

       it 'eligible / materials complete / budget_enough ' do
         signage_ad_unit.ads << create_list(:ad, 2, :file_complete, :eligible)
         expect(fetch_data_size).to eq(2)
       end

       it 'materials not complete' do
         signage_ad_unit.ads << create_list(:ad, 2, :eligible, :budget_enough)
         expect(fetch_data_size).to eq(0)
       end

       it 'materials not complete' do
         signage_ad_unit.ads << create_list(:ad, 2, :file_incomplete, :eligible, :budget_enough)
         expect(fetch_data_size).to eq(0)
       end

       it 'not eligible' do
         signage_ad_unit.ads << create_list(:ad, 2, :file_complete, :budget_enough)
         expect(fetch_data_size).to eq(0)
       end

       it 'budget not enough' do
         signage_ad_unit.ads << create_list(:ad, 2, :file_complete, :budget_not_enough, :eligible)
         expect(fetch_data_size).to eq(0)
       end

       it 'budget enough' do
         signage_ad_unit.ads << create_list(:ad, 2, :file_complete, :eligible)
         expect(fetch_data_size).to eq(2)
       end

      context 'default' do
        it 'file_complete & same ad template size' do
          create_list(:ad, 2, :default, :file_complete)
          expect(fetch_data_size).to eq(2)
        end

         it 'not same ad template size' do
           create_list(:ad, 2, :default, :file_complete, :ad_template_sm)
           expect(fetch_data_size).to eq(0)
         end

         it 'file incomplete' do
           create_list(:ad, 2, :default, :file_incomplete)
           expect(fetch_data_size).to eq(0)
         end

         it 'file incomplete' do
           create_list(:ad, 2, :default)
           expect(fetch_data_size).to eq(0)
         end
      end
    end

    context 'random' do
      let(:signage_ad_unit) { create(:signage_ad_unit, :random) }
      after(:each) { expect(signage_ad_unit.ads.size).to eq(0) }

       it 'eligible / materials complete / budget_enough ' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :file_complete, :eligible, :budget_enough)
         expect(fetch_data_size).to eq(1)
       end

       it 'eligible / materials complete / budget_enough ' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :file_complete, :eligible)
         expect(fetch_data_size).to eq(1)
       end

       it 'materials not complete' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :eligible, :budget_enough)
         expect(fetch_data_size).to eq(0)
       end

       it 'materials not complete' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :file_incomplete, :eligible, :budget_enough)
         expect(fetch_data_size).to eq(0)
       end

       it 'not eligible' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :file_complete, :budget_enough)
         expect(fetch_data_size).to eq(0)
       end

       it 'budget not enough' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :file_complete, :budget_not_enough, :eligible)
         expect(fetch_data_size).to eq(0)
       end

       it 'budget enough' do
         signage_ad_unit.client.ads << create_list(:ad, 2, :file_complete, :eligible)
         expect(fetch_data_size).to eq(1)
       end

      context 'default' do
         it 'file_complete & same ad template size' do
           create_list(:ad, 2, :default, :file_complete)
           expect(fetch_data_size).to eq(1)
         end

         it 'not same ad template size' do
           create_list(:ad, 2, :default, :file_complete, :ad_template_sm)
           expect(fetch_data_size).to eq(0)
         end


         it 'file incomplete' do
           create_list(:ad, 2, :default, :file_incomplete)
           expect(fetch_data_size).to eq(0)
         end

         it 'file incomplete' do
           create_list(:ad, 2, :default)
           expect(fetch_data_size).to eq(0)
         end
      end
     end
  end
end
