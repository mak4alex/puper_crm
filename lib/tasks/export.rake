namespace :export do
  desc 'Export supplier deals to XLSX'
  task supplier_deals: :environment do
    deals = SupplierDeal.last(1)
    DealXlsxService.new(Rails.root.join('tmp', 'export.xlsx')).export(deals)
  end
end
