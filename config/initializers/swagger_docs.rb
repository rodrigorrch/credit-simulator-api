Swagger::Docs::Config.register_apis({
  '1.0' => {
    controller_base_path: '',
    api_file_path: 'public/api/v1/',
    base_path: 'http://localhost:3000',
    clean_directory: true,
    attributes: {
      info: {
        title: 'Credit Simulator API',
        description: 'API for simulating loan payments with different interest rates and currencies',
        contact: 'support@example.com',
        version: '1.0'
      }
    }
  }
})

class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "api/#{api_version}/#{path}"
  end
end