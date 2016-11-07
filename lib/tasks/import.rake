namespace :import do
  desc 'Import supplier deals from XLSX'
  task supplier_deals: :environment do
    path = Rails.root.join('tmp', 'export.xlsx')
    DealXlsxService.new(path).import('SupplierDeal')
  end
end
