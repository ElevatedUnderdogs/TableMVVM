Pod::Spec.new do |s|
  s.name         = "TableMVVM"
  s.version      = "0.1.0"
  s.summary      = "A declarative framework for tableviews."
  s.description  = "A declarative framework for tableviews.  Heavily unit tested."
  s.homepage     = "https://github.com/ElevatedUnderdogs/TableMVVM"

  s.license      = ""
  s.author       = { "Scott Lydon" => "scottlydon18@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/ElevatedUnderdogs/TableMVVM.git", :commit => '71bd753f2c1e05b3cfaec46210c8ba06d11669a8' }
  s.source_files =  "TableMVVM/Sources/**/*" 
  # path to your classes. You can drag them into their own folder.

  s.requires_arc = true
  s.swift_version= '5.0'
  s.xcconfig     = { 'SWIFT_VERSION' => '5.0' }
end
