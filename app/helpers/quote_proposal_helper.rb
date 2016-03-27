module QuoteProposalHelper
  COLORS = Hash[%w(success primary warning info danger).map.with_index { |obj, i| [i, obj] }]

  def status_label(status)
    "label-#{COLORS[QuoteProposal.statuses[status]]}"
  end
end
