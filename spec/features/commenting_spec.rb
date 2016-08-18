require 'rails_helper'

feature "commenting" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let( :other_user_ids) { User.pluck(:id) - [user.id] }
  let(:other_person_comment) { comment(:comment, user_id: other_user_ids.sample ) }


  scenario "user can post on own timeline and redirected to own timeline" do
    login(user.email)
    new_post
    comment_body = Faker::Lorem.paragraph
    new_comment(comment_body)
    expect(page).to have_content(comment_body)
  end



  # scenario "user can post on someone elses timeline and is redirected to their timeline" do
  #   login(user.email)
  #   visit user_posts_path(other_user.id)
  #   body = Faker::Lorem.paragraph
  #   fill_in "new-post", with: body
  #   click_button "Post"
  #   expect(page).to have_content(body)
  # end


  scenario "user can't comment an empty post" do
    login(user.email)
    new_post
    new_comment("")
    expect(page).to have_css("div.alert-danger")

  end

  scenario "can't comment if there is nothing to comment on" do
    login(user.email)
    expect(page).to_not have_css("article.comment")
  end

  scenario "user can delete own post" do
    login(user.email)
    new_post
    comment_body = Faker::Lorem.paragraph

    new_comment(comment_body)
    click_link "delete-comment"
    expect(page).to_not have_content(comment_body)

  end

  scenario "user can't delete someone elses comments" do
    login(user.email)
    new_post
    new_comment
    logout
    login(other_user.email)
    visit user_posts_path(user.id)
    expect(page).to have_css("article.comment")
    expect(page).to_not have_css("a.delete-comment")

  end


end