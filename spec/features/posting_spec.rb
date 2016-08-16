feature "posting" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let( :other_users_ids) { User.pluck(:id) - [user.id] }
  let(:post) { build(:post, user_id: other_users_ids.sample) }


  scenario "user can post on own timeline and redirected to own timeline" do
    login(user.email)
    post_body = Faker::Lorem.paragraph
    new_post(post_body)
    expect(page).to have_content(post_body)
  end



  scenario "user can post on someone elses timeline and is redirected to their timeline" do
    login(user.email)
    visit user_posts_path(other_user.id)
    post_body = Faker::Lorem.paragraph
    new_post(post_body)
    expect(page).to have_content(post_body)
  end


  scenario "user can't post an empty post" do
    login(user.email)
    new_post("")
    expect(page).to have_css("div.alert-danger")

  end

  scenario "user can delete own post" do
    login(user.email)
    post_body = Faker::Lorem.paragraph

    new_post(post_body)
    click_link "delete-post"
    expect(page).to_not have_content(post_body)

  end

  scenario "user can't delete someone elses post" do
    user.posts << post
    login(user.email)
    expect(page).to have_css("article.posted-post")
    expect(page).to_not have_css("a.delete-post")
  end
end
