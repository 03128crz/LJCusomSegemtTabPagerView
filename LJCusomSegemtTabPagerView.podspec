#
#  Be sure to run `pod spec lint LJCusomSegemtTabPagerView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "LJCusomSegemtTabPagerView"
  s.version      = "1.0.1"
  s.summary      = "simple segment tab pager view"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                   simple segment tab pager view
                   DESC

  s.homepage     = "https://github.com/03128crz/LJCusomSegemtTabPagerView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT (example)"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "james" => "csj9628@gmail.com" }
  # Or just: s.author    = "james"
  # s.authors            = { "james" => "csj9628@gmail.com" }
  # s.social_media_url   = "http://twitter.com/james"


  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  #  When using multiple platforms
  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/03128crz/LJCusomSegemtTabPagerView.git", :tag => "1.0.1" }
  s.source_files  = "LJCusomSegemtTabPagerView", "LJCusomSegemtTabPagerView/LJCusomSegemtTabPagerView/lib/**/*.{h,m,xib}"
  s.exclude_files = "LJCusomSegemtTabPagerView/Exclude"

  s.requires_arc = true

end
