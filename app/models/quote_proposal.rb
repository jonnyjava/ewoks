class QuoteProposal < ActiveRecord::Base
  belongs_to :garage
  belongs_to :demand
  belongs_to :demands_garage
  has_attached_file :doc1
  has_attached_file :doc2
  has_attached_file :doc3

  validates :ttc_price, presence: true
  validates_attachment_content_type :doc1, content_type: ['application/pdf', 'image/jpeg', 'image/png']
  validates_attachment_content_type :doc2, content_type: ['application/pdf', 'image/jpeg', 'image/png']
  validates_attachment_content_type :doc3, content_type: ['application/pdf', 'image/jpeg', 'image/png']

  before_create :set_my_garage, :set_my_demand
  after_create :update_association_with_myself, :set_token
  before_destroy :delete_myself_from_association

  enum status: [:ready, :opened, :expired, :accepted, :refused, :banned]
  enum deliverable_status: [:to_deliver, :delivered]

  def self.attachment_params
    {
      storage: :ftp,
      path: "#{ENV['FTP_FOLDER']}/:garage/:id/:filename",
      url: "#{ENV['FTP_PUBLIC_URL']}/:garage/:id/:filename",
      ftp_servers: [FTP_SERVER],
      ftp_ignore_failing_connections: true,
      ftp_keep_empty_directories: true
    }
  end

  has_attached_file :doc1, attachment_params
  has_attached_file :doc2, attachment_params
  has_attached_file :doc3, attachment_params

  def set_my_garage
    self.garage = self.demands_garage.garage
  end

  def set_my_demand
    self.demand = self.demands_garage.demand
  end

  def update_association_with_myself
    demands_garage.update_attribute(:quote_proposal_id, self.id)
  end

  def delete_myself_from_association
    demands_garage.update_attribute(:quote_proposal_id, nil)
  end

  def deliverable?
    to_deliver? && (ready? || expired?)
  end

  def send_to_contact
    QuoteProposalMailer.send_quote_to_contact(self.decorate).deliver_now if to_deliver?
  end

  def can_accept?(status)
    ["accepted", "refused"].include?(status)
  end

  def set_token
    tokenizable = [self.decorate.identifier, status, updated_at, ENV['QUOTE_TOKENIZER']].join
    token = Digest::SHA1.hexdigest(tokenizable)
    self.update_attribute(:mail_token, token)
  end

  Paperclip.interpolates :garage do |attachment, style|
    attachment.instance.garage.created_at.strftime('%Y%m%d%H%M%S')
  end
end
