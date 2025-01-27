# Carrega todos os módulos necessários
%w[domain application infrastructure interfaces].each do |dir|
  path = Rails.root.join("app/#{dir}")
  if Dir.exist?(path)
    Dir[path.join('**/*.rb')].sort.each do |file|
      require_dependency file
    rescue LoadError, NameError => e
      Rails.logger.warn "Não foi possível carregar #{file}: #{e.message}"
    end
  else
    Rails.logger.warn "Diretório #{path} não encontrado"
  end
end 