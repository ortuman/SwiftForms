Pod::Spec.new do |s|
  s.name         = "SwiftForms"
  s.version      = "0.5"
  s.summary      = "A small and lightweight library written in Swift that allows you to easily create forms."
  s.homepage     = "http://github.com/ortuman/SwiftForms"
  s.license      = 'MIT'
  s.author       = { "Miguel Ángel Ortuño" => "ortuman@gmail.com" }
  s.social_media_url = "http://twitter.com/ortuman"
  s.source = { :git => "https://github.com/ortuman/SwiftForms.git", :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'SwiftForms/Source/*.{swift}'
  s.requires_arc = true
end
