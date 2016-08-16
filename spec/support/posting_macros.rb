module PostingMacros
  BODY = Faker::Lorem.paragraph
  def new_post(body=BODY)
    fill_in "new-post", with: body
    click_button "Post"
  end
end