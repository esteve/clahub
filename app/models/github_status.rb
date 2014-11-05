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

  def statuses
    @mash.statuses
  end
end
