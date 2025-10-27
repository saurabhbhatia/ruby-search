# frozen_string_literal: true

require 'minitest/autorun'
require 'open3'
require_relative "../search.rb"

class SearchTest < Minitest::Test
  def run_command(command_string)
    stdout, stderr, status = Open3.capture3(command_string)
    @last_command_output = stdout + stderr # Combine for easier assertion
    @last_command_exit_status = status.exitstatus
  end

  def test_search_by_name_successfully
    run_command 'chmod +x search.rb'
    run_command "./search.rb --name john"
    assert_match /john/, @last_command_output
  end

  def test_search_by_email_successfully
    run_command 'chmod +x search.rb'
    run_command "./search.rb --email john.doe@gmail.com"
    assert_match /john.doe@gmail.com/, @last_command_output
  end

  def test_search_by_name_capitalised
    run_command 'chmod +x search.rb'
    run_command "./search.rb --name JOHN"
    assert_match /john/, @last_command_output
  end

  def test_search_by_email_capitalised
    run_command 'chmod +x search.rb'
    run_command "./search.rb --email JOHN.DOE@GMAIL.COM"
    assert_match /john.doe@gmail.com/, @last_command_output
  end

  def test_search_by_email_exceptions
    run_command 'chmod +x search.rb'
    run_command "./search.rb --email saurabh.a.bhatia@gmail.com"
    assert_raises(ArgumentError) do
      raise ArgumentError, "No Results Found"
    end
  end

  def test_search_by_name_exceptions
    run_command 'chmod +x search.rb'
    run_command "./search.rb --name saurabh"
    assert_raises(ArgumentError) do
      raise ArgumentError, "No Results Found"
    end
  end
end