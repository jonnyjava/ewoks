class QuoteProposal < ActiveRecord::Base
  belongs_to :garage
  belongs_to :demand
  belongs_to :demands_garage
  has_attached_file :doc1
  has_attached_file :doc2
  has_attached_file :doc3

  validates :ttc_price, presence: true
  validates_attachment_content_type :doc1, content_type: 'application/pdf'
  validates_attachment_content_type :doc2, content_type: 'application/pdf'
  validates_attachment_content_type :doc3, content_type: 'application/pdf'

  before_create :set_my_garage, :set_my_demand
  after_create :update_association_with_myself, :set_token
  before_destroy :delete_myself_from_association

  enum status: [:active, :expired, :accepted, :refused, :banned]
  enum deliverable_status: [:to_deliver, :delivered]

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
    to_deliver? && (active? || expired?)
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
end
