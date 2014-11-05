class GithubWebhooksController < ApplicationController
  def repo_hook
    event = request.headers['X-GitHub-Event']

    Rails.logger.info(event.inspect)
    Rails.logger.info(params)

    if event == 'push'
      payload = GithubPush.new(params[:payload])
      PushStatusChecker.new(payload).check_and_update
    elsif event == 'status'
      Rails.logger.info('================== STATUS')
      payload = GithubStatus.new(params[:payload])
      Rails.logger.info(payload.status)
      Rails.logger.info(payload.user_login)
      Rails.logger.info(payload.repo_name)
    end

    render text: "OK", status: 200
  end
end
