module QuoteProposalHelper
  def status_label(status)
    "label-#{COLORS[QuoteProposal.statuses[status]]}"
  end
end
