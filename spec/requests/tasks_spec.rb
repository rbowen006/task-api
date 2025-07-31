require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  let(:valid_attributes) do
    { title: "Buy groceries", description: "Milk, Eggs" }
  end

  let(:invalid_attributes) do
    { description: "Missing title" }
  end

  describe "POST /tasks" do
    it "creates a task with valid attributes" do
      post "/tasks", params: { task: valid_attributes }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["title"]).to eq("Buy groceries")
    end

    it "returns error with invalid attributes" do
      post "/tasks", params: { task: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)["errors"]).to include("Title can't be blank")
    end
  end

  describe "GET /tasks" do
    before { Task.create!(valid_attributes) }

    it "returns a list of tasks" do
      get "/tasks"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "PATCH /tasks/:id/complete" do
    let!(:task) { Task.create!(valid_attributes) }

    it "marks the task as completed" do
      patch "/tasks/#{task.id}/complete"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["completed_at"]).not_to be_nil
    end

    it "returns 404 if task not found" do
      patch "/tasks/99999/complete"
      expect(response).to have_http_status(:not_found)
    end
  end
end
