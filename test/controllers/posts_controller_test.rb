require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    require_login login_path, 'b@b.com', '12345678'
    get posts_url
    assert_response :success
  end

  test "should get new" do
    require_login login_path, 'b@b.com', '12345678'
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    require_login login_path, 'b@b.com', '12345678'
    assert_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    require_login login_path, 'b@b.com', '12345678'
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    require_login login_path, 'b@b.com', '12345678'
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    require_login login_path, 'b@b.com', '12345678'
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    require_login login_path, 'b@b.com', '12345678'
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
