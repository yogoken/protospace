# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '52.198.45.165', user: 'yogoken', roles: %w{app db web}

#デプロイするサーバにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/key_pair_key_rsa'
