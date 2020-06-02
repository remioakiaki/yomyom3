# frozen_string_literal: true

module Common
  def sign_in_as(user)
    visit root_path
    sleep 1.0
    click_link 'ログイン'
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
  end
  def relation(user)
    expect do
      find(".relation-btn_#{user.id}").click_button 'フォローする'
      sleep 0.5
    end.to change(Relationship, :count).by(1)
    expect do
      find(".relation-btn_#{user.id}").click_button 'フォロー解除'
      sleep 0.5
    end.to change(Relationship, :count).by(-1)
  end
end
