require 'rails_helper'

describe Task do
	
	before(:each) do
		@task = FactoryGirl.create(:task)
	end

	describe 'create' do
		it 'has a status of incomplete' do
			expect(@task.status).to eq("incomplete")
		end

		it 'has a body' do
			@task.body.should be_present
		end
	end

	describe '.status_complete' do
	
		it 'changes to complete state' do
			@task.status_complete
			expect(@task.status).to eq("complete")
		end
	end

	describe '.status_incomplete' do	
		it 'changes a completed state to incomplete state' do
			@task.status_complete
			expect(@task.status).to eq("complete")
		
			@task.status_incomplete
			expect(@task.status).to eq("incomplete")
		end
	end
end