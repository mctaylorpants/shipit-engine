require 'test_helper'

module Shipit
  class GithubUrlHelperTest < ActiveSupport::TestCase
    include Shipit::GithubUrlHelper

    test "#github_user_url returns a user url" do
      assert_equal "https://github.com/tobi", github_user_url("tobi")
    end

    test "#github_repo_url returns a repo url" do
      assert_equal "https://github.com/rails/rails", github_repo_url("rails", "rails")
    end

    test "#github_commit_url returns a commit url" do
      expected = 'https://github.com/shopify/shipit-engine/commit/6d9278037b872fd9a6690523e411ecb3aa181355'
      assert_equal expected, github_commit_url(shipit_commits(:first))
    end

    test "#link_to_github_range returns the specified commit range" do
      COMMIT1_SHA = "12abe46b8929484b6218f4988825ea31e52fc3c1".freeze
      COMMIT2_SHA = "73f582e3b366d170773535f6117f166067c9f405".freeze
      REPO_OWNER = "some_repo_owner".freeze
      REPO_NAME = "shopifyrepo".freeze

      commit1 = Shipit::Commit.new(id: 1, sha: COMMIT1_SHA)
      commit2 = Shipit::Commit.new(id: 2, sha: COMMIT2_SHA)
      commit1_short_sha = commit1.short_sha
      commit2_short_sha = commit2.short_sha
      stack = Shipit::Stack.new(repo_owner: REPO_OWNER, repo_name: REPO_NAME)

      expected_result = "<a class=\"number\" href=\"https://github.com/#{REPO_OWNER}/#{REPO_NAME}/compare/#{COMMIT1_SHA}...#{COMMIT2_SHA}\">#{commit1_short_sha}...#{commit2_short_sha}</a>"
      result = link_to_github_range(stack, commit1, commit2)

      assert_equal expected_result, result
    end
  end
end
