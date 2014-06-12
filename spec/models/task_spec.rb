require 'rails_helper'

describe Task do
	
	before(:each) do
		@task = FactoryGirl.create(:task)
	end

	describe Task,'.new' do
		it 'has a status of incomplete' do
			expect(@task.status).to eq("incomplete")
		end

		it 'has a body' do
			@task.body.should be_present
		end
	end

	describe Task, '.status_complete' do
		it 'changes to complete state' do
			@task.status_complete
			expect(@task.status).to eq("complete")
		end
	end

	describe Task, '.status_incomplete' do	
		it 'changes a completed state to incomplete state' do
			@task.status_complete
			expect(@task.status).to eq("complete")
		
			@task.status_incomplete
			expect(@task.status).to eq("incomplete")
		end
	end

	describe Task, '.is_complete' do
		context 'task is incomplete' do
			it 'indicates that task is not complete' do
				expect(@task.is_complete).to eq(false)
			end
		end
	
		context 'task is complete' do
			it 'indicates that a task is complete' do
				@task.flip_status
				expect(@task.is_complete).to eq(true)
			end
		end
	end
end