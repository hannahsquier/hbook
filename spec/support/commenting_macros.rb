module CommentingMacros
  BODY = Faker::Lorem.paragraph
  def new_comment(body=BODY)
    fill_in "new-comment", with: body
    click_button "Comment"
  end
end