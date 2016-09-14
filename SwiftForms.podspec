Pod::Spec.new do |s|
  s.name = "SwiftForms"
  s.version = "1.7"
  s.summary = "A small and lightweight library written in Swift that allows you to easily create forms"
  s.homepage = "https://github.com/ortuman/SwiftForms"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.authors = "Miguel Ángel Ortuño"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/ortuman/SwiftForms.git", :tag => '1.7' }
  s.source_files = 'SwiftForms/*.swift','SwiftForms/descriptors/*.swift', 'SwiftForms/cells/base/*.swift', 'SwiftForms/cells/*.swift', 'SwiftForms/controllers/*.swift'
end
