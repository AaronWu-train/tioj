# == Schema Information
#
# Table name: submissions
#
#  id           :bigint           not null, primary key
#  code         :text(4294967295)
#  result       :string(255)      default("queued")
#  score        :decimal(18, 6)   default(0.0)
#  created_at   :datetime
#  updated_at   :datetime
#  problem_id   :bigint           default(0)
#  user_id      :bigint           default(0)
#  contest_id   :bigint
#  total_time   :integer
#  total_memory :integer
#  message      :text(16777215)
#  compiler_id  :bigint           not null
#
# Indexes
#
#  fk_rails_55e5b9f361                         (compiler_id)
#  index_submissions_contest_compiler          (contest_id,compiler_id,id DESC)
#  index_submissions_contest_result            (contest_id,result,id DESC)
#  index_submissions_fetch                     (result,contest_id,id)
#  index_submissions_on_contest_id             (contest_id)
#  index_submissions_on_result_and_updated_at  (result,updated_at)
#  index_submissions_on_user_id                (user_id)
#  index_submissions_problem_query             (contest_id,problem_id,user_id,result)
#  index_submissions_topcoder                  (contest_id,problem_id,result,score DESC,total_time,total_memory)
#  index_submissions_user_query                (contest_id,user_id,problem_id,result)
#
# Foreign Keys
#
#  fk_rails_...  (compiler_id => compilers.id)
#

require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
