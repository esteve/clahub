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
      Rails.logger.info(payload.state)
      Rails.logger.info(payload.user_login)
      Rails.logger.info(payload.repo_name)
      Rails.logger.info(payload.sha)
      Rails.logger.info('================== STATUSES ==============')
      Rails.logger.info('=== INDIVIDUAL STATUS: ' + payload.statuses.inspect)
    end

    render text: "OK", status: 200
  end
end
