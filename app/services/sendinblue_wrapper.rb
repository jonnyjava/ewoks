require 'sendinblue'

class SendinblueWrapper
  def initialize(content)
    @content = content
  end

  def send_via_sendiblue
    return false unless Rails.env.production?
    sendinblue_mailer = Sendinblue::Mailin.new(ENV["SENDINBLUE_API_URL"], ENV["SENDINBLUE_API_TOKEN"])
    result = sendinblue_mailer.send_transactional_template(@content)
    return (result['code'] == 'success')
  end
end
