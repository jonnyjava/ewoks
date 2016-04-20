require 'paperclip/storage/ftp'
FTP_SERVER = { 'host' => ENV['FTP_HOST'], 'user' => ENV['FTP_USER'], 'password' => ENV['FTP_PASSWORD'] }.freeze
