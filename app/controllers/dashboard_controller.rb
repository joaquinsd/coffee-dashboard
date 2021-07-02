class DashboardController < ApplicationController
  def index
    @last12m_sales = Sale.group_by_month(:sale_date, last: 12, format: "%b %Y").order(sale_date: :asc).sum(:price)
    @last12m_sales_count = Sale.group_by_month(:sale_date, last: 12, format: "%b %Y").order(sale_date: :asc).count
    @last12m_sales_average = Sale.group_by_month(:sale_date, last: 12, format: "%b %Y").order(sale_date: :asc).average(:price)

    range = [12, 6, 3, 1]
    option = %w[origin blend]
    @hash = {}

    option.each do |i|
      range.each do |j|
        @hash["sales_by_#{i}_#{j}m"] = Sale.where('sale_date >= ?', j.month.ago).group(:"#{i}").order(sale_date: :asc).count
      end
    end
  end
end
