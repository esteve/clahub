class GithubStatus
  def initialize(json)
    @mash = Hashie::Mash.new(JSON.parse(json))
  end

  def repo_name
    @mash.repository.try(:name)
  end

  def user_login
    @mash.repository.try(:owner).try(:login)
  end

  def state
    @mash.state
  end

  def sha
    @mash.sha
  end

  def repo_agreement
    @repo_agreement ||= Agreement.where({
      user_name: user_login,
      repo_name: repo_name
    }).first
  end

  def statuses
    GithubRepos.new(repo_agreement.user).get_statuses(user_login, repo_name, sha)
  end
end
