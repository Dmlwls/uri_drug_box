# prow = Prow.last
#     time_arr = Hash.new
#     for i in 1..24/prow.period.to_i do
#     	byebug
#       time_arr[i] = prow.start_time + i*prow.period.to_i.hours
#     end

<td><%= d = Date.civil(all_times[i].year, all_times[i].month,all_times[i].day).to_parsi%>&nbsp;&nbsp;&nbsp;<%= all_times[i].strftime("%M : %H") %></td>