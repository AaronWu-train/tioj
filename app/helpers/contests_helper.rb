module ContestsHelper
  def contest_type_desc_map
    {
      "gcj" => "gcj style (partial/dashboard)",
      "ioi" => "ioi style (partial/no dashboard)",
      "acm" => "acm style (no partial/dashboard)",
    }
  end

  def rel_timestamp(submission, start_time)
    submission.created_at_usec - to_us(start_time)
  end

  # return item_state; global_state will be changed
  def acm_ranklist_state(submission, start_time, item_state, global_state, is_waiting)
    # state: [attempts, ac_usec, is_first_ac, waiting]
    if item_state.nil?
      item_state = [0, nil, nil, 0]
    end
    return nil if not item_state[1].nil?
    item_state = item_state.dup
    if is_waiting
      item_state[3] += 1
    else
      item_state[0] += 1
      if submission.result == 'AC'
        item_state[1] = rel_timestamp(submission, start_time)
        item_state[2] = !global_state[submission.problem_id]
        item_state[3] = 0
        global_state[submission.problem_id] = true
      end
    end
    item_state
  end

  def ioi_ranklist_state(submission, start_time, item_state, global_state, is_waiting)
    # state: [score, has_sub, waiting]
    if item_state.nil?
      item_state = [BigDecimal(0), false, 0]
    end
    if is_waiting
      item_state = item_state.dup
      item_state[2] += 1
      item_state
    else
      item_state[0] >= submission.score && item_state[1] ? nil : [submission.score, true, item_state[2]]
    end
  end

  def ranklist_data(submissions, start_time, freeze_start, rule)
    res = Hash.new { |h, k| h[k] = [] }
    participants = Set[]
    global_state = {}
    func = rule == :acm ? method(:acm_ranklist_state) : method(:ioi_ranklist_state)
    submissions.each do |sub|
      participants << sub.user_id
      next if ['CE', 'ER', 'CLE', 'JE'].include?(sub.result) && sub.created_at < freeze_start
      key = "#{sub.user_id}_#{sub.problem_id}"
      is_waiting = ['queued', 'received', 'Validating'].include?(sub.result) || sub.created_at >= freeze_start
      orig_state = res[key][-1]&.dig(:state)
      new_state = func.call(sub, start_time, orig_state, global_state, is_waiting)
      res[key] << {timestamp: rel_timestamp(sub, start_time), state: new_state} unless new_state.nil?
    end
    res.delete_if { |key, value| value.empty? }
    {result: res, participants: participants.to_a}
  end
end
