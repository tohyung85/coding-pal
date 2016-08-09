module GroupsHelper
  def render_member(member)
    link_to profile_path(member.profile), class: 'group-members-profile-link' do
      if member.profile.avatar.present?
        image_tag(member.profile.avatar, class: 'group-members-image')
      else
        image_tag('http://placehold.it/30x30', class: 'group-members-image')
      end
    end
  end

  def render_join_request_button
    if current_user.present? && current_group.members.find_by_id(current_user.id).nil? && current_group.join_requests.find_by('requestor_id = ?', current_user.id).nil?
      return content_tag(:button, 'Join Group', class: 'btn btn-success join-button', data: { toggle: 'modal', target: '#joinRequestModal' })
    end

    if current_user.present? && current_group.join_requests.find_by('requestor_id = ?', current_user.id).present?
      return link_to('Withdraw Join Request', join_request_path(current_group.join_requests.find_by('requestor_id = ?', current_user.id)), method: :delete, class: 'btn btn-danger')
    end
  end

  def render_group_request(request)
    content_tag :div, class: 'individual-group-request' do
      concat (content_tag :div, class: 'group-request-details' do
                content_tag(:h4, link_to(request.requestor.profile.user_name, profile_path(request.requestor), class: 'requestor-profile-link') + ' ' + 'would like to join the group') +
                content_tag(:p, request.message)
              end)
      if current_group.user == current_user
        concat (content_tag :div, class: 'group-request-buttons' do
                  link_to('Enroll User', join_request_enroll_path(request), method: :delete, class: 'btn btn-success') +
                  link_to('Reject Request', join_request_path(request), method: :delete, class: 'btn btn-danger')
                end)
      end
    end
  end
end
