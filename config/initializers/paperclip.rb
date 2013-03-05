Paperclip::Attachment.default_options.update(
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml", 
  :s3_protcol => 'https',
#  :s3_permissions => :private,
  :path => ":class/:attachment/:hash/:style.:extension",
	:hash_secret => "zAZKcOPOk9ZffTdH+b6FwKNnHww7hGXxSMJBD2Qk1exRXgRQK+KCvzH6ZR/z1S9okM9WEZcCGya6s00hWQTR/tf6w2+HxQDcPEGdAiAQFZu4GEzhUsP+cBTz8EkDqsUjmiOJp2OYkHw/KuOUzwUJJ8evotzceYQkHMm9ABUh4zU="
)