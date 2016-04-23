Pod::Spec.new do |s|
  s.name         = "ThingsKit"
  s.version      = "0.0.1"
  s.summary      = "ThingsKit"
  s.description  = <<-DESC
  	ThingsKit
    DESC
  s.homepage         = "https://github.com/zubairhamed/bosch-iot-thingskit"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.authors          = { "Keith Harrison" => "keith@useyourloaf.com" }
  s.social_media_url = 'https://twitter.com/kharrison'
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/zubairhamed/bosch-iot-thingskit.git", :tag => "1.0.0" }
  s.source_files  = "ThingsKit/**"
  s.dependency  "Alamofire"
  s.dependency  "ObjectMapper"
  s.requires_arc = true
end