namespace :push do

  task build: %i[app]

  task app: :environment do
    app = Rpush::Gcm::App.new
    app.name = 'Taiwan'
    app.auth_key = 'AIzaSyBfomNeHU72hBbhkwXtWNNhaHJrrKKPcvM'
    app.connections = 1
    app.save!

    puts('done')
  end


end
