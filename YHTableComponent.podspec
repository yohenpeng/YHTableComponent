Pod::Spec.new do |s|
  s.name         = "YHTableComponent"
  s.version      = "1.0.0.3"
  s.summary      = "更好的管理TableView数据源，支持异步计算高度提高性能，目前提供Objective-C版本"
  s.license      = "None"
  s.homepage     = "https://yohen.me"
  s.author       = { "yohen.me" => "yohenpeng@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/yohenpeng/YHTableComponent.git", :tag => "#{s.version}" }
  s.source_files = 'YHTableComponent/YHTableComponent.h','YHTableComponent/Model/*.{h,m}','YHTableComponent/ViewModel/*.{h,m}'
end
