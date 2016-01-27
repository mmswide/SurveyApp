module OrdersHelper
  def count_fee(sum)
    fee = sum * Order::PROCENT_FEE + Order::DOLLAR_FEE
    total = fee + sum
    fee += total * Order::STRIPE_PROCENT_FEE + Order::STRIPE_DOLLAR_FEE
    fee.round(2)
  end

  def total(sum)
    sum = sum + (sum * Order::PROCENT_FEE + Order::DOLLAR_FEE)
    sum += sum * Order::STRIPE_PROCENT_FEE + Order::STRIPE_DOLLAR_FEE
    sum.round(2)
  end

  def build_ticket_hash(entitlements)
    tickets_occurance = entitlements.map(&:ticket_id).each_with_object(Hash.new(0)) { |ticket,counts| counts[ticket] += 1 }
  end
end
