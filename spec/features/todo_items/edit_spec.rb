require 'spec_helper'

describe "Editing todo item" do
	let!(:todo_list) {TodoList.create(title: "Grocery list", description: "Groceries")}
	let!(:todo_item) {todo_list.todo_items.create(content: "Milk")}

	it "is succesful with valid content" do 
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "Lots of Milk"
		click_button "Save"
		expect(page).to have_content("Saved todo list item")
		todo_item.reload
		expect(todo_item.content).to eq("Lots of Milk")
	end

	it "is unsuccesful with no content" do 
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: ""
		click_button "Save"
		expect(page).to_not have_content("Saved todo list item")
		expect(page).to have_content("Content can't be blank")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

	it "is unsuccesful with not enough content" do 
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "Hi"
		click_button "Save"
		expect(page).to_not have_content("Saved todo list item")
		expect(page).to have_content("Content is too short (minimum is 3 characters)")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

end